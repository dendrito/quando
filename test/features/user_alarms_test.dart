import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tue 3 Nov 2026, 12:00 UTC = 14:00 in Jerusalem.
final _now = DateTime.utc(2026, 11, 3, 12);

Future<ProviderContainer> _container() async {
  ensureTimeZones();
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [clockProvider.overrideWithValue(() => _now), prefsProvider.overrideWithValue(prefs)],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  test('weekday alarm at 07:00 rings Mon-Fri in the city\'s time', () async {
    final c = await _container();
    c
        .read(userAlarmsProvider.notifier)
        .save(const UserAlarm(id: 'a', hour: 7, minute: 0, days: {1, 2, 3, 4, 5}, label: 'Work'));
    final mine = c.read(planProvider).where((a) => a.ruleId == 'user.a').toList();
    // Wed, Thu, Fri, Mon, Tue (the 10th, still inside 7 days).
    expect(mine.map((a) => a.at.day), [4, 5, 6, 9, 10]);
    expect(mine.first.at, DateTime.utc(2026, 11, 4, 5)); // 07:00 Jerusalem (UTC+2)
    expect(mine.first.title, 'Work');
    expect(mine.first.body, 'Weekdays');
  });

  test('a one-off alarm rings once, at the next 07:00', () async {
    final c = await _container();
    c.read(userAlarmsProvider.notifier).save(const UserAlarm(id: 'b', hour: 7, minute: 0));
    final mine = c.read(planProvider).where((a) => a.ruleId == 'user.b').toList();
    expect(mine.map((a) => a.at), [DateTime.utc(2026, 11, 4, 5)]);
  });

  test('a one-off later today rings today', () async {
    final c = await _container();
    c.read(userAlarmsProvider.notifier).save(const UserAlarm(id: 'c', hour: 15, minute: 30));
    expect(
      c.read(planProvider).where((a) => a.ruleId == 'user.c').single.at,
      DateTime.utc(2026, 11, 3, 13, 30),
    );
  });

  test('switching off and deleting', () async {
    final c = await _container();
    final n = c.read(userAlarmsProvider.notifier);
    n.save(const UserAlarm(id: 'd', hour: 6, minute: 30, days: {1, 2, 3, 4, 5, 6, 7}));
    expect(c.read(planProvider).where((a) => a.ruleId == 'user.d'), hasLength(7));
    n.toggle('d', false);
    expect(c.read(planProvider).where((a) => a.ruleId == 'user.d'), isEmpty);
    n.delete('d');
    expect(c.read(userAlarmsProvider), isEmpty);
  });

  test('own ring length goes into the payload; Shabbat morning stays hands-free', () async {
    final c = await _container();
    c.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(mathTask: true));
    c
        .read(userAlarmsProvider.notifier)
        .save(const UserAlarm(id: 'e', hour: 8, minute: 0, days: {1, 2, 3, 4, 5, 6, 7}, ringSeconds: 240));
    final payloadFor = c.read(payloadForProvider);
    final mine = c.read(planProvider).where((a) => a.ruleId == 'user.e').toList();
    final weekday = payloadFor(mine.firstWhere((a) => a.at.day == 4));
    expect(weekday.ringSeconds, 240);
    expect(weekday.mathTask, isTrue);
    final saturday = payloadFor(mine.firstWhere((a) => a.at.day == 7));
    expect(saturday.shabbatSafe, isTrue);
    expect(saturday.mathTask, isFalse);
    expect(saturday.ringSeconds, 240);
  });

  test('alarms survive a restart', () async {
    final c = await _container();
    c.read(userAlarmsProvider.notifier).save(const UserAlarm(id: 'f', hour: 9, minute: 15, days: {6, 7}));
    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(c.read(prefsProvider))]);
    addTearDown(again.dispose);
    final a = again.read(userAlarmsProvider).single;
    expect((a.hour, a.minute, a.repeatLabel), (9, 15, 'Weekends'));
  });
}
