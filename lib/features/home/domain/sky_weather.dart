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

/// The Moon card's sky from moonrise (left) to moonset (right): the night
/// sky where the pass is dark and the daytime sky, with the real weather,
/// where the Sun is up. A pass that is mostly daytime reads as a day card.
class MoonSky {
  const MoonSky({required this.colors, required this.night});

  /// Top colour at each sample, left to right.
  final List<Color> colors;

  /// How dark each sample is, 0 day to 1 night (draws the stars).
  final List<double> night;

  /// Darker at the bottom, as the Sun card's gradient is.
  static const shade = Color(0x4D000000);

  double get maxNight => night.fold(0.0, (a, b) => a > b ? a : b);

  static MoonSky of(Place place, MoonTrack track, WeatherReport? report, {int count = 25}) {
    final start = track.rise, end = track.set;
    final DateTime a, b;
    if (start == null || end == null || !end.isAfter(start)) {
      a = b = track.now;
    } else {
      a = start;
      b = end;
    }
    final span = b.difference(a).inMicroseconds;
    final colors = <Color>[], night = <double>[];
    for (var i = 0; i < count; i++) {
      final at = a.add(Duration(microseconds: (span * i / (count - 1)).round()));
      final sky = SkyDay.of(place, at);
      final kind = report == null ? null : hourNear(report, at)?.kind;
      colors.add(skyWeatherGradient(sky, kind).$1);
      night.add(skyNightness(sky));
    }
    return MoonSky(colors: colors, night: night);
  }
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
