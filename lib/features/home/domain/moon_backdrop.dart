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

  // SunCalc solar coordinates (BSD-2-Clause, third_party/suncalc/LICENSE).
  // The color reaches night at the apparent sunset altitude. It also works
  // at polar latitudes where the civil day has no sunrise or sunset.
  static Color colorAt(Place place, DateTime at) {
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
