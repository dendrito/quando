import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../sounds/ui/sound_picker.dart';
import 'delivery_tile.dart';
import '../../alarms/ui/ring_length_picker.dart';
import '../../ringing/ui/alarm_extras.dart';

import 'package:quando/l10n/l10n.dart';

/// Change a ready-made rule: when it rings around its event, and with which
/// sound. Changes apply straight away.
class PresetScreen extends ConsumerWidget {
  const PresetScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rule = ref.watch(rulesProvider).where((r) => r.id == id).firstOrNull;
    final text = Theme.of(context).textTheme;
    if (rule == null) return Scaffold(body: Center(child: Text(l10n.presetGone)));
    final notifier = ref.read(rulesProvider.notifier);
    final offsets = rule.offsets();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.editPreset)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          Text(rule.name, style: text.headlineMedium),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(rule.enabled ? l10n.on : l10n.off, style: text.titleMedium),
            value: rule.enabled,
            onChanged: (v) => notifier.toggle(id, v),
          ),
          const SizedBox(height: 12),
          Text(l10n.ringsHeading, style: text.labelSmall),
          const SizedBox(height: 10),
          if (offsets.isEmpty) Text(l10n.noTimesYet, style: text.bodySmall),
          for (final d in offsets)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DeliveryTile(
                        key: ValueKey(d.inMinutes),
                        title: d == Duration.zero ? l10n.atTheMomentItself : describeOffset(d),
                        value: rule.deliveryAt(d),
                        ruleSound: rule.soundId,
                        defaultRingSeconds: rule.useRingDuration ? rule.ringDuration.inSeconds : null,
                        onChanged: (choice) =>
                            notifier.edit(id, (r) => r.copyWith(deliveries: {...r.deliveries, d.inMinutes: choice})),
                      ),
                    ),
                    Switch(
                      value: rule.deliveryAt(d).enabled,
                      onChanged: (v) => notifier.edit(
                        id,
                        (r) => r.copyWith(
                          deliveries: {
                            ...r.deliveries,
                            d.inMinutes: r.deliveryAt(d).copyWith(enabled: v),
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton.icon(
                    icon: const Icon(Icons.close, size: 16),
                    label: Text(l10n.remove),
                    onPressed: () => notifier.edit(id, (r) => r.withOffsets(r.offsets().where((o) => o != d))),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.addATime),
              onPressed: () async {
                final d = await _askOffset(context);
                if (d != null) notifier.edit(id, (r) => r.withOffsets([...r.offsets(), d]));
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.defaultLabel, style: text.labelSmall),
          SoundPickerTile(
            large: true,
            value: rule.soundId,
            onChanged: (s) =>
                notifier.edit(id, (r) => s == null ? r.copyWith(defaultSound: true) : r.copyWith(soundId: s)),
          ),
          Text(
            l10n.ringsForHeading(
              formatSpan(
                rule.useRingDuration
                    ? rule.ringDuration
                    : Duration(seconds: ref.watch(alarmOptionsProvider).ringSeconds),
              ),
            ),
          ),
          RingLengthPicker(
            seconds: rule.useRingDuration ? rule.ringDuration.inSeconds : ref.watch(alarmOptionsProvider).ringSeconds,
            onChanged: (seconds) => notifier.edit(id, (r) => r.copyWith(ringDuration: Duration(seconds: seconds))),
          ),
          AlarmExtras(
            value: rule.style,
            onChanged: (s) => notifier.edit(id, (r) => r.copyWith(style: s)),
          ),
          const SizedBox(height: 24),
          if (notifier.isCustom(id))
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.restart_alt),
                label: Text(l10n.resetPreset),
                onPressed: () => notifier.reset(id),
              ),
            ),
          const SizedBox(height: 8),
          Text(l10n.skipOneHint, style: text.bodySmall),
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
        title: Text(l10n.addATime),
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
                    items: [
                      DropdownMenuItem(value: 1, child: Text(l10n.unitMinutes)),
                      DropdownMenuItem(value: 60, child: Text(l10n.unitHours)),
                      DropdownMenuItem(value: 1440, child: Text(l10n.unitDays)),
                    ],
                    onChanged: (v) => setState(() => unit = v ?? 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: true, label: Text(l10n.before)),
                ButtonSegment(value: false, label: Text(l10n.after)),
              ],
              selected: {before},
              onSelectionChanged: (s) => setState(() => before = s.first),
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: () => Navigator.pop(context, Duration.zero), child: Text(l10n.atTheMomentItself)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              final n = int.tryParse(amount.text) ?? 0;
              if (n <= 0) return Navigator.pop(context);
              final d = Duration(minutes: n * unit);
              Navigator.pop(context, before ? -d : d);
            },
            child: Text(l10n.add, style: const TextStyle(color: QuandoColors.amber)),
          ),
        ],
      ),
    ),
  ).whenComplete(amount.dispose);
}
