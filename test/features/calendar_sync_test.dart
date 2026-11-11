import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/busy/domain/busy.dart';
import 'package:quando/features/calendar/data/calendar_reader.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/calendar/domain/calendar_sync.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime.utc(2026, 11, 3, 12);
final _tue = DateTime.utc(2026, 11, 10, 9);
final _wed = DateTime.utc(2026, 11, 11, 9);
final _thu = DateTime.utc(2026, 11, 5, 9);

/// A calendar the test edits between reads.
class _Calendar implements CalendarReader {
  final items = <String, (String title, DateTime start)>{};

  @override
  Future<bool> hasAccess() async => true;

  @override
  Future<bool> requestAccess() async => true;

  @override
  Future<List<PhoneCalendar>> calendars() async => const [PhoneCalendar(id: 'home', name: 'Home')];

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> ids) async => [
    for (final MapEntry(key: id, value: (title, start)) in items.entries) ...[
      AnchorEvent(id: 'cal.$id', kind: EventKind.calendar, title: title, at: start, source: 'home'),
      AnchorEvent(
        id: 'calend.$id',
        kind: EventKind.calendarEnd,
        title: '$title ends',
        at: start.add(const Duration(hours: 1)),
        source: 'home',
      ),
    ],
  ];
}

Future<(ProviderContainer, _Calendar, SharedPreferences)> _setUp({
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final p = await SharedPreferences.getInstance();
  final cal = _Calendar();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => _now),
      prefsProvider.overrideWithValue(p),
      calendarReaderProvider.overrideWithValue(cal),
    ],
  );
  addTearDown(c.dispose);
  for (final r in Presets.all) {
    c.read(rulesProvider.notifier).toggle(r.id, false);
  }
  return (c, cal, p);
}

/// Calendar alarm times, in order. The plan looks a week ahead from _now.
List<DateTime> _alarms(ProviderContainer c) => [
  for (final a in c.read(planProvider))
    if (a.ruleId.startsWith('cal.')) a.at,
];

Future<void> _save(ProviderContainer c, CalendarSync sync) async {
  c
      .read(calendarRulesProvider.notifier)
      .save(CalendarRule(id: 'r', keyword: 'dentist', atStart: true, sync: sync));
  await c.read(calendarProvider.notifier).refresh();
}

Future<void> _read(ProviderContainer c) => c.read(calendarProvider.notifier).refresh();

void main() {
  test('rules saved before this update follow the calendar live', () {
    final old = CalendarRule.fromJson(
      jsonDecode('{"id":"r","keyword":"dentist","atStart":true}') as Map<String, dynamic>,
    );
    expect(old.sync, CalendarSync.live);
    expect(old.toJson().containsKey('sync'), isFalse);
    final kept = CalendarRule.fromJson(old.copyWith(sync: CalendarSync.keepFirst).toJson());
    expect(kept.sync, CalendarSync.keepFirst);
    expect(CalendarRule.fromJson({'id': 'x', 'sync': 'nonsense'}).sync, CalendarSync.live);
  });

  group('Follow the calendar', () {
    test('a new event gets an alarm, a moved one moves, a deleted one goes', () async {
      final (c, cal, _) = await _setUp();
      cal.items['1'] = ('Dentist', _thu);
      await _save(c, CalendarSync.live);
      expect(_alarms(c), [_thu]);

      cal.items['2'] = ('Dentist again', _tue.subtract(const Duration(days: 1)));
      await _read(c);
      expect(_alarms(c), [_thu, DateTime.utc(2026, 11, 9, 9)]);

      cal.items['1'] = ('Dentist', _thu.add(const Duration(hours: 2)));
      await _read(c);
      expect(_alarms(c), [DateTime.utc(2026, 11, 5, 11), DateTime.utc(2026, 11, 9, 9)]);

      cal.items.remove('1');
      await _read(c);
      expect(_alarms(c), [DateTime.utc(2026, 11, 9, 9)]);
    });
  });

  group('Keep what I first saw', () {
    test('new events still get alarms, but moves and deletions are ignored', () async {
      final (c, cal, _) = await _setUp();
      cal.items['1'] = ('Dentist', _thu);
      await _save(c, CalendarSync.keepFirst);
      expect(_alarms(c), [_thu]);

      // Moved: the alarm stays where it was first seen, and doesn't double.
      cal.items['1'] = ('Dentist', _thu.add(const Duration(hours: 2)));
      await _read(c);
      expect(_alarms(c), [_thu]);

      // New: it gets an alarm.
      cal.items['2'] = ('Dentist', DateTime.utc(2026, 11, 9, 9));
      await _read(c);
      expect(_alarms(c), [_thu, DateTime.utc(2026, 11, 9, 9)]);

      // Deleted: the alarm stays.
      cal.items.remove('1');
      await _read(c);
      expect(_alarms(c), [_thu, DateTime.utc(2026, 11, 9, 9)]);
    });

    test('what it saw survives a restart', () async {
      final (c, cal, p) = await _setUp();
      cal.items['1'] = ('Dentist', _thu);
      await _save(c, CalendarSync.keepFirst);
      cal.items['1'] = ('Dentist', _thu.add(const Duration(hours: 2)));

      final again = ProviderContainer(
        overrides: [
          clockProvider.overrideWithValue(() => _now),
          prefsProvider.overrideWithValue(p),
          calendarReaderProvider.overrideWithValue(cal),
        ],
      );
      addTearDown(again.dispose);
      await again.read(calendarProvider.notifier).refresh();
      expect(_alarms(again), [_thu]);
    });

    test('changing the search starts over', () async {
      final (c, cal, _) = await _setUp();
      cal.items['1'] = ('Dentist', _thu);
      await _save(c, CalendarSync.keepFirst);
      cal.items['1'] = ('Dentist', _wed);
      c
          .read(calendarRulesProvider.notifier)
          .save(const CalendarRule(id: 'r', keyword: 'dent*', atStart: true, sync: CalendarSync.keepFirst));
      await _read(c);
      expect(_alarms(c), [_wed].where((d) => d.isBefore(_now.add(const Duration(days: 7)))).toList());
    });
  });

  group('Only events that exist now', () {
    test('takes the events there when saved, as they were, and nothing new', () async {
      final (c, cal, _) = await _setUp();
      cal.items['1'] = ('Dentist', _thu);
      await _save(c, CalendarSync.snapshot);
      expect(_alarms(c), [_thu]);

      cal.items['2'] = ('Dentist', DateTime.utc(2026, 11, 9, 9));
      cal.items['1'] = ('Dentist', _thu.add(const Duration(hours: 2)));
      await _read(c);
      expect(_alarms(c), [_thu]);

      cal.items.clear();
      await _read(c);
      expect(_alarms(c), [_thu]);
    });
  });

  test('a failed read never seeds "Only events that exist now" with nothing', () {
    const rule = CalendarRule(id: 'r', keyword: 'dentist', sync: CalendarSync.snapshot);
    // Nothing remembered yet, and the calendar wasn't read: nothing is called.
    expect(rememberedEvents([rule], const {}), isEmpty);
  });

  test('a remembered event only rings for its own rule, and other rules see the live one', () async {
    final (c, cal, _) = await _setUp();
    cal.items['1'] = ('Dentist', _thu);
    await _save(c, CalendarSync.keepFirst);
    c
        .read(calendarRulesProvider.notifier)
        .save(const CalendarRule(id: 'live', keyword: 'dentist', before: [Duration(hours: 1)]));
    await _read(c);
    cal.items['1'] = ('Dentist', _thu.add(const Duration(hours: 2)));
    await _read(c);
    final plan = [
      for (final a in c.read(planProvider))
        if (a.ruleId.startsWith('cal.')) (a.ruleId, a.at),
    ];
    expect(plan, [('cal.r.start', _thu), ('cal.live.start', DateTime.utc(2026, 11, 5, 10))]);
  });

  test('Busy mode follows the remembered times too', () async {
    final events = [
      AnchorEvent(id: 'cal.1', kind: EventKind.calendar, title: 'Dentist', at: _thu, source: 'home'),
      AnchorEvent(
        id: 'calend.1',
        kind: EventKind.calendarEnd,
        title: 'ends',
        at: _thu.add(const Duration(hours: 1)),
        source: 'home',
      ),
    ];
    const rule = CalendarRule(id: 'r', keyword: 'dentist', busy: true, sync: CalendarSync.keepFirst);
    final memory = rememberEvents(rules: [rule], events: events, memory: const {}, now: _now);
    final windows = busyWindows(
      now: _now,
      until: _now.add(const Duration(days: 7)),
      events: rememberedEvents([rule], memory),
      calendarRules: [rule],
      plan: const [],
      busyMinutesByAlarm: const {},
      locks: const [],
      settings: const BusySettings(),
    );
    expect(windows.single.start, _thu);
    expect(windows.single.end, _thu.add(const Duration(hours: 1)));
  });

  test('past events are forgotten after two days', () {
    final events = [
      AnchorEvent(id: 'cal.1', kind: EventKind.calendar, title: 'Dentist', at: _thu, source: 'home'),
    ];
    const rule = CalendarRule(id: 'r', keyword: 'dentist', sync: CalendarSync.keepFirst);
    final memory = rememberEvents(rules: [rule], events: events, memory: const {}, now: _now);
    expect(memory['r']!.events, hasLength(1));
    final later = rememberEvents(
      rules: [rule],
      events: const [],
      memory: memory,
      now: _thu.add(const Duration(days: 3)),
    );
    expect(later['r']!.events, isEmpty);
    // Deleting the rule forgets it.
    expect(rememberEvents(rules: const [], events: events, memory: memory, now: _now), isEmpty);
  });
}
