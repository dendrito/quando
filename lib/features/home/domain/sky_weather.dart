import 'dart:ui';

import '../../../core/util/local_time.dart';
import '../../shabbat/domain/place.dart';
import '../data/weather_repository.dart';
import 'moon.dart';
import 'sky.dart';

/// Option C of the sky redesign: the Sun card carries the weather on its
/// arc, and the card's colour follows the real sky. Rainy blue-grey on a wet
/// day, clear blue on a sunny afternoon, warm tones only around sunrise and
/// sunset, and indigo at night.
class SkyWeatherColors {
  static const clear = (Color(0xFF4F7FB8), Color(0xFF2E4F7E));
  static const clouds = (Color(0xFF6B7C93), Color(0xFF3B4A60));
  static const rain = (Color(0xFF6F86A0), Color(0xFF34465E));
  static const storm = (Color(0xFF4A566B), Color(0xFF252D3D));
  static const snow = (Color(0xFF8A9AB0), Color(0xFF4D5C73));
  static const fog = (Color(0xFF7D8696), Color(0xFF454D5C));
  static const warm = (Color(0xFFB0645A), Color(0xFF5A2E4A));
  static const night = (Color(0xFF141033), Color(0xFF2B1F4E));

  static (Color, Color) forKind(WeatherKind? kind) => switch (kind) {
    null || WeatherKind.clear => clear,
    WeatherKind.clouds => clouds,
    WeatherKind.rain => rain,
    WeatherKind.thunder => storm,
    WeatherKind.snow => snow,
    WeatherKind.fog => fog,
  };
}

/// The card's top and bottom colours for [sky] under [kind] (null when the
/// weather is unknown: then the clear-day colour is used).
(Color, Color) skyWeatherGradient(SkyDay sky, WeatherKind? kind) {
  final rise = sky.sunrise, set = sky.sunset;
  final day = SkyWeatherColors.forKind(kind);
  if (rise == null || set == null) return sky.isDay ? day : SkyWeatherColors.night;
  double mins(DateTime t) => sky.now.difference(t).inSeconds / 60;
  // A grey sky barely turns golden, so dawn and dusk tint less when wet.
  final warmth = kind == null || kind == WeatherKind.clear ? 1.0 : .45;
  final warm = _mix(day, SkyWeatherColors.warm, warmth);
  (Color, Color) blend((Color, Color) a, (Color, Color) b, double t) =>
      (Color.lerp(a.$1, b.$1, t.clamp(0, 1))!, Color.lerp(a.$2, b.$2, t.clamp(0, 1))!);
  final fromRise = mins(rise), fromSet = mins(set);
  if (fromRise < -45) return SkyWeatherColors.night;
  if (fromRise < 0) return blend(SkyWeatherColors.night, warm, (fromRise + 45) / 45);
  if (fromRise < 60) return blend(warm, day, fromRise / 60);
  if (fromSet < -60) return day;
  if (fromSet < 0) return blend(day, warm, (fromSet + 60) / 60);
  if (fromSet < 45) return blend(warm, SkyWeatherColors.night, fromSet / 45);
  return SkyWeatherColors.night;
}

(Color, Color) _mix((Color, Color) a, (Color, Color) b, double t) =>
    (Color.lerp(a.$1, b.$1, t)!, Color.lerp(a.$2, b.$2, t)!);

/// One forecast stop drawn on the Sun's arc.
class ArcWeather {
  const ArcWeather({required this.t, required this.hour, required this.label});

  /// Where on the arc: 0 at sunrise, 1 at sunset.
  final double t;
  final WeatherHour hour;

  /// "08:00 · 21°".
  final String label;
}

/// Up to three forecast hours spread over today's daylight, skipping the
/// stretch right around now (the Sun itself shows the weather there).
List<ArcWeather> arcWeather(SkyDay sky, WeatherReport report, String zone) =>
    arcWeatherAlong(report, zone, sky.at, now: sky.progress);

/// The same along the Moon's pass from moonrise (0) to moonset (1).
List<ArcWeather> moonArcWeather(MoonTrack track, WeatherReport report, String zone) {
  final rise = track.rise, set = track.set;
  if (rise == null || set == null || !set.isAfter(rise)) return const [];
  final span = set.difference(rise).inSeconds;
  return arcWeatherAlong(report, zone, (t) => t.difference(rise).inSeconds / span, now: track.progress);
}

/// Forecast stops along any arc. [pos] gives where a time falls on it, 0 at
/// the start and 1 at the end; [now] is where the Sun or Moon is.
List<ArcWeather> arcWeatherAlong(
  WeatherReport report,
  String zone,
  double? Function(DateTime) pos, {
  double? now,
}) {
  final hours = report.hours.where((h) {
    final t = pos(h.at);
    return t != null && t >= .04 && t <= .96;
  }).toList();
  if (hours.isEmpty) return const [];
  final picked = <ArcWeather>[];
  for (final target in const [.2, .47, .72, .92]) {
    if (picked.length == 3) break;
    WeatherHour? best;
    var bestGap = double.infinity;
    for (final h in hours) {
      final gap = (pos(h.at)! - target).abs();
      if (gap < bestGap) {
        best = h;
        bestGap = gap;
      }
    }
    if (best == null || bestGap > .12) continue;
    final t = pos(best.at)!;
    if (now != null && now >= 0 && now <= 1 && (t - now).abs() < .08) continue;
    if (picked.any((p) => (p.t - t).abs() < .15)) continue;
    picked.add(
      ArcWeather(t: t, hour: best, label: '${hhmm(inZone(best.at, zone))} · ${best.celsius.round()}°'),
    );
  }
  return picked;
}

/// 0 in full daylight, 1 in full night, with the same dawn and dusk
/// transitions as [skyWeatherGradient].
double skyNightness(SkyDay sky) {
  final rise = sky.sunrise, set = sky.sunset;
  if (rise == null || set == null) return sky.isDay ? 0 : 1;
  double mins(DateTime t) => sky.now.difference(t).inSeconds / 60;
  final fromRise = mins(rise), fromSet = mins(set);
  if (fromRise < -45) return 1;
  if (fromRise < 0) return -fromRise / 45;
  if (fromRise < 60) return 0;
  if (fromSet < 0) return 0;
  if (fromSet < 45) return fromSet / 45;
  return 1;
}

/// A card's sky along a stretch of time, left to right: sunrise to sunset on
/// the Sun card, moonrise to moonset on the Moon card. It is the night sky
/// where it is dark and the daytime sky, with the real weather, where the Sun
/// is up. The weather blends smoothly between forecast hours.
class SkyStrip {
  const SkyStrip({
    required this.colors,
    required this.night,
    required this.kinds,
    required this.start,
    required this.end,
  });

  /// Top colour at each sample, left to right.
  final List<Color> colors;

  /// How dark each sample is, 0 day to 1 night (draws the stars).
  final List<double> night;

  /// The forecast weather at each sample from now on, null for the past or
  /// when it is unknown (drives the rain, snow, fog and lightning).
  final List<WeatherKind?> kinds;

  /// The time at the left and right edges.
  final DateTime start, end;

  /// Darker at the bottom, as the Sun card's gradient is.
  static const shade = Color(0x4D000000);

  double get maxNight => night.fold(0.0, (a, b) => a > b ? a : b);

  static SkyStrip ofMoon(Place place, MoonTrack track, WeatherReport? report, {int count = 25}) {
    final start = track.rise, end = track.set;
    final valid = start != null && end != null && end.isAfter(start);
    return between(
      place,
      valid ? start : track.now,
      valid ? end : track.now,
      report,
      now: track.now,
      count: count,
    );
  }

  static SkyStrip between(
    Place place,
    DateTime a,
    DateTime b,
    WeatherReport? report, {
    required DateTime now,
    int count = 25,
  }) {
    final span = b.difference(a).inMicroseconds;
    final colors = <Color>[], night = <double>[];
    final kinds = <WeatherKind?>[];
    for (var i = 0; i < count; i++) {
      final at = a.add(Duration(microseconds: (span * i / (count - 1)).round()));
      final sky = SkyDay.of(place, at);
      colors.add(skyWeatherGradientAt(sky, report).$1);
      night.add(skyNightness(sky));
      // Weather effects only for the hours still to come.
      kinds.add(
        report == null || at.isBefore(now.subtract(const Duration(minutes: 30)))
            ? null
            : hourNear(report, at)?.kind,
      );
    }
    return SkyStrip(colors: colors, night: night, kinds: kinds, start: a, end: b);
  }
}

/// [skyWeatherGradient] with the weather blended between the forecast hours
/// either side of the sky's time, so colours change smoothly.
(Color, Color) skyWeatherGradientAt(SkyDay sky, WeatherReport? report) {
  if (report == null || report.hours.isEmpty) return skyWeatherGradient(sky, null);
  final at = sky.now;
  WeatherHour? before, after;
  for (final h in report.hours) {
    if (!h.at.isAfter(at)) {
      before = h;
    } else {
      after = h;
      break;
    }
  }
  // Beyond a few hours from any forecast point the weather is unknown.
  bool near(WeatherHour? h) => h != null && h.at.difference(at).abs() <= const Duration(hours: 3);
  if (!near(before) && !near(after)) return skyWeatherGradient(sky, null);
  if (!near(before)) return skyWeatherGradient(sky, after!.kind);
  if (!near(after)) return skyWeatherGradient(sky, before!.kind);
  final gap = after!.at.difference(before!.at).inSeconds;
  final t = gap <= 0 ? 0.0 : at.difference(before.at).inSeconds / gap;
  // Ease so a spell of rain holds its colour, then changes between hours.
  final eased = t * t * (3 - 2 * t);
  return _mix(skyWeatherGradient(sky, before.kind), skyWeatherGradient(sky, after.kind), eased);
}

/// The forecast hour closest to [at], if one is within two hours of it.
WeatherHour? hourNear(WeatherReport report, DateTime at) {
  WeatherHour? best;
  for (final h in report.hours) {
    final gap = h.at.difference(at).abs();
    if (gap <= const Duration(hours: 2) && (best == null || gap < best.at.difference(at).abs())) best = h;
  }
  return best;
}

/// When the current wet or stormy spell ends: the first later hour with a
/// different kind of weather, looked for up to 12 hours ahead.
DateTime? spellEnds(WeatherReport report, DateTime now, WeatherKind kind) {
  for (final h in report.hours) {
    if (!h.at.isAfter(now) || h.at.difference(now) > const Duration(hours: 12)) continue;
    if (h.kind != kind) return h.at;
  }
  return null;
}
