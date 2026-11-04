import 'dart:async';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/util/local_time.dart';
import '../alarms/data/alarm_registrar.dart';
import 'data/apps.dart';
import 'ring_payload.dart';
import 'ring_style.dart';
import 'shake_detector.dart';

/// Full screen shown while an alarm rings: what it is for, Stop, Snooze,
/// and the optional sum or wake-up check.
class RingScreen extends ConsumerStatefulWidget {
  const RingScreen({super.key, required this.alarm});

  final AlarmSettings alarm;

  @override
  ConsumerState<RingScreen> createState() => _RingScreenState();
}

enum _Stage { ringing, sum, shake, awaitingUp, done }

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
  final _openedAt = DateTime.now();
  Timer? _second;
  int? _checkId;
  late final (int, int) _sum = (Random().nextInt(60) + 12, Random().nextInt(30) + 7);
  String? _sumError;
  ShakeDetector? _shakes;
  var _shaken = 0;
  static const shakesToStop = 30;

  /// The task on screen is for snoozing, not stopping.
  var _forSnooze = false;
  void _taskDone() => _forSnooze ? _snoozeNow() : _stopNow();

  @override
  void initState() {
    super.initState();
    if (p.spoken) {
      _speakTimer = Timer(const Duration(seconds: 2), _speak);
    }
    _second = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
    if (p.snoozeBy.contains(StopWay.shake) || p.stopBy.contains(StopWay.shake) || p.shakeTask) {
      _shakes = ShakeDetector(onShake: _onShake)..start();
    }
    HardwareKeyboard.instance.addHandler(_onKey);
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

  /// Volume buttons snooze or stop, when this alarm says so.
  bool _onKey(KeyEvent e) {
    if (e is! KeyDownEvent) return false;
    final k = e.logicalKey;
    if (k != LogicalKeyboardKey.audioVolumeUp && k != LogicalKeyboardKey.audioVolumeDown) return false;
    if (_stage != _Stage.ringing || p.isCheck) return false;
    if (p.stopBy.contains(StopWay.volumeKeys)) {
      _onStop();
      return true;
    }
    if (p.snoozeBy.contains(StopWay.volumeKeys) && p.canSnooze) {
      _onSnooze();
      return true;
    }
    return false;
  }

  void _onShake() {
    if (!mounted) return;
    if (_stage == _Stage.shake) {
      setState(() => _shaken++);
      if (_shaken >= shakesToStop) _taskDone();
      return;
    }
    if (_stage != _Stage.ringing || p.isCheck) return;
    if (p.stopBy.contains(StopWay.shake)) {
      _onStop();
    } else if (p.snoozeBy.contains(StopWay.shake) && p.canSnooze) {
      _onSnooze();
    }
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    _shakes?.stop();
    _speakTimer?.cancel();
    _second?.cancel();
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
    _forSnooze = false;
    if (p.mathTask && _stage == _Stage.ringing) {
      setState(() => _stage = _Stage.sum);
      return;
    }
    if (p.shakeTask && _stage == _Stage.ringing) {
      setState(() => _stage = _Stage.shake);
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
      _openLink();
    }
  }

  void _checkSum() {
    final (a, b) = _sum;
    if (int.tryParse(_answer.text.trim()) == a + b) {
      _taskDone();
    } else {
      setState(() => _sumError = 'Not quite. Try again.');
      _answer.clear();
    }
  }

  Future<void> _onSnooze() async {
    if (_stage == _Stage.ringing && p.snoozeTask != StopTask.none) {
      setState(() {
        _forSnooze = true;
        _stage = p.snoozeTask == StopTask.sum ? _Stage.sum : _Stage.shake;
      });
      return;
    }
    await _snoozeNow();
  }

  Future<void> _snoozeNow() async {
    _tts.stop();
    await ref.read(registrarProvider).snooze(widget.alarm);
    _close();
  }

  Future<void> _onUp() async {
    if (_checkId != null) await ref.read(registrarProvider).cancel(_checkId!);
    _close();
    _openLink();
  }

  /// The song or playlist from Spotify, SoundCloud… that this alarm plays.
  Future<void> _openLink() async {
    final link = p.link;
    if (AppLink.isApp(link)) {
      await Apps.launch(AppLink.package(link!));
      return;
    }
    final uri = link == null ? null : Uri.tryParse(link);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // No app for it: the alarm has already done its job.
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final now = DateTime.now();
    final snoozesLeft = p.maxSnoozes - p.snoozeCount;
    const ink = QuandoColors.ground;
    final left = p.ringSeconds - now.difference(_openedAt).inSeconds;

    return PopScope(
      canPop: _stage == _Stage.done,
      child: Scaffold(
        backgroundColor: QuandoColors.coral,
        body: DefaultTextStyle.merge(
          style: const TextStyle(color: ink),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(dayLabel(now).toUpperCase(), style: text.labelSmall?.copyWith(color: ink)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      hhmm(now),
                      style: text.displayLarge?.copyWith(color: ink, fontSize: 128, letterSpacing: -7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(p.title, style: text.headlineMedium?.copyWith(color: ink)),
                  const SizedBox(height: 6),
                  Text(p.body, style: text.titleMedium?.copyWith(color: ink)),
                  const SizedBox(height: 10),
                  Text(
                    'If not now, when?',
                    style: text.bodyLarge?.copyWith(color: ink, fontStyle: FontStyle.italic),
                  ),
                  if (p.shabbatSafe) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Shabbat mode: this stops by itself in ${p.ringSeconds} seconds. No need to touch the phone.',
                      style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
                    ),
                  ],
                  Expanded(
                    child: _stage == _Stage.ringing && p.ringSeconds > 0 && left > 0
                        ? Center(
                            child: _RingLeft(left: left, total: p.ringSeconds),
                          )
                        : const SizedBox.shrink(),
                  ),
                  ..._actions(text, snoozesLeft),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(TextTheme text, int snoozesLeft) {
    const ink = QuandoColors.ground;
    switch (_stage) {
      case _Stage.sum:
        final (a, b) = _sum;
        return [
          Text(
            _forSnooze ? 'SOLVE TO SNOOZE' : 'SOLVE TO STOP',
            style: text.labelSmall?.copyWith(color: ink),
          ),
          const SizedBox(height: 8),
          Text('$a + $b = ?', style: text.displaySmall?.copyWith(color: ink)),
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
          _StopButton(label: _forSnooze ? 'Snooze' : 'Stop', onPressed: _checkSum),
        ];
      case _Stage.shake:
        return [
          Text(
            _forSnooze ? 'SHAKE TO SNOOZE' : 'SHAKE TO STOP',
            style: text.labelSmall?.copyWith(color: ink),
          ),
          const SizedBox(height: 8),
          Text('$_shaken / $shakesToStop', style: text.displaySmall?.copyWith(color: ink)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _shaken / shakesToStop,
              minHeight: 14,
              color: ink,
              backgroundColor: ink.withValues(alpha: 0.15),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Shake the phone hard until the bar fills.',
            style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
          ),
          // A phone without a motion sensor must still be able to stop.
          TextButton(
            onPressed: () => setState(() => _stage = _Stage.sum),
            style: TextButton.styleFrom(foregroundColor: ink),
            child: const Text('Can\'t shake? Solve a sum instead'),
          ),
        ];
      case _Stage.awaitingUp:
        return [
          Text(
            'I\'ll ring again in ${AlarmRegistrar.checkDelay.inMinutes} minutes unless you tap below.',
            style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _StopButton(label: 'I\'m up', onPressed: _onUp),
        ];
      case _Stage.ringing:
      case _Stage.done:
        return [
          if (!p.isCheck && p.canSnooze) ...[
            SizedBox(
              height: 64,
              child: OutlinedButton(
                onPressed: _onSnooze,
                style: OutlinedButton.styleFrom(
                  foregroundColor: ink,
                  side: const BorderSide(color: ink, width: 2.5),
                ),
                child: Text(
                  p.maxSnoozes >= SnoozePlan.unlimited
                      ? 'Snooze ${p.snoozeMinutes} min'
                      : 'Snooze ${p.snoozeMinutes} min · $snoozesLeft left',
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (!p.isCheck && !p.canSnooze && p.maxSnoozes > 0) ...[
            Text(
              'No snoozes left',
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
          ],
          if (p.isCheck)
            _StopButton(label: 'I\'m up', onPressed: _stopNow)
          else
            _StopButton(label: p.link == null ? 'Stop' : 'Stop · then open', onPressed: _onStop),
          if (!p.isCheck && _hints.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              _hints.join(' · '),
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: ink, fontWeight: FontWeight.w600),
            ),
          ],
        ];
    }
  }
}

extension on _RingScreenState {
  /// "Volume buttons stop · shake to snooze".
  List<String> get _hints => [
    for (final w in StopWay.values)
      if (p.stopBy.contains(w))
        '${w.label} to stop'
      else if (p.snoozeBy.contains(w) && p.canSnooze)
        '${w.label} to snooze',
  ];
}

/// The big plum Stop button with its amber arrow.
class _StopButton extends StatelessWidget {
  const _StopButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: QuandoColors.ground,
          foregroundColor: QuandoColors.text,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          textStyle: const TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w800, fontSize: 22),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(color: QuandoColors.amber, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward, color: QuandoColors.ground, size: 28),
            ),
            Expanded(child: Text(label, textAlign: TextAlign.center)),
            const SizedBox(width: 60),
          ],
        ),
      ),
    );
  }
}

/// How long the alarm keeps ringing, as a shrinking ring.
class _RingLeft extends StatelessWidget {
  const _RingLeft({required this.left, required this.total});

  final int left;
  final int total;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final m = left ~/ 60;
    final s = (left % 60).toString().padLeft(2, '0');
    return Semantics(
      label: 'Rings for $left more seconds',
      child: SizedBox.square(
        dimension: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(color: QuandoColors.amber, shape: BoxShape.circle),
            ),
            SizedBox.square(
              dimension: 170,
              child: CircularProgressIndicator(
                value: left / total,
                strokeWidth: 8,
                strokeCap: StrokeCap.round,
                color: QuandoColors.ground,
                backgroundColor: QuandoColors.ground.withValues(alpha: 0.15),
              ),
            ),
            ExcludeSemantics(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$m:$s', style: text.headlineMedium?.copyWith(color: QuandoColors.ground, height: 1)),
                  Text(
                    'left to ring',
                    style: text.bodySmall?.copyWith(color: QuandoColors.ground, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
