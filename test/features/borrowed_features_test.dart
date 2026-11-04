import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/events/domain/sun_times.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:quando/features/settings/domain/alarm_options.dart';
import 'package:quando/features/shabbat/domain/place.dart';

import '../shabbat_on.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container([Map<String, Object> saved = const {}]) async {
  SharedPreferences.setMockInitialValues({...shabbatOn, ...saved});
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
      prefsProvider.overrideWithValue(prefs),
    ],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  test('sunrise and sunset in Jerusalem', () {
    final events = const SunTimes(place: Places.jerusalem)
        .events(DateTime.utc(2026, 11, 6), DateTime.utc(2026, 11, 7));
    final sunset = events.firstWhere((e) => e.kind == EventKind.sunset);
    // Candle lighting that day is 14:05:34Z, 40 minutes before sea-level sunset.
    expect(sunset.at.difference(DateTime.utc(2026, 11, 6, 14, 45, 34)).inSeconds.abs(), lessThan(60));
    final sunrise = events.firstWhere((e) => e.kind == EventKind.sunrise);
    expect(sunrise.at.hour, inInclusiveRange(3, 4)); // ~06:00 local
  });

  test('Friday reminder rings 3 hours before candle lighting with its label', () async {
    final c = await _container();
    final reminder = c.read(planProvider).firstWhere((a) => a.ruleId == Presets.fridayReminder.id);
    expect(reminder.at, DateTime.utc(2026, 11, 6, 11, 5, 34));
    expect(reminder.body, contains('Charge your phone'));
  });

  test('sun alarms appear only when switched on', () async {
    final c = await _container();
    expect(c.read(planProvider).where((a) => a.title == 'Sunrise'), isEmpty);
    c.read(rulesProvider.notifier).toggle(Presets.sunrise.id, true);
    expect(c.read(planProvider).where((a) => a.title == 'Sunrise'), isNotEmpty);
  });

  test('alarms inside Shabbat never ask to be touched', () async {
    final c = await _container();
    c.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(mathTask: true, wakeCheck: true));
    c.read(rulesProvider.notifier).toggle(Presets.sunrise.id, true);
    final plan = c.read(planProvider);
    final payloadFor = c.read(payloadForProvider);

    final shabbatSunrise = plan.firstWhere((a) => a.title == 'Sunrise' && a.at.day == 7);
    final p = payloadFor(shabbatSunrise);
    expect(p.shabbatSafe, isTrue);
    expect(p.canSnooze, isFalse);
    expect(p.mathTask, isFalse);
    expect(p.wakeCheck, isFalse);
    expect(p.spoken, isFalse);

    final weekday = payloadFor(plan.firstWhere((a) => a.title == 'Sunrise' && a.at.day == 4));
    expect(weekday.shabbatSafe, isFalse);
    expect(weekday.mathTask, isTrue);
    expect(weekday.canSnooze, isTrue);
  });

  test('snooze limit and wake-up check payloads', () {
    final p = RingPayload.forAlarm(
      title: 'Candle lighting · Shabbat',
      body: '15 minutes before',
      options: const AlarmOptions(maxSnoozes: 2, wakeCheck: true),
      shabbatSafe: false,
    );
    final once = RingPayload.decode(p.snoozed().encode());
    expect(once.snoozeCount, 1);
    expect(once.canSnooze, isTrue);
    expect(once.transient, isTrue);
    expect(once.snoozed().canSnooze, isFalse);
    expect(p.check().isCheck, isTrue);
    expect(p.check().wakeCheck, isFalse); // a check never schedules another
    expect(p.spokenText, 'Candle lighting, Shabbat. 15 minutes before.');
  });

  test('settings survive a restart', () async {
    final c = await _container();
    c.read(placeProvider.notifier).set(Places.london);
    c.read(placeProvider.notifier).setCandleMinutes(25);
    c.read(rulesProvider.notifier).toggle(Presets.hourly.id, false);
    c.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(maxSnoozes: 4));
    final prefs = c.read(prefsProvider);

    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(again.dispose);
    expect(again.read(placeProvider).name, 'London');
    expect(again.read(placeProvider).candleLightingMinutes, 25);
    expect(again.read(rulesProvider).firstWhere((r) => r.id == Presets.hourly.id).enabled, isFalse);
    expect(again.read(alarmOptionsProvider).maxSnoozes, 4);
  });
}
