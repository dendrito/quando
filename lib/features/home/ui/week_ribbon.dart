import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../domain/week.dart';

import 'package:quando/l10n/l10n.dart';

/// Colour of an alarm group's dot, the same everywhere. No group is coral.
Color groupColor(String group) {
  if (group.isEmpty) return QuandoColors.coral;
  const palette = [
    Color(0xFF7FD1AE),
    Color(0xFF7DB7FF),
    Color(0xFFC59BFF),
    Color(0xFFFF8FB1),
    Color(0xFFFFD166),
    Color(0xFF6EDCE0),
  ];
  var h = 0;
  for (final c in group.codeUnits) {
    h = (h * 31 + c) & 0x7fffffff;
  }
  return palette[h % palette.length];
}

/// The week ahead as seven days in a row, one dot per alarm. Today is coral,
/// Shabbat and festival days have a gold ring. Tap a day to see only its
/// alarms; tap it again to see them all.
class WeekRibbon extends StatelessWidget {
  const WeekRibbon({super.key, required this.days, required this.selected, required this.onSelect});

  final List<RibbonDay> days;

  /// The day the list below is filtered to, if any.
  final DateTime? selected;
  final ValueChanged<DateTime?> onSelect;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        for (final d in days)
          Expanded(
            child: Semantics(
              button: true,
              selected: selected != null && d.sameDay(selected!),
              label: '${dayLabel(d.day)}, ${l10n.alarmCount(d.dots.length)}',
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onSelect(selected != null && d.sameDay(selected!) ? null : d.day),
                child: ExcludeSemantics(child: _cell(d, text)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _cell(RibbonDay d, TextTheme text) {
    final on = selected != null && d.sameDay(selected!);
    final shown = d.dots.take(6).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weekdayNarrow(d.day.weekday),
            style: text.labelSmall?.copyWith(color: on ? QuandoColors.amber : QuandoColors.blush),
          ),
          const SizedBox(height: 2),
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: d.today ? QuandoColors.coral : (on ? QuandoColors.raised : Colors.transparent),
              border: d.holy
                  ? Border.all(color: QuandoColors.amber, width: 2)
                  : on
                  ? Border.all(color: QuandoColors.text, width: 1.5)
                  : null,
            ),
            child: Text(
              '${d.day.day}',
              style: text.titleSmall?.copyWith(color: d.today ? QuandoColors.ground : QuandoColors.text),
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 8,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 2,
              runSpacing: 2,
              children: [
                for (final k in shown)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: _dot(k)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A dot's colour key is `g:<group>` for a user alarm or `e` for an event or Shabbat alarm.
  Color _dot(String key) =>
      key == 'e' ? QuandoColors.amber : groupColor(key.startsWith('g:') ? key.substring(2) : '');
}
