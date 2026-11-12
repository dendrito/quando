import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../sounds/ui/sound_picker.dart';
import 'ring_length_picker.dart';

import 'package:quando/l10n/l10n.dart';

/// "Wake me with": three rows, each opening a small menu. Same in Simple
/// and Everything.
///
/// [soundId] is the alarm's own sound (null = follows the default);
/// [ringSeconds] and [gentleMinutes] are what it uses now.
class WakeMeWith extends ConsumerWidget {
  const WakeMeWith({
    super.key,
    required this.soundId,
    required this.ringSeconds,
    required this.gentleMinutes,
    required this.onSound,
    required this.onRing,
    required this.onGentle,
  });

  final String? soundId;
  final int ringSeconds;
  final int gentleMinutes;
  final ValueChanged<String> onSound;
  final ValueChanged<int> onRing;
  final ValueChanged<int> onGentle;

  static const ringChoices = [30, 60, 180, 300, 600];
  static const gentleChoices = [0, 5, 10, 20];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sounds = ref.watch(soundsProvider);
    final options = ref.watch(alarmOptionsProvider);
    final effective = soundId ?? options.soundId;
    final soundLine = effective == null || effective == SoundPickerTile.phone
        ? l10n.phoneAlarmSound
        : soundName(sounds, effective);
    final text = Theme.of(context).textTheme;

    Widget row(Key key, IconData icon, String title, String value, VoidCallback onTap) => ListTile(
      key: key,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: QuandoColors.amber),
      title: Text(title),
      subtitle: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.wakeMeWith.toUpperCase(), style: text.labelSmall),
        const SizedBox(height: 4),
        row(
          const Key('wakeSound'),
          Icons.music_note_outlined,
          l10n.ringOrMusic,
          soundLine,
          () => _sound(context, ref, effective),
        ),
        row(
          const Key('wakeRing'),
          Icons.timer_outlined,
          l10n.ringsForRow,
          RingLengthPicker.short(ringSeconds),
          () => _ring(context, ref),
        ),
        row(
          const Key('wakeGentle'),
          Icons.wb_twilight,
          l10n.gentleWakeUp,
          gentleMinutes > 0 ? l10n.gentleBeforeValue(gentleMinutes) : l10n.off,
          () => _gentle(context, ref),
        ),
      ],
    );
  }

  /// Ring or music: the phone's alarm, or one of three lists.
  Future<void> _sound(BuildContext context, WidgetRef ref, String? current) async {
    var asDefault = false;
    var chosen = current;
    void choose(String id) {
      chosen = id;
      onSound(id);
      if (asDefault) _defaultSound(ref, id);
    }

    await _menu(
      context,
      title: l10n.ringOrMusic,
      body: (context, setState, close) {
        Widget option(String label, {bool selected = false, VoidCallback? onTap, bool more = false}) =>
            ListTile(
              leading: Icon(
                more
                    ? Icons.library_music_outlined
                    : (selected ? Icons.radio_button_checked : Icons.radio_button_off),
                color: QuandoColors.amber,
              ),
              title: Text(label),
              trailing: more ? const Icon(Icons.chevron_right) : null,
              onTap: onTap,
            );

        Future<void> from(SoundKind kind) async {
          final picked = await showSoundSheet(context, value: chosen, allowDefault: false, kind: kind);
          if (picked == null) return;
          if (picked == '__manage__') {
            if (context.mounted) {
              close();
              context.push('/sounds');
            }
            return;
          }
          choose(picked);
          setState(() {});
        }

        return [
          option(
            l10n.phoneAlarmSound,
            selected: chosen == null || chosen == SoundPickerTile.phone,
            onTap: () {
              choose(SoundPickerTile.phone);
              setState(() {});
            },
          ),
          option(l10n.quandoSounds, more: true, onTap: () => from(SoundKind.quando)),
          option(l10n.aSongApps, more: true, onTap: () => from(SoundKind.song)),
          option(l10n.myRecording, more: true, onTap: () => from(SoundKind.recording)),
        ];
      },
      useForNew: (v) {
        asDefault = v;
        final id = chosen;
        if (v && id != null) _defaultSound(ref, id);
      },
    );
  }

  void _defaultSound(WidgetRef ref, String id) {
    final before = ref.read(alarmOptionsProvider);
    // Alarms that followed the old default keep it; only new ones follow the new.
    ref.read(userAlarmsProvider.notifier).pinDefaults(before, sound: true);
    ref
        .read(alarmOptionsProvider.notifier)
        .update((o) => id == SoundPickerTile.phone ? o.copyWith(phoneSound: true) : o.copyWith(soundId: id));
  }

  Future<void> _ring(BuildContext context, WidgetRef ref) async {
    var asDefault = false;
    var now = ringSeconds;
    await _menu(
      context,
      title: l10n.ringsForRow,
      body: (context, setState, close) => [
        for (final s in {...ringChoices, now}.toList()..sort())
          ListTile(
            leading: Icon(
              now == s ? Icons.radio_button_checked : Icons.radio_button_off,
              color: QuandoColors.amber,
            ),
            title: Text(RingLengthPicker.short(s)),
            onTap: () {
              onRing(s);
              if (asDefault) _defaultRing(ref, s);
              setState(() => now = s);
            },
          ),
      ],
      useForNew: (v) {
        asDefault = v;
        if (v) _defaultRing(ref, now);
      },
    );
  }

  void _defaultRing(WidgetRef ref, int seconds) {
    final before = ref.read(alarmOptionsProvider);
    ref.read(userAlarmsProvider.notifier).pinDefaults(before, ring: true);
    ref.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(ringSeconds: seconds));
  }

  Future<void> _gentle(BuildContext context, WidgetRef ref) async {
    var asDefault = false;
    var now = gentleMinutes;
    await _menu(
      context,
      title: l10n.gentleWakeUp,
      body: (context, setState, close) => [
        for (final m in {...gentleChoices, now}.toList()..sort())
          ListTile(
            leading: Icon(
              now == m ? Icons.radio_button_checked : Icons.radio_button_off,
              color: QuandoColors.amber,
            ),
            title: Text(m == 0 ? l10n.off : l10n.gentleBeforeValue(m)),
            onTap: () {
              onGentle(m);
              if (asDefault) {
                ref.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(gentleMinutes: m));
              }
              setState(() => now = m);
            },
          ),
      ],
      useForNew: (v) {
        asDefault = v;
        if (v) ref.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(gentleMinutes: now));
      },
    );
  }

  /// The small bottom sheet: the choices, "Use for new alarms", Done.
  Future<void> _menu(
    BuildContext context, {
    required String title,
    required List<Widget> Function(BuildContext, StateSetter, VoidCallback) body,
    required ValueChanged<bool> useForNew,
  }) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheet) {
      var useNew = false;
      return StatefulBuilder(
        builder: (sheet, setState) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                  child: Text(title, style: Theme.of(sheet).textTheme.titleLarge),
                ),
                ...body(sheet, setState, () => Navigator.pop(sheet)),
                SwitchListTile(
                  key: const Key('useForNew'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(l10n.useForNewAlarms),
                  value: useNew,
                  onChanged: (v) {
                    setState(() => useNew = v);
                    useForNew(v);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                  child: FilledButton(onPressed: () => Navigator.pop(sheet), child: Text(l10n.done)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
