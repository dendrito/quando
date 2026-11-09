import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quando/l10n/l10n.dart';

import '../../../core/util/format.dart';
import '../data/timer_providers.dart';
import 'timers_screen.dart';

/// Where you choose what "Get set" says and when.
Future<void> showSequenceSettings(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: .92,
    maxChildSize: .96,
    builder: (context, scroll) => _Settings(scroll: scroll),
  ),
);

class _Settings extends ConsumerWidget {
  const _Settings({required this.scroll});
  final ScrollController scroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(sequenceConfigProvider);
    final set = ref.read(sequenceConfigProvider.notifier).set;
    final text = Theme.of(context).textTheme;

    Widget title(String s, {String? help}) => Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s, style: text.titleMedium),
          if (help != null) Text(help, style: text.bodySmall),
        ],
      ),
    );

    Widget chips<T>({
      required List<T> values,
      required T selected,
      required String Function(T) label,
      required void Function(T) onPick,
    }) => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final v in values)
          ChoiceChip(label: Text(label(v)), selected: v == selected, onSelected: (_) => onPick(v)),
      ],
    );

    String secs(int s) => s == 0
        ? l10n.seqOff
        : s % 60 == 0
        ? l10n.seqEveryMinutes(s ~/ 60)
        : l10n.seqEverySeconds(s);

    return ListView(
      controller: scroll,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      children: [
        Text(l10n.seqSettings, style: text.headlineSmall),

        // ---- Calls before the start ----
        title(l10n.seqStartCalls, help: l10n.seqStartCallsHelp),
        for (var i = 0; i < c.calls.length; i++)
          Padding(
            key: ValueKey('call$i-${c.calls.length}'),
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    initialValue: c.calls[i].text,
                    decoration: InputDecoration(labelText: l10n.seqCallText),
                    onChanged: (v) => set(
                      c.copyWith(
                        calls: [
                          for (var j = 0; j < c.calls.length; j++)
                            j == i ? (secondsBefore: c.calls[j].secondsBefore, text: v) : c.calls[j],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: c.calls[i].secondsBefore,
                  items: [
                    for (final s in {1, 2, 3, 4, 5, 6, 8, 10, 15, 20, 30, c.calls[i].secondsBefore}.toList()..sort())
                      DropdownMenuItem(value: s, child: Text(l10n.seqCallBefore(s))),
                  ],
                  onChanged: (v) => v == null
                      ? null
                      : set(
                          c.copyWith(
                            calls: [
                              for (var j = 0; j < c.calls.length; j++)
                                j == i ? (secondsBefore: v, text: c.calls[j].text) : c.calls[j],
                            ],
                          ),
                        ),
                ),
                IconButton(
                  tooltip: l10n.delete,
                  icon: const Icon(Icons.close),
                  onPressed: () => set(c.copyWith(calls: [...c.calls]..removeAt(i))),
                ),
              ],
            ),
          ),
        TextButton.icon(
          onPressed: () => set(
            c.copyWith(
              calls: [
                ...c.calls,
                (
                  secondsBefore: c.calls.isEmpty
                      ? 3
                      : (c.calls.last.secondsBefore > 1 ? c.calls.last.secondsBefore - 1 : 1),
                  text: '',
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.add),
          label: Text(l10n.seqAddCall),
        ),
        TextFormField(
          key: const ValueKey('go'),
          initialValue: c.goText,
          decoration: InputDecoration(labelText: l10n.seqGoText),
          onChanged: (v) => set(c.copyWith(goText: v)),
        ),

        // ---- Length ----
        title(l10n.seqLength),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in const [0, 10, 15, 30, 60, 120, 300])
              ChoiceChip(
                label: Text(s == 0 ? l10n.seqNoLimit : formatSpan(Duration(seconds: s))),
                selected: c.lengthSeconds == s,
                onSelected: (_) => set(c.copyWith(lengthSeconds: s)),
              ),
            ActionChip(
              avatar: const Icon(Icons.edit_outlined, size: 18),
              label: Text(l10n.timerSetTime),
              onPressed: () async {
                final picked = await pickDuration(context, c.lengthSeconds);
                if (picked != null) set(c.copyWith(lengthSeconds: picked));
              },
            ),
          ],
        ),
        if (c.lengthSeconds > 0)
          TextFormField(
            key: const ValueKey('finish'),
            initialValue: c.finishText,
            decoration: InputDecoration(labelText: l10n.seqFinishText),
            onChanged: (v) => set(c.copyWith(finishText: v)),
          ),

        // ---- The time, said out loud ----
        title(l10n.seqSayEvery),
        chips<int>(
          values: const [0, 1, 5, 10, 15, 30, 60],
          selected: c.sayEvery,
          label: secs,
          onPick: (v) => set(c.copyWith(sayEvery: v)),
        ),
        if (c.lengthSeconds > 0) ...[
          title(l10n.seqFinalCount),
          chips<int>(
            values: const [0, 3, 5, 10],
            selected: c.finalCount,
            label: (v) => v == 0 ? l10n.seqOff : l10n.spanSeconds(v),
            onPick: (v) => set(c.copyWith(finalCount: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.seqSayRemaining),
            value: c.sayRemaining,
            onChanged: (v) => set(c.copyWith(sayRemaining: v)),
          ),
        ],

        // ---- Your own marks ----
        title(l10n.seqMarks),
        for (var i = 0; i < c.marks.length; i++)
          Padding(
            key: ValueKey('mark$i-${c.marks.length}'),
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                ActionChip(
                  label: Text(l10n.seqMarkAt(clockText(c.marks[i].atSeconds))),
                  onPressed: () async {
                    final picked = await pickDuration(context, c.marks[i].atSeconds);
                    if (picked == null) return;
                    set(
                      c.copyWith(
                        marks: [
                          for (var j = 0; j < c.marks.length; j++)
                            j == i ? (atSeconds: picked, text: c.marks[j].text) : c.marks[j],
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: c.marks[i].text,
                    decoration: InputDecoration(labelText: l10n.seqCallText),
                    onChanged: (v) => set(
                      c.copyWith(
                        marks: [
                          for (var j = 0; j < c.marks.length; j++)
                            j == i ? (atSeconds: c.marks[j].atSeconds, text: v) : c.marks[j],
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.delete,
                  icon: const Icon(Icons.close),
                  onPressed: () => set(c.copyWith(marks: [...c.marks]..removeAt(i))),
                ),
              ],
            ),
          ),
        TextButton.icon(
          onPressed: () => set(
            c.copyWith(marks: [...c.marks, (atSeconds: c.lengthSeconds > 0 ? c.lengthSeconds ~/ 2 : 30, text: '')]),
          ),
          icon: const Icon(Icons.add),
          label: Text(l10n.seqAddMark),
        ),

        // ---- How ----
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.seqSpeak),
          value: c.speak,
          onChanged: (v) => set(c.copyWith(speak: v)),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.seqBeeps),
          value: c.beeps,
          onChanged: (v) => set(c.copyWith(beeps: v)),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: () => Navigator.pop(context), child: Text(l10n.done)),
      ],
    );
  }
}
