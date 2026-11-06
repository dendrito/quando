import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/alarm_rule.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shabbat_on.dart';

void main() {
  final event = AnchorEvent(
    id: 'meeting',
    kind: EventKind.calendar,
    title: 'Meeting',
    at: DateTime.utc(2026, 11, 7, 12),
    source: 'calendar',
  );
  final now = DateTime.utc(2026, 11, 7);
  const scheduler = Scheduler();
  const choices = {
    -60: ReminderDelivery(soundId: 'recording', pushoverEnabled: true, pushoverSound: 'cosmic'),
    -15: ReminderDelivery(soundId: 'radio', pushoverEnabled: false),
    0: ReminderDelivery(useDefaultSound: true),
    5: ReminderDelivery(soundId: 'music'),
  };
  const rule = AlarmRule(
    id: 'rule',
    name: 'Reminder',
    appliesTo: {EventKind.calendar},
    before: [Duration(hours: 1), Duration(minutes: 15)],
    atEvent: true,
    after: [Duration(minutes: 5)],
    soundId: 'legacy',
    ringDuration: Duration(seconds: 3),
  );

  test('old stored rules retain their sound and inherit integration defaults', () {
    final restored = rule.withCustom(jsonDecode(jsonEncode(rule.customJson())));
    final planned = scheduler.plan(now: now, events: [event], rules: [restored]);
    expect(restored.deliveries, isEmpty);
    expect(planned.map((a) => a.soundId), everyElement('legacy'));
    expect(planned.every((a) => a.delivery.pushoverEnabled == null), isTrue);
    expect(planned.every((a) => a.ringDuration == const Duration(seconds: 3)), isTrue);
    expect(
      planned.map((a) => a.id),
      scheduler.plan(now: now, events: [event], rules: [rule]).map((a) => a.id),
    );
  });

  test('different choices survive JSON and reach the matching scheduled offsets', () {
    final configured = rule.copyWith(deliveries: choices);
    final restored = rule.withCustom(jsonDecode(jsonEncode(configured.customJson())));
    final planned = scheduler.plan(now: now, events: [event], rules: [restored]);
    expect(planned.map((a) => a.soundId), ['recording', 'radio', null, 'music']);
    expect(planned.first.delivery.pushoverEnabled, isTrue);
    expect(planned.first.delivery.pushoverSound, 'cosmic');
    expect(planned[1].delivery.pushoverEnabled, isFalse);
    expect(planned[2].delivery.pushoverEnabled, isNull);
    expect(
      planned.map((a) => a.id),
      scheduler.plan(now: now, events: [event], rules: [rule]).map((a) => a.id),
    );
  });

  test('an unset offset inherits the rule sound; explicit default can replace it', () {
    final configured = rule.copyWith(deliveries: {0: choices[0]!});
    final planned = scheduler.plan(now: now, events: [event], rules: [configured]);
    expect(planned.map((a) => a.soundId), ['legacy', 'legacy', null, 'legacy']);
    expect(configured.copyWith(enabled: false).deliveries, configured.deliveries);
    expect(scheduler.plan(now: now, events: [event], rules: [configured.copyWith(enabled: false)]), isEmpty);
  });

  test('overrides do not add removed offsets or change duplicate priority', () {
    final configured = rule.copyWith(deliveries: choices);
    final reduced = configured.withOffsets([const Duration(minutes: -15)]);
    final planned = scheduler.plan(now: now, events: [event], rules: [reduced, rule]);
    expect(planned, hasLength(4));
    expect(planned.singleWhere((a) => a.offset.inMinutes == -15).soundId, 'radio');
    expect(scheduler.plan(now: now, events: [event], rules: [reduced]), hasLength(1));
  });

  test('calendar persistence preserves start, end, series and religious-time overrides', () {
    const calendar = CalendarRule(
      id: 'c',
      before: [Duration(minutes: 15)],
      after: [Duration(minutes: 5)],
      atStart: true,
      includeTimes: true,
      repeatEvery: Duration(hours: 1),
      repeatFor: Duration(hours: 2),
      soundId: 'legacy',
      deliveries: choices,
    );
    final restored = CalendarRule.fromJson(jsonDecode(jsonEncode(calendar.toJson())));
    final rules = restored.copyWith(name: 'Renamed').toAlarmRules();
    final end = AnchorEvent(
      id: 'end',
      kind: EventKind.calendarEnd,
      title: 'End',
      at: event.at.add(const Duration(hours: 1)),
      source: 'calendar',
    );
    final holy = AnchorEvent(
      id: 'holy',
      kind: EventKind.holyDayStart,
      title: 'Candles',
      at: event.at,
      source: 'times',
    );
    final planned = scheduler.plan(now: now, events: [event, end, holy], rules: rules);
    expect(
      planned.singleWhere((a) => a.eventId == 'meeting' && a.offset.inMinutes == -60).soundId,
      'recording',
    );
    expect(
      planned.singleWhere((a) => a.eventId == 'meeting' && a.offset.inMinutes == -120).soundId,
      'legacy',
    );
    expect(planned.singleWhere((a) => a.eventId == 'end').soundId, 'music');
    expect(
      planned.singleWhere((a) => a.eventId == 'holy' && a.offset.inMinutes == -15).delivery.pushoverEnabled,
      isFalse,
    );
    final old = calendar.toJson()..remove('deliveries');
    expect(CalendarRule.fromJson(old).deliveries, isEmpty);
  });

  test('preset and calendar overrides survive provider recreation and reset', () async {
    SharedPreferences.setMockInitialValues({...shabbatOn});
    final prefs = await SharedPreferences.getInstance();
    ProviderContainer make() {
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
      addTearDown(c.dispose);
      return c;
    }

    final first = make();
    final id = Presets.countdown.id;
    first.read(rulesProvider.notifier).edit(id, (r) => r.copyWith(deliveries: choices));
    first.read(calendarRulesProvider.notifier).save(const CalendarRule(id: 'cal', deliveries: choices));
    // Persistence is asynchronous; drain pending mock preference writes.
    await Future<void>.delayed(Duration.zero);
    final again = make();
    expect(
      again
          .read(rulesProvider)
          .singleWhere((r) => r.id == id)
          .deliveryAt(const Duration(hours: -1))
          .pushoverSound,
      'cosmic',
    );
    expect(again.read(calendarRulesProvider).single.deliveries[-15]!.pushoverEnabled, isFalse);
    again.read(rulesProvider.notifier).reset(id);
    await Future<void>.delayed(Duration.zero);
    expect(make().read(rulesProvider).singleWhere((r) => r.id == id).deliveries, isEmpty);
  });
}
