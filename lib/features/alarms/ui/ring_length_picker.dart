import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme.dart';
import '../../../core/util/format.dart';

import 'package:quando/l10n/l10n.dart';

/// Picks how long an alarm rings, down to the second: quick choices,
/// −/+ one second, or any minutes and seconds typed in.
class RingLengthPicker extends StatelessWidget {
  const RingLengthPicker({super.key, required this.seconds, required this.onChanged});

  final int seconds;
  final ValueChanged<int> onChanged;

  static const maxSeconds = 60 * 60;
  static const _quick = [1, 2, 3, 5, 10, 30, 60, 120, 300];

  static String short(int s) => s < 60
      ? l10n.secondsShort(s)
      : s % 60 == 0
      ? l10n.minutesShort(s ~/ 60)
      : '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  void _set(int s) => onChanged(s.clamp(1, maxSeconds));

  Future<void> _custom(BuildContext context) async {
    final min = TextEditingController(text: '${seconds ~/ 60}');
    final sec = TextEditingController(text: '${seconds % 60}');
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        Widget field(TextEditingController c, String label) => Expanded(
          child: TextField(
            controller: c,
            autofocus: label == l10n.minutes,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: label),
          ),
        );
        return AlertDialog(
          title: Text(l10n.ringFor),
          content: Row(
            children: [field(min, l10n.minutes), const SizedBox(width: 16), field(sec, l10n.seconds)],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context, (int.tryParse(min.text) ?? 0) * 60 + (int.tryParse(sec.text) ?? 0)),
              child: Text(l10n.ok),
            ),
          ],
        );
      },
    );
    if (result != null) _set(result);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            HoldToRepeatButton(
              tooltip: l10n.oneSecondLess,
              icon: Icons.remove,
              enabled: seconds > 1,
              onStep: (step) => _set(seconds - step),
            ),
            Expanded(
              child: TextButton(
                onPressed: () => _custom(context),
                child: Text(
                  formatSpan(Duration(seconds: seconds)),
                  style: text.titleLarge?.copyWith(color: QuandoColors.amber),
                ),
              ),
            ),
            HoldToRepeatButton(
              tooltip: l10n.oneSecondMore,
              icon: Icons.add,
              enabled: seconds < maxSeconds,
              onStep: (step) => _set(seconds + step),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final s in _quick)
              ChoiceChip(label: Text(short(s)), selected: s == seconds, onSelected: (_) => _set(s)),
          ],
        ),
      ],
    );
  }
}

/// Tap: one step. Hold: keeps stepping, faster the longer you hold
/// (1 second at a time, then 5, then 30).
class HoldToRepeatButton extends StatefulWidget {
  const HoldToRepeatButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.onStep,
  });

  final IconData icon;
  final String tooltip;
  final bool enabled;

  /// Called with how many seconds to move by.
  final ValueChanged<int> onStep;

  /// Step size after [ticks] repeats while held.
  static int stepFor(int ticks) => ticks < 10
      ? 1
      : ticks < 22
      ? 5
      : 30;

  @override
  State<HoldToRepeatButton> createState() => _HoldToRepeatButtonState();
}

class _HoldToRepeatButtonState extends State<HoldToRepeatButton> {
  Timer? _delay;
  Timer? _repeat;
  var _ticks = 0;

  // Raw pointer events, so nothing else (tooltips, scrolling) steals the hold.
  void _down(PointerDownEvent _) {
    if (!widget.enabled) return;
    widget.onStep(1);
    _ticks = 0;
    _delay = Timer(const Duration(milliseconds: 400), () {
      _repeat = Timer.periodic(const Duration(milliseconds: 120), (_) {
        if (!widget.enabled) return _stop();
        widget.onStep(HoldToRepeatButton.stepFor(_ticks++));
        HapticFeedback.selectionClick();
      });
    });
  }

  void _stop([PointerEvent? _]) {
    _delay?.cancel();
    _repeat?.cancel();
    _delay = _repeat = null;
  }

  @override
  void didUpdateWidget(HoldToRepeatButton old) {
    super.didUpdateWidget(old);
    if (!widget.enabled) _stop();
  }

  @override
  void dispose() {
    _stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.tooltip,
      button: true,
      child: Listener(
        onPointerDown: _down,
        onPointerUp: _stop,
        onPointerCancel: _stop,
        child: IconButton.outlined(
          // Steps are handled by the Listener above.
          onPressed: widget.enabled ? () {} : null,
          icon: Icon(widget.icon),
        ),
      ),
    );
  }
}
