import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../domain/sky.dart';

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
  const _ArcPainter({required this.progress, required this.marks});

  final double? progress;
  final List<double> marks;

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
    if (p >= 0 && p <= 1) {
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
  bool shouldRepaint(_ArcPainter old) => old.progress != progress || old.marks.length != marks.length;
}
