import 'package:kosher_dart/kosher_dart.dart';

import '../../shabbat/domain/place.dart';
import 'event.dart';

import 'package:quando/l10n/l10n.dart';

/// Sunrise and sunset for a place, for sun alarms. Uses the same astronomy
/// engine as the Shabbat times.
class SunTimes {
  const SunTimes({required this.place});

  final Place place;

  List<AnchorEvent> events(DateTime from, DateTime to) {
    final out = <AnchorEvent>[];
    var day = DateTime.utc(from.year, from.month, from.day).subtract(const Duration(days: 1));
    final last = DateTime.utc(to.year, to.month, to.day).add(const Duration(days: 1));
    for (; !day.isAfter(last); day = day.add(const Duration(days: 1))) {
      final noon = DateTime.utc(day.year, day.month, day.day, 12);
      final cal = ComplexZmanimCalendar.intGeoLocation(
        GeoLocation.setLocation(place.name, place.latitude, place.longitude, noon),
      );
      final key = '${day.year}-${day.month}-${day.day}';
      final rise = cal.getSeaLevelSunrise();
      final set = cal.getSeaLevelSunset();
      if (rise != null) {
        out.add(
          AnchorEvent(
            id: 'sun.rise.$key',
            kind: EventKind.sunrise,
            title: l10n.sunrise,
            alias: l10nEn.sunrise,
            at: rise.toUtc(),
            source: 'sun',
          ),
        );
      }
      if (set != null) {
        out.add(
          AnchorEvent(
            id: 'sun.set.$key',
            kind: EventKind.sunset,
            title: l10n.sunset,
            alias: l10nEn.sunset,
            at: set.toUtc(),
            source: 'sun',
          ),
        );
      }
    }
    return out.where((e) => !e.at.isBefore(from) && !e.at.isAfter(to)).toList()..sort((a, b) => a.at.compareTo(b.at));
  }
}
