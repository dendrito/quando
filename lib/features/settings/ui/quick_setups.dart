import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';
import '../../timers/data/timer_providers.dart';
import '../../timers/domain/timers.dart';
import '../domain/quick_setups.dart';

/// The top of Settings: three setups, each one tap and one line.
class QuickSetupsRow extends ConsumerWidget {
  const QuickSetupsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o = ref.watch(alarmOptionsProvider);
    final seq = ref.watch(sequenceConfigProvider);
    final text = Theme.of(context).textTheme;

    Widget tile(IconData icon, String title, bool on, VoidCallback onTap) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: on ? Text(l10n.on, style: text.labelMedium) : const Icon(Icons.chevron_right),
      onTap: onTap,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(l10n.quickSetups.toUpperCase(), style: text.labelSmall),
        ),
        tile(Icons.wb_sunny_outlined, l10n.qsMorningTitle, morningIsOn(o), () => _morning(context, ref)),
        tile(Icons.event_available_outlined, l10n.qsStartTitle, false, () => _start(context)),
        tile(Icons.hourglass_bottom, l10n.qsStretchTitle, stretchIsOn(seq), () => _stretch(context, ref)),
      ],
    );
  }

  Future<void> _morning(BuildContext context, WidgetRef ref) async {
    final before = ref.read(alarmOptionsProvider);
    final after = morningApplied(before);
    final changes = <(String, String, String)>[
      if (before.wakeCheck != after.wakeCheck)
        (l10n.wakeUpCheck, _onOff(before.wakeCheck), _onOff(after.wakeCheck)),
      if (before.maxSnoozes != after.maxSnoozes)
        (l10n.qsSnoozeTimes, '${before.maxSnoozes}', '${after.maxSnoozes}'),
      if (before.snoozeMinutes != after.snoozeMinutes)
        (l10n.qsSnoozeMinutes, '${before.snoozeMinutes}', '${after.snoozeMinutes}'),
      if (before.spoken != after.spoken) (l10n.sayItOutLoud, _onOff(before.spoken), _onOff(after.spoken)),
    ];
    final ok = await _confirm(context, l10n.qsMorningTitle, changes, morningIsOn(before));
    if (ok != true || !context.mounted) return;
    ref.read(alarmOptionsProvider.notifier).update(morningApplied);
    _undoBar(context, () => ref.read(alarmOptionsProvider.notifier).update((_) => before));
  }

  void _start(BuildContext context) => context.push('/calendar');

  Future<void> _stretch(BuildContext context, WidgetRef ref) async {
    final before = ref.read(sequenceConfigProvider);
    final after = stretchApplied(before, l10n.qsFiveLeft);
    String sec(int s) => s == 0
        ? l10n.seqOff
        : s % 60 == 0
        ? l10n.seqEveryMinutes(s ~/ 60)
        : l10n.seqEverySeconds(s);
    String clock(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
    String marks(SequenceConfig c) => c.marks.isEmpty
        ? l10n.seqOff
        : c.marks.map((m) => '${clock(m.atSeconds)} ${m.text}'.trim()).join(', ');
    final changes = <(String, String, String)>[
      if (before.lengthSeconds != after.lengthSeconds)
        (
          l10n.seqLength,
          before.lengthSeconds == 0 ? l10n.seqNoLimit : sec(before.lengthSeconds),
          sec(after.lengthSeconds),
        ),
      if (before.sayEvery != after.sayEvery) (l10n.seqSayEvery, sec(before.sayEvery), sec(after.sayEvery)),
      if (before.finalCount != after.finalCount)
        (l10n.seqFinalCount, sec(before.finalCount), sec(after.finalCount)),
      if (marks(before) != marks(after)) (l10n.seqMarks, marks(before), marks(after)),
    ];
    final ok = await _confirm(context, l10n.qsStretchTitle, changes, stretchIsOn(before));
    if (ok != true || !context.mounted) return;
    final n = ref.read(sequenceConfigProvider.notifier);
    n.set(after);
    _undoBar(context, () => n.set(before));
    context.push('/timers?tab=2');
  }

  String _onOff(bool v) => v ? l10n.on : l10n.off;

  Future<bool?> _confirm(
    BuildContext context,
    String title,
    List<(String, String, String)> changes,
    bool already,
  ) => showModalBottomSheet<bool>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (ctx) {
      final text = Theme.of(ctx).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.headlineSmall),
              const SizedBox(height: 16),
              if (already || changes.isEmpty)
                Text(l10n.qsAlreadyOn, style: text.bodyMedium)
              else ...[
                Text(l10n.qsWillChange, style: text.labelSmall),
                const SizedBox(height: 4),
                for (final c in changes)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${c.$1}: ${c.$2} → ${c.$3}'),
                  ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: already || changes.isEmpty ? null : () => Navigator.pop(ctx, true),
                    child: Text(l10n.qsApply),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  void _undoBar(BuildContext context, VoidCallback undo) {
    final m = ScaffoldMessenger.of(context);
    m.hideCurrentSnackBar();
    m.showSnackBar(
      SnackBar(
        content: Text(l10n.qsDone),
        duration: const Duration(seconds: 8),
        action: SnackBarAction(label: l10n.qsUndo, onPressed: undo),
      ),
    );
  }
}
