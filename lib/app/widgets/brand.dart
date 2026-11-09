import 'package:flutter/material.dart';

import '../edition.dart';
import '../theme.dart';

import 'package:quando/l10n/l10n.dart';

/// The Q-hand logo: a Q drawn as a clock whose tail is the minute hand.
/// Drawn on a 180-unit grid, the same as the app icon. Matai? draws its own
/// icon: plum tile, amber ring, and a candle flame for the hour hand.
class QMark extends StatelessWidget {
  const QMark({super.key, this.size = 32, this.tile = true});

  final double size;

  /// With the coral tile behind it, like the app icon.
  final bool tile;

  @override
  Widget build(BuildContext context) => Semantics(
    label: l10n.logoLabel,
    child: CustomPaint(size: Size.square(size), painter: _QMarkPainter(tile)),
  );
}

class _QMarkPainter extends CustomPainter {
  const _QMarkPainter(this.tile);

  final bool tile;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 180);
    if (tile) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(0, 0, 180, 180), const Radius.circular(44)),
        Paint()..color = kodesh ? QuandoColors.ground : QuandoColors.coral,
      );
    }
    if (kodesh) return _matai(canvas);
    final ink = tile ? QuandoColors.ground : QuandoColors.coral;
    final hand = tile ? QuandoColors.text : QuandoColors.coral;
    Paint stroke(Color c, double w) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..strokeCap = StrokeCap.round;
    const centre = Offset(86, 84);
    canvas.drawCircle(centre, 46, stroke(ink, 17));
    canvas.drawLine(centre, const Offset(86, 56), stroke(ink, 12));
    canvas.drawLine(centre, const Offset(146, 144), stroke(hand, 17));
    if (tile) canvas.drawCircle(centre, 9, Paint()..color = QuandoColors.text);
  }

  void _matai(Canvas canvas) {
    const centre = Offset(86, 84);
    final ring = tile ? QuandoColors.amber : QuandoColors.coral;
    canvas.drawCircle(
      centre,
      46,
      Paint()
        ..color = ring
        ..style = PaintingStyle.stroke
        ..strokeWidth = 17,
    );
    Path flame(double top, double halfWidth, double bottom) => Path()
      ..moveTo(86, top)
      ..cubicTo(
        86 + halfWidth * .8,
        top + (bottom - top) * .45,
        86 + halfWidth,
        bottom - halfWidth * 1.2,
        86 + halfWidth,
        bottom - halfWidth,
      )
      ..arcToPoint(Offset(86 - halfWidth, bottom - halfWidth), radius: Radius.circular(halfWidth))
      ..cubicTo(86 - halfWidth, bottom - halfWidth * 1.2, 86 - halfWidth * .8, top + (bottom - top) * .45, 86, top)
      ..close();
    canvas.drawPath(flame(50, 11, 82), Paint()..color = QuandoColors.coral);
    if (tile) canvas.drawPath(flame(62, 5, 78), Paint()..color = QuandoColors.text);
    canvas.drawLine(
      centre,
      const Offset(146, 144),
      Paint()
        ..color = tile ? QuandoColors.text : QuandoColors.coral
        ..strokeWidth = 17
        ..strokeCap = StrokeCap.round,
    );
    if (tile) canvas.drawCircle(centre, 9, Paint()..color = QuandoColors.text);
  }

  @override
  bool shouldRepaint(_QMarkPainter old) => old.tile != tile;
}

/// A candle flame, for Shabbat and festivals.
class Flame extends StatelessWidget {
  const Flame({super.key, this.height = 52, this.candle = false, this.glow = false});

  final double height;

  /// Draw the candle under the flame.
  final bool candle;

  /// A soft halo around the flame.
  final bool glow;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: CustomPaint(
      size: Size(height * (candle ? 64 / 150 : 40 / 52), height),
      painter: _FlamePainter(candle: candle, glow: glow),
    ),
  );
}

class _FlamePainter extends CustomPainter {
  const _FlamePainter({required this.candle, required this.glow});

  final bool candle;
  final bool glow;

  @override
  void paint(Canvas canvas, Size size) {
    if (candle) {
      canvas.scale(size.width / 64);
      if (glow) {
        canvas.drawCircle(
          const Offset(32, 36),
          22,
          Paint()
            ..color = QuandoColors.amber.withValues(alpha: 0.35)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
        );
      }
      canvas.drawPath(_outer(), Paint()..color = QuandoColors.amber);
      canvas.drawPath(_inner(), Paint()..color = QuandoColors.coral);
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(20, 60, 24, 90), const Radius.circular(4)),
        Paint()..color = QuandoColors.text,
      );
    } else {
      // The flame alone, scaled from the 64-wide candle drawing.
      final s = size.height / 52;
      canvas.scale(s);
      canvas.translate(size.width / s / 2 - 32, -4);
      canvas.drawPath(_outer(), Paint()..color = QuandoColors.coral);
      canvas.drawPath(_inner(), Paint()..color = QuandoColors.ground.withValues(alpha: 0.25));
    }
  }

  Path _outer() => Path()
    ..moveTo(32, 6)
    ..cubicTo(42, 20, 46, 28, 45, 38)
    ..cubicTo(44, 48, 39, 54, 32, 54)
    ..cubicTo(25, 54, 20, 48, 19, 38)
    ..cubicTo(18, 30, 24, 22, 32, 6)
    ..close();

  Path _inner() => Path()
    ..moveTo(32, 26)
    ..cubicTo(37, 33, 39, 38, 38, 43)
    ..cubicTo(37, 48, 35, 50, 32, 50)
    ..cubicTo(29, 50, 27, 48, 26, 43)
    ..cubicTo(25, 38, 27, 33, 32, 26)
    ..close();

  @override
  bool shouldRepaint(_FlamePainter old) => old.candle != candle || old.glow != glow;
}
