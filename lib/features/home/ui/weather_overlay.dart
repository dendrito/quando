import 'dart:math' as m;

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../data/weather_repository.dart';

/// Weather falling over a card, for the hours it is forecast: rain, snow,
/// drifting fog, and lightning where thunder is expected. [kinds] runs from
/// the card's left edge to its right (the same time axis as its sky), with
/// null where nothing should fall (the past, or unknown).
///
/// Decorative and cheap: it stops when the card is off screen or when the
/// system asks for reduced motion (then a still picture is drawn).
class WeatherOverlay extends StatefulWidget {
  const WeatherOverlay({super.key, required this.kinds});
  final List<WeatherKind?> kinds;

  /// Whether any of [kinds] needs this overlay at all.
  static bool needed(List<WeatherKind?> kinds) => kinds.any(
    (k) => k == WeatherKind.rain || k == WeatherKind.thunder || k == WeatherKind.snow || k == WeatherKind.fog,
  );

  @override
  State<WeatherOverlay> createState() => _WeatherOverlayState();
}

class _WeatherOverlayState extends State<WeatherOverlay>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final _clock = AnimationController(vsync: this, duration: const Duration(seconds: 10));
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
        _foreground && !MediaQuery.disableAnimationsOf(context) && TickerMode.valuesOf(context).enabled;
    if (animate) {
      if (!_clock.isAnimating) _clock.repeat();
    } else {
      _clock.stop();
      _clock.value = .19;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
  Widget build(BuildContext context) => Positioned.fill(
    child: ExcludeSemantics(
      child: IgnorePointer(
        child: RepaintBoundary(child: CustomPaint(painter: WeatherOverlayPainter(widget.kinds, _clock))),
      ),
    ),
  );
}

/// Draws the falling weather; public so tests can paint it.
class WeatherOverlayPainter extends CustomPainter {
  WeatherOverlayPainter(this.kinds, this.clock) : super(repaint: clock);
  final List<WeatherKind?> kinds;
  final Animation<double> clock;

  static const _columns = 70;

  /// 0..1 at x: how strongly [match] holds around that point of the card,
  /// fading over about a sample either side so edges are soft.
  double _strength(double x, bool Function(WeatherKind?) match) {
    if (kinds.isEmpty) return 0;
    final at = (x * (kinds.length - 1)).clamp(0.0, kinds.length - 1.0);
    final i = at.floor(), j = (i + 1).clamp(0, kinds.length - 1);
    final a = match(kinds[i]) ? 1.0 : 0.0, b = match(kinds[j]) ? 1.0 : 0.0;
    return a + (b - a) * (at - i);
  }

  /// A stable pseudo-random number in 0..1 for [i] and [salt].
  static double _rand(int i, int salt) {
    final v = m.sin(i * 12.9898 + salt * 78.233) * 43758.5453;
    return v - v.floorToDouble();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    final w = size.width, h = size.height;
    if (w <= 0 || h <= 0) return;
    bool wet(WeatherKind? k) => k == WeatherKind.rain || k == WeatherKind.thunder;
    bool snow(WeatherKind? k) => k == WeatherKind.snow;
    bool fog(WeatherKind? k) => k == WeatherKind.fog;

    // Fog: slow pale bands drifting sideways.
    for (var band = 0; band < 3; band++) {
      final y = h * (.35 + band * .2) + m.sin(t * 2 * m.pi + band) * 4;
      final shift = m.sin(t * 2 * m.pi + band * 2) * 14;
      final rect = Rect.fromLTWH(shift - 20, y, w + 40, 22);
      final stops = [for (var i = 0; i <= 8; i++) _strength(i / 8, fog)];
      if (stops.every((v) => v == 0)) break;
      canvas.drawRect(
        rect,
        Paint()
          ..shader = LinearGradient(
            colors: [for (final v in stops) QuandoColors.text.withValues(alpha: .16 * v)],
          ).createShader(rect),
      );
    }

    // Rain: slanted streaks falling, only over the hours it is expected.
    final rain = Paint()
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < _columns; i++) {
      final x = (i + _rand(i, 1)) / _columns;
      final strength = _strength(x, wet);
      if (strength < _rand(i, 2) * .9 + .05) continue;
      final speed = 2 + (_rand(i, 3) * 2).floor();
      final phase = (t * speed + _rand(i, 4)) % 1;
      final y = phase * (h + 30) - 15;
      final len = 9 + _rand(i, 5) * 8;
      rain.color = QuandoColors.text.withValues(alpha: (.18 + .3 * _rand(i, 6)) * strength.clamp(0, 1));
      canvas.drawLine(Offset(x * w, y), Offset(x * w - len * .22, y + len), rain);
    }

    // Snow: soft flakes drifting down.
    for (var i = 0; i < _columns ~/ 2; i++) {
      final x = (i + _rand(i, 7)) / (_columns ~/ 2);
      final strength = _strength(x, snow);
      if (strength < _rand(i, 8) * .9 + .05) continue;
      final phase = (t * (1 + (_rand(i, 9) * 2).floor()) + _rand(i, 10)) % 1;
      final dx = m.sin(t * 2 * m.pi * 2 + i) * 6;
      canvas.drawCircle(
        Offset(x * w + dx, phase * (h + 20) - 10),
        1.2 + _rand(i, 11) * 1.4,
        Paint()..color = QuandoColors.text.withValues(alpha: .7 * strength.clamp(0, 1)),
      );
    }

    // Lightning: a few flashes per cycle, each at a thunder stretch.
    final ranges = <(double, double)>[];
    double? from;
    for (var i = 0; i < kinds.length; i++) {
      final isThunder = kinds[i] == WeatherKind.thunder;
      if (isThunder && from == null) from = i / (kinds.length - 1);
      if ((!isThunder || i == kinds.length - 1) && from != null) {
        ranges.add((from, (isThunder ? i : i - 1) / (kinds.length - 1)));
        from = null;
      }
    }
    var n = 0;
    for (final (a, b) in ranges) {
      final flashes = ((b - a) * 6).ceil().clamp(1, 3);
      for (var j = 0; j < flashes; j++, n++) {
        final at = a + (b - a) * (flashes == 1 ? .5 : (.12 + .76 * j / (flashes - 1)));
        final when = (.12 + _rand(n, 12) * .76) % 1;
        // A quick double flash: a strong one, then a weaker one.
        var glow = (1 - (t - when).abs() / .012).clamp(0.0, 1.0);
        glow = m.max(glow, .6 * (1 - (t - when - .03).abs() / .01).clamp(0.0, 1.0));
        if (glow <= 0) continue;
        final cx = at * w;
        final haze = Rect.fromCenter(center: Offset(cx, h * .4), width: w * .55, height: h * 1.4);
        canvas.drawRect(
          haze.intersect(Offset.zero & size),
          Paint()
            ..shader = RadialGradient(
              colors: [
                QuandoColors.text.withValues(alpha: .38 * glow),
                const Color(0x00FFFFFF),
              ],
            ).createShader(haze),
        );
        // The bolt, jagged and the same every time at this spot.
        final bolt = Path()..moveTo(cx, 0);
        var x = cx, y = 0.0;
        for (var k = 0; k < 6; k++) {
          x += (_rand(n * 10 + k, 13) - .5) * 26;
          y += h * .14;
          bolt.lineTo(x, y);
        }
        canvas.drawPath(
          bolt,
          Paint()
            ..color = const Color(0xFFFFF4C2).withValues(alpha: .95 * glow)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2
            ..strokeJoin = StrokeJoin.miter,
        );
      }
    }
  }

  @override
  bool shouldRepaint(WeatherOverlayPainter old) => old.kinds != kinds;
}
