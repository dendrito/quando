import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

/// A clock that can be paused. The time comes from [now] (milliseconds), so
/// tests can drive it.
class PausableClock {
  PausableClock(this.now);
  final int Function() now;
  int _base = 0;
  int? _startedAt;

  bool get running => _startedAt != null;
  int get elapsedMs => _base + (_startedAt == null ? 0 : now() - _startedAt!);

  void start() => _startedAt ??= now();

  void pause() {
    final at = _startedAt;
    if (at == null) return;
    _base += now() - at;
    _startedAt = null;
  }

  void reset() {
    _base = 0;
    _startedAt = null;
  }

  /// Moves the clock to [ms] (keeps running if it was).
  void seek(int ms) {
    _base = ms;
    if (_startedAt != null) _startedAt = now();
  }
}

int _wallMs() => DateTime.now().millisecondsSinceEpoch;

/// Drives a [ChangeNotifier] on a steady beat while something runs.
mixin Beat on ChangeNotifier {
  Timer? _beat;
  bool _gone = false;

  /// Called on every beat while running.
  void onBeat();

  void startBeat([Duration every = const Duration(milliseconds: 40)]) {
    _beat ??= Timer.periodic(every, (_) {
      onBeat();
      notifyListeners();
    });
  }

  void stopBeat() {
    _beat?.cancel();
    _beat = null;
  }

  @override
  void dispose() {
    _gone = true;
    stopBeat();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_gone) super.notifyListeners();
  }
}

/// Count up, with laps.
class StopwatchModel extends ChangeNotifier with Beat {
  StopwatchModel([int Function()? now]) : clock = PausableClock(now ?? _wallMs);
  final PausableClock clock;

  /// Each lap: the total time when it was taken, newest first.
  final laps = <int>[];

  bool get running => clock.running;
  int get elapsedMs => clock.elapsedMs;
  bool get untouched => !running && elapsedMs == 0;

  void start() {
    clock.start();
    startBeat();
    notifyListeners();
  }

  void pause() {
    clock.pause();
    stopBeat();
    notifyListeners();
  }

  void lap() {
    if (!running) return;
    laps.insert(0, elapsedMs);
    notifyListeners();
  }

  void reset() {
    clock.reset();
    laps.clear();
    stopBeat();
    notifyListeners();
  }

  /// How long lap [i] (an index into [laps]) took.
  int lapLength(int i) => laps[i] - (i + 1 < laps.length ? laps[i + 1] : 0);

  @override
  void onBeat() {}
}

/// Count down from a length you choose; rings at zero.
class CountdownModel extends ChangeNotifier with Beat {
  CountdownModel([int Function()? now]) : clock = PausableClock(now ?? _wallMs);
  final PausableClock clock;

  Duration length = const Duration(minutes: 5);

  /// Set by the app: rings (or speaks) when the time is up.
  void Function()? onFinish;

  /// Set by the app: schedules or cancels the phone's own alarm for the end,
  /// so it still rings with the app closed. Null cancels.
  void Function(DateTime? endsAt)? onSchedule;

  bool _finished = false;

  bool get running => clock.running;
  bool get finished => _finished;
  bool get untouched => !running && clock.elapsedMs == 0 && !_finished;
  Duration get remaining {
    final left = length.inMilliseconds - clock.elapsedMs;
    return Duration(milliseconds: left < 0 ? 0 : left);
  }

  /// 1 at the start, 0 at the end.
  double get fraction => length.inMilliseconds == 0 ? 0 : remaining.inMilliseconds / length.inMilliseconds;

  void setLength(Duration d) {
    if (running || d.isNegative) return;
    length = d;
    clock.reset();
    _finished = false;
    notifyListeners();
  }

  void start() {
    if (remaining == Duration.zero) return;
    _finished = false;
    clock.start();
    startBeat(const Duration(milliseconds: 100));
    onSchedule?.call(DateTime.now().add(remaining));
    notifyListeners();
  }

  void pause() {
    clock.pause();
    stopBeat();
    onSchedule?.call(null);
    notifyListeners();
  }

  void reset() {
    clock.reset();
    _finished = false;
    stopBeat();
    onSchedule?.call(null);
    notifyListeners();
  }

  @override
  void onBeat() {
    if (running && remaining == Duration.zero) {
      clock.pause();
      stopBeat();
      _finished = true;
      onFinish?.call();
    }
  }
}

/// A spoken or shown moment in a [SequenceConfig], in milliseconds from the
/// start (Go): negative before it.
class SequenceCue {
  const SequenceCue(this.ms, this.text, {this.kind = CueKind.mark});
  final int ms;
  final String text;
  final CueKind kind;
}

enum CueKind { call, go, mark, tick, count, finish }

/// "On your marks... get set... go", with what to say and when set by you.
class SequenceConfig {
  const SequenceConfig({
    required this.calls,
    required this.goText,
    required this.finishText,
    this.lengthSeconds = 0,
    this.sayEvery = 0,
    this.finalCount = 0,
    this.marks = const [],
    this.speak = true,
    this.beeps = true,
    this.sayRemaining = true,
  });

  /// Said before Go: [secondsBefore] seconds ahead.
  final List<({int secondsBefore, String text})> calls;
  final String goText;
  final String finishText;

  /// 0 = no limit: counts up after Go until stopped.
  final int lengthSeconds;

  /// Say the time every this many seconds (0 = never).
  final int sayEvery;

  /// Count each of the last this many seconds aloud (0 = never).
  final int finalCount;

  /// Your own words at moments after Go.
  final List<({int atSeconds, String text})> marks;
  final bool speak;
  final bool beeps;

  /// With a length: say the time left (true) or the time passed (false).
  final bool sayRemaining;

  /// How long before Go the first call is.
  int get leadMs => calls.fold(0, (a, c) => c.secondsBefore * 1000 > a ? c.secondsBefore * 1000 : a);

  SequenceConfig copyWith({
    List<({int secondsBefore, String text})>? calls,
    String? goText,
    String? finishText,
    int? lengthSeconds,
    int? sayEvery,
    int? finalCount,
    List<({int atSeconds, String text})>? marks,
    bool? speak,
    bool? beeps,
    bool? sayRemaining,
  }) => SequenceConfig(
    calls: calls ?? this.calls,
    goText: goText ?? this.goText,
    finishText: finishText ?? this.finishText,
    lengthSeconds: lengthSeconds ?? this.lengthSeconds,
    sayEvery: sayEvery ?? this.sayEvery,
    finalCount: finalCount ?? this.finalCount,
    marks: marks ?? this.marks,
    speak: speak ?? this.speak,
    beeps: beeps ?? this.beeps,
    sayRemaining: sayRemaining ?? this.sayRemaining,
  );

  String encode() => jsonEncode({
    'calls': [
      for (final c in calls) {'s': c.secondsBefore, 't': c.text},
    ],
    'go': goText,
    'finish': finishText,
    'length': lengthSeconds,
    'every': sayEvery,
    'final': finalCount,
    'marks': [
      for (final m in marks) {'s': m.atSeconds, 't': m.text},
    ],
    'speak': speak,
    'beeps': beeps,
    'remaining': sayRemaining,
  });

  static SequenceConfig? decode(String? raw) {
    if (raw == null) return null;
    try {
      final j = jsonDecode(raw) as Map<String, dynamic>;
      return SequenceConfig(
        calls: [
          for (final c in (j['calls'] as List? ?? const []))
            (secondsBefore: (c as Map)['s'] as int, text: c['t'] as String),
        ],
        goText: j['go'] as String? ?? '',
        finishText: j['finish'] as String? ?? '',
        lengthSeconds: j['length'] as int? ?? 0,
        sayEvery: j['every'] as int? ?? 0,
        finalCount: j['final'] as int? ?? 0,
        marks: [
          for (final m in (j['marks'] as List? ?? const []))
            (atSeconds: (m as Map)['s'] as int, text: m['t'] as String),
        ],
        speak: j['speak'] as bool? ?? true,
        beeps: j['beeps'] as bool? ?? true,
        sayRemaining: j['remaining'] as bool? ?? true,
      );
    } catch (_) {
      return null;
    }
  }
}

/// The longest stretch spoken every N seconds when there is no length.
const _openEndedSeconds = 3 * 3600;

/// Everything said and when, in order. [say] turns a number of seconds into
/// words ("1 minute 30 seconds"). When two things land on the same moment
/// the more specific one wins: your own mark, then the calls and Go, then the
/// end, the final count and the regular time.
List<SequenceCue> sequenceCues(SequenceConfig c, String Function(int seconds) say) {
  final byMs = <int, SequenceCue>{};
  void put(SequenceCue cue) => byMs.putIfAbsent(cue.ms, () => cue);
  final end = c.lengthSeconds;

  for (final m in c.marks) {
    if (m.atSeconds < 0 || (end > 0 && m.atSeconds > end) || m.text.trim().isEmpty) continue;
    put(SequenceCue(m.atSeconds * 1000, m.text.trim()));
  }
  for (final call in c.calls) {
    if (call.secondsBefore <= 0 || call.text.trim().isEmpty) continue;
    put(SequenceCue(-call.secondsBefore * 1000, call.text.trim(), kind: CueKind.call));
  }
  put(SequenceCue(0, c.goText.trim(), kind: CueKind.go));
  if (end > 0) {
    put(SequenceCue(end * 1000, c.finishText.trim(), kind: CueKind.finish));
    for (var s = c.finalCount; s >= 1; s--) {
      if (end - s <= 0) continue;
      put(SequenceCue((end - s) * 1000, '$s', kind: CueKind.count));
    }
  }
  if (c.sayEvery > 0) {
    final last = end > 0 ? end : _openEndedSeconds;
    for (var t = c.sayEvery; t < last; t += c.sayEvery) {
      final inFinal = end > 0 && c.finalCount > 0 && end - t <= c.finalCount;
      if (inFinal) continue;
      put(SequenceCue(t * 1000, say(end > 0 && c.sayRemaining ? end - t : t), kind: CueKind.tick));
    }
  }
  return byMs.values.toList()..sort((a, b) => a.ms.compareTo(b.ms));
}

/// Where a [SequenceRunner] is.
enum SequencePhase { ready, running, paused, done }

/// Runs a sequence: tells [onCue] about each moment as it comes. Time before
/// Go is negative.
class SequenceRunner extends ChangeNotifier with Beat {
  SequenceRunner({int Function()? now, required this.say}) : clock = PausableClock(now ?? _wallMs);
  final PausableClock clock;
  final String Function(int seconds) say;

  SequenceConfig? _config;
  var _cues = <SequenceCue>[];
  var _next = 0;
  SequencePhase phase = SequencePhase.ready;

  /// The last thing said or shown, for the big text.
  SequenceCue? lastCue;

  /// Set by the app: speaks, beeps and vibrates.
  void Function(SequenceCue cue, SequenceConfig config)? onCue;

  SequenceConfig? get config => _config;

  /// Milliseconds since Go: negative while the calls are being made.
  int get positionMs => clock.elapsedMs - (_config?.leadMs ?? 0);

  /// With a length: milliseconds left until the end (null otherwise).
  int? get leftMs {
    final c = _config;
    if (c == null || c.lengthSeconds == 0) return null;
    final left = c.lengthSeconds * 1000 - positionMs;
    return left < 0 ? 0 : left;
  }

  void start(SequenceConfig config) {
    if (phase == SequencePhase.running) return;
    if (phase == SequencePhase.ready || phase == SequencePhase.done) {
      _config = config;
      _cues = sequenceCues(config, say);
      clock.reset();
      _next = 0;
      lastCue = null;
    }
    phase = SequencePhase.running;
    clock.start();
    // Fire what is due right away (the first call may be at the very start).
    onBeat();
    startBeat(const Duration(milliseconds: 25));
    notifyListeners();
  }

  void pause() {
    if (phase != SequencePhase.running) return;
    clock.pause();
    stopBeat();
    phase = SequencePhase.paused;
    notifyListeners();
  }

  void reset() {
    clock.reset();
    stopBeat();
    phase = SequencePhase.ready;
    lastCue = null;
    _next = 0;
    notifyListeners();
  }

  @override
  void onBeat() {
    final c = _config;
    if (c == null || phase != SequencePhase.running) return;
    final pos = positionMs;
    while (_next < _cues.length && _cues[_next].ms <= pos) {
      final cue = _cues[_next++];
      // A cue far behind (the app was busy) is skipped, not blurted out late.
      if (pos - cue.ms > 1500 && cue.kind != CueKind.finish) continue;
      lastCue = cue;
      onCue?.call(cue, c);
    }
    if (c.lengthSeconds > 0 && pos >= c.lengthSeconds * 1000) {
      clock.pause();
      stopBeat();
      phase = SequencePhase.done;
    }
  }
}
