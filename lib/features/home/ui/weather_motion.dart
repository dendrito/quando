import 'dart:math' as m;

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../data/weather_repository.dart';

/// Small, decorative motion: never changes the full-screen brightness.
class WeatherMotion extends StatefulWidget {
  const WeatherMotion({super.key, required this.kind, this.night = false, this.active = true});
  final WeatherKind kind;
  final bool night, active;
  @override
  State<WeatherMotion> createState() => _WeatherMotionState();
}

class _WeatherMotionState extends State<WeatherMotion>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final _clock = AnimationController(vsync: this, duration: const Duration(seconds: 8));
  bool _foreground = true;
  @override
  void initState() {
    super.initState();
    _foreground =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    WidgetsBinding.instance.addObserver(this);
  }

  void _update() {
    final animate =
        widget.active &&
        _foreground &&
        !MediaQuery.disableAnimationsOf(context) &&
        TickerMode.valuesOf(context).enabled;
    if (animate) {
      if (!_clock.isAnimating) _clock.repeat();
    } else {
      _clock.stop();
      _clock.value = 0.19;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(covariant WeatherMotion old) {
    super.didUpdateWidget(old);
    _update();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    _update();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: RepaintBoundary(
      child: SizedBox(
        width: 108,
        height: 108,
        child: AnimatedBuilder(
          animation: _clock,
          builder: (context, _) =>
              CustomPaint(painter: _WeatherPainter(widget.kind, widget.night, _clock.value)),
        ),
      ),
    ),
  );
}

class _WeatherPainter extends CustomPainter {
  const _WeatherPainter(this.kind, this.night, this.t);
  final WeatherKind kind;
  final bool night;
  final double t;
  @override
  void paint(Canvas c, Size s) {
    c.save();
    c.scale(s.width / 108, s.height / 108);
    final amber = Paint()..color = QuandoColors.amber;
    if (kind == WeatherKind.clear || kind == WeatherKind.clouds) {
      final sun = Offset(kind == WeatherKind.clear ? 54 : 39, kind == WeatherKind.clear ? 49 : 33);
      c.drawCircle(
        sun,
        25 + 2 * m.sin(t * 2 * m.pi),
        Paint()..color = QuandoColors.coral.withValues(alpha: 0.18),
      );
      if (night) {
        c.drawPath(
          Path.combine(
            PathOperation.difference,
            Path()..addOval(Rect.fromCircle(center: sun, radius: 17)),
            Path()..addOval(Rect.fromCircle(center: sun + const Offset(7, -6), radius: 15)),
          ),
          amber,
        );
      } else {
        for (var i = 0; i < 8; i++) {
          final a = i * m.pi / 4 + t * 0.15;
          c.drawLine(
            sun + Offset(m.cos(a), m.sin(a)) * 24,
            sun + Offset(m.cos(a), m.sin(a)) * 29,
            Paint()
              ..color = QuandoColors.amber.withValues(alpha: 0.6)
              ..strokeWidth = 2
              ..strokeCap = StrokeCap.round,
          );
        }
        c.drawCircle(sun, 17, amber);
      }
    }
    if (kind != WeatherKind.clear) {
      final drift = m.sin(t * 2 * m.pi) * 3;
      final cloud = Path()
        ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(20 + drift, 38, 69, 25), const Radius.circular(14)))
        ..addOval(Rect.fromCircle(center: Offset(42 + drift, 39), radius: 18))
        ..addOval(Rect.fromCircle(center: Offset(66 + drift, 43), radius: 15));
      c.drawPath(
        cloud,
        Paint()..color = QuandoColors.blush.withValues(alpha: kind == WeatherKind.thunder ? 0.65 : 0.9),
      );
    }
    if (kind == WeatherKind.rain || kind == WeatherKind.thunder) {
      for (var i = 0; i < 7; i++) {
        final phase = (t * 8 + i * 0.19) % 1, x = 28 + i * 8.0, y = 64 + phase * 32;
        c.drawLine(
          Offset(x, y),
          Offset(x - 3, y + 7),
          Paint()
            ..color = QuandoColors.coral.withValues(alpha: 0.65 * (1 - phase * 0.5))
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round,
        );
      }
    }
    if (kind == WeatherKind.thunder) {
      // One brief fade every eight seconds, confined to the bolt itself.
      final glow = (1 - (t - 0.19).abs() / 0.025).clamp(0.0, 1.0);
      final bolt = Path()
        ..moveTo(58, 53)
        ..lineTo(46, 76)
        ..lineTo(58, 73)
        ..lineTo(50, 96)
        ..lineTo(76, 66)
        ..lineTo(61, 68)
        ..lineTo(70, 53)
        ..close();
      c.drawPath(bolt, Paint()..color = QuandoColors.amber.withValues(alpha: 0.25 + 0.7 * glow));
    }
    if (kind == WeatherKind.snow) {
      for (var i = 0; i < 8; i++) {
        final phase = (t * 2 + i * 0.16) % 1;
        c.drawCircle(
          Offset(25 + i * 8 + m.sin(t * 6 + i) * 3, 64 + phase * 32),
          2,
          Paint()..color = QuandoColors.text.withValues(alpha: 0.8),
        );
      }
    }
    if (kind == WeatherKind.fog) {
      for (var i = 0; i < 3; i++) {
        c.drawLine(
          Offset(24 + m.sin(t * 6 + i) * 4, 73 + i * 8.0),
          Offset(85 + m.sin(t * 6 + i) * 4, 73 + i * 8.0),
          Paint()
            ..color = QuandoColors.blush.withValues(alpha: 0.5)
            ..strokeWidth = 3
            ..strokeCap = StrokeCap.round,
        );
      }
    }
    c.restore();
  }

  @override
  bool shouldRepaint(_WeatherPainter old) => old.t != t || old.kind != kind || old.night != night;
}
