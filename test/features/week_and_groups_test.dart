import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/home/domain/week.dart';
import 'package:shared_preferences/shared_preferences.dart';

ScheduledAlarm _a(DateTime at, String title) => ScheduledAlarm(
  id: at.millisecondsSinceEpoch,
  at: at,
  title: title,
  body: 'b',
  ringDuration: const Duration(seconds: 30),
  ruleId: 'r',
  eventId: 'e',
  offset: Duration.zero,
);

void main() {
  test('the week folds into days, and each day into series', () {
    final plan = [
      _a(DateTime.utc(2026, 11, 6, 9), 'Candle lighting'),
      _a(DateTime.utc(2026, 11, 6, 8), 'Candle lighting'),
      _a(DateTime.utc(2026, 11, 6, 7), 'Wake up'),
      _a(DateTime.utc(2026, 11, 6, 13), 'Candle lighting'),
      _a(DateTime.utc(2026, 11, 7, 7), 'Wake up'),
    ];
    final week = weekPlan(plan, 'Europe/London');
    expect(week.length, 2);
    expect(week.first.count, 4);
    expect(
      [for (final s in week.first.series) s.title],
      ['Wake up', 'Candle lighting'],
    );
    final candles = week.first.series.last;
    expect(candles.alarms.length, 3);
    expect(candles.first, DateTime.utc(2026, 11, 6, 8));
    expect(candles.last, DateTime.utc(2026, 11, 6, 13));

    final today = DateTime(2026, 11, 6);
    expect(dayHeading(DateTime(2026, 11, 6), today), 'Today');
    expect(dayHeading(DateTime(2026, 11, 7), today), 'Tomorrow');
    expect(dayHeading(DateTime(2026, 11, 9), today), 'Mon 9 Nov');
  });

  test('groups: named, switched together, renamed, and kept', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    ProviderContainer make() => ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
        prefsProvider.overrideWithValue(prefs),
      ],
    );
    final c = make();
    addTearDown(c.dispose);
    final alarms = c.read(userAlarmsProvider.notifier);
    alarms.save(
      const UserAlarm(id: 'a', hour: 7, minute: 0, days: {1}, group: 'Work'),
    );
    alarms.save(
      const UserAlarm(id: 'b', hour: 8, minute: 0, days: {2}, group: 'Work'),
    );
    alarms.save(
      const UserAlarm(id: 'c', hour: 9, minute: 0, days: {3}, group: 'Kids'),
    );
    alarms.save(const UserAlarm(id: 'd', hour: 10, minute: 0, days: {4}));
    expect(alarms.groups, ['Kids', 'Work']);

    alarms.toggleGroup('Work', false);
    expect(
      [for (final a in c.read(userAlarmsProvider)) a.enabled],
      [false, false, true, true],
    );

    alarms.renameGroup('Work', 'Office');
    expect(alarms.groups, ['Kids', 'Office']);

    final again = make();
    addTearDown(again.dispose);
    expect(again.read(userAlarmsProvider.notifier).groups, ['Kids', 'Office']);
  });
}
