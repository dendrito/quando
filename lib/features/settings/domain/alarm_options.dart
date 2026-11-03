/// How alarms behave when they ring. Applied to every alarm.
class AlarmOptions {
  const AlarmOptions({
    this.spoken = true,
    this.ringSeconds = 60,
    this.maxSnoozes = 2,
    this.snoozeMinutes = 5,
    this.wakeCheck = false,
    this.mathTask = false,
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

  AlarmOptions copyWith({
    bool? spoken,
    int? ringSeconds,
    int? maxSnoozes,
    int? snoozeMinutes,
    bool? wakeCheck,
    bool? mathTask,
  }) => AlarmOptions(
    spoken: spoken ?? this.spoken,
    ringSeconds: ringSeconds ?? this.ringSeconds,
    maxSnoozes: maxSnoozes ?? this.maxSnoozes,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    wakeCheck: wakeCheck ?? this.wakeCheck,
    mathTask: mathTask ?? this.mathTask,
  );

  Map<String, dynamic> toJson() => {
    'spoken': spoken,
    'ringSeconds': ringSeconds,
    'maxSnoozes': maxSnoozes,
    'snoozeMinutes': snoozeMinutes,
    'wakeCheck': wakeCheck,
    'mathTask': mathTask,
  };

  factory AlarmOptions.fromJson(Map<String, dynamic> j) => AlarmOptions(
    spoken: j['spoken'] as bool? ?? true,
    ringSeconds: (j['ringSeconds'] as num?)?.toInt() ?? 60,
    maxSnoozes: (j['maxSnoozes'] as num?)?.toInt() ?? 2,
    snoozeMinutes: (j['snoozeMinutes'] as num?)?.toInt() ?? 5,
    wakeCheck: j['wakeCheck'] as bool? ?? false,
    mathTask: j['mathTask'] as bool? ?? false,
  );
}
