import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import 'sound_player.dart';

/// A row showing the chosen sound; tap to pick another.
///
/// [value] null means "use the default" when [allowDefault] is on, or the
/// phone's alarm sound when it is off (the default itself).
class SoundPickerTile extends ConsumerWidget {
  const SoundPickerTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.allowDefault = true,
    this.large = false,
  });

  /// A big card for the top of an alarm editor.
  final bool large;

  final String? value;
  final ValueChanged<String?> onChanged;
  final bool allowDefault;

  static const phone = '__phone__';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sounds = ref.watch(soundsProvider);
    final defaultId = ref.watch(alarmOptionsProvider).soundId;
    final label = value == null
        ? (allowDefault ? 'Default (${soundName(sounds, defaultId)})' : 'Phone alarm sound')
        : value == phone
        ? 'Phone alarm sound'
        : soundName(sounds, value);

    final chosen = sounds.where((s) => s.id == (value ?? (allowDefault ? defaultId : null))).firstOrNull;
    final kind = chosen == null
        ? 'Phone alarm sound'
        : chosen.isRadio
        ? 'Online radio'
        : chosen.isLink
        ? 'Song link · opens ${chosen.linkApp}'
        : chosen.builtIn
        ? 'Built in'
        : 'Your recording';
    Future<void> pick() async {
      final picked = await showModalBottomSheet<String>(
        context: context,
        showDragHandle: true,
        builder: (context) => _Sheet(value: value, allowDefault: allowDefault),
      );
      await SoundPreview.instance.stop();
      if (picked == null) return;
      if (picked == '__manage__') {
        if (context.mounted) context.push('/sounds');
        return;
      }
      onChanged(picked == '__default__' ? null : (picked == phone && !allowDefault ? null : picked));
    }

    if (large) {
      final text = Theme.of(context).textTheme;
      return Material(
        color: QuandoColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: pick,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sound', style: text.titleLarge),
                      const SizedBox(height: 8),
                      Text(kind, style: text.bodyMedium?.copyWith(color: QuandoColors.amber)),
                      Text(
                        label,
                        style: text.bodyLarge?.copyWith(
                          color: QuandoColors.amber,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(color: QuandoColors.raised, shape: BoxShape.circle),
                  child: Icon(
                    chosen?.isRadio ?? false ? Icons.radio : Icons.music_note,
                    color: QuandoColors.coral,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.music_note_outlined, color: QuandoColors.amber),
      title: const Text('Sound'),
      subtitle: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: pick,
    );
  }
}

class _Sheet extends ConsumerStatefulWidget {
  const _Sheet({required this.value, required this.allowDefault});

  final String? value;
  final bool allowDefault;

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  @override
  Widget build(BuildContext context) {
    final sounds = ref.watch(soundsProvider);
    final current = widget.value ?? (widget.allowDefault ? '__default__' : SoundPickerTile.phone);
    Widget option(String id, String name, {VoidCallback? onListen, bool playing = false}) => ListTile(
      leading: Icon(
        current == id ? Icons.radio_button_checked : Icons.radio_button_off,
        color: QuandoColors.amber,
      ),
      title: Text(name),
      trailing: onListen == null
          ? null
          : IconButton(
              tooltip: 'Listen',
              icon: Icon(playing ? Icons.stop_circle_outlined : Icons.play_circle_outline),
              onPressed: onListen,
            ),
      onTap: () => Navigator.pop(context, id),
    );

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          // The hero: wake up to something of your own.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Material(
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: Ink(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [QuandoColors.amber, QuandoColors.coral],
                  ),
                ),
                child: InkWell(
                  onTap: () => Navigator.pop(context, '__manage__'),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wake up to your own sound',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: QuandoColors.ground),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Your voice, a song, Spotify or live radio',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: QuandoColors.ground),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  for (final i in const [
                                    Icons.mic,
                                    Icons.music_note,
                                    Icons.library_music,
                                    Icons.radio,
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: QuandoColors.ground,
                                        child: Icon(i, size: 18, color: QuandoColors.amber),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: QuandoColors.ground, size: 28),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.allowDefault)
            option('__default__', 'Default (${soundName(sounds, ref.watch(alarmOptionsProvider).soundId)})'),
          option(SoundPickerTile.phone, 'Phone alarm sound'),
          for (final s in sounds)
            option(
              s.id,
              s.name,
              playing: SoundPreview.instance.playingId == s.id,
              onListen: () async {
                final p = SoundPreview.instance;
                if (p.playingId == s.id) {
                  await p.stop();
                } else {
                  await p.play(s, onDone: () => mounted ? setState(() {}) : null);
                }
                if (mounted) setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
