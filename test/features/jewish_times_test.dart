import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/shabbat/domain/jewish_times.dart';
import 'package:quando/features/shabbat/domain/place.dart';

void main() {
  group('Ordinary Shabbat', () {
    final times = JewishTimes(place: Places.jerusalem);
    final events = times.events(
      DateTime.utc(2026, 11, 5),
      DateTime.utc(2026, 11, 9),
    );

    test('Jerusalem lights 40 minutes before sunset on Friday', () {
      final start = events.singleWhere((e) => e.kind == EventKind.holyDayStart);
      // Sunset in Jerusalem on 6 Nov 2026 is about 16:45 local (14:45 UTC).
      expect(start.at, DateTime.utc(2026, 11, 6, 14, 5, 34));
      expect(start.title, 'Candle lighting · Shabbat');
    });

    test('havdalah is Saturday night, after sunset', () {
      final end = events.singleWhere((e) => e.kind == EventKind.holyDayEnd);
      expect(end.at.weekday, DateTime.saturday);
      expect(end.at.isAfter(DateTime.utc(2026, 11, 7, 14, 45)), isTrue);
      expect(end.title, 'Havdalah · end of Shabbat');
    });

    test('one period of about 25 hours', () {
      final periods = times.periods(
        DateTime.utc(2026, 11, 5),
        DateTime.utc(2026, 11, 9),
      );
      expect(periods, hasLength(1));
      expect(periods.single.length.inHours, inInclusiveRange(24, 26));
    });

    test('Rabbeinu Tam ends later than the Geonim', () {
      final rt =
          JewishTimes(
                place: Places.jerusalem,
                havdalah: HavdalahOpinion.rabbeinuTam,
              )
              .events(DateTime.utc(2026, 11, 5), DateTime.utc(2026, 11, 9))
              .singleWhere((e) => e.kind == EventKind.holyDayEnd);
      final geonim = events.singleWhere((e) => e.kind == EventKind.holyDayEnd);
      expect(rt.at.isAfter(geonim.at), isTrue);
    });
  });

  group('Rosh Hashanah 5787 runs into Shabbat (11–13 Sept 2026)', () {
    final from = DateTime.utc(2026, 9, 10);
    final to = DateTime.utc(2026, 9, 15);

    test('one unbroken period, Friday to Sunday night, in New York', () {
      final periods = JewishTimes(place: Places.newYork).periods(from, to);
      expect(periods, hasLength(1));
      final p = periods.single;
      expect(p.names, ['Shabbat · Rosh Hashanah', 'Rosh Hashanah']);
      expect(p.length.inHours, inInclusiveRange(48, 50));
    });

    test('second night candles are after nightfall on Saturday, no havdalah in between', () {
      final events = JewishTimes(place: Places.newYork).events(from, to);
      final kinds = events.map((e) => e.kind).toList();
      expect(kinds, [
        EventKind.holyDayStart,
        EventKind.secondNightCandles,
        EventKind.holyDayEnd,
      ]);
      expect(events[1].title, 'Candle lighting · Rosh Hashanah');
    });

    test('Rosh Hashanah is two days in Israel too', () {
      final p = JewishTimes(place: Places.jerusalem).periods(from, to).single;
      expect(p.names, hasLength(2));
    });
  });

  group('Sukkot 5787 starts on Shabbat (25 Sept 2026)', () {
    final from = DateTime.utc(2026, 9, 24);
    final to = DateTime.utc(2026, 9, 29);

    test('one day in Israel', () {
      final p = JewishTimes(place: Places.telAviv).periods(from, to).single;
      expect(p.names, ['Shabbat · Sukkot']);
      expect(p.length.inHours, inInclusiveRange(24, 26));
    });

    test('two days outside Israel', () {
      final p = JewishTimes(place: Places.london).periods(from, to).single;
      expect(p.names, ['Shabbat · Sukkot', 'Sukkot']);
      expect(p.length.inHours, inInclusiveRange(48, 50));
    });
  });

  test('Yom Kippur 5787 starts Sunday evening, 20 Sept 2026', () {
    final events = JewishTimes(place: Places.jerusalem)
        .events(DateTime.utc(2026, 9, 19, 12), DateTime.utc(2026, 9, 22));
    final start = events.firstWhere((e) => e.kind == EventKind.holyDayStart);
    expect(start.title, 'Candle lighting · Yom Kippur');
    expect(start.at.day, 20);
  });

  test(
    'works far west of UTC: Los Angeles Friday sunset falls on Saturday UTC',
    () {
      final start = JewishTimes(place: Places.losAngeles)
          .events(DateTime.utc(2026, 11, 5), DateTime.utc(2026, 11, 9))
          .firstWhere((e) => e.kind == EventKind.holyDayStart);
      // About 16:37 local on Friday 6 Nov = 00:37 UTC on Saturday.
      expect(start.at, DateTime.utc(2026, 11, 7, 0, 37, 28));
    },
  );
}
