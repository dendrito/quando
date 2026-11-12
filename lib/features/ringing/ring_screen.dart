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
import '../settings/domain/ui_level.dart';
import '../sounds/ui/sound_player.dart';
import 'data/apps.dart';
import 'data/music.dart';
import 'data/embedded_music.dart';
import 'ui/embedded_music_player.dart';
import 'ring_payload.dart';
import 'ring_style.dart';
import 'shake_detector.dart';
import 'ui/tasks.dart';

import 'package:quando/l10n/l10n.dart';

/// Full screen shown while an alarm rings: what it is for, Stop, Snooze,
/// and the optional sum or wake-up check.
class RingScreen extends ConsumerStatefulWidget {
  const RingScreen({super.key, required this.alarm});

  final AlarmSettings alarm;

  @override
  ConsumerState<RingScreen> createState() => _RingScreenState();
}

enum _Stage { ringing, sum, shake, puzzle, awaitingUp, done }

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
  var _resolving = false;
  final _openedAt = DateTime.now();

  /// Which ring of the app's life this is. The hint line is for the first
  /// few only.
  static const hintRings = 3;
  var _ringNo = 1;
  Timer? _second;
  int? _checkId;
  late final (int, int) _sum = (Random().nextInt(60) + 12, Random().nextInt(30) + 7);
  String? _sumError;
  ShakeDetector? _shakes;
  var _shaken = 0;
  static const shakesToStop = 30;

  /// The task on screen is for snoozing, not stopping.
  var _forSnooze = false;

  /// The memory game, phrase or scan on screen.
  var _puzzle = StopTask.none;

  /// Shows the task for [t] on screen.
  void _startTask(StopTask t) => setState(() {
    if (t.isPuzzle) _puzzle = t;
    _stage = switch (t) {
      StopTask.sum => _Stage.sum,
      StopTask.shake => _Stage.shake,
      _ => _Stage.puzzle,
    };
    if (t == StopTask.shake && _shakes == null) _shakes = ShakeDetector(onShake: _onShake)..start();
  });
  void _taskDone() => _forSnooze ? _snoozeNow() : _stopNow();

  @override
  void initState() {
    super.initState();
    if (!p.isCheck && !p.gentle && !p.isLock) {
      // A counter must never keep an alarm from showing.
      try {
        final prefs = ref.read(prefsProvider);
        _ringNo = (prefs.getInt(UiLevelStore.ringsKey) ?? 0) + 1;
        prefs.setInt(UiLevelStore.ringsKey, _ringNo);
      } catch (_) {}
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(SoundPreview.instance.stop());
      unawaited(Music.stopPreview());
    });
    if (p.localAudio && p.spoken) {
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
      if (!stillRinging && !_resolving && _stage == _Stage.ringing) _close();
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
    if (!mounted || _stage == _Stage.done) return;
    final route = ModalRoute.of(context);
    if (route == null || !route.isActive) return;
    _stage = _Stage.done;
    // An overlapping alarm may be above this one. Remove this card, never
    // another alarm's card: leaving this one marked done makes Stop inert.
    if (route.isCurrent) {
      Navigator.of(context).pop();
    } else {
      route.navigator?.removeRoute(route);
    }
  }

  Future<void> _onStop() async {
    _forSnooze = false;
    if (_stage == _Stage.ringing) {
      final t = p.puzzle != StopTask.none
          ? p.puzzle
          : (p.mathTask ? StopTask.sum : (p.shakeTask ? StopTask.shake : StopTask.none));
      if (t != StopTask.none) return _startTask(t);
    }
    await _stopNow();
  }

  Future<void> _stopNow() async {
    if (!mounted || _stage == _Stage.done || _resolving) return;
    _resolving = true;
    try {
      _speakTimer?.cancel();
      _tts.stop();
      // Stopped before the song took over: stop the song too.
      if (p.song != null) unawaited(Music.pause(alarmId: widget.alarm.id));
      final registrar = ref.read(registrarProvider);
      // The stopped stream event must not close this card before we know
      // whether it needs to show the wake-up confirmation.
      final checkId = await registrar.stop(widget.alarm);
      if (!mounted) return;
      if (checkId != null) {
        setState(() {
          _checkId = checkId;
          _stage = _Stage.awaitingUp;
        });
      } else {
        _close();
        _openLink();
      }
    } finally {
      _resolving = false;
    }
  }

  void _checkSum() {
    final (a, b) = _sum;
    if (int.tryParse(_answer.text.trim()) == a + b) {
      _taskDone();
    } else {
      setState(() => _sumError = l10n.notQuite);
      _answer.clear();
    }
  }

  Future<void> _onSnooze() async {
    if (_stage == _Stage.ringing && p.snoozeTask != StopTask.none) {
      _forSnooze = true;
      return _startTask(p.snoozeTask);
    }
    await _snoozeNow();
  }

  Future<void> _snoozeNow() async {
    if (!mounted || _stage == _Stage.done || _resolving) return;
    _resolving = true;
    try {
      _speakTimer?.cancel();
      _tts.stop();
      if (p.song != null) unawaited(Music.pause(alarmId: widget.alarm.id));
      await ref.read(registrarProvider).snooze(widget.alarm);
      _close();
    } finally {
      _resolving = false;
    }
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
    if (p.songSeconds > 0) {
      // A song link with a play length: play it, then pause it in time.
      unawaited(Music.start(link!, playFor: Duration(seconds: p.songSeconds)));
      return;
    }
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
    final embedded = p.localAudio && !p.shabbatSafe && !p.gentle && !p.isLock
        ? EmbeddedMusic.parse(p.song)
        : null;

    return PopScope(
      canPop: _stage == _Stage.done,
      child: Scaffold(
        backgroundColor: QuandoColors.coral,
        body: DefaultTextStyle.merge(
          style: const TextStyle(color: ink),
          child: SafeArea(
            // Scrolls only when a task and the keyboard need more room.
            child: LayoutBuilder(
              builder: (context, box) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: box.maxHeight),
                  child: IntrinsicHeight(
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
                              style: text.displayLarge?.copyWith(
                                color: ink,
                                fontSize: _stage == _Stage.ringing ? 128 : 64,
                                letterSpacing: _stage == _Stage.ringing ? -7 : -3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(p.title, style: text.headlineMedium?.copyWith(color: ink)),
                          const SizedBox(height: 6),
                          // "When this rings, I will…" stands in for the
                          // repeat details.
                          if (p.iWill.isNotEmpty)
                            Text(
                              p.iWill,
                              key: const Key('ringIWill'),
                              style: text.titleLarge?.copyWith(color: ink, fontWeight: FontWeight.w800),
                            )
                          else
                            Text(p.body, style: text.titleMedium?.copyWith(color: ink)),
                          const SizedBox(height: 10),
                          if (_stage == _Stage.ringing)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: l10n.ringQuote),
                                  TextSpan(
                                    text: '  — ${l10n.ringQuoteBy}',
                                    style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 12),
                                  ),
                                ],
                              ),
                              style: text.bodyMedium?.copyWith(
                                color: ink.withValues(alpha: 0.7),
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          if (p.shabbatSafe) ...[
                            const SizedBox(height: 16),
                            Text(
                              l10n.shabbatStopsItself(p.ringSeconds),
                              style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
                            ),
                          ],
                          if (embedded != null && _stage != _Stage.awaitingUp && _stage != _Stage.done) ...[
                            const SizedBox(height: 16),
                            EmbeddedMusicPlayer(
                              source: embedded,
                              alarmId: widget.alarm.id,
                              deadline: _openedAt.add(Duration(seconds: p.ringSeconds)),
                              active: ModalRoute.isCurrentOf(context) == true && !_resolving,
                            ),
                          ],
                          Expanded(
                            // Tapping the middle of the screen is the same
                            // as pressing Stop: any task or wake-up check
                            // still comes first.
                            child: GestureDetector(
                              key: const Key('ringCentre'),
                              behavior: HitTestBehavior.opaque,
                              onTap: _stage == _Stage.ringing ? (p.isCheck ? _stopNow : _onStop) : null,
                              child: _stage == _Stage.ringing && p.ringSeconds > 0 && left > 0
                                  ? Center(
                                      child: _RingLeft(left: left, total: p.ringSeconds),
                                    )
                                  : const SizedBox.expand(),
                            ),
                          ),
                          ..._actions(text, snoozesLeft),
                        ],
                      ),
                    ),
                  ),
                ),
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
            _forSnooze ? l10n.solveToSnooze : l10n.solveToStop,
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
            decoration: InputDecoration(errorText: _sumError, hintText: l10n.answer),
            onSubmitted: (_) => _checkSum(),
          ),
          const SizedBox(height: 16),
          _StopButton(label: _forSnooze ? l10n.snooze : l10n.stop, onPressed: _checkSum),
        ];
      case _Stage.shake:
        return [
          Text(
            _forSnooze ? l10n.shakeToSnooze : l10n.shakeToStop,
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
            l10n.shakeHard,
            style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
          ),
          // A phone without a motion sensor must still be able to stop.
          TextButton(
            onPressed: () => setState(() => _stage = _Stage.sum),
            style: TextButton.styleFrom(foregroundColor: ink),
            child: Text(l10n.cantShake),
          ),
        ];
      case _Stage.puzzle:
        return [
          Text(switch (_puzzle) {
            StopTask.memory => _forSnooze ? l10n.pairsToSnooze : l10n.pairsToStop,
            StopTask.phrase => _forSnooze ? l10n.typeToSnooze : l10n.typeToStop,
            _ => _forSnooze ? l10n.scanToSnooze : l10n.scanToStop,
          }, style: text.labelSmall?.copyWith(color: ink)),
          const SizedBox(height: 10),
          switch (_puzzle) {
            StopTask.memory => MemoryTask(onDone: _taskDone),
            StopTask.phrase => PhraseTask(onDone: _taskDone),
            _ => ScanTask(
              code: p.scanCode ?? '',
              onDone: _taskDone,
              onGiveUp: () => setState(() => _stage = _Stage.sum),
            ),
          },
        ];
      case _Stage.awaitingUp:
        return [
          Text(
            l10n.ringAgainUnless(AlarmRegistrar.checkDelay.inMinutes),
            style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _StopButton(label: l10n.imUp, onPressed: _onUp),
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
                      ? l10n.snoozeMin(p.snoozeMinutes)
                      : l10n.snoozeMinLeft(p.snoozeMinutes, snoozesLeft),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (!p.isCheck && !p.canSnooze && p.maxSnoozes > 0) ...[
            Text(
              l10n.noSnoozesLeft,
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(color: ink, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
          ],
          if (p.isCheck)
            _StopButton(label: l10n.imUp, onPressed: _stopNow)
          else
            _StopButton(label: p.link == null ? l10n.stop : l10n.stopThenOpen, onPressed: _onStop),
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
    if (p.song != null) l10n.startingSong,
    // Only the first few rings of the app; after that it knows.
    if (_ringNo <= _RingScreenState.hintRings) ...[
      l10n.tapMiddleToStop,
      for (final w in StopWay.values)
        if (p.stopBy.contains(w))
          l10n.wayToStop(w.label)
        else if (p.snoozeBy.contains(w) && p.canSnooze)
          l10n.wayToSnooze(w.label),
    ],
  ];
}

/// The big plum Stop button with its amber arrow. Tap anywhere on it, or
/// slide the arrow along it: past [fireAt] of the way counts as a press,
/// once per slide; let go sooner and it springs back. Mirrored in
/// right-to-left languages.
class _StopButton extends StatefulWidget {
  const _StopButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  static const fireAt = 0.7;

  @override
  State<_StopButton> createState() => _StopButtonState();
}

class _StopButtonState extends State<_StopButton> {
  static const _knob = 60.0;
  static const _pad = 8.0;

  /// How far the arrow has slid, in logical pixels from its start.
  double _offset = 0;
  bool _dragging = false;
  bool _fired = false;

  void _start(DragStartDetails _) => setState(() {
    _dragging = true;
    _fired = false;
  });

  void _update(DragUpdateDetails d, double track, bool rtl) {
    final dx = rtl ? -d.delta.dx : d.delta.dx;
    setState(() => _offset = (_offset + dx).clamp(0.0, track));
    if (!_fired && track > 0 && _offset >= track * _StopButton.fireAt) {
      _fired = true;
      HapticFeedback.mediumImpact();
      widget.onPressed();
    }
  }

  void _end() {
    if (!mounted) return;
    setState(() {
      _dragging = false;
      _offset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox(
      height: 76,
      child: FilledButton(
        onPressed: widget.onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: QuandoColors.ground,
          foregroundColor: QuandoColors.text,
          padding: const EdgeInsets.symmetric(horizontal: _pad),
          textStyle: const TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w800, fontSize: 22),
        ),
        child: LayoutBuilder(
          builder: (context, c) {
            final track = (c.maxWidth - _knob).clamp(0.0, double.infinity);
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _knob),
                  child: Opacity(
                    // The label fades as the arrow slides over it.
                    opacity: track == 0 ? 1 : (1 - _offset / track).clamp(0.2, 1.0),
                    child: Text(widget.label, textAlign: TextAlign.center),
                  ),
                ),
                AnimatedPositionedDirectional(
                  duration: _dragging ? Duration.zero : const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  start: _offset,
                  top: 0,
                  bottom: 0,
                  child: ExcludeSemantics(
                    child: GestureDetector(
                      key: const Key('stopArrow'),
                      behavior: HitTestBehavior.opaque,
                      onHorizontalDragStart: _start,
                      onHorizontalDragUpdate: (d) => _update(d, track, rtl),
                      onHorizontalDragEnd: (_) => _end(),
                      onHorizontalDragCancel: _end,
                      child: Center(
                        child: Container(
                          width: _knob,
                          height: _knob,
                          decoration: const BoxDecoration(color: QuandoColors.amber, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_forward, color: QuandoColors.ground, size: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
      label: l10n.ringsForMore(left),
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
                    l10n.leftToRing,
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
