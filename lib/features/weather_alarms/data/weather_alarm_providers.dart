import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../events/domain/event.dart';
import '../../home/data/home_information_providers.dart';
import '../../../l10n/l10n.dart';
import '../domain/weather_alarms.dart';
import 'weather_background.dart';

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
    final place = ref.read(weatherPlaceProvider);
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
      // Weather reminders stay quiet through Shabbat and festivals.
      final blocked = ref.read(shabbatInUseProvider)
          ? [for (final p in ref.read(periodsProvider)) (p.start, p.end)]
          : const <(DateTime, DateTime)>[];
      _set(
        planner.plan(settings: settings, hours: report.hours, now: now, anchors: anchors, blocked: blocked),
      );
      // What the background check needs, as it cannot ask the app.
      final locale = currentLocale;
      await WeatherSnapshot(
        place: place,
        anchors: anchors,
        blocked: blocked,
        locale: locale.scriptCode == null
            ? locale.languageCode
            : '${locale.languageCode}_${locale.scriptCode}',
      ).save(ref.read(prefsProvider));
    } catch (e) {
      // Keep the reminders already set: an old forecast beats none.
      debugPrint('Quando?: weather reminders not updated: $e');
    }
  }
}

final weatherAlertsProvider = NotifierProvider<WeatherAlertsNotifier, List<WeatherAlert>>(
  WeatherAlertsNotifier.new,
);
