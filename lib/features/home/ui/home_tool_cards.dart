import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../../timers/data/timer_providers.dart';
import '../../timers/domain/timers.dart';
import '../../timers/ui/timers_screen.dart' show clockText, stopwatchText;

enum HomeTool { stopwatch, countdown, getSet }

/// Stopwatch, countdown and get set in one card: one line each, side by
/// side when the card is wide. Each runs from here; a tap opens it.
class ToolsCard extends StatelessWidget {
  const ToolsCard({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      const tools = HomeTool.values;
      if (box.maxWidth >= 560) {
        return Row(
          children: [
            for (final t in tools) ...[
              if (t != tools.first) const SizedBox(width: 8),
              Expanded(child: ToolLine(tool: t)),
            ],
          ],
        );
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final t in tools) ...[
            if (t != tools.first) const Divider(height: 1, indent: 52, color: Color(0x22FFFFFF)),
            ToolLine(tool: t),
          ],
        ],
      );
    },
  );
}

/// One tool on one line: its icon, name, live time and a play/pause button.
class ToolLine extends ConsumerWidget {
  const ToolLine({super.key, required this.tool});
  final HomeTool tool;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final Listenable model = switch (tool) {
      HomeTool.stopwatch => ref.watch(stopwatchProvider),
      HomeTool.countdown => ref.watch(countdownProvider),
      HomeTool.getSet => ref.watch(sequenceRunnerProvider),
    };
    return ListenableBuilder(
      listenable: model,
      builder: (context, _) {
        final (icon, name, time, running, toggle) = switch (tool) {
          HomeTool.stopwatch => () {
            final m = ref.read(stopwatchProvider);
            return (
              Icons.timer_outlined,
              l10n.timerStopwatch,
              stopwatchText(m.elapsedMs),
              m.running,
              () => m.running ? m.pause() : m.start(),
            );
          }(),
          HomeTool.countdown => () {
            final m = ref.read(countdownProvider);
            return (
              Icons.hourglass_bottom,
              l10n.timerCountdown,
              clockText((m.remaining.inMilliseconds / 1000).ceil()),
              m.running,
              () => m.running ? m.pause() : (m.finished ? (m..reset()).start() : m.start()),
            );
          }(),
          HomeTool.getSet => () {
            final m = ref.read(sequenceRunnerProvider);
            final going = m.phase == SequencePhase.running;
            final pos = m.positionMs;
            return (
              Icons.flag_outlined,
              l10n.timerSequence,
              m.phase == SequencePhase.ready
                  ? '–'
                  : pos < 0
                  ? (m.lastCue?.text ?? '-${clockText((-pos / 1000).ceil())}')
                  : clockText(((m.leftMs ?? pos) / 1000).ceil()),
              going,
              () => going ? m.pause() : m.start(ref.read(sequenceConfigProvider)),
            );
          }(),
        };
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push('/timers?tab=${tool.index}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Icon(icon, color: QuandoColors.amber, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.bodySmall),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          time,
                          maxLines: 1,
                          style: text.titleLarge?.copyWith(
                            fontFeatures: const [FontFeature.tabularFigures()],
                            color: running ? QuandoColors.amber : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: running ? l10n.timerPause : l10n.timerStart,
                  onPressed: toggle,
                  icon: Icon(running ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 34),
                  color: QuandoColors.coral,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
