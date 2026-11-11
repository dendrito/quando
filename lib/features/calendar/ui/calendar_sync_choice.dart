import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/platform.dart';
import '../domain/calendar_sync.dart';

import 'package:quando/l10n/l10n.dart';

/// "When the calendar changes": follow it (default), keep what was first
/// seen, or only the events there now. Each choice says what it does in one
/// line, and the (?) explains with examples.
class CalendarSyncChoice extends StatelessWidget {
  const CalendarSyncChoice({super.key, required this.value, required this.onChanged});

  final CalendarSync value;
  final ValueChanged<CalendarSync> onChanged;

  static String label(CalendarSync s) => switch (s) {
    CalendarSync.live => l10n.syncLive,
    CalendarSync.keepFirst => l10n.syncKeepFirst,
    CalendarSync.snapshot => l10n.syncSnapshot,
  };

  static String hint(CalendarSync s) => switch (s) {
    CalendarSync.live => l10n.syncLiveHint,
    CalendarSync.keepFirst => l10n.syncKeepFirstHint,
    CalendarSync.snapshot => l10n.syncSnapshotHint,
  };

  static IconData _icon(CalendarSync s) => switch (s) {
    CalendarSync.live => Icons.sync,
    CalendarSync.keepFirst => Icons.push_pin_outlined,
    CalendarSync.snapshot => Icons.photo_camera_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(l10n.syncHeading.toUpperCase(), style: text.labelSmall)),
            IconButton(
              key: const Key('syncHelp'),
              tooltip: l10n.syncHelpButton,
              icon: const Icon(Icons.help_outline, color: QuandoColors.amber),
              onPressed: () => showHelp(context),
            ),
          ],
        ),
        for (final s in CalendarSync.values)
          ListTile(
            key: Key('sync.${s.name}'),
            contentPadding: EdgeInsets.zero,
            selected: s == value,
            selectedColor: QuandoColors.text,
            leading: Icon(
              s == value ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: s == value ? QuandoColors.amber : QuandoColors.muted,
            ),
            title: Text(label(s)),
            subtitle: Text(hint(s)),
            trailing: Icon(_icon(s), color: s == value ? QuandoColors.amber : QuandoColors.muted, size: 20),
            onTap: () => onChanged(s),
          ),
      ],
    );
  }

  /// The help sheet: what each choice does, with the same dentist example,
  /// and when Quando? notices changes.
  static Future<void> showHelp(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final text = Theme.of(context).textTheme;
      Widget choice(CalendarSync s, String example) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12, top: 2),
              child: Icon(_icon(s), color: QuandoColors.amber),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label(s), style: text.titleMedium?.copyWith(color: QuandoColors.amber)),
                  const SizedBox(height: 2),
                  Text(hint(s), style: text.bodyMedium),
                  const SizedBox(height: 4),
                  Text(example, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
                ],
              ),
            ),
          ],
        ),
      );
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.syncHelpTitle, style: text.headlineSmall),
                const SizedBox(height: 8),
                Text(l10n.syncHelpIntro, style: text.bodyMedium),
                const SizedBox(height: 8),
                choice(CalendarSync.live, l10n.syncHelpExampleLive),
                choice(CalendarSync.keepFirst, l10n.syncHelpExampleKeepFirst),
                choice(CalendarSync.snapshot, l10n.syncHelpExampleSnapshot),
                const SizedBox(height: 8),
                Text(l10n.syncHelpTip, style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                Text(l10n.syncHelpWhenTitle, style: text.titleMedium),
                const SizedBox(height: 6),
                Text('• ${l10n.syncHelpWhenOpen}', style: text.bodyMedium),
                const SizedBox(height: 4),
                Text('• ${l10n.syncHelpWhenClosed}', style: text.bodyMedium),
                if (!isAndroid) ...[
                  const SizedBox(height: 4),
                  Text('• ${l10n.syncHelpWhenClosedApple}', style: text.bodyMedium),
                ],
              ],
            ),
          ),
        ),
      );
    },
  );
}
