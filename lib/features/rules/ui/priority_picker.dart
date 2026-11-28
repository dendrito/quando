import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../domain/alarm_priority.dart';

/// Quiet, Normal, Loud or Critical, each with one short line under it.
/// [value] null = the default in settings (shown when [onDefault] is given).
class PriorityPicker extends StatelessWidget {
  const PriorityPicker({super.key, required this.value, required this.onChanged, this.onDefault});
  final AlarmPriority? value;
  final ValueChanged<AlarmPriority> onChanged;
  final VoidCallback? onDefault;

  static String label(AlarmPriority p) => switch (p) {
    AlarmPriority.quiet => l10n.alarmPriorityQuiet,
    AlarmPriority.normal => l10n.alarmPriorityNormal,
    AlarmPriority.loud => l10n.alarmPriorityLoud,
    AlarmPriority.critical => l10n.alarmPriorityCritical,
  };

  static String hint(AlarmPriority p) => switch (p) {
    AlarmPriority.quiet => l10n.alarmPriorityQuietHint,
    AlarmPriority.normal => l10n.alarmPriorityNormalHint,
    AlarmPriority.loud => l10n.alarmPriorityLoudHint,
    AlarmPriority.critical => l10n.alarmPriorityCriticalHint,
  };

  @override
  Widget build(BuildContext context) {
    Widget row(Key key, String title, String? subtitle, bool selected, VoidCallback onTap) => ListTile(
      key: key,
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(selected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      onTap: onTap,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.alarmPriority, style: Theme.of(context).textTheme.labelSmall),
        if (onDefault != null)
          row(const ValueKey('priority-default'), l10n.defaultLabel, null, value == null, onDefault!),
        for (final p in AlarmPriority.values)
          row(ValueKey('priority-${p.name}'), label(p), hint(p), value == p, () => onChanged(p)),
      ],
    );
  }
}
