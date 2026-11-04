import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../settings/domain/alarm_options.dart';
import '../../sounds/domain/loudness.dart';
import '../data/apps.dart';
import '../ring_style.dart';
import 'gentle_screen.dart';

/// One alarm's extras as short rows and cards, each opening its own small
/// screen: Volume, Snooze, Stop, Gentle wake-up, Wake-up check, Open an app.
class AlarmExtras extends ConsumerWidget {
  const AlarmExtras({super.key, required this.value, required this.onChanged});

  final RingStyle value;
  final ValueChanged<RingStyle> onChanged;

  Future<void> _open(BuildContext context, Widget screen) async {
    final changed = await Navigator.of(context).push<RingStyle>(MaterialPageRoute(builder: (_) => screen));
    if (changed != null) onChanged(changed);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o = ref.watch(alarmOptionsProvider);
    final s = value;
    final plan = s.snooze ?? defaultSnooze(o);
    final stopTask = s.task ?? (o.mathTask ? StopTask.sum : StopTask.none);
    final wakeCheck = s.wakeCheck ?? o.wakeCheck;
    final open = s.openAfter;
    final hasOpen = open != null && open.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Row(
          icon: Icons.volume_up_outlined,
          title: 'Volume',
          subtitle: (s.loudness ?? o.loudness).summary,
          onTap: () => _open(context, VolumeScreen(initial: s)),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ActionCard(
                title: 'Snooze',
                ways: s.snoozeBy,
                off: plan.times == 0,
                line: plan.times == 0 ? 'Off' : '${plan.minutes} min',
                task: s.snoozeTask ?? StopTask.none,
                onTap: () => _open(context, SnoozeScreen(initial: s)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ActionCard(
                title: 'Stop',
                ways: s.stopBy,
                line: wakeCheck ? 'Wake-up check on' : 'Stops at once',
                task: stopTask,
                onTap: () => _open(context, StopScreen(initial: s)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _Row(
          icon: Icons.wb_twilight,
          title: 'Gentle wake-up',
          subtitle: s.gentleMinutes > 0
              ? '${s.gentleMinutes} min before · ${calmName(s.gentleSound)}'
              : 'Off',
          on: s.gentleMinutes > 0,
          onSwitch: (v) => onChanged(s.copyWith(gentleMinutes: v ? 20 : 0)),
          onTap: () => _open(context, GentleScreen(initial: s)),
        ),
        _Row(
          icon: Icons.task_alt,
          title: 'Wake-up check',
          subtitle: 'Rings again in 3 min if you\'re not up',
          on: wakeCheck,
          onSwitch: (v) => onChanged(s.copyWith(wakeCheck: v)),
        ),
        _Row(
          icon: Icons.apps,
          title: 'Open an app after',
          subtitle: hasOpen ? AppLink.label(open) : 'Off',
          on: hasOpen,
          onSwitch: (v) async {
            if (!v) return onChanged(s.copyWith(noOpenAfter: true));
            final picked = await pickOpenAfter(context, s.openAfter);
            if (picked != null) onChanged(s.copyWith(openAfter: picked));
          },
          onTap: () async {
            final picked = await pickOpenAfter(context, s.openAfter);
            if (picked != null) onChanged(s.copyWith(openAfter: picked));
          },
        ),
      ],
    );
  }
}

SnoozePlan defaultSnooze(AlarmOptions o) => SnoozePlan(minutes: o.snoozeMinutes, times: o.maxSnoozes);

/// A tappable row, optionally with a switch.
class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.on,
    this.onSwitch,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool? on;
  final ValueChanged<bool>? onSwitch;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: QuandoColors.amber),
      title: Text(title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: on == null ? const Icon(Icons.chevron_right) : Switch(value: on!, onChanged: onSwitch),
      onTap: onTap ?? (onSwitch == null || on == null ? null : () => onSwitch!(!on!)),
    );
  }
}

const _wayIcons = {StopWay.volumeKeys: Icons.unfold_more, StopWay.shake: Icons.vibration};

/// The Snooze or Stop card: which controls work, and the task.
class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.ways,
    required this.line,
    required this.task,
    required this.onTap,
    this.off = false,
  });

  final String title;
  final Set<StopWay> ways;
  final String line;
  final StopTask task;
  final VoidCallback onTap;
  final bool off;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    Widget dot(IconData i, bool lit) => Icon(
      i,
      size: 22,
      color: lit && !off ? QuandoColors.amber : QuandoColors.faint.withValues(alpha: 0.6),
    );
    return Material(
      color: QuandoColors.surface,
      borderRadius: const BorderRadius.all(Radius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.titleLarge),
              const SizedBox(height: 10),
              Row(
                children: [
                  dot(Icons.touch_app_outlined, true),
                  const SizedBox(width: 10),
                  for (final w in StopWay.values) ...[
                    dot(_wayIcons[w]!, ways.contains(w)),
                    const SizedBox(width: 10),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Text(line, style: text.bodySmall),
              Text(
                task == StopTask.none ? 'No task' : task.label,
                style: text.bodySmall?.copyWith(color: task == StopTask.none ? null : QuandoColors.blush),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A screen that edits a copy of the style and hands it back on leaving.
abstract class _StyleScreen extends ConsumerStatefulWidget {
  const _StyleScreen({super.key, required this.initial});
  final RingStyle initial;
}

abstract class _StyleScreenState<T extends _StyleScreen> extends ConsumerState<T> {
  late RingStyle s = widget.initial;
  String get title;
  List<Widget> body(BuildContext context, TextTheme text, AlarmOptions o);

  void set(RingStyle v) => setState(() => s = v);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final o = ref.watch(alarmOptionsProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(s);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(padding: const EdgeInsets.fromLTRB(24, 8, 24, 40), children: body(context, text, o)),
      ),
    );
  }
}

/// "CONTROLS": on screen always works; volume buttons and shaking can be
/// switched on. A control does one job: turning it on here takes it off the
/// other card.
Widget _controls(
  TextTheme text,
  Set<StopWay> mine,
  void Function(StopWay, bool) toggle, {
  bool enabled = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('CONTROLS', style: text.labelSmall),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          const FilterChip(
            showCheckmark: false,
            avatar: Icon(Icons.touch_app_outlined, size: 18),
            label: Text('On screen'),
            selected: true,
            onSelected: null,
          ),
          for (final w in StopWay.values)
            FilterChip(
              showCheckmark: false,
              avatar: Icon(_wayIcons[w], size: 18),
              label: Text(w.label),
              selected: mine.contains(w),
              onSelected: enabled ? (v) => toggle(w, v) : null,
            ),
        ],
      ),
    ],
  );
}

Widget _taskChips(TextTheme text, StopTask current, ValueChanged<StopTask> pick, {bool enabled = true}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TASK', style: text.labelSmall),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final t in StopTask.values)
              ChoiceChip(
                label: Text(t == StopTask.none ? 'None' : t.label),
                selected: current == t,
                onSelected: enabled ? (_) => pick(t) : null,
              ),
          ],
        ),
      ],
    );

/// A setting row with its value in amber; tap to choose another.
class _Setting extends StatelessWidget {
  const _Setting({
    required this.title,
    required this.subtitle,
    required this.values,
    required this.current,
    required this.label,
    required this.onPick,
  });

  final String title;
  final String subtitle;
  final List<int> values;
  final int current;
  final String Function(int) label;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: text.titleMedium),
      subtitle: Text(subtitle),
      trailing: Text(label(current), style: text.titleMedium?.copyWith(color: QuandoColors.amber)),
      onTap: () async {
        final v = await showDialog<int>(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text(title),
            children: [
              for (final v in values)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, v),
                  child: Row(
                    children: [
                      Icon(
                        v == current ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: QuandoColors.amber,
                      ),
                      const SizedBox(width: 14),
                      Text(label(v), style: text.titleMedium),
                    ],
                  ),
                ),
            ],
          ),
        );
        if (v != null) onPick(v);
      },
    );
  }
}

String _min(int m) => m == 0 ? '0 min' : '$m min';

class SnoozeScreen extends _StyleScreen {
  const SnoozeScreen({super.key, required super.initial});

  @override
  ConsumerState<SnoozeScreen> createState() => _SnoozeScreenState();
}

class _SnoozeScreenState extends _StyleScreenState<SnoozeScreen> {
  @override
  String get title => 'Snooze';

  @override
  List<Widget> body(BuildContext context, TextTheme text, AlarmOptions o) {
    final plan = s.snooze ?? defaultSnooze(o);
    final on = plan.times > 0;
    void setPlan(SnoozePlan p) => set(s.copyWith(snooze: p));
    return [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Snooze', style: text.titleLarge),
        subtitle: const Text('Ring again a little later.'),
        value: on,
        onChanged: (v) => setPlan(plan.copyWith(times: v ? (plan.times > 0 ? plan.times : 3) : 0)),
      ),
      if (on) ...[
        const SizedBox(height: 16),
        _controls(
          text,
          s.snoozeBy,
          (w, v) => set(
            s.copyWith(
              snoozeBy: {...s.snoozeBy.where((x) => x != w), if (v) w},
              stopBy: v ? s.stopBy.where((x) => x != w).toSet() : null,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _taskChips(
          text,
          s.snoozeTask ?? StopTask.none,
          (t) => set(t == StopTask.none ? s.copyWith(noSnoozeTask: true) : s.copyWith(snoozeTask: t)),
        ),
        const SizedBox(height: 24),
        Text('SETTINGS', style: text.labelSmall),
        _Setting(
          title: 'Snooze time',
          subtitle: 'How long the first snooze lasts',
          values: const [1, 2, 3, 5, 10, 15, 20, 30],
          current: plan.minutes,
          label: _min,
          onPick: (m) => setPlan(plan.copyWith(minutes: m)),
        ),
        _Setting(
          title: 'Shorten extra snoozes',
          subtitle: 'Each snooze after the first is this much shorter',
          values: const [0, 1, 2, 3, 5],
          current: plan.shortenBy,
          label: _min,
          onPick: (m) => setPlan(plan.copyWith(shortenBy: m)),
        ),
        _Setting(
          title: 'Auto-snooze',
          subtitle: 'If you don\'t touch it, it snoozes by itself after',
          values: const [0, 1, 2, 3, 5, 10],
          current: plan.autoSnoozeMinutes,
          label: (m) => m == 0 ? 'Never' : _min(m),
          onPick: (m) => setPlan(plan.copyWith(autoSnoozeMinutes: m)),
        ),
        _Setting(
          title: 'Snooze limit',
          subtitle: 'How many times you can snooze',
          values: const [1, 2, 3, 5, 10, SnoozePlan.unlimited],
          current: plan.times,
          label: (n) => n >= SnoozePlan.unlimited ? 'Unlimited' : '$n',
          onPick: (n) => setPlan(plan.copyWith(times: n)),
        ),
      ],
      if (s.snooze != null)
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => set(s.copyWith(defaultSnooze: true)),
            child: const Text('Use the snooze from Settings'),
          ),
        ),
    ];
  }
}

class StopScreen extends _StyleScreen {
  const StopScreen({super.key, required super.initial});

  @override
  ConsumerState<StopScreen> createState() => _StopScreenState();
}

class _StopScreenState extends _StyleScreenState<StopScreen> {
  @override
  String get title => 'Stop';

  @override
  List<Widget> body(BuildContext context, TextTheme text, AlarmOptions o) => [
    Text('How you turn the alarm off.', style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
    const SizedBox(height: 20),
    _controls(
      text,
      s.stopBy,
      (w, v) => set(
        s.copyWith(
          stopBy: {...s.stopBy.where((x) => x != w), if (v) w},
          snoozeBy: v ? s.snoozeBy.where((x) => x != w).toSet() : null,
        ),
      ),
    ),
    const SizedBox(height: 24),
    _taskChips(text, s.task ?? (o.mathTask ? StopTask.sum : StopTask.none), (t) => set(s.copyWith(task: t))),
    const SizedBox(height: 24),
    Text(
      'On Shabbat and festivals alarms stop by themselves and never ask for a task.',
      style: text.bodySmall,
    ),
  ];
}

class VolumeScreen extends _StyleScreen {
  const VolumeScreen({super.key, required super.initial});

  @override
  ConsumerState<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends _StyleScreenState<VolumeScreen> {
  @override
  String get title => 'Volume';

  @override
  List<Widget> body(BuildContext context, TextTheme text, AlarmOptions o) => [
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Same as other alarms'),
      subtitle: Text(o.loudness.summary),
      value: s.loudness == null,
      onChanged: (v) => set(v ? s.copyWith(defaultLoudness: true) : s.copyWith(loudness: o.loudness)),
    ),
    if (s.loudness != null)
      LoudnessEditor(
        value: s.loudness!,
        onChanged: (l) => set(s.copyWith(loudness: l)),
      ),
  ];
}

/// An app on the phone, or a link, to open once you're up.
Future<String?> pickOpenAfter(BuildContext context, String? current) async {
  final link = TextEditingController(text: AppLink.isApp(current) ? '' : (current ?? ''));
  final r = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Open after the alarm', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            icon: const Icon(Icons.apps),
            label: const Text('Pick an app'),
            onPressed: () async {
              final a = await _pickApp(context);
              if (a != null && context.mounted) Navigator.pop(context, AppLink.of(a));
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: link,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(hintText: 'Or paste a link: https://…'),
            onSubmitted: (v) => Navigator.pop(context, v.trim().isEmpty ? null : v.trim()),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (name, url) in _quickLinks)
                ActionChip(label: Text(name), onPressed: () => Navigator.pop(context, url)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                final v = link.text.trim();
                Navigator.pop(context, v.isEmpty ? null : v);
              },
              child: const Text('Use this link'),
            ),
          ),
        ],
      ),
    ),
  );
  link.dispose();
  return r;
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
