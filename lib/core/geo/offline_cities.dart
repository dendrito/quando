import 'dart:math' as math;

import 'package:flutter/services.dart';

/// Names the city nearest to a position using a bundled copy of GeoNames
/// (cities of 15,000 people or more; CC BY 4.0, https://www.geonames.org/).
/// Works offline: no coordinates leave the phone.
class OfflineCities {
  OfflineCities._();

  static List<OfflineCity>? _cities;

  /// Reads the bundled list once; [search] finds nothing until it is loaded.
  static Future<List<OfflineCity>> load() async =>
      _cities ??= _parse(await rootBundle.loadString('assets/geo/cities.tsv'));

  static bool get loaded => _cities != null;

  /// Places whose name starts with, or else contains, [query], biggest
  /// first. Accents and case are ignored ("niteroi" finds Niterói).
  static List<OfflineCity> search(String query, {int limit = 40}) {
    final q = fold(query.trim());
    final cities = _cities;
    if (q.length < 2 || cities == null) return const [];
    final starts = <OfflineCity>[];
    final inside = <OfflineCity>[];
    for (final c in cities) {
      final i = c.folded.indexOf(q);
      if (i == 0) {
        starts.add(c);
      } else if (i > 0) {
        inside.add(c);
      }
    }
    int bigFirst(OfflineCity a, OfflineCity b) => b.population.compareTo(a.population);
    return [...(starts..sort(bigFirst)), ...(inside..sort(bigFirst))].take(limit).toList();
  }

  static const _accented = 'áàâãäåāăąçćčďéèêëēėęěğíìîïīįıłñńňóòôõöøōőřśšşșťţțúùûüūůűųýÿźżž';
  static const _plain = 'aaaaaaaaacccdeeeeeeeegiiiiiiilnnnoooooooorsssstttuuuuuuuuyyzzz';

  /// Lower case without accents, for matching what people type.
  static String fold(String s) {
    final out = StringBuffer();
    for (final ch in s.toLowerCase().split('')) {
      final i = _accented.indexOf(ch);
      out.write(i < 0 ? ch : _plain[i]);
    }
    return out.toString();
  }

  /// Distances are to city centres, so a spot at the edge of one city can be
  /// nearer the centre of its neighbour; callers should treat this as a label.
  static Future<String?> nearest(double latitude, double longitude, {double maxKm = 30}) async {
    final cities = await load();
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
  static String? _nearestIn(
    List<OfflineCity> cities,
    double latitude,
    double longitude, {
    double maxKm = 30,
  }) {
    final cosLat = math.cos(latitude * math.pi / 180);
    OfflineCity? big;
    OfflineCity? town;
    OfflineCity? district;
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

  static List<OfflineCity> _parse(String text) => [
    for (final line in text.split('\n'))
      if (line.isNotEmpty) OfflineCity.parse(line),
  ];
}

/// One place in the bundled list, with its time zone and country code.
class OfflineCity {
  OfflineCity(this.name, this.latitude, this.longitude, this.population, this.timeZone, this.country)
    : folded = OfflineCities.fold(name);
  factory OfflineCity.parse(String line) {
    final f = line.split('\t');
    return OfflineCity(
      f[0],
      double.parse(f[1]),
      double.parse(f[2]),
      int.parse(f[3]),
      f.length > 4 ? f[4] : '',
      f.length > 5 ? f[5] : '',
    );
  }
  final String name;
  final double latitude;
  final double longitude;
  final int population;
  final String timeZone;
  final String country;
  final String folded;

  /// The country's flag, from its two-letter code.
  String get flag => country.length == 2
      ? String.fromCharCodes(country.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41))
      : '';
}
