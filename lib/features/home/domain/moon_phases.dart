// New/full phase series adapted from astronomia, MIT, Sonia Keys (2013),
// Commenthol (2016). Meeus, Astronomical Algorithms, chapter 49.
// License: third_party/astronomia/LICENSE. UTC conversion uses NASA's ΔT
// polynomials: https://eclipse.gsfc.nasa.gov/SEcat5/deltatpoly.html
import 'dart:math' as math;

class MoonPhases {
  const MoonPhases({required this.newMoon, required this.fullMoon});
  final DateTime newMoon, fullMoon;

  static MoonPhases nextAfter(DateTime now) {
    final utc = now.toUtc();
    final jd = utc.millisecondsSinceEpoch / 86400000 + 2440587.5;
    final lunation = ((jd - 2451550.09766) / 29.530588861).floor() - 1;
    DateTime next(double fraction) {
      for (var i = 0; i < 5; i++) {
        final at = _phase(lunation + i + fraction);
        if (at.isAfter(utc)) return at;
      }
      throw StateError('Could not find the next lunar phase');
    }

    return MoonPhases(newMoon: next(0), fullMoon: next(0.5));
  }

  static DateTime _phase(double k) {
    const rad = math.pi / 180;
    final t = k / 1236.85, t2 = t * t, t3 = t2 * t, t4 = t3 * t;
    final e = 1 - 0.002516 * t - 0.0000074 * t2;
    final m = (2.5534 + 29.1053567 * k - 0.0000014 * t2 - 0.00000011 * t3) * rad;
    final mp = (201.5643 + 385.81693528 * k + 0.0107582 * t2 + 0.00001238 * t3 - 0.000000058 * t4) * rad;
    final f = (160.7108 + 390.67050284 * k - 0.0016118 * t2 - 0.00000227 * t3 + 0.000000011 * t4) * rad;
    final omega = (124.7746 - 1.56375588 * k + 0.0020672 * t2 + 0.00000215 * t3) * rad;
    final full = k != k.floorToDouble();
    final c = full ? _full : _new;
    final terms = [
      math.sin(mp),
      e * math.sin(m),
      math.sin(2 * mp),
      math.sin(2 * f),
      e * math.sin(mp - m),
      e * math.sin(mp + m),
      e * e * math.sin(2 * m),
      math.sin(mp - 2 * f),
      math.sin(mp + 2 * f),
      e * math.sin(2 * mp + m),
      math.sin(3 * mp),
      e * math.sin(m + 2 * f),
      e * math.sin(m - 2 * f),
      e * math.sin(2 * mp - m),
      math.sin(omega),
      math.sin(mp + 2 * m),
      math.sin(2 * (mp - f)),
      math.sin(3 * m),
      math.sin(mp + m - 2 * f),
      math.sin(2 * (mp + f)),
      math.sin(mp + m + 2 * f),
      math.sin(mp - m + 2 * f),
      math.sin(mp - m - 2 * f),
      math.sin(3 * mp + m),
      math.sin(4 * mp),
    ];
    var correction = 0.0;
    for (var i = 0; i < c.length; i++) {
      correction += c[i] * terms[i];
    }
    const angles = [
      (299.7, .107408),
      (251.88, .016321),
      (251.83, 26.651886),
      (349.42, 36.412478),
      (84.66, 18.206239),
      (141.74, 53.303771),
      (207.17, 2.453732),
      (154.84, 7.30686),
      (34.52, 27.261239),
      (207.19, .121824),
      (291.34, 1.844379),
      (161.72, 24.198154),
      (239.56, 25.513099),
      (331.55, 3.592518),
    ];
    const extra = [
      .000325,
      .000165,
      .000164,
      .000126,
      .00011,
      .000062,
      .00006,
      .000056,
      .000047,
      .000042,
      .000040,
      .000037,
      .000035,
      .000023,
    ];
    for (var i = 0; i < angles.length; i++) {
      final a = (angles[i].$1 + angles[i].$2 * k) * rad - (i == 0 ? .009173 * t2 : 0);
      correction += extra[i] * math.sin(a);
    }
    final jde = 2451550.09766 + 29.530588861 * k + .00015437 * t2 - .00000015 * t3 + .00000000073 * t4 + correction;
    final approximate = DateTime.fromMillisecondsSinceEpoch(((jde - 2440587.5) * 86400000).round(), isUtc: true);
    return approximate.subtract(Duration(milliseconds: (_deltaT(approximate) * 1000).round()));
  }

  static double _deltaT(DateTime date) {
    final y = date.year + (date.month - .5) / 12;
    if (y >= 2005 && y < 2050) {
      final t = y - 2000;
      return 62.92 + .32217 * t + .005589 * t * t;
    }
    if (y >= 2050 && y < 2150) return -20 + 32 * math.pow((y - 1820) / 100, 2) - .5628 * (2150 - y);
    if (y >= 1986 && y < 2005) {
      final t = y - 2000;
      return 63.86 +
          .3345 * t -
          .060374 * t * t +
          .0017275 * math.pow(t, 3) +
          .000651814 * math.pow(t, 4) +
          .00002373599 * math.pow(t, 5);
    }
    return (-20 + 32 * math.pow((y - 1820) / 100, 2)).toDouble();
  }

  static const _new = [
    -.4072,
    .17241,
    .01608,
    .01039,
    .00739,
    -.00514,
    .00208,
    -.00111,
    -.00057,
    .00056,
    -.00042,
    .00042,
    .00038,
    -.00024,
    -.00017,
    -.00007,
    .00004,
    .00004,
    .00003,
    .00003,
    -.00003,
    .00003,
    -.00002,
    -.00002,
    .00002,
  ];
  static const _full = [
    -.40614,
    .17302,
    .01614,
    .01043,
    .00734,
    -.00515,
    .00209,
    -.00111,
    -.00057,
    .00056,
    -.00042,
    .00042,
    .00038,
    -.00024,
    -.00017,
    -.00007,
    .00004,
    .00004,
    .00003,
    .00003,
    -.00003,
    .00003,
    -.00002,
    -.00002,
    .00002,
  ];
}
