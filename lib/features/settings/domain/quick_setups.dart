import '../../timers/domain/timers.dart';
import 'alarm_options.dart';

/// Quick setups: one tap applies a few settings that already exist. They
/// add no behaviour of their own.

/// "Morning that works": wake-up check on, snooze once (5 min), say it aloud.
AlarmOptions morningApplied(AlarmOptions o) =>
    o.copyWith(wakeCheck: true, maxSnoozes: 1, snoozeMinutes: 5, spoken: true);

bool morningIsOn(AlarmOptions o) => o.wakeCheck && o.maxSnoozes == 1 && o.snoozeMinutes == 5 && o.spoken;

const stretchSeconds = 25 * 60;
const stretchSayEvery = 5 * 60;
const stretchFinalCount = 10;
const stretchMarkAt = 20 * 60;

/// "Work in stretches": 25 minutes, the time left every 5 minutes, the last
/// 10 seconds counted, and a mark at 5 minutes left ([markText]).
SequenceConfig stretchApplied(SequenceConfig c, String markText) => c.copyWith(
  lengthSeconds: stretchSeconds,
  sayEvery: stretchSayEvery,
  finalCount: stretchFinalCount,
  marks: [(atSeconds: stretchMarkAt, text: markText)],
);

bool stretchIsOn(SequenceConfig c) =>
    c.lengthSeconds == stretchSeconds &&
    c.sayEvery == stretchSayEvery &&
    c.finalCount == stretchFinalCount &&
    c.marks.length == 1 &&
    c.marks.first.atSeconds == stretchMarkAt;
