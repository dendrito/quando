import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../domain/sky.dart';
import '../domain/moon.dart';

import 'package:quando/l10n/l10n.dart';

/// Today as an arc from sunrise to sunset, with the sun where it is now and
/// a dot for each alarm that rings in daylight.
class DayArc extends StatelessWidget {
  const DayArc({super.key, required this.sky, this.marks = const []});

  final SkyDay sky;

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
        height: 120,
        width: double.infinity,
        child: CustomPaint(
          painter: _ArcPainter(progress: p, marks: marks),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter({required this.progress, required this.marks, this.moon, this.above = true});

  final double? progress;
  final List<double> marks;
  final MoonIllumination? moon;
  final bool above;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final horizon = h - 10;
    final start = Offset(14, horizon);
    final end = Offset(w - 14, horizon);
    final control = Offset(w / 2, -h * 0.85);

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
    for (var t = 0.0; t <= 1.0001; t += 1 / 36) {
      canvas.drawCircle(point(t), 1.3, dots);
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
      canvas.drawCircle(point(m), 5, Paint()..color = QuandoColors.text);
    }

    // The sun, or where it will rise or has set.
    final sun = point(done);
    if (moon != null && above) {
      paintMoon(canvas, sun, 13, moon!);
    } else if (moon == null && p >= 0 && p <= 1) {
      canvas.drawCircle(sun, 20, Paint()..color = QuandoColors.coral.withValues(alpha: 0.3));
      canvas.drawCircle(sun, 11, Paint()..color = QuandoColors.amber);
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

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress ||
      old.marks.length != marks.length ||
      old.moon?.phase != moon?.phase ||
      old.above != above;
}

class MoonArc extends StatelessWidget {
  const MoonArc({super.key, required this.track, required this.illumination});
  final MoonTrack track;
  final MoonIllumination illumination;

  @override
  Widget build(BuildContext context) => Semantics(
    label: track.above ? l10n.moonAboveHorizon : l10n.moonBelowHorizon,
    child: SizedBox(
      height: 120,
      width: double.infinity,
      child: CustomPaint(
        painter: _ArcPainter(
          progress: track.progress ?? (track.above ? .5 : 0),
          marks: const [],
          moon: illumination,
          above: track.above,
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
    path.lineTo(
      center.dx + side * terminator * radius * math.sqrt((1 - y * y).clamp(0, 1)),
      center.dy + y * radius,
    );
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
