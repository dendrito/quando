import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/calendar/data/loud_notifications.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final dentist = AnchorEvent(
    id: 'cal.1',
    kind: EventKind.calendar,
    title: 'Dentist',
    at: DateTime.utc(2026, 11, 12, 15),
    source: 'work',
    reminders: const [Duration(minutes: 10), Duration(hours: 1)],
  );
  const scheduler = Scheduler();

  test("a calendar alarm rings at the event's own reminders", () {
    const rule = CalendarRule(id: 'r', eventReminders: true);
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 12, 8),
      events: [dentist],
      rules: rule.toAlarmRules(),
    );
    expect(plan.map((a) => a.at.difference(dentist.at).inMinutes), [-60, -10]);
    expect(plan.first.title, 'Dentist');
  });

  test('own offsets and the event reminders ring once per minute', () {
    const rule = CalendarRule(
      id: 'r',
      eventReminders: true,
      before: [Duration(minutes: 10), Duration(minutes: 30)],
    );
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 12, 8),
      events: [dentist],
      rules: rule.toAlarmRules(),
    );
    expect(plan.map((a) => a.at.difference(dentist.at).inMinutes), [-60, -30, -10]);
  });

  test('without the switch, event reminders are ignored', () {
    const rule = CalendarRule(id: 'r', before: [Duration(minutes: 30)]);
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 12, 8),
      events: [dentist],
      rules: rule.toAlarmRules(),
    );
    expect(plan.map((a) => a.at.difference(dentist.at).inMinutes), [-30]);
  });

  test('a reminders-only rule reads a week of events ahead', () {
    const rule = CalendarRule(id: 'r', eventReminders: true);
    final now = DateTime.utc(2026, 11, 12);
    final window = scheduler.eventWindow(now, rule.toAlarmRules());
    expect(window.to.difference(now), const Duration(days: 14));
  });

  test('the switch survives a restart', () {
    const rule = CalendarRule(id: 'r', eventReminders: true);
    final back = CalendarRule.fromJson(jsonDecode(jsonEncode(rule.toJson())) as Map<String, dynamic>);
    expect(back.eventReminders, isTrue);
    expect(back.hasAlarms, isTrue);
    expect(CalendarRule.fromJson(const {'id': 'old'}).eventReminders, isFalse);
  });

  test('loud notifications hand the listener a template, planned alarms and quiet times', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final loud = LoudNotifications(prefs);
    expect(loud.on, isFalse);
    expect(loud.apps, contains('com.google.android.calendar'));
    await loud.setApps({'com.samsung.android.calendar'});
    expect(loud.apps, {'com.samsung.android.calendar'});

    final now = DateTime.utc(2026, 11, 12, 14);
    final plan = [
      ScheduledAlarm(
        id: 1,
        at: DateTime.utc(2026, 11, 12, 14, 50),
        title: 'Dentist',
        body: '10 minutes before',
        ringDuration: const Duration(minutes: 1),
        ruleId: 'cal.r.start',
        eventId: 'cal.1',
        offset: const Duration(minutes: -10),
      ),
      ScheduledAlarm(
        id: 2,
        at: DateTime.utc(2026, 11, 12, 15),
        title: 'Wake up',
        body: '',
        ringDuration: const Duration(minutes: 1),
        ruleId: 'user.a',
        eventId: 'x',
        offset: Duration.zero,
      ),
    ];
    await loud.publish(
      now: now,
      plan: plan,
      payloadFor: (a) => RingPayload(title: a.title, body: a.body, ringSeconds: 60),
      quiet: [
        HolyPeriod(start: now, end: now.add(const Duration(hours: 25)), names: const ['Shabbat']),
      ],
    );
    final template = jsonDecode(prefs.getString(LoudNotifications.templateKey)!) as Map<String, dynamic>;
    expect(template['notificationSettings'], isA<Map>());
    // Re-planning must leave these alarms alone.
    expect(RingPayload.decode(template['payload'] as String).transient, isTrue);
    final planned = jsonDecode(prefs.getString(LoudNotifications.plannedKey)!) as List;
    expect(planned, [
      {'t': 'Dentist', 'at': DateTime.utc(2026, 11, 12, 14, 50).millisecondsSinceEpoch},
    ]);
    expect(jsonDecode(prefs.getString(LoudNotifications.quietKey)!), hasLength(1));
  });
}
