import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../alarms/ui/ring_length_picker.dart';
import '../../integrations/ui/pushover_icon.dart';
import '../../integrations/ui/smart_home_tile.dart';
import '../domain/reminder_delivery.dart';

/// Inline controls at the reminder time, shared with the everyday alarm editor.
class DeliveryTile extends ConsumerStatefulWidget {
  const DeliveryTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.ruleSound,
    this.initiallyExpanded = false,
    this.showSoundPicker = true,
    this.defaultRingSeconds,
  });
  final String title;
  final ReminderDelivery value;
  final ValueChanged<ReminderDelivery> onChanged;
  final String? ruleSound;
  final bool initiallyExpanded;
  final bool showSoundPicker;
  final int? defaultRingSeconds;

  @override
  ConsumerState<DeliveryTile> createState() => _DeliveryTileState();
}

class _DeliveryTileState extends ConsumerState<DeliveryTile> {
  Map<String, String> _sounds = const {};
  List<String> _devices = const [];
  bool _loading = false;
  bool _testing = false;
  String? _error;

  Future<void> _load() async {
    final settings = ref.read(integrationsProvider);
    final sender = ref.read(integrationSenderProvider);
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final sounds = await sender.pushoverSounds(settings.pushoverToken);
      final devices = await sender.pushoverDevices(settings.pushoverToken, settings.pushoverUser);
      if (mounted) {
        setState(() {
          _sounds = sounds;
          _devices = devices;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _error = l10n.deliveryLoadFailed);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _testSound() async {
    setState(() => _testing = true);
    final error = await ref
        .read(integrationSenderProvider)
        .testPushover(ref.read(integrationsProvider), delivery: widget.value);
    if (!mounted) return;
    setState(() => _testing = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ?? l10n.sentCheckDevices)));
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final ringSeconds = value.ringSeconds ?? widget.defaultRingSeconds ?? ref.watch(alarmOptionsProvider).ringSeconds;
    final settings = ref.watch(integrationsProvider);
    final push = value.pushoverEnabled ?? settings.pushoverReady;
    final mode = !value.localAudio
        ? 'push'
        : push
        ? 'both'
        : 'local';
    final labels = {'local': l10n.deliveryLocal, 'push': 'Pushover', 'both': l10n.deliveryBoth};
    final soundEntries = {
      ..._sounds,
      if (value.pushoverSound != null) value.pushoverSound!: _sounds[value.pushoverSound] ?? value.pushoverSound!,
    };
    final deviceNames = {..._devices, ...?value.pushoverDevices};
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          initiallyExpanded: widget.initiallyExpanded,
          leading: widget.showSoundPicker ? null : const PushoverIcon(),
          title: Text(widget.title),
          subtitle: Text(labels[mode]!),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            if (widget.showSoundPicker) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(value.enabled ? l10n.on : l10n.off),
                value: value.enabled,
                onChanged: (on) => widget.onChanged(value.copyWith(enabled: on)),
              ),
              Text(l10n.ringsForHeading('$ringSeconds s')),
              RingLengthPicker(
                seconds: ringSeconds,
                onChanged: (seconds) => widget.onChanged(value.copyWith(ringSeconds: seconds)),
              ),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final entry in labels.entries)
                  ChoiceChip(
                    key: ValueKey('delivery-${entry.key}'),
                    label: Text(entry.value),
                    selected: mode == entry.key,
                    onSelected: entry.key != 'local' && !settings.pushoverReady
                        ? null
                        : (_) => widget.onChanged(
                            value.copyWith(localAudio: entry.key != 'push', pushoverEnabled: entry.key != 'local'),
                          ),
                  ),
              ],
            ),
            if (!settings.pushoverReady)
              TextButton.icon(
                onPressed: () => context.push('/connections'),
                icon: const Icon(Icons.link),
                label: Text(l10n.deliveryConnect),
              ),
            if (value.localAudio && widget.showSoundPicker)
              SoundPickerTile(
                value: value.resolveSound(widget.ruleSound),
                onChanged: (id) =>
                    widget.onChanged(value.copyWith(soundId: id, clearSound: id == null, useDefaultSound: id == null)),
              ),
            if (mode != 'local') ...[
              Text(
                value.localAudio ? l10n.deliveryBothHint : l10n.deliveryPushHint,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (!value.localAudio) Text(l10n.deliveryFallback, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: ValueKey('push-sound-${value.pushoverSound}'),
                initialValue: value.pushoverSound ?? '__inherit__',
                isExpanded: true,
                decoration: InputDecoration(labelText: l10n.soundItPlays),
                items: [
                  DropdownMenuItem(value: '__inherit__', child: Text(l10n.defaultLabel)),
                  for (final e in soundEntries.entries)
                    DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: (id) => widget.onChanged(
                  value.copyWith(
                    pushoverSound: id == '__inherit__' ? null : id,
                    clearPushoverSound: id == '__inherit__',
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: settings.pushoverReady && !_testing ? _testSound : null,
                icon: const PushoverIcon(size: 22),
                label: Text(_testing ? l10n.sending : l10n.testPushoverSound),
              ),
              Text(l10n.pushoverSoundTestHint, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: settings.pushoverReady && !_loading ? _load : null,
                  icon: const Icon(Icons.refresh),
                  label: Text(_loading ? l10n.loading : l10n.loadFromPushover),
                ),
              ),
              if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ChoiceChip(
                    label: Text(l10n.defaultLabel),
                    selected: value.pushoverDevices == null,
                    onSelected: (_) => widget.onChanged(value.copyWith(inheritPushoverDevices: true)),
                  ),
                  ChoiceChip(
                    label: Text(l10n.allMyDevices),
                    selected: value.pushoverDevices?.isEmpty ?? false,
                    onSelected: (_) => widget.onChanged(value.copyWith(pushoverDevices: {})),
                  ),
                  for (final device in deviceNames)
                    FilterChip(
                      label: Text(device),
                      selected: value.pushoverDevices?.contains(device) ?? false,
                      onSelected: (on) {
                        final devices = {...?value.pushoverDevices};
                        on ? devices.add(device) : devices.remove(device);
                        widget.onChanged(value.copyWith(pushoverDevices: devices));
                      },
                    ),
                ],
              ),
            ],
            if (widget.showSoundPicker) SmartHomeTile(value: value, onChanged: widget.onChanged),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => widget.onChanged(ReminderDelivery.inherit),
                child: Text(l10n.deliveryReset),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
