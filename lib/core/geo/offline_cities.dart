import 'dart:math' as math;

import 'package:flutter/services.dart';

/// Names the city nearest to a position using a bundled copy of GeoNames
/// (cities of 15,000 people or more; CC BY 4.0, https://www.geonames.org/).
/// Works offline: no coordinates leave the phone.
class OfflineCities {
  OfflineCities._();

  static List<_City>? _cities;

  /// Distances are to city centres, so a spot at the edge of one city can be
  /// nearer the centre of its neighbour; callers should treat this as a label.
  static Future<String?> nearest(double latitude, double longitude, {double maxKm = 30}) async {
    final cities = _cities ??= _parse(await rootBundle.loadString('assets/geo/cities.tsv'));
    return _nearestIn(cities, latitude, longitude, maxKm: maxKm);
  }

  /// Names the place for a position: the city it sits in, plus the district
  /// within 3 km when there is one ("Alfama, Lisbon").
  ///
  /// The city is the one whose own size the position is closest to: distance
  /// divided by a rough radius (sqrt(population) / 125 km, about 5,000 people
  /// per km²). Cities of 200,000+ are tried first, so a district never counts
  /// as the city; then towns of 15,000+. Distances are to centre points, so a
  /// suburb nearer a big neighbour's centre can take its name.
  static String? _nearestIn(List<_City> cities, double latitude, double longitude, {double maxKm = 30}) {
    final cosLat = math.cos(latitude * math.pi / 180);
    _City? big;
    _City? town;
    _City? district;
    var bigScore = 1.5;
    var townScore = 1.5;
    var districtKm = 3.0;
    for (final c in cities) {
      final dLat = (c.latitude - latitude) * 111.2;
      final dLon = (c.longitude - longitude) * 111.2 * cosLat;
      final km = math.sqrt(dLat * dLat + dLon * dLon);
      if (km > maxKm) continue;
      final score = km / math.max(2.0, math.sqrt(c.population) / 125);
      if (c.population >= 200000) {
        if (score < bigScore) {
          bigScore = score;
          big = c;
        }
      } else if (c.population >= 15000 && score < townScore) {
        townScore = score;
        town = c;
      }
      if (km < districtKm) {
        districtKm = km;
        district = c;
      }
    }
    final city = big ?? town;
    if (city == null) return district?.name;
    if (district == null || district.name == city.name) return city.name;
    return '${district.name}, ${city.name}';
  }

  static List<_City> _parse(String text) => [
    for (final line in text.split('\n'))
      if (line.isNotEmpty) _City.parse(line),
  ];
}

class _City {
  const _City(this.name, this.latitude, this.longitude, this.population);
  factory _City.parse(String line) {
    final f = line.split('\t');
    return _City(f[0], double.parse(f[1]), double.parse(f[2]), int.parse(f[3]));
  }
  final String name;
  final double latitude;
  final double longitude;
  final int population;
}
