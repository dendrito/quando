import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';

/// The time, big, and the day: weekday in words and the day of the month as
/// a large number. Redraws on the minute.
class ClockHero extends StatefulWidget {
  const ClockHero({super.key, required this.now, required this.zone});

  /// The current instant (UTC) and the zone to show it in.
  final DateTime Function() now;
  final String zone;

  @override
  State<ClockHero> createState() => _ClockHeroState();
}

class _ClockHeroState extends State<ClockHero> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  /// Wakes just after the next minute starts.
  void _schedule() {
    final t = widget.now();
    final toNext = Duration(seconds: 60 - t.second, milliseconds: -t.millisecond);
    _timer = Timer(toNext + const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {});
      _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final local = inZone(widget.now(), widget.zone);
    return Semantics(
      label: '${hhmm(local)}, ${weekdayName(local)} ${local.day} ${monthName(local)}',
      child: ExcludeSemantics(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  hhmm(local),
                  maxLines: 1,
                  style: text.displayLarge?.copyWith(
                    fontSize: 84,
                    color: QuandoColors.text,
                    letterSpacing: -2,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // The day: weekday in words over a big number and the month.
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weekdayName(local).toUpperCase(),
                  style: text.labelLarge?.copyWith(
                    color: QuandoColors.amber,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${local.day}',
                  style: text.displayMedium?.copyWith(fontSize: 56, color: QuandoColors.text, height: 1),
                ),
                Text(
                  monthName(local),
                  style: text.bodyMedium?.copyWith(color: QuandoColors.blush, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
