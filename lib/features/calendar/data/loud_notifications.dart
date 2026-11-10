import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/scheduler/scheduler.dart';
import '../../alarms/data/alarm_registrar.dart';
import '../../events/domain/event.dart';
import '../../ringing/ring_payload.dart';

/// A calendar app whose reminders Quando? can ring loud.
class CalendarApp {
  const CalendarApp(this.package, this.name);

  final String package;
  final String name;

  static const known = [
    CalendarApp('com.google.android.calendar', 'Google Calendar'),
    CalendarApp('com.samsung.android.calendar', 'Samsung Calendar'),
    CalendarApp('com.microsoft.office.outlook', 'Outlook'),
    CalendarApp('com.android.calendar', 'Calendar'),
    CalendarApp('com.xiaomi.calendar', 'Xiaomi Calendar'),
    CalendarApp('com.oneplus.calendar', 'OnePlus Calendar'),
    CalendarApp('com.coloros.calendar', 'OPPO Calendar'),
    CalendarApp('com.huawei.calendar', 'Huawei Calendar'),
    CalendarApp('com.appgenix.bizcal', 'Business Calendar'),
    CalendarApp('com.tasks.android', 'Tasks'),
  ];
}

/// "Make calendar notifications loud" (Android only): when a picked
/// calendar app shows a reminder, Quando? rings it as an alarm.
///
/// The work happens in the Android notification listener (QuandoListener),
/// which runs without Flutter. This side keeps what it needs in
/// SharedPreferences: on/off, the apps, how the alarm rings (a template of
/// the alarm settings), the calendar alarms Quando? already rings (so an
/// event never rings twice) and the Shabbat and festival times to stay
/// quiet in.
class LoudNotifications {
  LoudNotifications(this._prefs);

  final SharedPreferences _prefs;
  static const _channel = MethodChannel('quando/phone');

  static const onKey = 'loudCalendar.on';
  static const appsKey = 'loudCalendar.apps';
  static const templateKey = 'loudCalendar.template';
  static const plannedKey = 'loudCalendar.planned';
  static const quietKey = 'loudCalendar.quiet';

  bool get on => _prefs.getBool(onKey) ?? false;

  /// Picked apps. Never chosen = every known calendar app.
  Set<String> get apps {
    final raw = _prefs.getString(appsKey);
    if (raw == null) return {for (final a in CalendarApp.known) a.package};
    try {
      return {for (final p in jsonDecode(raw) as List) p as String};
    } catch (_) {
      return const {};
    }
  }

  Future<void> setOn(bool v) => _prefs.setBool(onKey, v);

  Future<void> setApps(Set<String> apps) => _prefs.setString(appsKey, jsonEncode(apps.toList()..sort()));

  static Future<bool> allowed() async {
    try {
      return await _channel.invokeMethod<bool>('listenerAllowed') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<void> openSettings() async {
    try {
      await _channel.invokeMethod<bool>('openListenerSettings');
    } on PlatformException {
      // Nothing to open on this phone.
    } on MissingPluginException {
      // Not Android.
    }
  }

  /// The known calendar apps that are on this phone.
  static Future<List<CalendarApp>> installed() async {
    try {
      final got = await _channel.invokeListMethod<String>('installed', {
        'packages': [for (final a in CalendarApp.known) a.package],
      });
      final have = {...?got};
      return [
        for (final a in CalendarApp.known)
          if (have.contains(a.package)) a,
      ];
    } on PlatformException {
      return const [];
    } on MissingPluginException {
      return const [];
    }
  }

  /// Hands the listener what it needs. Cheap; called after every re-plan.
  Future<void> publish({
    required DateTime now,
    required List<ScheduledAlarm> plan,
    required RingPayload Function(ScheduledAlarm) payloadFor,
    required List<HolyPeriod> quiet,
  }) async {
    final p = payloadFor(
      ScheduledAlarm(
        id: 0,
        at: now,
        title: '',
        body: '',
        ringDuration: const Duration(minutes: 1),
        ruleId: 'loud.calendar',
        eventId: '',
        offset: Duration.zero,
      ),
    ).asExternal();
    final template = AlarmRegistrar.settingsFor(0, now, p).toJson();
    await _prefs.setString(templateKey, jsonEncode(template));
    await _prefs.setString(
      plannedKey,
      jsonEncode([
        for (final a in plan)
          if (a.ruleId.startsWith('cal.') && a.at.difference(now) < const Duration(days: 2))
            {'t': a.title, 'at': a.at.millisecondsSinceEpoch},
      ]),
    );
    await _prefs.setString(
      quietKey,
      jsonEncode([
        for (final q in quiet) [q.start.millisecondsSinceEpoch, q.end.millisecondsSinceEpoch],
      ]),
    );
  }
}
