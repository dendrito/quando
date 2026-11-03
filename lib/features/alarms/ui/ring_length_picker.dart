import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme.dart';
import '../../../core/util/format.dart';

/// Picks how long an alarm rings, down to the second: quick choices,
/// −/+ one second, or any minutes and seconds typed in.
class RingLengthPicker extends StatelessWidget {
  const RingLengthPicker({super.key, required this.seconds, required this.onChanged});

  final int seconds;
  final ValueChanged<int> onChanged;

  static const maxSeconds = 60 * 60;
  static const _quick = [1, 2, 3, 5, 10, 30, 60, 120, 300];

  static String short(int s) => s < 60
      ? '$s s'
      : s % 60 == 0
      ? '${s ~/ 60} min'
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
            autofocus: label == 'Minutes',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: label),
          ),
        );
        return AlertDialog(
          title: const Text('Ring for'),
          content: Row(children: [field(min, 'Minutes'), const SizedBox(width: 16), field(sec, 'Seconds')]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context, (int.tryParse(min.text) ?? 0) * 60 + (int.tryParse(sec.text) ?? 0)),
              child: const Text('OK'),
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
            IconButton.outlined(
              tooltip: '1 second less',
              onPressed: seconds > 1 ? () => _set(seconds - 1) : null,
              icon: const Icon(Icons.remove),
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
            IconButton.outlined(
              tooltip: '1 second more',
              onPressed: seconds < maxSeconds ? () => _set(seconds + 1) : null,
              icon: const Icon(Icons.add),
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
