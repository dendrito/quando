import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quando/l10n/l10n.dart';

import '../../../app/theme.dart';
import '../data/timer_providers.dart';
import '../domain/timers.dart';
import 'sequence_settings.dart';

/// "3:05", "1:02:03".
String clockText(int totalSeconds) {
  final h = totalSeconds ~/ 3600, m = totalSeconds % 3600 ~/ 60, s = totalSeconds % 60;
  String two(int v) => v.toString().padLeft(2, '0');
  return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
}

/// "03:05.42" for the stopwatch.
String stopwatchText(int ms) {
  final cs = ms % 1000 ~/ 10;
  return '${clockText(ms ~/ 1000)}.${cs.toString().padLeft(2, '0')}';
}

/// The time, as big as the screen allows.
class BigTime extends StatelessWidget {
  const BigTime(this.text, {super.key, this.color, this.size = 96});
  final String text;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      text,
      maxLines: 1,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: size,
        color: color ?? QuandoColors.text,
        letterSpacing: -2,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    ),
  );
}

/// Stopwatch, Timer and Get set: three tabs, each one tap from the home
/// screen.
class TimersScreen extends ConsumerWidget {
  const TimersScreen({super.key, this.initialTab = 0});
  final int initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialTab.clamp(0, 2),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.timersTitle),
          bottom: TabBar(
            labelColor: QuandoColors.amber,
            indicatorColor: QuandoColors.amber,
            tabs: [
              Tab(icon: const Icon(Icons.timer_outlined), text: l10n.timerStopwatch),
              Tab(icon: const Icon(Icons.hourglass_bottom), text: l10n.timerCountdown),
              Tab(icon: const Icon(Icons.flag_outlined), text: l10n.timerSequence),
            ],
          ),
        ),
        body: const TabBarView(children: [_StopwatchPage(), _CountdownPage(), _SequencePage()]),
      ),
    );
  }
}

class _Round extends StatelessWidget {
  const _Round({required this.label, required this.onTap, this.primary = false});
  final String label;
  final VoidCallback? onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 64,
    child: primary
        ? FilledButton(
            onPressed: onTap,
            child: Text(label, style: const TextStyle(fontSize: 20)),
          )
        : OutlinedButton(
            onPressed: onTap,
            child: Text(label, style: const TextStyle(fontSize: 18)),
          ),
  );
}

// ---------------------------------------------------------------- Stopwatch

class _StopwatchPage extends ConsumerWidget {
  const _StopwatchPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(stopwatchProvider);
    return ListenableBuilder(
      listenable: m,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
        children: [
          BigTime(stopwatchText(m.elapsedMs), size: 104),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _Round(
                  label: m.running ? l10n.timerLap : l10n.timerReset,
                  onTap: m.running ? m.lap : (m.untouched ? null : m.reset),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _Round(
                  primary: true,
                  label: m.running ? l10n.timerPause : (m.untouched ? l10n.timerStart : l10n.timerResume),
                  onTap: m.running ? m.pause : m.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < m.laps.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(
                    '${l10n.timerLap} ${m.laps.length - i}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: QuandoColors.blush),
                  ),
                  const Spacer(),
                  Text(
                    stopwatchText(m.lapLength(i)),
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    stopwatchText(m.laps[i]),
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: QuandoColors.muted, fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------- Countdown

class _CountdownPage extends ConsumerWidget {
  const _CountdownPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(countdownProvider);
    return ListenableBuilder(
      listenable: m,
      builder: (context, _) {
        final left = (m.remaining.inMilliseconds / 1000).ceil();
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
          children: [
            GestureDetector(
              onTap: m.running
                  ? null
                  : () async {
                      final picked = await pickDuration(context, m.length.inSeconds);
                      if (picked != null && picked > 0) m.setLength(Duration(seconds: picked));
                    },
              child: BigTime(clockText(left), size: 112, color: m.finished ? QuandoColors.coral : null),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: m.untouched ? 1 : m.fraction,
                minHeight: 10,
                color: m.finished ? QuandoColors.coral : QuandoColors.amber,
                backgroundColor: QuandoColors.surface,
              ),
            ),
            if (m.finished) ...[
              const SizedBox(height: 16),
              Center(
                child: Text(
                  l10n.timerTimesUp,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: QuandoColors.coral),
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (m.untouched || m.finished) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (final minutes in const [1, 3, 5, 10, 15, 30])
                    ChoiceChip(
                      label: Text(l10n.minutesShort(minutes)),
                      selected: m.length == Duration(minutes: minutes),
                      onSelected: (_) => m.setLength(Duration(minutes: minutes)),
                    ),
                  ActionChip(
                    avatar: const Icon(Icons.edit_outlined, size: 18),
                    label: Text(l10n.timerSetTime),
                    onPressed: () async {
                      final picked = await pickDuration(context, m.length.inSeconds);
                      if (picked != null && picked > 0) m.setLength(Duration(seconds: picked));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
            Row(
              children: [
                Expanded(
                  child: _Round(label: l10n.timerReset, onTap: m.untouched ? null : m.reset),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _Round(
                    primary: true,
                    label: m.running
                        ? l10n.timerPause
                        : (m.untouched || m.finished ? l10n.timerStart : l10n.timerResume),
                    onTap: m.running
                        ? m.pause
                        : () {
                            if (m.finished) m.reset();
                            m.start();
                          },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Asks for minutes and seconds. Returns the total seconds.
Future<int?> pickDuration(BuildContext context, int initialSeconds) {
  final minutes = TextEditingController(text: '${initialSeconds ~/ 60}');
  final seconds = TextEditingController(text: '${initialSeconds % 60}');
  return showDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.timerSetTime),
      content: Row(
        children: [
          Expanded(
            child: TextField(
              controller: minutes,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l10n.timerMinutes),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: seconds,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l10n.timerSeconds),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            ((int.tryParse(minutes.text) ?? 0) * 60 + (int.tryParse(seconds.text) ?? 0)).clamp(0, 99 * 3600),
          ),
          child: Text(l10n.done),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------- Get set

class _SequencePage extends ConsumerWidget {
  const _SequencePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(sequenceRunnerProvider);
    final config = ref.watch(sequenceConfigProvider);
    final text = Theme.of(context).textTheme;
    return ListenableBuilder(
      listenable: run,
      builder: (context, _) {
        final pos = run.positionMs;
        final cue = run.lastCue;
        final idle = run.phase == SequencePhase.ready;
        // Before Go: the seconds until it. After: the time left, or passed.
        final String time;
        if (idle) {
          time = clockText(config.lengthSeconds);
        } else if (pos < 0) {
          time = '${(-pos / 1000).ceil()}';
        } else if (run.leftMs case final left?) {
          time = clockText((left / 1000).ceil());
        } else {
          time = clockText(pos ~/ 1000);
        }
        final headline = idle
            ? l10n.seqReady
            : run.phase == SequencePhase.done
            ? config.finishText
            : (cue?.text ?? '');
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            SizedBox(
              height: 64,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    headline,
                    maxLines: 1,
                    style: text.displaySmall?.copyWith(
                      fontSize: 44,
                      color: cue?.kind == CueKind.go || run.phase == SequencePhase.done
                          ? QuandoColors.amber
                          : QuandoColors.blush,
                    ),
                  ),
                ),
              ),
            ),
            BigTime(time, size: 120, color: pos < 0 && !idle ? QuandoColors.coral : null),
            const SizedBox(height: 8),
            Center(
              child: Text(
                config.lengthSeconds > 0 ? l10n.seqHintLength : l10n.seqHintNoLimit,
                style: text.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: _Round(label: l10n.timerReset, onTap: idle ? null : run.reset),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _Round(
                    primary: true,
                    label: run.phase == SequencePhase.running
                        ? l10n.timerPause
                        : (run.phase == SequencePhase.paused ? l10n.timerResume : l10n.timerStart),
                    onTap: run.phase == SequencePhase.running ? run.pause : () => run.start(config),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.seqPresets, style: text.labelSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (label, make) in <(String, SequenceConfig Function())>[
                  (l10n.seqPresetRace, racePreset),
                  (l10n.seqPresetSprint, sprintPreset),
                  (l10n.seqPresetRound, roundPreset),
                ])
                  ActionChip(
                    label: Text(label),
                    onPressed: idle ? () => ref.read(sequenceConfigProvider.notifier).set(make()) : null,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: idle ? () => showSequenceSettings(context) : null,
              icon: const Icon(Icons.tune),
              label: Text(l10n.seqSettings),
            ),
          ],
        );
      },
    );
  }
}
