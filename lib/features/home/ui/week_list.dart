import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/local_time.dart';
import '../domain/week.dart';

import 'package:quando/l10n/l10n.dart';

/// The week ahead, one heading per day and one row per series of alarms.
/// A series with several alarms opens when tapped.
class WeekList extends StatefulWidget {
  const WeekList({
    super.key,
    required this.days,
    required this.today,
    required this.zone,
    this.skipped = const {},
    this.onTap,
    this.onSeries,
  });

  final List<DayPlan> days;

  /// Alarms that won't ring this time, shown struck through.
  final Set<int> skipped;

  /// Tapping one alarm: skip it, or edit what set it.
  final ValueChanged<ScheduledAlarm>? onTap;

  /// The ⋯ button or a long press on a row: act on all its alarms at once.
  final ValueChanged<AlarmSeries>? onSeries;
  final DateTime today;
  final String zone;

  @override
  State<WeekList> createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  final _open = <String>{};

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    String local(DateTime utc) => hhmm(inZone(utc, widget.zone));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final day in widget.days) ...[
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    dayHeading(day.day, widget.today),
                    style: text.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
                Text(l10n.alarmCount(day.count), style: text.bodySmall),
              ],
            ),
          ),
          Material(
            color: QuandoColors.surface,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final (i, s) in day.series.indexed) ...[
                  if (i > 0) const Divider(height: 1, indent: 18, endIndent: 18),
                  _series(s, '${day.day.toIso8601String()}|${s.title}', text, local),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _series(AlarmSeries s, String key, TextTheme text, String Function(DateTime) local) {
    final timeStyle = text.titleLarge?.copyWith(color: QuandoColors.amber, fontSize: 22);
    const off = TextStyle(decoration: TextDecoration.lineThrough, color: QuandoColors.faint);
    bool skip(ScheduledAlarm a) => widget.skipped.contains(a.id);
    if (s.alarms.length == 1) {
      final a = s.alarms.single;
      final x = skip(a);
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        onTap: widget.onTap == null ? null : () => widget.onTap!(a),
        onLongPress: widget.onTap == null ? null : () => widget.onTap!(a),
        title: Text(s.title, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(x ? l10n.skippedBody(a.body) : a.body, style: text.bodySmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(local(a.at), style: x ? timeStyle?.merge(off) : timeStyle),
            if (widget.onTap != null) _more(() => widget.onTap!(a)),
          ],
        ),
      );
    }
    final open = _open.contains(key);
    final skipped = s.alarms.where(skip).length;
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
          onTap: () => setState(() => open ? _open.remove(key) : _open.add(key)),
          onLongPress: widget.onSeries == null ? null : () => widget.onSeries!(s),
          title: Text(s.title, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          subtitle: Text(
            [
              l10n.alarmCount(s.alarms.length),
              l10n.timeToTime(local(s.first), local(s.last)),
              if (skipped > 0) l10n.skippedCount(skipped),
            ].join(' · '),
            style: text.bodySmall,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(local(s.first), style: timeStyle),
              const SizedBox(width: 4),
              AnimatedRotation(
                turns: open ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.expand_more, color: QuandoColors.muted),
              ),
              if (widget.onSeries != null) _more(() => widget.onSeries!(s)),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: !open
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      for (final a in s.alarms)
                        InkWell(
                          onTap: widget.onTap == null ? null : () => widget.onTap!(a),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: skip(a) ? QuandoColors.faint : QuandoColors.coral,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    a.body,
                                    style: skip(a) ? text.bodyMedium?.merge(off) : text.bodyMedium,
                                  ),
                                ),
                                Text(
                                  local(a.at),
                                  style: text.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800)
                                      .merge(skip(a) ? off : null),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _more(VoidCallback onPressed) => IconButton(
    tooltip: l10n.more,
    visualDensity: VisualDensity.compact,
    onPressed: onPressed,
    icon: const Icon(Icons.more_vert, color: QuandoColors.muted),
  );
}
