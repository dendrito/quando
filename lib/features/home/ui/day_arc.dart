import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../data/weather_repository.dart';
import '../domain/sky.dart';
import '../domain/moon.dart';
import '../domain/sky_weather.dart';
import 'weather_motion.dart';

import 'package:quando/l10n/l10n.dart';

/// Today as an arc from sunrise to sunset, with the sun where it is now and
/// a dot for each alarm that rings in daylight.
class DayArc extends StatelessWidget {
  const DayArc({
    super.key,
    required this.sky,
    this.marks = const [],
    this.weather = const [],
    this.nowWeather,
    this.nowLabel,
  });

  final SkyDay sky;

  /// Forecast stops drawn along the arc (option C).
  final List<ArcWeather> weather;

  /// The weather right now, drawn over the Sun.
  final WeatherKind? nowWeather;

  /// "Now 15:30", shown above the Sun when weather is on the arc.
  final String? nowLabel;

  /// Alarm positions on the arc, 0 = sunrise, 1 = sunset.
  final List<double> marks;

  @override
  Widget build(BuildContext context) {
    final p = sky.progress;
    final label = p == null
        ? l10n.sunNoRiseSet
        : sky.isDay
        ? l10n.sunProgress((p * 100).round())
        : l10n.sunIsDown;
    return Semantics(
      label: label,
      child: SizedBox(
        height: weather.isEmpty && nowWeather == null ? 120 : 150,
        width: double.infinity,
        child: _ArcClock(
          active: nowWeather != null && nowWeather != WeatherKind.clear,
          builder: (clock) => CustomPaint(
            painter: _ArcPainter(
              progress: p,
              marks: marks,
              weather: weather,
              nowWeather: nowWeather,
              nowLabel: nowLabel,
              textStyle: Theme.of(context).textTheme.bodySmall,
              clock: clock,
            ),
          ),
        ),
      ),
    );
  }
}

/// Moves the cloud, rain or snow drawn over the Sun or Moon. Still when the
/// weather is clear, the card is off screen or reduced motion is on.
class _ArcClock extends StatefulWidget {
  const _ArcClock({required this.active, required this.builder});
  final bool active;
  final Widget Function(Animation<double>? clock) builder;
  @override
  State<_ArcClock> createState() => _ArcClockState();
}

class _ArcClockState extends State<_ArcClock> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8));

  void _update() {
    final animate = widget.active && !MediaQuery.disableAnimationsOf(context) && TickerMode.valuesOf(context).enabled;
    if (animate) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
      _controller.value = .19;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(covariant _ArcClock old) {
    super.didUpdateWidget(old);
    _update();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(widget.active ? _controller : null);
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.progress,
    required this.marks,
    this.moon,
    this.above = true,
    this.daylight,
    this.weather = const [],
    this.nowWeather,
    this.nowLabel,
    this.textStyle,
    this.clock,
  }) : super(repaint: clock);

  /// Moves the clouds; null draws them still.
  final Animation<double>? clock;
  final List<ArcWeather> weather;
  final WeatherKind? nowWeather;
  final String? nowLabel;
  final TextStyle? textStyle;
  final double? progress;
  final List<double> marks;
  final MoonIllumination? moon;
  final bool above;
  final List<bool>? daylight;

  /// Dots where the Moon is up at night.
  static const moonlight = Color(0xFFC9C2E6);

  /// A small five-point star with a soft glow: one alarm on the Sun's path.
  void _star(Canvas canvas, Offset c, double r) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final radius = i.isEven ? r : r * .45;
      final a = -math.pi / 2 + i * math.pi / 5;
      final p = c + Offset(math.cos(a), math.sin(a)) * radius;
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    path.close();
    canvas.drawCircle(c, r * 1.5, Paint()..color = QuandoColors.amber.withValues(alpha: .3));
    canvas.drawPath(path, Paint()..color = QuandoColors.text);
    canvas.drawPath(
      path,
      Paint()
        ..color = QuandoColors.coral
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    // Reserve room for the whole Sun and its glow, including at noon and
    // either horizon. A quadratic's midpoint is halfway to its control point.
    const inset = 24.0;
    final horizon = h - inset;
    final start = Offset(inset, horizon);
    final end = Offset(w - inset, horizon);
    final control = Offset(w / 2, 2 * inset - horizon);

    Offset point(double t) {
      final u = 1 - t;
      return start * (u * u) + control * (2 * u * t) + end * (t * t);
    }

    Path arc(double from, double to) {
      final path = Path();
      const steps = 48;
      for (var i = 0; i <= steps; i++) {
        final pt = point(from + (to - from) * i / steps);
        i == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
      }
      return path;
    }

    // Horizon.
    canvas.drawLine(
      Offset(0, horizon),
      Offset(w, horizon),
      Paint()
        ..color = QuandoColors.blush.withValues(alpha: 0.45)
        ..strokeWidth = 1.5,
    );

    // The whole day, dotted.
    final dots = Paint()..color = QuandoColors.blush.withValues(alpha: 0.6);
    final day = daylight;
    if (day != null && day.length > 1) {
      // Moon path: amber where the Moon is up in daylight, silver at night.
      for (var i = 0; i < day.length; i++) {
        canvas.drawCircle(
          point(i / (day.length - 1)),
          1.8,
          Paint()..color = day[i] ? QuandoColors.amber.withValues(alpha: .9) : moonlight.withValues(alpha: .9),
        );
      }
    } else {
      for (var t = 0.0; t <= 1.0001; t += 1 / 36) {
        canvas.drawCircle(point(t), 1.3, dots);
      }
    }

    final p = progress;
    if (p == null) return;
    final done = p.clamp(0.0, 1.0);

    // The part of the day already lived.
    if (done > 0) {
      canvas.drawPath(
        arc(0, done),
        Paint()
          ..color = QuandoColors.amber
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round,
      );
    }

    // Alarms in daylight.
    for (final m in marks) {
      _star(canvas, point(m), 9);
    }

    // Forecast stops: a small picture on the path and its time and
    // temperature underneath, flipped inward near the horizons.
    for (final stop in weather) {
      final at = point(stop.t.clamp(0.0, 1.0));
      final lived = stop.t <= done;
      if (stop.hour.kind == WeatherKind.clear) {
        final body = stop.hour.night ? moonlight : QuandoColors.amber;
        canvas.drawCircle(at, 9, Paint()..color = lived ? body : body.withValues(alpha: .55));
        canvas.drawCircle(
          at,
          9,
          Paint()
            ..color = QuandoColors.text
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      } else {
        _glyph(canvas, at, 40, stop.hour.kind, stop.hour.night);
      }
      _label(canvas, size, stop.label, at + const Offset(0, 16));
    }

    // The sun, or where it will rise or has set.
    final sun = point(done);
    final kind = nowWeather;
    if (moon != null && above) {
      paintMoon(canvas, sun, 13, moon!);
      // The Moon behind clouds, rain or snow.
      if (kind != null && kind != WeatherKind.clear) _cover(canvas, sun, kind);
      final now = nowLabel;
      if (now != null) _label(canvas, size, now, sun - const Offset(0, 42), bold: true);
    } else if (moon == null && p >= 0 && p <= 1) {
      canvas.drawCircle(sun, 20, Paint()..color = QuandoColors.coral.withValues(alpha: 0.3));
      canvas.drawCircle(sun, 11, Paint()..color = QuandoColors.amber);
      // The Sun behind today's clouds, rain or snow.
      if (kind != null && kind != WeatherKind.clear) _cover(canvas, sun, kind);
      final now = nowLabel;
      if (now != null) _label(canvas, size, now, sun - const Offset(0, 42), bold: true);
    } else {
      canvas.drawCircle(
        sun,
        8,
        Paint()
          ..color = QuandoColors.blush
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  /// A cloud big enough to hide the Sun or Moon at [at], with its rain or
  /// snow falling below. The picture's cloud sits a little above its centre,
  /// so it is drawn lower to land on the body.
  void _cover(Canvas canvas, Offset at, WeatherKind kind) =>
      _glyph(canvas, at + const Offset(0, 8), 68, kind, false, sunless: true);

  void _glyph(Canvas canvas, Offset at, double size, WeatherKind kind, bool night, {bool sunless = false}) {
    canvas.save();
    canvas.translate(at.dx - size / 2, at.dy - size / 2);
    // The arc already draws the Sun, so the picture adds only the cloud.
    WeatherPainter(kind, night, clock?.value ?? .19, sunless: sunless).paint(canvas, Size.square(size));
    canvas.restore();
  }

  void _label(Canvas canvas, Size size, String text, Offset at, {bool bold = false}) {
    final base = textStyle ?? const TextStyle(fontSize: 12);
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: base.copyWith(
          color: QuandoColors.text,
          fontWeight: bold ? FontWeight.w700 : null,
          shadows: const [Shadow(color: Color(0x66000000), blurRadius: 4)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    final x = (at.dx - painter.width / 2).clamp(0.0, math.max(0.0, size.width - painter.width)).toDouble();
    final y = at.dy.clamp(0.0, math.max(0.0, size.height - painter.height)).toDouble();
    painter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.weather.map((w) => w.label).join() != weather.map((w) => w.label).join() ||
      old.nowWeather != nowWeather ||
      old.nowLabel != nowLabel ||
      old.progress != progress ||
      old.marks.length != marks.length ||
      old.moon?.phase != moon?.phase ||
      old.above != above ||
      !_sameDaylight(old.daylight, daylight);

  static bool _sameDaylight(List<bool>? a, List<bool>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null || a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class MoonArc extends StatelessWidget {
  const MoonArc({
    super.key,
    required this.track,
    required this.illumination,
    this.daylight,
    this.weather = const [],
    this.nowWeather,
    this.nowLabel,
  });
  final MoonTrack track;
  final MoonIllumination illumination;

  /// Forecast stops along the Moon's path, and the weather over the Moon now.
  final List<ArcWeather> weather;
  final WeatherKind? nowWeather;
  final String? nowLabel;

  /// Sun up or down at each dot of the path, moonrise to moonset.
  final List<bool>? daylight;

  @override
  Widget build(BuildContext context) => Semantics(
    label: track.above ? l10n.moonAboveHorizon : l10n.moonBelowHorizon,
    child: SizedBox(
      height: weather.isEmpty && nowWeather == null ? 120 : 150,
      width: double.infinity,
      child: _ArcClock(
        active: track.above && nowWeather != null && nowWeather != WeatherKind.clear,
        builder: (clock) => CustomPaint(
          painter: _ArcPainter(
            progress: track.progress ?? (track.above ? .5 : 0),
            marks: const [],
            moon: illumination,
            above: track.above,
            daylight: daylight,
            weather: weather,
            nowWeather: track.above ? nowWeather : null,
            nowLabel: track.above ? nowLabel : null,
            textStyle: Theme.of(context).textTheme.bodySmall,
            clock: clock,
          ),
        ),
      ),
    ),
  );
}

class MoonDisc extends StatelessWidget {
  const MoonDisc({super.key, required this.illumination});
  final MoonIllumination illumination;
  @override
  Widget build(BuildContext context) =>
      SizedBox.square(dimension: 44, child: CustomPaint(painter: _MoonPainter(illumination)));
}

class _MoonPainter extends CustomPainter {
  const _MoonPainter(this.illumination);
  final MoonIllumination illumination;
  @override
  void paint(Canvas canvas, Size size) =>
      paintMoon(canvas, size.center(Offset.zero), size.shortestSide / 2 - 2, illumination);
  @override
  bool shouldRepaint(_MoonPainter old) => old.illumination.phase != illumination.phase;
}

void paintMoon(Canvas canvas, Offset center, double radius, MoonIllumination light) {
  canvas.drawCircle(center, radius, Paint()..color = QuandoColors.ground);
  final path = Path();
  final side = light.phase < .5 ? 1.0 : -1.0;
  final terminator = 1 - 2 * light.fraction;
  for (var i = 0; i <= 40; i++) {
    final y = -1 + i / 20;
    final point = center + Offset(side * radius * math.sqrt((1 - y * y).clamp(0, 1)), y * radius);
    i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
  }
  for (var i = 40; i >= 0; i--) {
    final y = -1 + i / 20;
    path.lineTo(center.dx + side * terminator * radius * math.sqrt((1 - y * y).clamp(0, 1)), center.dy + y * radius);
  }
  path.close();
  canvas.drawPath(path, Paint()..color = QuandoColors.text);
  canvas.drawCircle(
    center,
    radius,
    Paint()
      ..color = QuandoColors.blush.withValues(alpha: .5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1,
  );
}
