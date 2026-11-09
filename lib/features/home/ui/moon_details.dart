import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../domain/moon.dart';
import 'day_arc.dart';

/// Length of a synodic month, new moon to new moon.
const synodicMonthDays = 29.53;

/// The big "Moon first" view: the phase drawn large, then rise, set and the
/// next new and full moon, and how far through the lunar month we are.
/// Shown as an optional swipe page and when the Moon card is tapped.
class MoonDetails extends StatelessWidget {
  const MoonDetails({
    super.key,
    required this.illumination,
    required this.phaseName,
    required this.rises,
    required this.sets,
    required this.newMoon,
    required this.fullMoon,
  });

  final MoonIllumination illumination;
  final String phaseName, rises, sets, newMoon, fullMoon;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final day = (illumination.phase * synodicMonthDays).floor() + 1;
    final lit = (illumination.fraction * 100).round();
    Widget fact(String label, String value) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label.toUpperCase(), style: text.labelSmall?.copyWith(color: QuandoColors.faint, letterSpacing: 1)),
        const SizedBox(height: 2),
        Text(value, style: text.bodyMedium),
      ],
    );
    final facts = Wrap(
      spacing: 24,
      runSpacing: 10,
      children: [
        SizedBox(width: 150, child: fact(l10n.moonRises, rises)),
        SizedBox(width: 150, child: fact(l10n.moonSets, sets)),
        SizedBox(width: 150, child: fact(l10n.moonNextNew, newMoon)),
        SizedBox(width: 150, child: fact(l10n.moonNextFull, fullMoon)),
      ],
    );
    final summary = Column(
      key: const ValueKey('moon-details'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(phaseName, style: text.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        Text('$lit% ${l10n.moonIlluminated}', style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
        const SizedBox(height: 14),
        facts,
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: illumination.phase.clamp(0.0, 1.0),
            minHeight: 6,
            color: const Color(0xFF8E7BB5),
            backgroundColor: const Color(0xFF33234D),
          ),
        ),
        const SizedBox(height: 6),
        Text(l10n.moonLunarDay(day), style: text.bodySmall?.copyWith(color: QuandoColors.faint)),
      ],
    );
    final disc = Semantics(
      label: '$phaseName, $lit%',
      child: SizedBox.square(dimension: 140, child: CustomPaint(painter: _BigMoonPainter(illumination))),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth >= 560
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  disc,
                  const SizedBox(width: 32),
                  Expanded(child: summary),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: disc),
                  const SizedBox(height: 16),
                  summary,
                ],
              ),
      ),
    );
  }
}

class _BigMoonPainter extends CustomPainter {
  const _BigMoonPainter(this.illumination);
  final MoonIllumination illumination;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero), radius = size.shortestSide / 2;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [QuandoColors.text.withValues(alpha: .12), QuandoColors.text.withValues(alpha: 0)],
          stops: const [.7, 1],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
    paintMoon(canvas, center, radius * .72, illumination);
  }

  @override
  bool shouldRepaint(_BigMoonPainter old) => old.illumination.phase != illumination.phase;
}

/// Opens [MoonDetails] over the home screen.
Future<void> showMoonDetails(BuildContext context, MoonDetails details) => showModalBottomSheet<void>(
  context: context,
  backgroundColor: QuandoColors.surface,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (context) => SafeArea(
    child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), child: details),
  ),
);
