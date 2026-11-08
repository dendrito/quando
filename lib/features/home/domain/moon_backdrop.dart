import 'dart:math' as math;
import 'dart:ui';

import '../../shabbat/domain/place.dart';
import 'moon.dart';
import 'sky.dart';

/// Colors run from moonrise (left) to moonset (right), using sunlight at
/// each instant. Entirely nocturnal passes remain purple; passes crossing
/// sunrise/sunset blend at those positions on the lunar timeline.
class MoonBackdrop {
  static List<Color> forTrack(Place place, MoonTrack track) {
    final start = track.rise, end = track.set;
    if (start == null || end == null || !end.isAfter(start)) {
      final color = colorAt(place, track.now);
      return [color, color];
    }
    return [
      for (var i = 0; i <= 48; i++)
        colorAt(
          place,
          start.add(Duration(microseconds: (end.difference(start).inMicroseconds * i / 48).round())),
        ),
    ];
  }

  /// Whether the Sun is up at each of [count] evenly spaced instants from
  /// moonrise to moonset. The Moon card colors its dotted path with this
  /// (amber in daylight, silver at night) instead of tinting the whole card,
  /// which turned a dark screen bright orange at night.
  static List<bool> daylightForTrack(Place place, MoonTrack track, {int count = 37}) {
    final start = track.rise, end = track.set;
    if (start == null || end == null || !end.isAfter(start)) {
      return List.filled(count, colorAt(place, track.now) != SkyColors.night);
    }
    final span = end.difference(start).inMicroseconds;
    return [
      for (var i = 0; i < count; i++)
        colorAt(place, start.add(Duration(microseconds: (span * i / (count - 1)).round()))) !=
            SkyColors.night,
    ];
  }

  static Color colorAt(Place place, DateTime at) {
    // Match the actual sunrise/sunset shown on the Sun tab. The Moon being
    // above the horizon does not make it night, and setting does not make it day.
    final sun = SkyDay.of(place, at);
    if (sun.sunrise != null && sun.sunset != null) {
      return sun.isDay ? sun.color : SkyColors.night;
    }
    return _polarColorAt(place, at);
  }

  // SunCalc solar coordinates (BSD-2-Clause, third_party/suncalc/LICENSE).
  // Only needed at polar latitudes without a complete rise/set pair.
  static Color _polarColorAt(Place place, DateTime at) {
    const rad = math.pi / 180, obliquity = 23.4397 * rad;
    final d = at.toUtc().millisecondsSinceEpoch / 86400000 - 10957.5;
    final anomaly = rad * (357.5291 + .98560028 * d);
    final l =
        anomaly +
        rad * (1.9148 * math.sin(anomaly) + .02 * math.sin(2 * anomaly) + .0003 * math.sin(3 * anomaly)) +
        rad * 102.9372 +
        math.pi;
    final declination = math.asin(math.sin(obliquity) * math.sin(l));
    final ra = math.atan2(math.sin(l) * math.cos(obliquity), math.cos(l));
    final hourAngle = rad * (280.16 + 360.9856235 * d + place.longitude) - ra;
    final phi = place.latitude * rad;
    final altitude =
        math.asin(
          (math.sin(phi) * math.sin(declination) +
                  math.cos(phi) * math.cos(declination) * math.cos(hourAngle))
              .clamp(-1, 1),
        ) /
        rad;
    var daylight = ((altitude + .833) / 6.833).clamp(0.0, 1.0);
    daylight = daylight * daylight * (3 - 2 * daylight);
    return Color.lerp(SkyColors.night, SkyColors.day, daylight)!;
  }
}
