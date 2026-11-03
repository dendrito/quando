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

/// How one alarm rings and stops, on top of the settings every alarm shares.
/// A field left null follows those settings.
class RingStyle {
  const RingStyle({
    this.loudness,
    this.gentleMinutes = 0,
    this.snoozeBy = const {},
    this.stopBy = const {},
    this.task,
    this.wakeCheck,
    this.openAfter,
  });

  final Loudness? loudness;

  /// A soft alarm this many minutes before the real one. 0 = none.
  final int gentleMinutes;

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
      snoozeBy.isEmpty &&
      stopBy.isEmpty &&
      task == null &&
      wakeCheck == null &&
      (openAfter == null || openAfter!.isEmpty);

  RingStyle copyWith({
    Loudness? loudness,
    bool defaultLoudness = false,
    int? gentleMinutes,
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
      _same(other.snoozeBy, snoozeBy) &&
      _same(other.stopBy, stopBy) &&
      other.task == task &&
      other.wakeCheck == wakeCheck &&
      other.openAfter == openAfter;

  static bool _same(Set<StopWay> a, Set<StopWay> b) => a.length == b.length && a.containsAll(b);

  @override
  int get hashCode =>
      Object.hash(loudness, gentleMinutes, snoozeBy.length, stopBy.length, task, wakeCheck, openAfter);
}
