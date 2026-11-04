import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../../sounds/domain/sound.dart';
import '../../sounds/ui/sound_player.dart';
import '../ring_style.dart';

/// A row in the alarm editor: "Gentle wake-up · 30 min · Waves on the shore".
class GentleTile extends StatelessWidget {
  const GentleTile({super.key, required this.value, required this.onChanged});

  final RingStyle value;
  final ValueChanged<RingStyle> onChanged;

  @override
  Widget build(BuildContext context) {
    final on = value.gentleMinutes > 0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.wb_twilight, color: QuandoColors.amber),
      title: const Text('Gentle wake-up'),
      subtitle: Text(on ? '${value.gentleMinutes} min before · ${calmName(value.gentleSound)}' : 'Off'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final changed = await Navigator.of(context)
            .push<RingStyle>(MaterialPageRoute(builder: (_) => GentleScreen(initial: value)));
        if (changed != null) onChanged(changed);
      },
    );
  }
}

String calmName(String id) =>
    (AlarmSound.calm.where((c) => c.id == id).firstOrNull ?? AlarmSound.calm.first).name;

/// Calm sounds that start before the alarm and rise slowly, so you wake from
/// light sleep. The alarm's own sound is chosen elsewhere. Back saves.
class GentleScreen extends StatefulWidget {
  const GentleScreen({super.key, required this.initial});

  final RingStyle initial;

  @override
  State<GentleScreen> createState() => _GentleScreenState();
}

class _GentleScreenState extends State<GentleScreen> {
  late RingStyle _s = widget.initial;
  late int _lastMinutes = widget.initial.gentleMinutes > 0 ? widget.initial.gentleMinutes : 20;

  @override
  void dispose() {
    SoundPreview.instance.stop();
    super.dispose();
  }

  Future<void> _listen(AlarmSound c) async {
    final p = SoundPreview.instance;
    if (p.playingId == c.id) {
      await p.stop();
    } else {
      await p.play(c, onDone: () => mounted ? setState(() {}) : null);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final on = _s.gentleMinutes > 0;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_s);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Gentle wake-up')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          children: [
            const FeatureHeader(
              icon: Icons.wb_twilight,
              sentence: 'A calm sound starts softly before your alarm, so it never jolts you awake.',
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Gentle wake-up', style: text.titleLarge),
              value: on,
              onChanged: (v) => setState(() => _s = _s.copyWith(gentleMinutes: v ? _lastMinutes : 0)),
            ),
            Text(
              'It grows slowly, easing you out of light sleep, and stops just before the alarm rings.',
              style: text.bodyMedium?.copyWith(color: QuandoColors.muted),
            ),
            if (on) ...[
              const SizedBox(height: 24),
              Text('STARTS BEFORE THE ALARM', style: text.labelSmall),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in const [5, 10, 15, 20, 30, 45, 60])
                    ChoiceChip(
                      label: Text('$m min'),
                      selected: _s.gentleMinutes == m,
                      onSelected: (_) => setState(() {
                        _lastMinutes = m;
                        _s = _s.copyWith(gentleMinutes: m);
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text('LEAD-UP SOUND', style: text.labelSmall),
              const SizedBox(height: 4),
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
                    onPressed: () => _listen(c),
                  ),
                  onTap: () => setState(() => _s = _s.copyWith(gentleSound: c.id)),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => _credits(context),
                  child: const Text('Who recorded these'),
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              onPressed: () => Navigator.of(context).pop(_s),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  void _credits(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Sound credits'),
      content: SingleChildScrollView(
        child: Text(
          [for (final (name, who, licence) in AlarmSound.calmCredits) '$name: $who ($licence)'].join('\n\n'),
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
    ),
  );
}
