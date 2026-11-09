import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/theme.dart';

import 'package:quando/l10n/l10n.dart';

/// The ringing screen's tasks, drawn in plum on its coral background.
const _ink = QuandoColors.ground;

/// Find the six pairs. A wrong pair turns back over.
class MemoryTask extends StatefulWidget {
  const MemoryTask({super.key, required this.onDone, this.seed});

  final VoidCallback onDone;
  final int? seed;

  @override
  State<MemoryTask> createState() => _MemoryTaskState();
}

class _MemoryTaskState extends State<MemoryTask> {
  static const _icons = [Icons.wb_sunny, Icons.local_cafe, Icons.favorite, Icons.music_note, Icons.star, Icons.spa];
  late final List<IconData> _cards = [..._icons, ..._icons]..shuffle(Random(widget.seed));
  @visibleForTesting
  List<IconData> get cardsForTest => _cards;
  final _matched = <int>{};
  final _up = <int>[];
  var _busy = false;

  void _tap(int i) {
    if (_busy || _matched.contains(i) || _up.contains(i)) return;
    setState(() => _up.add(i));
    if (_up.length < 2) return;
    final [a, b] = _up;
    if (_cards[a] == _cards[b]) {
      setState(() {
        _matched.addAll(_up);
        _up.clear();
      });
      if (_matched.length == _cards.length) widget.onDone();
    } else {
      _busy = true;
      Timer(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() {
          _up.clear();
          _busy = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (var i = 0; i < _cards.length; i++)
          Semantics(
            button: true,
            label: _matched.contains(i) || _up.contains(i) ? l10n.card : l10n.hiddenCard,
            child: GestureDetector(
              onTap: () => _tap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: _matched.contains(i)
                      ? _ink.withValues(alpha: 0.25)
                      : (_up.contains(i) ? QuandoColors.text : _ink),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: _matched.contains(i) || _up.contains(i)
                    ? Icon(_cards[i], color: _matched.contains(i) ? QuandoColors.text : QuandoColors.coral, size: 30)
                    : const Icon(Icons.question_mark, color: QuandoColors.faint, size: 22),
              ),
            ),
          ),
      ],
    );
  }
}

List<String> get wakePhrases => [l10n.phrase1, l10n.phrase2, l10n.phrase3, l10n.phrase4, l10n.phrase5];

/// Type a phrase exactly (any case, extra spaces don't matter).
class PhraseTask extends StatefulWidget {
  const PhraseTask({super.key, required this.onDone, this.seed});

  final VoidCallback onDone;
  final int? seed;

  @override
  State<PhraseTask> createState() => _PhraseTaskState();
}

class _PhraseTaskState extends State<PhraseTask> {
  late final String _phrase = wakePhrases[Random(widget.seed).nextInt(wakePhrases.length)];
  final _c = TextEditingController();
  String? _error;

  static String norm(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^\p{L}\p{N} ]', unicode: true), '').replaceAll(RegExp(r'\s+'), ' ').trim();

  void _check() {
    if (norm(_c.text) == norm(_phrase)) {
      widget.onDone();
    } else {
      setState(() => _error = l10n.notQuiteWords);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('"$_phrase"', style: text.headlineSmall?.copyWith(color: _ink)),
        const SizedBox(height: 12),
        TextField(
          controller: _c,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          style: text.titleMedium,
          decoration: InputDecoration(errorText: _error, hintText: l10n.typeItHere),
          onSubmitted: (_) => _check(),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: _ink, foregroundColor: QuandoColors.text),
            onPressed: _check,
            child: Text(l10n.done),
          ),
        ),
      ],
    );
  }
}

/// Point the camera at the code you saved, e.g. on a box in the kitchen.
class ScanTask extends StatefulWidget {
  const ScanTask({super.key, required this.code, required this.onDone, required this.onGiveUp});

  final String code;
  final VoidCallback onDone;

  /// No camera, or the code is gone: fall back to another task.
  final VoidCallback onGiveUp;

  @override
  State<ScanTask> createState() => _ScanTaskState();
}

class _ScanTaskState extends State<ScanTask> {
  var _done = false;
  String? _wrong;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 240,
            child: MobileScanner(
              onDetect: (capture) {
                if (_done) return;
                final hit = capture.barcodes.any((b) => b.rawValue == widget.code);
                if (hit) {
                  _done = true;
                  widget.onDone();
                } else if (capture.barcodes.isNotEmpty) {
                  setState(() => _wrong = l10n.differentCode);
                }
              },
              errorBuilder: (context, error) => Container(
                color: _ink,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(l10n.cameraUnavailable, style: const TextStyle(color: QuandoColors.text)),
              ),
            ),
          ),
        ),
        if (_wrong != null) ...[
          const SizedBox(height: 8),
          Text(
            _wrong!,
            style: text.bodyLarge?.copyWith(color: _ink, fontWeight: FontWeight.w600),
          ),
        ],
        TextButton(
          onPressed: widget.onGiveUp,
          style: TextButton.styleFrom(foregroundColor: _ink),
          child: Text(l10n.cantScan),
        ),
      ],
    );
  }
}

/// Saves the code to scan later: point the camera at any barcode or QR
/// code, ideally in another room.
class ScanSetupScreen extends StatefulWidget {
  const ScanSetupScreen({super.key});

  @override
  State<ScanSetupScreen> createState() => _ScanSetupScreenState();
}

class _ScanSetupScreenState extends State<ScanSetupScreen> {
  var _done = false;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.saveCodeToScan)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          Text(l10n.saveCodeHint, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 320,
              child: MobileScanner(
                onDetect: (capture) {
                  final code = capture.barcodes.map((b) => b.rawValue).nonNulls.firstOrNull;
                  if (_done || code == null || code.isEmpty) return;
                  _done = true;
                  Navigator.of(context).pop(code);
                },
                errorBuilder: (context, error) => Container(
                  color: QuandoColors.surface,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Text(l10n.cameraUnavailableSettings),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
