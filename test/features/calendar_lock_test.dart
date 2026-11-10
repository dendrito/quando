import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/calendar/data/calendar_reader.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/lock/domain/lock.dart';
import 'package:quando/features/lock/domain/shabbat_calendar.dart';

final _now = DateTime.utc(2026, 11, 3, 12);

List<AnchorEvent> _event(String id, String title, DateTime start, DateTime end, {String cal = 'work'}) => [
  AnchorEvent(id: 'cal.$id', kind: EventKind.calendar, title: title, at: start, source: cal),
  AnchorEvent(id: 'calend.$id', kind: EventKind.calendarEnd, title: '$title (ends)', at: end, source: cal),
];

final _hebcal = [
  ..._event(
    'h1',
    'Candle lighting: 16:52',
    DateTime.utc(2026, 11, 6, 19, 52),
    DateTime.utc(2026, 11, 6, 19, 52),
    cal: 'hebcal',
  ),
  ..._event(
    'h2',
    'Havdalah (50 min): 18:01',
    DateTime.utc(2026, 11, 7, 21, 1),
    DateTime.utc(2026, 11, 7, 21, 1),
    cal: 'hebcal',
  ),
];

void main() {
  test('between two events: from "Leave office" until the next "Back home"', () {
    final events = [
      ..._event('1', 'Leave office', DateTime.utc(2026, 11, 4, 18), DateTime.utc(2026, 11, 4, 18, 15)),
      ..._event('2', 'Back home', DateTime.utc(2026, 11, 4, 19), DateTime.utc(2026, 11, 4, 19, 5)),
      ..._event('3', 'Back home', DateTime.utc(2026, 11, 5, 19), DateTime.utc(2026, 11, 5, 19, 5)),
    ];
    final p = lockPeriods(
      settings: const LockSettings(
        calendarLocks: [CalendarLock(id: 'commute', startQuery: 'leave office', endQuery: 'back home')],
      ),
      holy: const [],
      calendarEvents: events,
      now: _now,
    ).single;
    expect((p.start, p.end), (DateTime.utc(2026, 11, 4, 18), DateTime.utc(2026, 11, 4, 19)));
    expect(p.look, LockLook.calm);
    expect(p.reason, 'Leave office');
  });

  test('a start with no end within 3 days does not lock forever', () {
    final events = [
      ..._event('1', 'Leave office', DateTime.utc(2026, 11, 4, 18), DateTime.utc(2026, 11, 4, 18, 15)),
      ..._event('2', 'Back home', DateTime.utc(2026, 11, 9, 19), DateTime.utc(2026, 11, 9, 19, 5)),
    ];
    expect(
      calendarLockPeriods(const CalendarLock(id: 'c', startQuery: 'leave', endQuery: 'home'), events),
      isEmpty,
    );
  });

  test('only the chosen calendars count', () {
    final events = [
      ..._event('1', 'Exam', DateTime.utc(2026, 11, 4, 8), DateTime.utc(2026, 11, 4, 10), cal: 'school'),
      ..._event('2', 'Exam', DateTime.utc(2026, 11, 5, 8), DateTime.utc(2026, 11, 5, 10), cal: 'kids'),
    ];
    final p = calendarLockPeriods(
      const CalendarLock(id: 'c', startQuery: 'exam', calendarIds: {'school'}),
      events,
    ).single;
    expect(p.start, DateTime.utc(2026, 11, 4, 8));
  });

  test('a Shabbat calendar is spotted by name or by its candle times', () {
    const cals = [
      PhoneCalendar(id: 'work', name: 'Work'),
      PhoneCalendar(id: 'jew', name: 'Jewish Holidays'),
      PhoneCalendar(id: 'hebcal', name: 'My times'),
    ];
    expect(shabbatCalendarIds(cals, _hebcal), {'jew', 'hebcal'});
    expect(shabbatCalendarIds(const [PhoneCalendar(id: 'work', name: 'Work')], const []), isEmpty);
  });

  test('Shabbat from a Hebcal calendar locks candle lighting to havdalah, with candles', () {
    final p = calendarLockPeriods(
      const CalendarLock(id: 's', startQuery: candleLightingQuery, endQuery: havdalahQuery, name: 'Shabbat'),
      _hebcal,
      shabbatCalendars: {'hebcal'},
    ).single;
    expect((p.start, p.end), (DateTime.utc(2026, 11, 6, 19, 52), DateTime.utc(2026, 11, 7, 21, 1)));
    expect(p.look, LockLook.shabbat);
  });

  test('ordinary events never get Shabbat visuals', () {
    final p = calendarLockPeriods(
      const CalendarLock(id: 'c', startQuery: 'focus'),
      _event('1', 'Focus', DateTime.utc(2026, 11, 6, 19), DateTime.utc(2026, 11, 6, 21)),
      shabbatCalendars: {'hebcal'},
    ).single;
    expect(p.look, LockLook.calm);
  });

  test('"When is candle lighting?" is read from the calendar first, then built-in times', () {
    final fromCal = nextCandleLighting(after: _now, calendarEvents: _hebcal)!;
    expect(
      (fromCal.at, fromCal.calendarId, fromCal.title),
      (DateTime.utc(2026, 11, 6, 19, 52), 'hebcal', 'Candle lighting: 16:52'),
    );
    final builtIn = nextCandleLighting(
      after: _now,
      calendarEvents: const [],
      builtIn: [
        AnchorEvent(
          id: 'j',
          kind: EventKind.holyDayStart,
          title: 'Candle lighting · Shabbat',
          at: DateTime.utc(2026, 11, 6, 20),
          source: 'jewish',
        ),
      ],
    )!;
    expect(builtIn.fromCalendar, isFalse);
  });

  test('the old single keyword setting becomes a calendar lock', () {
    final s = LockSettings.fromJson({'calendarKeyword': 'exam'});
    expect(s.calendarLocks.single.startQuery, 'exam');
    expect(LockSettings.fromJson(s.toJson()).calendarLocks.single.startQuery, 'exam');
  });
}
