import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../../sounds/ui/sound_picker.dart';
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
  });
  final String title;
  final ReminderDelivery value;
  final ValueChanged<ReminderDelivery> onChanged;
  final String? ruleSound;
  final bool initiallyExpanded;
  final bool showSoundPicker;

  @override
  ConsumerState<DeliveryTile> createState() => _DeliveryTileState();
}

class _DeliveryTileState extends ConsumerState<DeliveryTile> {
  Map<String, String> _sounds = const {};
  List<String> _devices = const [];
  bool _loading = false;
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

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
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
      if (value.pushoverSound != null)
        value.pushoverSound!: _sounds[value.pushoverSound] ?? value.pushoverSound!,
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
          leading: widget.showSoundPicker
              ? null
              : const Icon(Icons.notifications_active_outlined, color: Color(0xFF64B5F6)),
          title: Text(widget.title),
          subtitle: Text(labels[mode]!),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
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
                            value.copyWith(
                              localAudio: entry.key != 'push',
                              pushoverEnabled: entry.key != 'local',
                            ),
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
                onChanged: (id) => widget.onChanged(
                  value.copyWith(soundId: id, clearSound: id == null, useDefaultSound: id == null),
                ),
              ),
            if (mode != 'local') ...[
              Text(
                value.localAudio ? l10n.deliveryBothHint : l10n.deliveryPushHint,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (!value.localAudio)
                Text(l10n.deliveryFallback, style: Theme.of(context).textTheme.bodySmall),
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
                    onSelected: (_) => widget.onChanged(
                      ReminderDelivery(
                        soundId: value.soundId,
                        useDefaultSound: value.useDefaultSound,
                        localAudio: value.localAudio,
                        pushoverEnabled: value.pushoverEnabled,
                        pushoverSound: value.pushoverSound,
                      ),
                    ),
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
