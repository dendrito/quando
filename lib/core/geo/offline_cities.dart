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

  /// Picks the city whose own size the position sits closest to: distance
  /// divided by the city's rough radius (sqrt(population) / 125 km, about
  /// 5,000 people per km²). That keeps a big city's neighbourhoods and its
  /// bigger neighbour from winning over the city the position is inside.
  static String? _nearestIn(List<_City> cities, double latitude, double longitude, {double maxKm = 30}) {
    final cosLat = math.cos(latitude * math.pi / 180);
    String? best;
    var bestScore = 1.5;
    for (final c in cities) {
      final dLat = (c.latitude - latitude) * 111.2;
      final dLon = (c.longitude - longitude) * 111.2 * cosLat;
      final km = math.sqrt(dLat * dLat + dLon * dLon);
      if (km > maxKm) continue;
      final score = km / math.max(2.0, math.sqrt(c.population) / 125);
      if (score < bestScore) {
        bestScore = score;
        best = c.name;
      }
    }
    return best;
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
