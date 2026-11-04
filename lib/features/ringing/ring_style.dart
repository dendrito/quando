import '../sounds/domain/loudness.dart';

/// Ways to snooze or stop a ringing alarm besides the buttons on screen.
enum StopWay {
  volumeKeys('Volume buttons'),
  shake('Shake the phone');

  const StopWay(this.label);
  final String label;
}

/// What you must do before an alarm stops.
enum StopTask {
  none('Nothing'),
  sum('Solve a sum'),
  shake('Shake 30 times');

  const StopTask(this.label);
  final String label;
}

/// How snoozing works: how long, how many times, and how much shorter each
/// extra snooze gets ("10, then 8, then 6 minutes").
class SnoozePlan {
  const SnoozePlan({this.minutes = 5, this.times = 2, this.shortenBy = 0, this.autoSnoozeMinutes = 0});

  final int minutes;

  /// 0 = no snooze.
  final int times;
  final int shortenBy;

  /// Snooze by itself after ringing this many minutes untouched. 0 = never.
  final int autoSnoozeMinutes;

  /// Stands for "as many as you like".
  static const unlimited = 99;

  /// The length of snooze number [n], counting from 0. Never under a minute.
  int lengthOf(int n) => (minutes - shortenBy * n).clamp(1, 120);

  /// "10 min, up to 3×, 2 min shorter each time".
  String get summary => times == 0
      ? 'No snooze'
      : [
          '$minutes min',
          times >= unlimited ? 'no limit' : 'up to $times×',
          if (shortenBy > 0) '$shortenBy min shorter each time',
          if (autoSnoozeMinutes > 0) 'snoozes by itself after $autoSnoozeMinutes min',
        ].join(', ');

  SnoozePlan copyWith({int? minutes, int? times, int? shortenBy, int? autoSnoozeMinutes}) => SnoozePlan(
    minutes: minutes ?? this.minutes,
    times: times ?? this.times,
    shortenBy: shortenBy ?? this.shortenBy,
    autoSnoozeMinutes: autoSnoozeMinutes ?? this.autoSnoozeMinutes,
  );

  Map<String, dynamic> toJson() => {
    'minutes': minutes,
    'times': times,
    'shortenBy': shortenBy,
    'autoSnooze': autoSnoozeMinutes,
  };

  static SnoozePlan? fromJson(Object? j) => j is! Map
      ? null
      : SnoozePlan(
          minutes: (j['minutes'] as num?)?.toInt() ?? 5,
          times: (j['times'] as num?)?.toInt() ?? 2,
          shortenBy: (j['shortenBy'] as num?)?.toInt() ?? 0,
          autoSnoozeMinutes: (j['autoSnooze'] as num?)?.toInt() ?? 0,
        );

  @override
  bool operator ==(Object other) =>
      other is SnoozePlan &&
      other.minutes == minutes &&
      other.times == times &&
      other.shortenBy == shortenBy &&
      other.autoSnoozeMinutes == autoSnoozeMinutes;

  @override
  int get hashCode => Object.hash(minutes, times, shortenBy, autoSnoozeMinutes);
}

/// How one alarm rings and stops, on top of the settings every alarm shares.
/// A field left null follows those settings.
class RingStyle {
  const RingStyle({
    this.loudness,
    this.gentleMinutes = 0,
    this.gentleSound = 'calm.waves',
    this.snooze,
    this.snoozeTask,
    this.snoozeBy = const {},
    this.stopBy = const {},
    this.task,
    this.wakeCheck,
    this.openAfter,
  });

  final Loudness? loudness;

  /// A soft alarm this many minutes before the real one. 0 = none.
  final int gentleMinutes;

  /// Which calm sound the gentle wake-up plays.
  final String gentleSound;

  /// Snooze length, count and shortening for this alarm. null = settings.
  final SnoozePlan? snooze;

  /// What you must do before it snoozes. null = nothing.
  final StopTask? snoozeTask;

  /// Extra ways to snooze, and to stop, besides the screen buttons.
  final Set<StopWay> snoozeBy;
  final Set<StopWay> stopBy;

  final StopTask? task;

  /// Ring again in 3 minutes unless you tap "I'm up".
  final bool? wakeCheck;

  /// A link or app opened once you stop the alarm, e.g. a news site, the
  /// weather or a playlist.
  final String? openAfter;

  static const none = RingStyle();

  bool get isDefault =>
      loudness == null &&
      gentleMinutes == 0 &&
      gentleSound == 'calm.waves' &&
      snooze == null &&
      snoozeTask == null &&
      snoozeBy.isEmpty &&
      stopBy.isEmpty &&
      task == null &&
      wakeCheck == null &&
      (openAfter == null || openAfter!.isEmpty);

  RingStyle copyWith({
    Loudness? loudness,
    bool defaultLoudness = false,
    int? gentleMinutes,
    String? gentleSound,
    SnoozePlan? snooze,
    bool defaultSnooze = false,
    StopTask? snoozeTask,
    bool noSnoozeTask = false,
    Set<StopWay>? snoozeBy,
    Set<StopWay>? stopBy,
    StopTask? task,
    bool defaultTask = false,
    bool? wakeCheck,
    bool defaultWakeCheck = false,
    String? openAfter,
    bool noOpenAfter = false,
  }) => RingStyle(
    loudness: defaultLoudness ? null : (loudness ?? this.loudness),
    gentleMinutes: gentleMinutes ?? this.gentleMinutes,
    gentleSound: gentleSound ?? this.gentleSound,
    snooze: defaultSnooze ? null : (snooze ?? this.snooze),
    snoozeTask: noSnoozeTask ? null : (snoozeTask ?? this.snoozeTask),
    snoozeBy: snoozeBy ?? this.snoozeBy,
    stopBy: stopBy ?? this.stopBy,
    task: defaultTask ? null : (task ?? this.task),
    wakeCheck: defaultWakeCheck ? null : (wakeCheck ?? this.wakeCheck),
    openAfter: noOpenAfter ? null : (openAfter ?? this.openAfter),
  );

  Map<String, dynamic>? toJson() => isDefault
      ? null
      : {
          'loudness': loudness?.toJson(),
          'gentle': gentleMinutes,
          'gentleSound': gentleSound,
          'snooze': snooze?.toJson(),
          'snoozeTask': snoozeTask?.name,
          'snoozeBy': [for (final w in snoozeBy) w.name],
          'stopBy': [for (final w in stopBy) w.name],
          'task': task?.name,
          'wakeCheck': wakeCheck,
          'openAfter': openAfter,
        };

  static RingStyle fromJson(Object? j) {
    if (j is! Map) return none;
    Set<StopWay> ways(Object? l) => {
      for (final n in (l is List ? l : const [])) ?StopWay.values.where((w) => w.name == n).firstOrNull,
    };
    return RingStyle(
      loudness: Loudness.fromJson(j['loudness']),
      gentleMinutes: (j['gentle'] as num?)?.toInt() ?? 0,
      gentleSound: j['gentleSound'] as String? ?? 'calm.waves',
      snooze: SnoozePlan.fromJson(j['snooze']),
      snoozeTask: StopTask.values.where((t) => t.name == j['snoozeTask']).firstOrNull,
      snoozeBy: ways(j['snoozeBy']),
      stopBy: ways(j['stopBy']),
      task: StopTask.values.where((t) => t.name == j['task']).firstOrNull,
      wakeCheck: j['wakeCheck'] as bool?,
      openAfter: j['openAfter'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is RingStyle &&
      other.loudness == loudness &&
      other.gentleMinutes == gentleMinutes &&
      other.gentleSound == gentleSound &&
      other.snooze == snooze &&
      other.snoozeTask == snoozeTask &&
      _same(other.snoozeBy, snoozeBy) &&
      _same(other.stopBy, stopBy) &&
      other.task == task &&
      other.wakeCheck == wakeCheck &&
      other.openAfter == openAfter;

  static bool _same(Set<StopWay> a, Set<StopWay> b) => a.length == b.length && a.containsAll(b);

  @override
  int get hashCode => Object.hash(
    loudness,
    gentleMinutes,
    gentleSound,
    snooze,
    snoozeTask,
    snoozeBy.length,
    stopBy.length,
    task,
    wakeCheck,
    openAfter,
  );
}
