import 'package:kosher_dart/kosher_dart.dart';

import '../../events/domain/event.dart';
import 'place.dart';

/// Which nightfall ends Shabbat and festivals.
enum HavdalahOpinion {
  /// Sun 8.5° below the horizon (Geonim). Common default.
  geonim,

  /// 72 fixed minutes after sunset (Rabbeinu Tam).
  rabbeinuTam,
}

/// Produces Shabbat and festival events for a place, calculated on the phone
/// with no internet.
///
/// For each civil day it asks two questions: is work forbidden today, and is
/// it forbidden tomorrow? That covers every case, including two-day
/// festivals and a festival that runs into Shabbat:
///
/// * not today, but tomorrow → candle lighting before sunset (start)
/// * today and tomorrow      → candle lighting after nightfall (second night)
/// * today, but not tomorrow → havdalah (end)
class JewishTimes {
  JewishTimes({required this.place, this.havdalah = HavdalahOpinion.geonim});

  final Place place;
  final HavdalahOpinion havdalah;

  List<AnchorEvent> events(DateTime from, DateTime to) {
    final out = <AnchorEvent>[];
    // Pad by a day each side so events near the edges are not missed in
    // places far from UTC.
    var day = DateTime.utc(from.year, from.month, from.day).subtract(const Duration(days: 1));
    final last = DateTime.utc(to.year, to.month, to.day).add(const Duration(days: 1));

    for (; !day.isAfter(last); day = day.add(const Duration(days: 1))) {
      final today = _jewishDay(day);
      final tomorrow = _jewishDay(day.add(const Duration(days: 1)));
      final holyToday = today.isAssurBemelacha();
      final holyTomorrow = tomorrow.isAssurBemelacha();
      if (!holyToday && !holyTomorrow) continue;

      final zmanim = _zmanim(day);
      final key = '${day.year}-${day.month}-${day.day}';

      if (!holyToday && holyTomorrow) {
        final sunset = zmanim.getSeaLevelSunset();
        if (sunset == null) continue;
        out.add(
          AnchorEvent(
            id: 'jewish.start.$key',
            kind: EventKind.holyDayStart,
            title: 'Candle lighting · ${dayName(tomorrow)}',
            at: sunset.toUtc().subtract(Duration(minutes: place.candleLightingMinutes)),
            source: 'jewish',
          ),
        );
      } else if (holyToday && holyTomorrow) {
        final night = _nightfall(zmanim);
        if (night == null) continue;
        out.add(
          AnchorEvent(
            id: 'jewish.second.$key',
            kind: EventKind.secondNightCandles,
            title: 'Candle lighting · ${dayName(tomorrow)}',
            at: night,
            source: 'jewish',
          ),
        );
      } else {
        final night = _nightfall(zmanim);
        if (night == null) continue;
        out.add(
          AnchorEvent(
            id: 'jewish.end.$key',
            kind: EventKind.holyDayEnd,
            title: 'Havdalah · end of ${dayName(today)}',
            at: night,
            source: 'jewish',
          ),
        );
      }
    }

    return out.where((e) => !e.at.isBefore(from) && !e.at.isAfter(to)).toList()
      ..sort((a, b) => a.at.compareTo(b.at));
  }

  /// Shabbat and festival mode windows: first candle lighting to havdalah.
  List<HolyPeriod> periods(DateTime from, DateTime to) {
    // Look a few days wider so a period that started before [from] is whole.
    final evs = events(from.subtract(const Duration(days: 4)), to.add(const Duration(days: 4)));
    final out = <HolyPeriod>[];
    DateTime? start;
    final names = <String>[];
    for (final e in evs) {
      switch (e.kind) {
        case EventKind.holyDayStart:
          start = e.at;
          names
            ..clear()
            ..add(_dayPart(e.title));
        case EventKind.secondNightCandles:
          if (start != null) names.add(_dayPart(e.title));
        case EventKind.holyDayEnd:
          if (start != null) {
            out.add(HolyPeriod(start: start, end: e.at, names: List.of(names)));
            start = null;
          }
        default:
          break;
      }
    }
    return out.where((p) => p.end.isAfter(from) && p.start.isBefore(to)).toList();
  }

  /// "Candle lighting · Shabbat · Sukkot" → "Shabbat · Sukkot".
  static String _dayPart(String title) => title.substring(title.indexOf(' · ') + 3);

  String dayName(JewishCalendar day) {
    final isShabbat = day.getDayOfWeek() == 7;
    final festival = day.isYomTovAssurBemelacha() ? (_festivalNames[day.getYomTovIndex()] ?? 'Yom Tov') : '';
    if (isShabbat && festival.isNotEmpty) return 'Shabbat · $festival';
    if (festival.isNotEmpty) return festival;
    return 'Shabbat';
  }

  JewishCalendar _jewishDay(DateTime utcDay) {
    final jc = JewishCalendar.fromDateTime(DateTime(utcDay.year, utcDay.month, utcDay.day));
    jc.inIsrael = place.inIsrael;
    return jc;
  }

  ComplexZmanimCalendar _zmanim(DateTime utcDay) {
    final noon = DateTime.utc(utcDay.year, utcDay.month, utcDay.day, 12);
    final location = GeoLocation.setLocation(place.name, place.latitude, place.longitude, noon);
    return ComplexZmanimCalendar.intGeoLocation(location);
  }

  DateTime? _nightfall(ComplexZmanimCalendar z) {
    final t = switch (havdalah) {
      HavdalahOpinion.geonim => z.getTzais(),
      HavdalahOpinion.rabbeinuTam => z.getTzais72(),
    };
    return t?.toUtc();
  }
}

/// English names for the festival days when work is forbidden.
const _festivalNames = {
  JewishCalendar.PESACH: 'Pesach',
  JewishCalendar.SHAVUOS: 'Shavuot',
  JewishCalendar.ROSH_HASHANA: 'Rosh Hashanah',
  JewishCalendar.YOM_KIPPUR: 'Yom Kippur',
  JewishCalendar.SUCCOS: 'Sukkot',
  JewishCalendar.SHEMINI_ATZERES: 'Shemini Atzeret',
  JewishCalendar.SIMCHAS_TORAH: 'Simchat Torah',
};
