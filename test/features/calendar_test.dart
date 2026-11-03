import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/calendar/data/calendar_reader.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime.utc(2026, 11, 3, 12);

class _FakeReader implements CalendarReader {
  bool granted = false;
  DateTime? askedFrom;
  DateTime? askedTo;

  @override
  Future<bool> hasAccess() async => granted;

  @override
  Future<bool> requestAccess() async => granted = true;

  @override
  Future<List<PhoneCalendar>> calendars() async => const [
    PhoneCalendar(id: 'work', name: 'Work'),
    PhoneCalendar(id: 'home', name: 'Home'),
  ];

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> ids) async {
    askedFrom = from;
    askedTo = to;
    AnchorEvent ev(String id, String cal, String title, DateTime start, DateTime end) => [
      AnchorEvent(id: 'cal.$id', kind: EventKind.calendar, title: title, at: start, source: cal),
      AnchorEvent(
        id: 'calend.$id',
        kind: EventKind.calendarEnd,
        title: '$title (ends)',
        at: end,
        source: cal,
      ),
    ].first;
    final all = [
      ev('1', 'work', 'Standup', DateTime.utc(2026, 11, 4, 7), DateTime.utc(2026, 11, 4, 7, 15)),
      AnchorEvent(
        id: 'calend.1',
        kind: EventKind.calendarEnd,
        title: 'Standup (ends)',
        at: DateTime.utc(2026, 11, 4, 7, 15),
        source: 'work',
      ),
      ev('2', 'home', 'Dentist', DateTime.utc(2026, 11, 5, 9), DateTime.utc(2026, 11, 5, 10)),
      AnchorEvent(
        id: 'calend.2',
        kind: EventKind.calendarEnd,
        title: 'Dentist (ends)',
        at: DateTime.utc(2026, 11, 5, 10),
        source: 'home',
      ),
    ];
    return [
      for (final e in all)
        if (ids.contains(e.source)) e,
    ];
  }
}

Future<(ProviderContainer, _FakeReader)> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final reader = _FakeReader();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => _now),
      prefsProvider.overrideWithValue(prefs),
      calendarReaderProvider.overrideWithValue(reader),
    ],
  );
  addTearDown(c.dispose);
  // Keep the presets out of the way.
  for (final r in Presets.all) {
    c.read(rulesProvider.notifier).toggle(r.id, false);
  }
  return (c, reader);
}

List<DateTime> _calendarAlarms(ProviderContainer c) => [
  for (final a in c.read(planProvider))
    if (a.ruleId.startsWith('cal.')) a.at,
];

void main() {
  test('nothing is read until calendars are connected', () async {
    final (c, _) = await _container();
    await c.read(calendarProvider.notifier).refresh();
    expect(c.read(calendarProvider).access, isFalse);
    expect(c.read(calendarProvider).events, isEmpty);
  });

  test('alarms before the start and after the end of every event', () async {
    final (c, _) = await _container();
    await c.read(calendarProvider.notifier).connect();
    c
        .read(calendarRulesProvider.notifier)
        .save(
          const CalendarRule(
            id: 'r',
            before: [Duration(minutes: 15), Duration(hours: 1)],
            after: [Duration(minutes: 5)],
          ),
        );
    expect(_calendarAlarms(c), [
      DateTime.utc(2026, 11, 4, 6), // standup -1h
      DateTime.utc(2026, 11, 4, 6, 45), // -15m
      DateTime.utc(2026, 11, 4, 7, 20), // ends +5m
      DateTime.utc(2026, 11, 5, 8),
      DateTime.utc(2026, 11, 5, 8, 45),
      DateTime.utc(2026, 11, 5, 10, 5),
    ]);
    final first = c.read(planProvider).firstWhere((a) => a.ruleId.startsWith('cal.'));
    expect(first.title, 'Standup');
    expect(first.body, '1 hour before');
  });

  test('keyword and calendar filters', () async {
    final (c, _) = await _container();
    await c.read(calendarProvider.notifier).connect();
    final rules = c.read(calendarRulesProvider.notifier);
    rules.save(const CalendarRule(id: 'k', keyword: 'DENT', atStart: true));
    expect(_calendarAlarms(c), [DateTime.utc(2026, 11, 5, 9)]);
    rules.save(const CalendarRule(id: 'k', calendarIds: {'work'}, atStart: true));
    expect(_calendarAlarms(c), [DateTime.utc(2026, 11, 4, 7)]);
  });

  test('switching a calendar off drops its events', () async {
    final (c, _) = await _container();
    await c.read(calendarProvider.notifier).connect();
    c.read(calendarRulesProvider.notifier).save(const CalendarRule(id: 'r', atStart: true));
    await c.read(calendarProvider.notifier).select('home', false);
    expect(_calendarAlarms(c), [DateTime.utc(2026, 11, 4, 7)]);
  });

  test('every hour for 3 hours before', () async {
    final (c, _) = await _container();
    await c.read(calendarProvider.notifier).connect();
    c
        .read(calendarRulesProvider.notifier)
        .save(
          const CalendarRule(
            id: 'r',
            keyword: 'dentist',
            repeatEvery: Duration(hours: 1),
            repeatFor: Duration(hours: 3),
          ),
        );
    expect(_calendarAlarms(c), [
      DateTime.utc(2026, 11, 5, 6),
      DateTime.utc(2026, 11, 5, 7),
      DateTime.utc(2026, 11, 5, 8),
    ]);
  });

  test('a week-before rule reads events far enough ahead', () async {
    final (c, reader) = await _container();
    await c.read(calendarProvider.notifier).connect();
    c.read(calendarRulesProvider.notifier).save(const CalendarRule(id: 'r', before: [Duration(days: 7)]));
    await c.read(calendarProvider.notifier).refresh();
    expect(reader.askedTo!.isAfter(_now.add(const Duration(days: 13))), isTrue);
  });

  test('rules survive a restart', () async {
    final (c, _) = await _container();
    c
        .read(calendarRulesProvider.notifier)
        .save(const CalendarRule(id: 'x', keyword: 'flight', after: [Duration(hours: 1)]));
    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(c.read(prefsProvider))]);
    addTearDown(again.dispose);
    final r = again.read(calendarRulesProvider).single;
    expect(r.keyword, 'flight');
    expect(r.after, [const Duration(hours: 1)]);
  });

  test('event alarms find events by search, Shabbat times included when asked', () async {
    final (c, reader) = await _container();
    reader.granted = true;
    await c.read(calendarProvider.notifier).refresh();

    c
        .read(calendarRulesProvider.notifier)
        .save(const CalendarRule(id: 'q', keyword: 'dent* OR "stand"', before: [Duration(minutes: 10)]));
    final cal = c.read(planProvider).where((a) => a.ruleId == 'cal.q.start').map((a) => a.title).toSet();
    expect(cal, {'Standup', 'Dentist'});

    c
        .read(calendarRulesProvider.notifier)
        .save(const CalendarRule(id: 'q', keyword: 'stand* -dentist', before: [Duration(minutes: 10)]));
    expect(c.read(planProvider).where((a) => a.ruleId == 'cal.q.start').map((a) => a.title).toSet(), {
      'Standup',
    });

    c
        .read(calendarRulesProvider.notifier)
        .save(
          const CalendarRule(
            id: 'shab',
            keyword: 'candle*',
            includeTimes: true,
            before: [Duration(minutes: 20)],
          ),
        );
    final shab = c.read(planProvider).where((a) => a.ruleId == 'cal.shab.times').toList();
    expect(shab, isNotEmpty);
    expect(shab.every((a) => a.title.toLowerCase().startsWith('candle')), isTrue);
    expect(c.read(planProvider).where((a) => a.ruleId == 'cal.shab.start'), isEmpty);

    // Havdalah is a moment too: 10 minutes after it.
    c
        .read(calendarRulesProvider.notifier)
        .save(
          const CalendarRule(
            id: 'hav',
            keyword: 'havdalah',
            includeTimes: true,
            after: [Duration(minutes: 10)],
          ),
        );
    final hav = c.read(planProvider).where((a) => a.ruleId == 'cal.hav.times').toList();
    expect(hav, isNotEmpty);
    expect(hav.every((a) => a.offset == const Duration(minutes: 10)), isTrue);

    final found = await c.read(searchableEventsProvider.future);
    expect(found.any((e) => e.title == 'Dentist'), isTrue);
    expect(found.any((e) => e.kind == EventKind.holyDayStart), isTrue);
  });
}
