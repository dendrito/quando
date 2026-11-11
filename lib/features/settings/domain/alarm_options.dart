import '../../sounds/domain/loudness.dart';

/// How alarms behave when they ring. Applied to every alarm.
class AlarmOptions {
  const AlarmOptions({
    this.spoken = true,
    this.ringSeconds = 60,
    this.maxSnoozes = 2,
    this.snoozeMinutes = 5,
    this.wakeCheck = false,
    this.mathTask = false,
    this.soundId,
    this.loudness = Loudness.standard,
    this.fadesForAll = false,
    this.gentleMinutes = 0,
  });

  /// New alarms start with a gentle wake-up this many minutes before. 0 = off.
  final int gentleMinutes;

  /// Every alarm uses [loudness]'s fades instead of its own (each keeps its
  /// own volume).
  final bool fadesForAll;

  /// Read the alarm's label aloud when it rings.
  final bool spoken;

  /// Stop by itself after this many seconds.
  final int ringSeconds;

  /// How many times one alarm may be snoozed. 0 = no snooze.
  final int maxSnoozes;
  final int snoozeMinutes;

  /// After you stop an alarm, ring again in 3 minutes unless you tap
  /// "I'm up".
  final bool wakeCheck;

  /// Solve a sum before the alarm stops.
  final bool mathTask;

  /// Default sound for every alarm. null = the phone's alarm sound.
  final String? soundId;

  /// Volume and fades for every alarm that doesn't set its own.
  final Loudness loudness;

  AlarmOptions copyWith({
    bool? spoken,
    int? ringSeconds,
    int? maxSnoozes,
    int? snoozeMinutes,
    bool? wakeCheck,
    bool? mathTask,
    String? soundId,
    bool phoneSound = false,
    Loudness? loudness,
    bool? fadesForAll,
    int? gentleMinutes,
  }) => AlarmOptions(
    spoken: spoken ?? this.spoken,
    ringSeconds: ringSeconds ?? this.ringSeconds,
    maxSnoozes: maxSnoozes ?? this.maxSnoozes,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    wakeCheck: wakeCheck ?? this.wakeCheck,
    mathTask: mathTask ?? this.mathTask,
    soundId: phoneSound ? null : (soundId ?? this.soundId),
    loudness: loudness ?? this.loudness,
    fadesForAll: fadesForAll ?? this.fadesForAll,
    gentleMinutes: gentleMinutes ?? this.gentleMinutes,
  );

  Map<String, dynamic> toJson() => {
    'spoken': spoken,
    'ringSeconds': ringSeconds,
    'maxSnoozes': maxSnoozes,
    'snoozeMinutes': snoozeMinutes,
    'wakeCheck': wakeCheck,
    'mathTask': mathTask,
    'soundId': soundId,
    'loudness': loudness.toJson(),
    'fadesForAll': fadesForAll,
    'gentleMinutes': gentleMinutes,
  };

  factory AlarmOptions.fromJson(Map<String, dynamic> j) => AlarmOptions(
    spoken: j['spoken'] as bool? ?? true,
    ringSeconds: (j['ringSeconds'] as num?)?.toInt() ?? 60,
    maxSnoozes: (j['maxSnoozes'] as num?)?.toInt() ?? 2,
    snoozeMinutes: (j['snoozeMinutes'] as num?)?.toInt() ?? 5,
    wakeCheck: j['wakeCheck'] as bool? ?? false,
    mathTask: j['mathTask'] as bool? ?? false,
    soundId: j['soundId'] as String?,
    loudness: Loudness.fromJson(j['loudness']) ?? Loudness.standard,
    fadesForAll: j['fadesForAll'] as bool? ?? false,
    gentleMinutes: (j['gentleMinutes'] as num?)?.toInt() ?? 0,
  );
}
