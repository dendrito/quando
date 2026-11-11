import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../events/domain/event.dart';
import '../../home/data/home_information_providers.dart';
import '../../ringing/ring_style.dart';
import '../../sounds/domain/loudness.dart';
import '../domain/weather_alarms.dart';

class WeatherAlarmSettingsNotifier extends Notifier<WeatherAlarmSettings> {
  @override
  WeatherAlarmSettings build() {
    try {
      final raw = ref.read(prefsProvider).getString('weatherAlarms');
      return raw == null
          ? const WeatherAlarmSettings()
          : WeatherAlarmSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const WeatherAlarmSettings();
    }
  }

  void update(WeatherAlarmSettings Function(WeatherAlarmSettings) change) {
    state = change(state);
    ref.read(prefsProvider).setString('weatherAlarms', jsonEncode(state.toJson()));
  }
}

final weatherAlarmSettingsProvider = NotifierProvider<WeatherAlarmSettingsNotifier, WeatherAlarmSettings>(
  WeatherAlarmSettingsNotifier.new,
);

/// The reminders planned from the latest forecast. Kept on the phone, so
/// they are still set after a restart even without a new forecast.
class WeatherAlertsNotifier extends Notifier<List<WeatherAlert>> {
  @override
  List<WeatherAlert> build() {
    try {
      final raw = jsonDecode(ref.read(prefsProvider).getString('weatherAlerts') ?? '[]') as List;
      return [for (final r in raw) ?WeatherAlert.fromJson(r)];
    } catch (_) {
      return const [];
    }
  }

  void _set(List<WeatherAlert> alerts) {
    state = alerts;
    ref.read(prefsProvider).setString('weatherAlerts', jsonEncode([for (final a in alerts) a.toJson()]));
  }

  /// Reads the forecast again and re-plans. Quiet when there is no place,
  /// no network or the feature is off.
  Future<void> refresh() async {
    final settings = ref.read(weatherAlarmSettingsProvider);
    if (!settings.active) {
      if (state.isNotEmpty) _set(const []);
      return;
    }
    final place = ref.read(skyPlaceProvider);
    if (place == null) return;
    try {
      final now = ref.read(clockProvider)();
      final report = await ref.read(weatherRepositoryProvider).load(place);
      const planner = WeatherPlanner();
      final anchors = <WeatherAnchor>[];
      if (settings.tied) {
        final zone = ref.read(homeZoneProvider);
        final ring = Duration(seconds: ref.read(alarmOptionsProvider).ringSeconds);
        for (final a in ref.read(userAlarmsProvider)) {
          for (final s in a.plan(now: now, horizon: planner.horizon, zone: zone, defaultRing: ring)) {
            anchors.add(WeatherAnchor(id: '${s.id}', at: s.at, title: s.title));
          }
        }
        for (final e in ref.read(eventsProvider)) {
          if (e.kind == EventKind.calendar) anchors.add(WeatherAnchor(id: e.id, at: e.at, title: e.title));
        }
      }
      _set(planner.plan(settings: settings, hours: report.hours, now: now, anchors: anchors));
    } catch (e) {
      // Keep the reminders already set: an old forecast beats none.
      debugPrint('Quando?: weather reminders not updated: $e');
    }
  }
}

final weatherAlertsProvider = NotifierProvider<WeatherAlertsNotifier, List<WeatherAlert>>(
  WeatherAlertsNotifier.new,
);

String _hhmm(DateTime utc) {
  final t = utc.toLocal();
  return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

String _lead(Duration d) {
  if (d.inMinutes % 60 == 0) {
    final h = d.inHours;
    return h == 1 ? '1 hour' : '$h hours';
  }
  return '${d.inMinutes} minutes';
}

String _kindName(WeatherAlert a) => switch (a.kind.name) {
  'thunder' => 'Thunderstorm',
  'snow' => 'Snow',
  'fog' => 'Fog',
  _ => 'Rain',
};

/// The reminders as alarms the phone can ring. A soft one is a quiet,
/// short ping; a loud one is a full alarm.
// TODO(weather-alarms): move these texts into the translations.
List<ScheduledAlarm> weatherAlarmsFor(List<WeatherAlert> alerts, DateTime now) => [
  for (final a in alerts)
    if (a.at.isAfter(now))
      ScheduledAlarm(
        id: stableId('weather|${a.key}'),
        at: a.at,
        title: a.anchorTitle == null
            ? '${_kindName(a)} forecast'
            : '${_kindName(a)} forecast · ${a.anchorTitle}',
        body: a.anchorTitle == null
            ? 'Expected around ${_hhmm(a.onset)}, in ${_lead(a.lead)}'
            : '${_hhmm(a.onset)}: ${_lead(a.lead)} to go',
        ringDuration: Duration(seconds: a.loud ? 60 : 15),
        ringDurationOverride: true,
        ruleId: 'weather',
        eventId: a.key,
        offset: -a.lead,
        style: a.loud ? RingStyle.none : const RingStyle(loudness: Loudness(volume: 30, fadeInSeconds: 3)),
      ),
];
