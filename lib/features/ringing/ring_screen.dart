import 'dart:async';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/util/local_time.dart';
import '../alarms/data/alarm_registrar.dart';
import 'ring_payload.dart';

/// Full screen shown while an alarm rings: what it is for, Stop, Snooze,
/// and the optional sum or wake-up check.
class RingScreen extends ConsumerStatefulWidget {
  const RingScreen({super.key, required this.alarm});

  final AlarmSettings alarm;

  @override
  ConsumerState<RingScreen> createState() => _RingScreenState();
}

enum _Stage { ringing, sum, awaitingUp, done }

class _RingScreenState extends ConsumerState<RingScreen> {
  late final RingPayload p = RingPayload.decode(
    widget.alarm.payload,
    fallbackTitle: widget.alarm.notificationSettings.title,
    fallbackBody: widget.alarm.notificationSettings.body,
  );
  final _tts = FlutterTts();
  final _answer = TextEditingController();
  StreamSubscription<AlarmSet>? _ringingSub;
  Timer? _speakTimer;
  var _stage = _Stage.ringing;
  int? _checkId;
  late final (int, int) _sum = (Random().nextInt(60) + 12, Random().nextInt(30) + 7);
  String? _sumError;

  @override
  void initState() {
    super.initState();
    if (p.spoken) {
      _speakTimer = Timer(const Duration(seconds: 2), _speak);
    }
    // Close when the alarm stops on its own (ring duration) or elsewhere.
    _ringingSub = Alarm.ringing.listen((set) {
      final stillRinging = set.alarms.any((a) => a.id == widget.alarm.id);
      if (!stillRinging && _stage == _Stage.ringing) _close();
    });
  }

  Future<void> _speak() async {
    try {
      await _tts.setSpeechRate(0.45);
      await _tts.speak(p.spokenText);
    } catch (_) {
      // No speech engine on this phone: the alarm still rings.
    }
  }

  @override
  void dispose() {
    _speakTimer?.cancel();
    _ringingSub?.cancel();
    _tts.stop();
    _answer.dispose();
    super.dispose();
  }

  void _close() {
    if (_stage == _Stage.done) return;
    _stage = _Stage.done;
    if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  Future<void> _onStop() async {
    if (p.mathTask && _stage == _Stage.ringing) {
      setState(() => _stage = _Stage.sum);
      return;
    }
    await _stopNow();
  }

  Future<void> _stopNow() async {
    _tts.stop();
    final registrar = ref.read(registrarProvider);
    final checkId = await registrar.stop(widget.alarm);
    if (checkId != null) {
      setState(() {
        _checkId = checkId;
        _stage = _Stage.awaitingUp;
      });
    } else {
      _close();
    }
  }

  void _checkSum() {
    final (a, b) = _sum;
    if (int.tryParse(_answer.text.trim()) == a + b) {
      _stopNow();
    } else {
      setState(() => _sumError = 'Not quite. Try again.');
      _answer.clear();
    }
  }

  Future<void> _onSnooze() async {
    _tts.stop();
    await ref.read(registrarProvider).snooze(widget.alarm);
    _close();
  }

  Future<void> _onUp() async {
    if (_checkId != null) await ref.read(registrarProvider).cancel(_checkId!);
    _close();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final now = DateTime.now();
    final snoozesLeft = p.maxSnoozes - p.snoozeCount;

    return PopScope(
      canPop: _stage == _Stage.done,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(hhmm(now), style: text.displayLarge?.copyWith(color: QuandoColors.amber)),
                const SizedBox(height: 12),
                Text(p.title, style: text.headlineSmall),
                const SizedBox(height: 6),
                Text(p.body, style: text.titleMedium?.copyWith(color: QuandoColors.muted)),
                if (p.shabbatSafe) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Shabbat mode: this stops by itself in ${p.ringSeconds} seconds. No need to touch the phone.',
                    style: text.bodyMedium?.copyWith(color: QuandoColors.muted),
                  ),
                ],
                const Spacer(),
                ..._actions(text, snoozesLeft),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(TextTheme text, int snoozesLeft) {
    switch (_stage) {
      case _Stage.sum:
        final (a, b) = _sum;
        return [
          Text('Solve to stop', style: text.labelSmall),
          const SizedBox(height: 8),
          Text('$a + $b = ?', style: text.displaySmall),
          const SizedBox(height: 12),
          TextField(
            controller: _answer,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: text.headlineSmall,
            decoration: InputDecoration(errorText: _sumError, hintText: 'Answer'),
            onSubmitted: (_) => _checkSum(),
          ),
          const SizedBox(height: 16),
          _big(FilledButton(onPressed: _checkSum, child: const Text('Stop'))),
        ];
      case _Stage.awaitingUp:
        return [
          Text(
            'I\'ll ring again in ${AlarmRegistrar.checkDelay.inMinutes} minutes unless you tap below.',
            style: text.bodyLarge,
          ),
          const SizedBox(height: 16),
          _big(FilledButton(onPressed: _onUp, child: const Text('I\'m up'))),
        ];
      case _Stage.ringing:
      case _Stage.done:
        return [
          if (p.isCheck)
            _big(FilledButton(onPressed: _stopNow, child: const Text('I\'m up')))
          else
            _big(FilledButton(onPressed: _onStop, child: const Text('Stop'))),
          if (!p.isCheck && p.canSnooze) ...[
            const SizedBox(height: 12),
            _big(
              OutlinedButton(
                onPressed: _onSnooze,
                child: Text('Snooze ${p.snoozeMinutes} min · $snoozesLeft left'),
              ),
            ),
          ],
          if (!p.isCheck && !p.canSnooze && p.maxSnoozes > 0) ...[
            const SizedBox(height: 12),
            Text('No snoozes left', textAlign: TextAlign.center, style: text.bodyMedium),
          ],
        ];
    }
  }

  Widget _big(Widget button) => SizedBox(height: 60, child: button);
}
