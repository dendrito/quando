import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../ringing/ui/gentle_screen.dart';
import '../../ringing/ui/ring_style_screen.dart';

/// Change a ready-made rule: when it rings around its event, and with which
/// sound. Changes apply straight away.
class PresetScreen extends ConsumerWidget {
  const PresetScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rule = ref.watch(rulesProvider).where((r) => r.id == id).firstOrNull;
    final text = Theme.of(context).textTheme;
    if (rule == null) return const Scaffold(body: Center(child: Text('This preset no longer exists.')));
    final notifier = ref.read(rulesProvider.notifier);
    final offsets = rule.offsets();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit preset')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          Text(rule.name, style: text.headlineMedium),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(rule.enabled ? 'On' : 'Off', style: text.titleMedium),
            value: rule.enabled,
            onChanged: (v) => notifier.toggle(id, v),
          ),
          const SizedBox(height: 12),
          Text('RINGS', style: text.labelSmall),
          const SizedBox(height: 10),
          if (offsets.isEmpty) Text('No times yet. Add one below.', style: text.bodySmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final d in offsets)
                InputChip(
                  label: Text(d == Duration.zero ? 'At the moment itself' : describeOffset(d)),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  deleteButtonTooltipMessage: 'Remove',
                  onDeleted: () => notifier.edit(id, (r) => r.withOffsets(r.offsets().where((o) => o != d))),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add a time'),
              onPressed: () async {
                final d = await _askOffset(context);
                if (d != null) notifier.edit(id, (r) => r.withOffsets([...r.offsets(), d]));
              },
            ),
          ),
          const SizedBox(height: 24),
          SoundPickerTile(
            value: rule.soundId,
            onChanged: (s) =>
                notifier.edit(id, (r) => s == null ? r.copyWith(defaultSound: true) : r.copyWith(soundId: s)),
          ),
          GentleTile(
            value: rule.style,
            onChanged: (s) => notifier.edit(id, (r) => r.copyWith(style: s)),
          ),
          RingStyleTile(
            value: rule.style,
            onChanged: (s) => notifier.edit(id, (r) => r.copyWith(style: s)),
          ),
          const SizedBox(height: 24),
          if (notifier.isCustom(id))
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset to how it came'),
                onPressed: () => notifier.reset(id),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'To skip just one alarm, tap it in "Alarms this week" on the home screen.',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// "15 minutes before", "2 hours after", "at the moment itself".
Future<Duration?> _askOffset(BuildContext context) {
  final amount = TextEditingController(text: '15');
  var unit = 1; // minutes
  var before = true;
  return showDialog<Duration>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Add a time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: amount,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<int>(
                    value: unit,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('minutes')),
                      DropdownMenuItem(value: 60, child: Text('hours')),
                      DropdownMenuItem(value: 1440, child: Text('days')),
                    ],
                    onChanged: (v) => setState(() => unit = v ?? 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Before')),
                ButtonSegment(value: false, label: Text('After')),
              ],
              selected: {before},
              onSelectionChanged: (s) => setState(() => before = s.first),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context, Duration.zero),
              child: const Text('At the moment itself'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final n = int.tryParse(amount.text) ?? 0;
              if (n <= 0) return Navigator.pop(context);
              final d = Duration(minutes: n * unit);
              Navigator.pop(context, before ? -d : d);
            },
            child: const Text('Add', style: TextStyle(color: QuandoColors.amber)),
          ),
        ],
      ),
    ),
  ).whenComplete(amount.dispose);
}
