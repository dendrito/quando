import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../l10n/l10n.dart';
import '../../alarms/data/alarm_registrar.dart';
import '../../home/data/weather_repository.dart';
import '../../ringing/ring_payload.dart';
import '../../shabbat/domain/place.dart';
import '../../sounds/domain/loudness.dart';
import '../domain/weather_alarms.dart';
import 'weather_alarm_alarms.dart';

/// What the background check needs from the app: where you are, the alarms
/// and events to check the weather against, and the holy periods to stay
/// quiet in. Saved each time the app plans, because the background check
/// runs without the app.
class WeatherSnapshot {
  const WeatherSnapshot({
    required this.place,
    required this.anchors,
    required this.blocked,
    required this.locale,
  });

  final Place place;
  final List<WeatherAnchor> anchors;
  final List<(DateTime, DateTime)> blocked;
  final String locale;

  static const _key = 'weatherAlarms.snapshot';

  Future<void> save(SharedPreferences prefs) => prefs.setString(
    _key,
    jsonEncode({
      'place': place.toJson(),
      'locale': locale,
      'anchors': [
        for (final a in anchors) {'id': a.id, 'at': a.at.toUtc().toIso8601String(), 'title': a.title},
      ],
      'blocked': [
        for (final b in blocked) [b.$1.toUtc().toIso8601String(), b.$2.toUtc().toIso8601String()],
      ],
    }),
  );

  static WeatherSnapshot? load(SharedPreferences prefs) {
    try {
      final j = jsonDecode(prefs.getString(_key) ?? '') as Map<String, dynamic>;
      return WeatherSnapshot(
        place: Place.fromJson((j['place'] as Map).cast<String, dynamic>()),
        locale: j['locale'] as String? ?? 'en',
        anchors: [
          for (final a in j['anchors'] as List)
            WeatherAnchor(
              id: (a as Map)['id'] as String,
              at: DateTime.parse(a['at'] as String),
              title: a['title'] as String,
            ),
        ],
        blocked: [
          for (final b in j['blocked'] as List)
            (DateTime.parse((b as List)[0] as String), DateTime.parse(b[1] as String)),
        ],
      );
    } catch (_) {
      return null;
    }
  }
}

const _task = 'quando.weather';

/// Android only: now and then reads the forecast again while Quando? is
/// closed, and moves, adds or removes the weather reminders to match.
class WeatherBackground {
  static Future<void> schedule(bool on) async {
    try {
      final wm = Workmanager();
      await wm.initialize(weatherCallbackDispatcher);
      if (on) {
        await wm.registerPeriodicTask(
          _task,
          _task,
          frequency: const Duration(hours: 3),
          constraints: Constraints(networkType: NetworkType.connected),
          existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
        );
      } else {
        await wm.cancelByUniqueName(_task);
      }
    } catch (e) {
      debugPrint('Quando?: weather background check not scheduled: $e');
    }
  }

  static const _idsKey = 'weatherAlarms.ids';

  /// One background pass. Returns whether it finished.
  static Future<bool> run({DateTime? now}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final settings = _settings(prefs);
    final snapshot = WeatherSnapshot.load(prefs);
    if (!settings.active || snapshot == null) return true;
    useLocale([localeFromTag(snapshot.locale)]);
    final time = now ?? DateTime.now();
    final repository = WeatherRepository(prefs);
    try {
      final report = await repository.load(snapshot.place);
      final alerts = const WeatherPlanner().plan(
        settings: settings,
        hours: report.hours,
        now: time,
        anchors: snapshot.anchors,
        blocked: snapshot.blocked,
      );
      await prefs.setString('weatherAlerts', jsonEncode([for (final a in alerts) a.toJson()]));
      await Alarm.init();
      final planned = weatherAlarmsFor(alerts, time);
      final keep = {for (final a in planned) a.id};
      for (final old in prefs.getStringList(_idsKey) ?? const <String>[]) {
        final id = int.tryParse(old);
        if (id != null && !keep.contains(id)) await Alarm.stop(id);
      }
      for (final a in planned) {
        final soft = a.style.loudness != null;
        await Alarm.set(
          alarmSettings: AlarmRegistrar.settingsFor(
            a.id,
            a.at,
            RingPayload(
              title: a.title,
              body: a.body,
              ringSeconds: a.ringDuration.inSeconds,
              spoken: false,
              loudness: soft ? softLoudness : Loudness.standard,
            ),
          ),
        );
      }
      await prefs.setStringList(_idsKey, [for (final a in planned) '${a.id}']);
      return true;
    } catch (e) {
      debugPrint('Quando?: weather background check failed: $e');
      return false;
    } finally {
      repository.close();
    }
  }

  static WeatherAlarmSettings _settings(SharedPreferences prefs) {
    try {
      return WeatherAlarmSettings.fromJson(
        jsonDecode(prefs.getString('weatherAlarms') ?? '{}') as Map<String, dynamic>,
      );
    } catch (_) {
      return const WeatherAlarmSettings();
    }
  }
}

@pragma('vm:entry-point')
void weatherCallbackDispatcher() {
  Workmanager().executeTask((task, input) async => WeatherBackground.run());
}
