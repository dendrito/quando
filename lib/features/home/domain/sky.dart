import 'dart:ui';

import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import '../../events/domain/sun_times.dart';
import '../../shabbat/domain/place.dart';

import 'package:quando/l10n/l10n.dart';

/// Today's sun for the home screen's sky: when it rises and sets, and where
/// it is now.
class SkyDay {
  const SkyDay({required this.now, this.sunrise, this.sunset, this.nextSunset});

  final DateTime now;
  final DateTime? sunrise;
  final DateTime? sunset;

  /// The next sunset after now, today's or tomorrow's.
  final DateTime? nextSunset;

  static SkyDay of(Place place, DateTime now) {
    final events = SunTimes(place: place)
        .events(now.subtract(const Duration(hours: 30)), now.add(const Duration(hours: 40)));
    final today = inZone(now, place.timeZone);
    bool isToday(AnchorEvent e) {
      final l = inZone(e.at, place.timeZone);
      return l.year == today.year && l.month == today.month && l.day == today.day;
    }

    DateTime? first(EventKind kind, bool Function(AnchorEvent) test) =>
        events.where((e) => e.kind == kind && test(e)).firstOrNull?.at;

    return SkyDay(
      now: now,
      sunrise: first(EventKind.sunrise, isToday),
      sunset: first(EventKind.sunset, isToday),
      nextSunset: first(EventKind.sunset, (e) => e.at.isAfter(now)),
    );
  }

  /// How far the sun is through the day: 0 at sunrise, 1 at sunset. Below 0
  /// before dawn, above 1 after dark. null when the sun doesn't rise or set.
  double? get progress {
    final rise = sunrise, set = sunset;
    if (rise == null || set == null || !set.isAfter(rise)) return null;
    return now.difference(rise).inSeconds / set.difference(rise).inSeconds;
  }

  bool get isDay {
    final p = progress;
    return p != null && p >= 0 && p <= 1;
  }

  /// Where [t] falls on today's arc, like [progress].
  double? at(DateTime t) {
    final rise = sunrise, set = sunset;
    if (rise == null || set == null || !set.isAfter(rise)) return null;
    return t.difference(rise).inSeconds / set.difference(rise).inSeconds;
  }

  /// The header's color: deep plum at night, rose at dawn and dusk,
  /// terracotta in the day. Every shade keeps cream text readable.
  Color get color {
    final rise = sunrise, set = sunset;
    if (rise == null || set == null) return SkyColors.dusk;
    double mins(DateTime t) => now.difference(t).inSeconds / 60;
    final fromRise = mins(rise);
    final fromSet = mins(set);
    // An hour either side of sunrise and sunset blends between shades.
    if (fromRise < -60) return SkyColors.night;
    if (fromRise < 0) return Color.lerp(SkyColors.night, SkyColors.dawn, (fromRise + 60) / 60)!;
    if (fromRise < 60) return Color.lerp(SkyColors.dawn, SkyColors.day, fromRise / 60)!;
    if (fromSet < -60) return SkyColors.day;
    if (fromSet < 0) return Color.lerp(SkyColors.day, SkyColors.dusk, (fromSet + 60) / 60)!;
    if (fromSet < 60) return Color.lerp(SkyColors.dusk, SkyColors.night, fromSet / 60)!;
    return SkyColors.night;
  }
}

class SkyColors {
  static const night = Color(0xFF26143A);
  static const dawn = Color(0xFF6B2D4F);
  static const day = Color(0xFF8A3A2C);
  static const dusk = Color(0xFF4A2142);
}

/// "in 1h 40m", "in 12m", "in 2d 5h", "now".
String countdown(Duration d) {
  if (d.inMinutes < 1) return l10n.now;
  final days = d.inDays;
  final hours = d.inHours % 24;
  final minutes = d.inMinutes % 60;
  if (days > 0) return hours == 0 ? l10n.inDays(days) : l10n.inDaysHours(days, hours);
  if (d.inHours > 0) return minutes == 0 ? l10n.inHours(d.inHours) : l10n.inHoursMinutes(d.inHours, minutes);
  return l10n.inMins(minutes);
}
