// Lunar astronomy adapted from SunCalc 1.9.0 (BSD-2-Clause).
// Copyright (c) 2014, Vladimir Agafonkin. See third_party/suncalc/LICENSE.
import 'dart:math' as m;

import 'package:timezone/timezone.dart' as tz;

import '../../../core/util/local_time.dart';
import '../../shabbat/domain/place.dart';

const _rad = m.pi / 180;
const _obliquity = 23.4397 * _rad;
double _days(DateTime at) => at.toUtc().millisecondsSinceEpoch / 86400000 - 10957.5;
double _ra(double l, double b) =>
    m.atan2(m.sin(l) * m.cos(_obliquity) - m.tan(b) * m.sin(_obliquity), m.cos(l));
double _dec(double l, double b) =>
    m.asin(m.sin(b) * m.cos(_obliquity) + m.cos(b) * m.sin(_obliquity) * m.sin(l));
({double ra, double dec, double distance}) _moon(double d) {
  final l0 = _rad * (218.316 + 13.176396 * d),
      anomaly = _rad * (134.963 + 13.064993 * d),
      f = _rad * (93.272 + 13.229350 * d);
  final l = l0 + _rad * 6.289 * m.sin(anomaly), b = _rad * 5.128 * m.sin(f);
  return (ra: _ra(l, b), dec: _dec(l, b), distance: 385001 - 20905 * m.cos(anomaly));
}

class MoonIllumination {
  const MoonIllumination(this.fraction, this.phase);
  final double fraction, phase;
  int get phaseIndex {
    if (phase < .01 || phase > .99) return 0;
    if ((phase - .25).abs() < .01) return 2;
    if ((phase - .5).abs() < .01) return 4;
    if ((phase - .75).abs() < .01) return 6;
    return phase < .25
        ? 1
        : phase < .5
        ? 3
        : phase < .75
        ? 5
        : 7;
  }

  static MoonIllumination at(DateTime at) {
    final d = _days(at), moon = _moon(d), anomaly = _rad * (357.5291 + 0.98560028 * d);
    final l =
        anomaly +
        _rad * (1.9148 * m.sin(anomaly) + 0.02 * m.sin(2 * anomaly) + 0.0003 * m.sin(3 * anomaly)) +
        _rad * 102.9372 +
        m.pi;
    final sd = _dec(l, 0), sr = _ra(l, 0);
    final phi = m.acos(
      (m.sin(sd) * m.sin(moon.dec) + m.cos(sd) * m.cos(moon.dec) * m.cos(sr - moon.ra)).clamp(-1.0, 1.0),
    );
    final inc = m.atan2(149598000 * m.sin(phi), moon.distance - 149598000 * m.cos(phi));
    final angle = m.atan2(
      m.cos(sd) * m.sin(sr - moon.ra),
      m.sin(sd) * m.cos(moon.dec) - m.cos(sd) * m.sin(moon.dec) * m.cos(sr - moon.ra),
    );
    return MoonIllumination((1 + m.cos(inc)) / 2, 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / m.pi);
  }
}

/// The lunar pass containing now, or the next pass when below the horizon.
/// A pass may cross midnight: do not join today's set to a later rise.
class MoonTrack {
  const MoonTrack({required this.now, required this.above, this.rise, this.set});
  final DateTime now;
  final bool above;
  final DateTime? rise, set;
  double? get progress {
    final r = rise, s = set;
    if (r == null || s == null || !s.isAfter(r)) return null;
    return now.difference(r).inSeconds / s.difference(r).inSeconds;
  }

  static MoonTrack of(Place place, DateTime now) {
    final above = MoonDay.altitude(now, place.latitude, place.longitude) > .133 * _rad;
    final days = [for (var i = -2; i <= 2; i++) MoonDay.of(place, now.add(Duration(days: i)))];
    final rises = days.map((d) => d.rise).whereType<DateTime>().toSet().toList()..sort();
    final sets = days.map((d) => d.set).whereType<DateTime>().toSet().toList()..sort();
    final rise = above
        ? rises.where((r) => !r.isAfter(now)).lastOrNull
        : rises.where((r) => r.isAfter(now)).firstOrNull;
    final set = rise == null ? null : sets.where((s) => s.isAfter(rise)).firstOrNull;
    return MoonTrack(now: now, above: above, rise: rise, set: set);
  }
}

class MoonDay {
  const MoonDay({this.rise, this.set, required this.alwaysUp, required this.alwaysDown});
  final DateTime? rise, set;
  final bool alwaysUp, alwaysDown;

  static double altitude(DateTime at, double latitude, double longitude) {
    final d = _days(at), c = _moon(d), phi = latitude * _rad;
    final hAngle = _rad * (280.16 + 360.9856235 * d) + longitude * _rad - c.ra;
    final h = m.asin(
      (m.sin(phi) * m.sin(c.dec) + m.cos(phi) * m.cos(c.dec) * m.cos(hAngle)).clamp(-1.0, 1.0),
    );
    final refH = m.max(0.0, h);
    return h + 0.0002967 / m.tan(refH + 0.00312536 / (refH + 0.08901179));
  }

  /// Search the selected city's civil day, including 23/25-hour DST days.
  static MoonDay of(Place place, DateTime now) {
    ensureTimeZones();
    final local = inZone(now, place.timeZone), zone = tz.getLocation(place.timeZone);
    final start = tz.TZDateTime(zone, local.year, local.month, local.day).toUtc();
    final end = tz.TZDateTime(zone, local.year, local.month, local.day + 1).toUtc();
    DateTime hour(double h) => start.add(Duration(microseconds: (h * 3600000000).round()));
    double height(double h) => altitude(hour(h), place.latitude, place.longitude) - 0.133 * _rad;
    var h0 = height(0);
    DateTime? rise, set;
    for (var i = 1; i <= end.difference(start).inHours; i += 2) {
      final h1 = height(i.toDouble()), h2 = height(i + 1.0), a = (h0 + h2) / 2 - h1, b = (h2 - h0) / 2;
      final roots = <double>[];
      if (a.abs() < 1e-12) {
        if (b.abs() > 1e-12) roots.add(-h1 / b);
      } else {
        final disc = b * b - 4 * a * h1;
        if (disc >= 0) {
          final center = -b / (2 * a), dx = m.sqrt(disc) / (2 * a.abs());
          roots.addAll([center - dx, center + dx]);
        }
      }
      for (final root in roots.where((r) => r >= -1 && r <= 1)) {
        final at = hour(i + root);
        if (at.isBefore(start) || !at.isBefore(end)) continue;
        final rising = 2 * a * root + b > 0;
        if (rising) {
          rise ??= at;
        } else {
          set ??= at;
        }
      }
      h0 = h2;
    }
    final up = height(end.difference(start).inMinutes / 120) > 0;
    return MoonDay(
      rise: rise,
      set: set,
      alwaysUp: rise == null && set == null && up,
      alwaysDown: rise == null && set == null && !up,
    );
  }
}
