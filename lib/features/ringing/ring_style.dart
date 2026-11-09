import '../../core/util/platform.dart';
import '../sounds/domain/loudness.dart';

import 'package:quando/l10n/l10n.dart';

/// Ways to snooze or stop a ringing alarm besides the buttons on screen.
enum StopWay {
  volumeKeys,
  shake;

  String get label => switch (this) {
    volumeKeys => l10n.wayVolumeButtons,
    shake => l10n.wayShake,
  };

  /// iOS cannot read volume buttons; Macs do not have a motion sensor.
  static List<StopWay> get onThisPhone => isMacOS ? const [] : (isAndroid ? values : const [shake]);
}

/// What you must do before an alarm stops.
enum StopTask {
  none,
  sum,
  shake,
  memory,
  phrase,
  scan;

  static Iterable<StopTask> get onThisDevice => isMacOS ? values.where((t) => t != shake) : values;

  /// Done in its own little screen, not on the ringing screen's buttons.
  bool get isPuzzle => this == memory || this == phrase || this == scan;

  String get label => switch (this) {
    none => l10n.taskNothing,
    sum => l10n.taskSum,
    shake => l10n.taskShake,
    memory => l10n.taskMemory,
    phrase => l10n.taskPhrase,
    scan => l10n.taskScan,
  };
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
      ? l10n.noSnooze
      : [
          l10n.minutesShort(minutes),
          times >= unlimited ? l10n.noLimit : l10n.upToTimes(times),
          if (shortenBy > 0) l10n.shorterEachTime(shortenBy),
          if (autoSnoozeMinutes > 0) l10n.autoSnoozeAfter(autoSnoozeMinutes),
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
    this.scanCode,
  });

  /// The barcode or QR code to scan for [StopTask.scan], e.g. one on a
  /// box in the kitchen, so you have to get up.
  final String? scanCode;

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
      (openAfter == null || openAfter!.isEmpty) &&
      scanCode == null;

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
    String? scanCode,
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
    scanCode: scanCode ?? this.scanCode,
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
          'scanCode': scanCode,
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
      scanCode: j['scanCode'] as String?,
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
      other.openAfter == openAfter &&
      other.scanCode == scanCode;

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
