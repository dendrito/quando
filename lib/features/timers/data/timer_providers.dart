import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';
import '../../../core/util/format.dart';
import '../../../core/util/platform.dart';
import '../../ringing/ring_payload.dart';
import '../domain/timers.dart';

/// Speaks the timers' words, in the language in use.
class TimerVoice {
  final _tts = FlutterTts();
  bool _ready = false;

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    try {
      if (!_ready) {
        _ready = true;
        await _tts.setSpeechRate(0.5);
        await _tts.setLanguage(currentLocale.toLanguageTag());
      }
      await _tts.speak(text);
    } catch (_) {
      // No voice on this device: the beeps and the screen still work.
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}

final timerVoiceProvider = Provider<TimerVoice>((ref) {
  final v = TimerVoice();
  ref.onDispose(v.stop);
  return v;
});

/// The stopwatch lives here, so it keeps running when you leave the screen.
final stopwatchProvider = Provider<StopwatchModel>((ref) {
  final m = StopwatchModel();
  ref.onDispose(m.dispose);
  return m;
});

/// The id of the phone alarm that rings when the countdown ends.
final _countdownAlarmId = stableId('timers.countdown');

final countdownProvider = Provider<CountdownModel>((ref) {
  final m = CountdownModel();
  final voice = ref.read(timerVoiceProvider);
  m.onSchedule = (endsAt) async {
    if (!supportsLocalAlarms) return;
    try {
      final registrar = ref.read(registrarProvider);
      if (endsAt == null) {
        await registrar.cancel(_countdownAlarmId);
      } else {
        await registrar.set(
          _countdownAlarmId,
          endsAt,
          RingPayload(title: l10n.timerCountdown, body: l10n.timerTimesUp, ringSeconds: 60, transient: true),
        );
      }
    } catch (_) {
      // Without a phone alarm it still shows and speaks at zero.
    }
  };
  m.onFinish = () {
    // With the phone's alarm available it rings by itself.
    if (supportsLocalAlarms) return;
    voice.speak(l10n.timerTimesUp);
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
  };
  ref.onDispose(m.dispose);
  return m;
});

/// What the start sequence says, kept between launches.
class SequenceConfigNotifier extends Notifier<SequenceConfig> {
  static const _key = 'timers.sequence';

  @override
  SequenceConfig build() => SequenceConfig.decode(ref.read(prefsProvider).getString(_key)) ?? racePreset();

  Future<void> set(SequenceConfig value) async {
    state = value;
    await ref.read(prefsProvider).setString(_key, value.encode());
  }
}

final sequenceConfigProvider = NotifierProvider<SequenceConfigNotifier, SequenceConfig>(
  SequenceConfigNotifier.new,
);

/// "On your marks, get set, go": the classic start, no length.
SequenceConfig racePreset() => SequenceConfig(
  calls: [(secondsBefore: 6, text: l10n.seqOnYourMarks), (secondsBefore: 3, text: l10n.seqGetSet)],
  goText: l10n.seqGo,
  finishText: l10n.seqFinish,
  sayEvery: 10,
);

/// A 30 second effort: 3, 2, 1, go, the time left every 10 s, the last 5
/// counted down.
SequenceConfig sprintPreset() => SequenceConfig(
  calls: [(secondsBefore: 3, text: l10n.seqGetSet)],
  goText: l10n.seqGo,
  finishText: l10n.seqFinish,
  lengthSeconds: 30,
  sayEvery: 10,
  finalCount: 5,
);

/// A 1 minute round with a halfway mark.
SequenceConfig roundPreset() => SequenceConfig(
  calls: [(secondsBefore: 5, text: l10n.seqGetSet)],
  goText: l10n.seqGo,
  finishText: l10n.seqFinish,
  lengthSeconds: 60,
  sayEvery: 15,
  finalCount: 3,
);

String _say(int seconds) => formatSpan(Duration(seconds: seconds));

final sequenceRunnerProvider = Provider<SequenceRunner>((ref) {
  final voice = ref.read(timerVoiceProvider);
  final m = SequenceRunner(say: _say);
  m.onCue = (cue, config) {
    if (config.speak) voice.speak(cue.text);
    if (config.beeps) {
      switch (cue.kind) {
        case CueKind.go:
          HapticFeedback.heavyImpact();
          SystemSound.play(SystemSoundType.alert);
        case CueKind.finish:
          HapticFeedback.vibrate();
          SystemSound.play(SystemSoundType.alert);
        case CueKind.call || CueKind.count:
          HapticFeedback.mediumImpact();
          SystemSound.play(SystemSoundType.click);
        case CueKind.mark || CueKind.tick:
          HapticFeedback.selectionClick();
      }
    }
  };
  ref.onDispose(m.dispose);
  return m;
});
