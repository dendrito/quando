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
  });

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

  AlarmOptions copyWith({
    bool? spoken,
    int? ringSeconds,
    int? maxSnoozes,
    int? snoozeMinutes,
    bool? wakeCheck,
    bool? mathTask,
    String? soundId,
    bool phoneSound = false,
  }) => AlarmOptions(
    spoken: spoken ?? this.spoken,
    ringSeconds: ringSeconds ?? this.ringSeconds,
    maxSnoozes: maxSnoozes ?? this.maxSnoozes,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    wakeCheck: wakeCheck ?? this.wakeCheck,
    mathTask: mathTask ?? this.mathTask,
    soundId: phoneSound ? null : (soundId ?? this.soundId),
  );

  Map<String, dynamic> toJson() => {
    'spoken': spoken,
    'ringSeconds': ringSeconds,
    'maxSnoozes': maxSnoozes,
    'snoozeMinutes': snoozeMinutes,
    'wakeCheck': wakeCheck,
    'mathTask': mathTask,
    'soundId': soundId,
  };

  factory AlarmOptions.fromJson(Map<String, dynamic> j) => AlarmOptions(
    spoken: j['spoken'] as bool? ?? true,
    ringSeconds: (j['ringSeconds'] as num?)?.toInt() ?? 60,
    maxSnoozes: (j['maxSnoozes'] as num?)?.toInt() ?? 2,
    snoozeMinutes: (j['snoozeMinutes'] as num?)?.toInt() ?? 5,
    wakeCheck: j['wakeCheck'] as bool? ?? false,
    mathTask: j['mathTask'] as bool? ?? false,
    soundId: j['soundId'] as String?,
  );
}
