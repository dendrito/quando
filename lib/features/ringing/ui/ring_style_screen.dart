import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../settings/domain/alarm_options.dart';
import '../../sounds/domain/loudness.dart';
import '../../sounds/domain/sound.dart';
import '../../sounds/ui/sound_player.dart';
import '../data/apps.dart';
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
      if (s.snooze != null) 'snooze ${s.snooze!.summary.toLowerCase()}',
      if ((s.task ?? (o.mathTask ? StopTask.sum : StopTask.none)) != StopTask.none)
        (s.task ?? StopTask.sum).label.toLowerCase(),
      for (final w in StopWay.values)
        if (s.stopBy.contains(w))
          '${w.label.toLowerCase()} stop'
        else if (s.snoozeBy.contains(w))
          '${w.label.toLowerCase()} snooze',
      if (s.openAfter != null && s.openAfter!.isNotEmpty)
        'then opens ${AppLink.isApp(s.openAfter) ? AppLink.label(s.openAfter!) : 'a link'}',
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
    SoundPreview.instance.stop();
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

  static SnoozePlan _defaultSnooze(AlarmOptions o) =>
      SnoozePlan(minutes: o.snoozeMinutes, times: o.maxSnoozes);

  void _setSnooze(SnoozePlan plan) => setState(() => _s = _s.copyWith(snooze: plan));

  Widget _chipRow(
    String title,
    List<int> values,
    int current,
    String Function(int) label,
    void Function(int) pick,
  ) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: text.titleMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final v in values)
                ChoiceChip(label: Text(label(v)), selected: current == v, onSelected: (_) => pick(v)),
            ],
          ),
        ],
      ),
    );
  }

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
              'Calm sounds that start softly before the alarm and rise slowly, so you surface from light '
              'sleep instead of being jolted awake. They stop just before the real alarm.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in const [0, 5, 10, 15, 20, 30, 45, 60])
                  ChoiceChip(
                    label: Text(m == 0 ? 'Off' : '$m min before'),
                    selected: _s.gentleMinutes == m,
                    onSelected: (_) => setState(() => _s = _s.copyWith(gentleMinutes: m)),
                  ),
              ],
            ),
            if (_s.gentleMinutes > 0) ...[
              const SizedBox(height: 8),
              for (final c in AlarmSound.calm)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    _s.gentleSound == c.id ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: QuandoColors.amber,
                  ),
                  title: Text(c.name),
                  trailing: IconButton(
                    tooltip: 'Listen',
                    icon: Icon(
                      SoundPreview.instance.playingId == c.id
                          ? Icons.stop_circle_outlined
                          : Icons.play_circle_outline,
                    ),
                    onPressed: () async {
                      final p = SoundPreview.instance;
                      if (p.playingId == c.id) {
                        await p.stop();
                      } else {
                        await p.play(c, onDone: () => mounted ? setState(() {}) : null);
                      }
                      if (mounted) setState(() {});
                    },
                  ),
                  onTap: () => setState(() => _s = _s.copyWith(gentleSound: c.id)),
                ),
            ],
            const SizedBox(height: 24),
            Text('SNOOZE', style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Same as other alarms'),
              subtitle: Text(_defaultSnooze(o).summary),
              value: _s.snooze == null,
              onChanged: (v) => setState(
                () => _s = v ? _s.copyWith(defaultSnooze: true) : _s.copyWith(snooze: _defaultSnooze(o)),
              ),
            ),
            if (_s.snooze case final plan?) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Snooze allowed'),
                value: plan.times > 0,
                onChanged: (v) => _setSnooze(plan.copyWith(times: v ? 3 : 0)),
              ),
              if (plan.times > 0) ...[
                _chipRow(
                  'Snooze for',
                  const [1, 3, 5, 10, 15, 20, 30],
                  plan.minutes,
                  (m) => '$m min',
                  (m) => _setSnooze(plan.copyWith(minutes: m)),
                ),
                _chipRow(
                  'Each extra snooze is shorter by',
                  const [0, 1, 2, 3, 5],
                  plan.shortenBy,
                  (m) => m == 0 ? 'Not shorter' : '$m min',
                  (m) => _setSnooze(plan.copyWith(shortenBy: m)),
                ),
                _chipRow(
                  'How many times',
                  const [1, 2, 3, 5, 10, SnoozePlan.unlimited],
                  plan.times,
                  (n) => n == SnoozePlan.unlimited ? 'No limit' : '$n×',
                  (n) => _setSnooze(plan.copyWith(times: n)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Snooze by itself'),
                  subtitle: const Text(
                    'When it has rung for its full time and you haven\'t touched it, it snoozes instead of '
                    'stopping.',
                  ),
                  value: plan.autoSnooze,
                  onChanged: (v) => _setSnooze(plan.copyWith(autoSnooze: v)),
                ),
              ],
            ],
            const SizedBox(height: 12),
            Text('BEFORE IT SNOOZES', style: text.labelSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in StopTask.values)
                  ChoiceChip(
                    label: Text(t.label),
                    selected: (_s.snoozeTask ?? StopTask.none) == t,
                    onSelected: (_) => setState(
                      () => _s = t == StopTask.none
                          ? _s.copyWith(noSnoozeTask: true)
                          : _s.copyWith(snoozeTask: t),
                    ),
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
              'Start your morning in one move: an app or link opens once you\'re up, like the news, the '
              'weather or a playlist.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 8),
            if (AppLink.isApp(_link.text))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.apps, color: QuandoColors.amber),
                title: Text(AppLink.label(_link.text)),
                subtitle: const Text('Opens after the alarm'),
                trailing: IconButton(
                  tooltip: 'Remove',
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _link.clear()),
                ),
              )
            else
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
                ActionChip(
                  avatar: const Icon(Icons.apps, size: 18),
                  label: const Text('Pick an app'),
                  onPressed: () async {
                    final a = await _pickApp(context);
                    if (a != null) setState(() => _link.text = AppLink.of(a));
                  },
                ),
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

/// Every app on the phone that can be opened, with its icon.
Future<PhoneApp?> _pickApp(BuildContext context) => showModalBottomSheet<PhoneApp>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.7,
    builder: (context, scroll) => FutureBuilder<List<PhoneApp>>(
      future: Apps.list(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final apps = snap.data!;
        if (apps.isEmpty) {
          return const Padding(padding: EdgeInsets.all(24), child: Text('No apps found.'));
        }
        return ListView.builder(
          controller: scroll,
          itemCount: apps.length,
          itemBuilder: (context, i) {
            final a = apps[i];
            return ListTile(
              leading: a.icon == null
                  ? const Icon(Icons.apps)
                  : Image.memory(a.icon!, width: 40, height: 40, gaplessPlayback: true),
              title: Text(a.label),
              onTap: () => Navigator.pop(context, a),
            );
          },
        );
      },
    ),
  ),
);

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
