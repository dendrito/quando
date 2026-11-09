import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../domain/home_display.dart';

/// The time, big, and the day: weekday in words and the day of the month as
/// a large number. Redraws on the minute.
class ClockHero extends StatefulWidget {
  const ClockHero({super.key, required this.now, required this.zone, this.size = ClockSize.large});

  /// The current instant (UTC) and the zone to show it in.
  final DateTime Function() now;
  final String zone;

  /// Large: big time and the date beside it. Medium: smaller time, date on
  /// one line. Small: one line of text. Off is never built.
  final ClockSize size;

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
    final date = '${weekdayName(local)} ${local.day} ${monthName(local)}';
    if (widget.size == ClockSize.small) {
      return Text(
        '${hhmm(local)} · $date',
        style: text.titleMedium?.copyWith(
          color: QuandoColors.blush,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      );
    }
    if (widget.size == ClockSize.medium) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            hhmm(local),
            style: text.displayMedium?.copyWith(
              fontSize: 34,
              color: QuandoColors.text,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              date,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.titleMedium?.copyWith(color: QuandoColors.blush),
            ),
          ),
        ],
      );
    }
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
                    fontSize: 52,
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
                  style: text.displayMedium?.copyWith(fontSize: 32, color: QuandoColors.text, height: 1),
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
