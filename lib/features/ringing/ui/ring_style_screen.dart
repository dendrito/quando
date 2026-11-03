import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../sounds/domain/loudness.dart';
import '../ring_style.dart';

/// A row under the sound picker: "Volume, fades & stopping", with a summary.
/// Tap to change them for this one alarm.
class RingStyleTile extends ConsumerWidget {
  const RingStyleTile({super.key, required this.value, required this.onChanged});

  final RingStyle value;
  final ValueChanged<RingStyle> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o = ref.watch(alarmOptionsProvider);
    final s = value;
    final parts = [
      (s.loudness ?? o.loudness).summary,
      if (s.gentleMinutes > 0) 'gentle ${s.gentleMinutes} min before',
      if ((s.task ?? (o.mathTask ? StopTask.sum : StopTask.none)) != StopTask.none)
        (s.task ?? StopTask.sum).label.toLowerCase(),
      for (final w in StopWay.values)
        if (s.stopBy.contains(w))
          '${w.label.toLowerCase()} stop'
        else if (s.snoozeBy.contains(w))
          '${w.label.toLowerCase()} snooze',
      if (s.openAfter != null && s.openAfter!.isNotEmpty) 'opens a link after',
    ];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.tune, color: QuandoColors.amber),
      title: const Text('Volume, fades & stopping'),
      subtitle: Text(parts.join(' · ')),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final changed = await Navigator.of(context)
            .push<RingStyle>(MaterialPageRoute(builder: (_) => RingStyleScreen(initial: value)));
        if (changed != null) onChanged(changed);
      },
    );
  }
}

/// Everything about how one alarm rings and stops. Back saves.
class RingStyleScreen extends ConsumerStatefulWidget {
  const RingStyleScreen({super.key, required this.initial});

  final RingStyle initial;

  @override
  ConsumerState<RingStyleScreen> createState() => _RingStyleScreenState();
}

enum _Does { nothing, snooze, stop }

class _RingStyleScreenState extends ConsumerState<RingStyleScreen> {
  late RingStyle _s = widget.initial;
  late final _link = TextEditingController(text: widget.initial.openAfter ?? '');

  @override
  void dispose() {
    _link.dispose();
    super.dispose();
  }

  RingStyle get _result {
    final l = _link.text.trim();
    return l.isEmpty ? _s.copyWith(noOpenAfter: true) : _s.copyWith(openAfter: l);
  }

  _Does _does(StopWay w) => _s.stopBy.contains(w)
      ? _Does.stop
      : _s.snoozeBy.contains(w)
      ? _Does.snooze
      : _Does.nothing;

  void _setDoes(StopWay w, _Does d) => setState(
    () => _s = _s.copyWith(
      snoozeBy: {..._s.snoozeBy.where((x) => x != w), if (d == _Does.snooze) w},
      stopBy: {..._s.stopBy.where((x) => x != w), if (d == _Does.stop) w},
    ),
  );

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final o = ref.watch(alarmOptionsProvider);
    final defaultTask = o.mathTask ? StopTask.sum : StopTask.none;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_result);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Volume, fades & stopping')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          children: [
            Text('VOLUME', style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Same as other alarms'),
              subtitle: Text(o.loudness.summary),
              value: _s.loudness == null,
              onChanged: (v) => setState(
                () => _s = v ? _s.copyWith(defaultLoudness: true) : _s.copyWith(loudness: o.loudness),
              ),
            ),
            if (_s.loudness != null)
              LoudnessEditor(
                value: _s.loudness!,
                onChanged: (l) => setState(() => _s = _s.copyWith(loudness: l)),
              ),
            const SizedBox(height: 20),
            Text('GENTLE WAKE-UP', style: text.labelSmall),
            const SizedBox(height: 4),
            Text(
              'A soft alarm before the real one, quiet and slowly rising, so the real one doesn\'t jolt you.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in const [0, 5, 10, 15, 20, 30])
                  ChoiceChip(
                    label: Text(m == 0 ? 'Off' : '$m min before'),
                    selected: _s.gentleMinutes == m,
                    onSelected: (_) => setState(() => _s = _s.copyWith(gentleMinutes: m)),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text('SNOOZE AND STOP WITH', style: text.labelSmall),
            const SizedBox(height: 4),
            Text('The buttons on screen always work too.', style: text.bodySmall),
            for (final w in StopWay.values) ...[
              const SizedBox(height: 12),
              Text(w.label, style: text.titleMedium),
              const SizedBox(height: 6),
              SegmentedButton<_Does>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: _Does.nothing, label: Text('Nothing')),
                  ButtonSegment(value: _Does.snooze, label: Text('Snooze')),
                  ButtonSegment(value: _Does.stop, label: Text('Stop')),
                ],
                selected: {_does(w)},
                onSelectionChanged: (d) => _setDoes(w, d.first),
              ),
            ],
            const SizedBox(height: 24),
            Text('BEFORE IT STOPS', style: text.labelSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: Text('Like other alarms (${defaultTask.label.toLowerCase()})'),
                  selected: _s.task == null,
                  onSelected: (_) => setState(() => _s = _s.copyWith(defaultTask: true)),
                ),
                for (final t in StopTask.values)
                  ChoiceChip(
                    label: Text(t.label),
                    selected: _s.task == t,
                    onSelected: (_) => setState(() => _s = _s.copyWith(task: t)),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text('WAKE-UP CHECK', style: text.labelSmall),
            const SizedBox(height: 4),
            Text(
              'After you stop it, rings again in 3 minutes unless you tap "I\'m up".',
              style: text.bodySmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<bool?>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: null, label: Text('Default (${o.wakeCheck ? 'on' : 'off'})')),
                const ButtonSegment(value: true, label: Text('On')),
                const ButtonSegment(value: false, label: Text('Off')),
              ],
              selected: {_s.wakeCheck},
              onSelectionChanged: (v) => setState(
                () => _s = v.first == null
                    ? _s.copyWith(defaultWakeCheck: true)
                    : _s.copyWith(wakeCheck: v.first),
              ),
            ),
            const SizedBox(height: 24),
            Text('OPEN AFTER STOPPING', style: text.labelSmall),
            const SizedBox(height: 4),
            Text(
              'A link or app that opens once you\'re up: the news, the weather, a playlist.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _link,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(hintText: 'https://…'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (name, url) in _quickLinks)
                  ActionChip(label: Text(name), onPressed: () => setState(() => _link.text = url)),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'On Shabbat and festivals alarms never ask to be touched: no tasks, no shaking, nothing opens.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              onPressed: () => Navigator.of(context).pop(_result),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

const _quickLinks = [
  ('Weather', 'https://www.google.com/search?q=weather'),
  ('News', 'https://news.google.com'),
  ('Calendar', 'https://calendar.google.com'),
  ('YouTube', 'https://www.youtube.com'),
  ('Spotify', 'spotify:'),
];

/// Volume slider plus fade-in and fade-out lengths.
class LoudnessEditor extends StatelessWidget {
  const LoudnessEditor({super.key, required this.value, required this.onChanged});

  final Loudness value;
  final ValueChanged<Loudness> onChanged;

  static const _fades = [0, 5, 10, 20, 30, 45, 60, 90, 120, 180, 300];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final v = value;
    int fadeIndex(int s) {
      final i = _fades.indexWhere((f) => f >= s);
      return i < 0 ? _fades.length - 1 : i;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Use the phone\'s alarm volume'),
          value: v.volume == null,
          onChanged: (on) => onChanged(on ? v.copyWith(phoneVolume: true) : v.copyWith(volume: 80)),
        ),
        if (v.volume != null) ...[
          Row(
            children: [
              const Icon(Icons.volume_down, color: QuandoColors.muted),
              Expanded(
                child: Slider(
                  min: 5,
                  max: 100,
                  divisions: 19,
                  value: v.volume!.clamp(5, 100).toDouble(),
                  label: '${v.volume}%',
                  onChanged: (x) => onChanged(v.copyWith(volume: x.round())),
                ),
              ),
              SizedBox(width: 52, child: Text('${v.volume}%', style: text.titleMedium)),
            ],
          ),
          Text('Sets the phone\'s alarm volume while it rings, then puts it back.', style: text.bodySmall),
        ],
        const SizedBox(height: 12),
        Text(
          v.fadeInSeconds == 0
              ? 'Fade in: off, full volume at once'
              : 'Fade in over ${Loudness.seconds(v.fadeInSeconds)}',
          style: text.titleMedium,
        ),
        Slider(
          max: (_fades.length - 1).toDouble(),
          divisions: _fades.length - 1,
          value: fadeIndex(v.fadeInSeconds).toDouble(),
          label: Loudness.seconds(v.fadeInSeconds),
          onChanged: (x) => onChanged(v.copyWith(fadeInSeconds: _fades[x.round()])),
        ),
        Text(
          v.fadeOutSeconds == 0
              ? 'Fade out: off'
              : 'Fade out over the last ${Loudness.seconds(v.fadeOutSeconds)}',
          style: text.titleMedium,
        ),
        Slider(
          max: (_fades.length - 1).toDouble(),
          divisions: _fades.length - 1,
          value: fadeIndex(v.fadeOutSeconds).toDouble(),
          label: Loudness.seconds(v.fadeOutSeconds),
          onChanged: (x) => onChanged(v.copyWith(fadeOutSeconds: _fades[x.round()])),
        ),
        Text(
          'Fading out happens as the alarm stops by itself. If the fades are longer than the alarm rings, '
          'both shrink to fit.',
          style: text.bodySmall,
        ),
      ],
    );
  }
}
