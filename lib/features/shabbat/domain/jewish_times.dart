import 'package:kosher_dart/kosher_dart.dart';

import '../../events/domain/event.dart';
import 'place.dart';

import 'package:quando/l10n/l10n.dart';

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
    var day = DateTime.utc(
      from.year,
      from.month,
      from.day,
    ).subtract(const Duration(days: 1));
    final last = DateTime.utc(
      to.year,
      to.month,
      to.day,
    ).add(const Duration(days: 1));

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
            title: '${l10n.candleLighting} · ${dayName(tomorrow)}',
            alias: '${l10nEn.candleLighting} · ${dayName(tomorrow, l10nEn)}',
            at: sunset.toUtc().subtract(
              Duration(minutes: place.candleLightingMinutes),
            ),
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
            title: '${l10n.candleLighting} · ${dayName(tomorrow)}',
            alias: '${l10nEn.candleLighting} · ${dayName(tomorrow, l10nEn)}',
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
            title: l10n.havdalahEndOf(dayName(today)),
            alias: l10nEn.havdalahEndOf(dayName(today, l10nEn)),
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
    final evs = events(
      from.subtract(const Duration(days: 4)),
      to.add(const Duration(days: 4)),
    );
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
    return out
        .where((p) => p.end.isAfter(from) && p.start.isBefore(to))
        .toList();
  }

  /// "Candle lighting · Shabbat · Sukkot" → "Shabbat · Sukkot".
  static String _dayPart(String title) =>
      title.substring(title.indexOf(' · ') + 3);

  String dayName(JewishCalendar day, [AppLocalizations? t]) {
    t ??= l10n;
    final isShabbat = day.getDayOfWeek() == 7;
    final festival = day.isYomTovAssurBemelacha()
        ? (_festivalName(day.getYomTovIndex(), t) ?? t.yomTov)
        : '';
    if (isShabbat && festival.isNotEmpty) return '${t.shabbat} · $festival';
    if (festival.isNotEmpty) return festival;
    return t.shabbat;
  }

  JewishCalendar _jewishDay(DateTime utcDay) {
    final jc = JewishCalendar.fromDateTime(
      DateTime(utcDay.year, utcDay.month, utcDay.day),
    );
    jc.inIsrael = place.inIsrael;
    return jc;
  }

  ComplexZmanimCalendar _zmanim(DateTime utcDay) {
    final noon = DateTime.utc(utcDay.year, utcDay.month, utcDay.day, 12);
    final location = GeoLocation.setLocation(
      place.name,
      place.latitude,
      place.longitude,
      noon,
    );
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

/// Names for the festival days when work is forbidden, in the language in use.
String? _festivalName(int index, AppLocalizations t) => switch (index) {
  JewishCalendar.PESACH => t.pesach,
  JewishCalendar.SHAVUOS => t.shavuot,
  JewishCalendar.ROSH_HASHANA => t.roshHashanah,
  JewishCalendar.YOM_KIPPUR => t.yomKippur,
  JewishCalendar.SUCCOS => t.sukkot,
  JewishCalendar.SHEMINI_ATZERES => t.sheminiAtzeret,
  JewishCalendar.SIMCHAS_TORAH => t.simchatTorah,
  _ => null,
};
