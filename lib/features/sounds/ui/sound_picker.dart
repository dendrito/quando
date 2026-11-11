import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import 'sound_player.dart';
import 'music_preview_dialog.dart';
import 'service_logo.dart';

import 'package:quando/l10n/l10n.dart';

/// Which kind of sound a list shows, when it shows only one.
enum SoundKind { quando, song, recording }

/// The sound list as a bottom sheet. Returns the id picked, `__default__`,
/// [SoundPickerTile.phone] or `__manage__` (open the sounds screen).
Future<String?> showSoundSheet(
  BuildContext context, {
  required String? value,
  bool allowDefault = true,
  SoundKind? kind,
}) async {
  final picked = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: kind != null,
    builder: (context) => _Sheet(value: value, allowDefault: allowDefault, kind: kind),
  );
  await SoundPreview.instance.stop();
  return picked;
}

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
        ? (allowDefault ? l10n.defaultNamed(soundName(sounds, defaultId)) : l10n.phoneAlarmSound)
        : value == phone
        ? l10n.phoneAlarmSound
        : soundName(sounds, value);

    final chosen = sounds.where((s) => s.id == (value ?? (allowDefault ? defaultId : null))).firstOrNull;
    final kind = chosen == null
        ? l10n.phoneAlarmSound
        : chosen.isRadio
        ? l10n.onlineRadio
        : chosen.isLink
        ? (chosen.plays ? l10n.playsIn(chosen.linkApp ?? '') : l10n.songLinkOpens(chosen.linkApp ?? ''))
        : chosen.builtIn
        ? l10n.builtIn
        : l10n.yourRecording;
    Future<void> pick() async {
      final picked = await showSoundSheet(context, value: value, allowDefault: allowDefault);
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
                      Text(l10n.sound, style: text.titleLarge),
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
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 14,
                        runSpacing: 10,
                        children: [
                          for (final (Widget icon, name) in [
                            (const ServiceLogo(MusicService.spotify, size: 20), 'Spotify'),
                            (const ServiceLogo(MusicService.youTube, size: 20), 'YouTube'),
                            (const ServiceLogo(MusicService.youTubeMusic, size: 20), 'YouTube Music'),
                            (
                              const Icon(Icons.audio_file_outlined, size: 20, color: QuandoColors.amber),
                              l10n.addAFile,
                            ),
                            (
                              const Icon(Icons.radio_outlined, size: 20, color: QuandoColors.coral),
                              l10n.onlineRadio,
                            ),
                          ])
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                icon,
                                const SizedBox(width: 5),
                                Text(name, style: text.labelMedium),
                              ],
                            ),
                        ],
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
      title: Text(l10n.sound),
      subtitle: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: pick,
    );
  }
}

class _Sheet extends ConsumerStatefulWidget {
  const _Sheet({required this.value, required this.allowDefault, this.kind});

  final String? value;
  final bool allowDefault;
  final SoundKind? kind;

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  void _previewChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SoundPreview.instance.addListener(_previewChanged);
  }

  @override
  void dispose() {
    SoundPreview.instance.removeListener(_previewChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kind = widget.kind;
    final sounds = [
      for (final s in ref.watch(soundsProvider))
        if (switch (kind) {
          null => true,
          SoundKind.quando => s.builtIn,
          SoundKind.song => s.isLink || s.isRadio,
          SoundKind.recording => !s.builtIn && !s.isLink && !s.isRadio,
        })
          s,
    ];
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
              tooltip: l10n.listen,
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
                                l10n.wakeToOwnSound,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: QuandoColors.ground),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.wakeToOwnSoundHint,
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
          if (kind == null && widget.allowDefault)
            option(
              '__default__',
              l10n.defaultNamed(soundName(sounds, ref.watch(alarmOptionsProvider).soundId)),
            ),
          if (kind == null) option(SoundPickerTile.phone, l10n.phoneAlarmSound),
          for (final s in sounds)
            option(
              s.id,
              s.name,
              playing: SoundPreview.instance.playingId == s.id,
              onListen: () async {
                final p = SoundPreview.instance;
                if (s.isLink) {
                  await p.stop();
                  if (!context.mounted) return;
                  await showDialog<void>(
                    context: context,
                    builder: (_) => MusicPreviewDialog(sound: s),
                  );
                  return;
                }
                if (p.playingId == s.id) {
                  await p.stop();
                } else {
                  await p.play(
                    s,
                    onResolved: (url) => ref.read(soundsProvider.notifier).replace(s.copyWith(path: url)),
                    onDone: () => mounted ? setState(() {}) : null,
                    onError: (_) {
                      if (mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(l10n.musicPreviewFailed)));
                      }
                    },
                  );
                }
                if (mounted) setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
