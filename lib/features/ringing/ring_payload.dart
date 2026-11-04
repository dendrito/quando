import 'dart:convert';

import '../settings/domain/alarm_options.dart';
import '../sounds/domain/loudness.dart';
import 'ring_style.dart';

/// Everything the ringing screen needs, stored with the alarm itself so it
/// still works when the phone launches the app cold.
class RingPayload {
  const RingPayload({
    required this.title,
    required this.body,
    required this.ringSeconds,
    this.spoken = true,
    this.maxSnoozes = 0,
    this.snoozeMinutes = 5,
    this.snoozeCount = 0,
    this.wakeCheck = false,
    this.mathTask = false,
    this.shabbatSafe = false,
    this.isCheck = false,
    this.transient = false,
    this.isLock = false,
    this.sound,
    this.link,
    this.shakeTask = false,
    this.loudness = Loudness.standard,
    this.snoozeBy = const {},
    this.stopBy = const {},
    this.shortenBy = 0,
    this.autoSnoozeMinutes = 0,
    this.snoozeTask = StopTask.none,
    this.puzzle = StopTask.none,
    this.scanCode,
    this.gentle = false,
  });

  /// Builds the payload for an alarm. Inside Shabbat or a festival
  /// ([shabbatSafe]) nothing asks to be touched: no snooze, no sums, no
  /// wake-up check, and it stops by itself.
  factory RingPayload.forAlarm({
    required String title,
    required String body,
    required AlarmOptions options,
    required bool shabbatSafe,
  }) => RingPayload(
    title: title,
    body: body,
    ringSeconds: options.ringSeconds,
    spoken: options.spoken && !shabbatSafe,
    maxSnoozes: shabbatSafe ? 0 : options.maxSnoozes,
    snoozeMinutes: options.snoozeMinutes,
    wakeCheck: options.wakeCheck && !shabbatSafe,
    mathTask: options.mathTask && !shabbatSafe,
    shabbatSafe: shabbatSafe,
    loudness: options.loudness,
  );

  final String title;
  final String body;
  final int ringSeconds;
  final bool spoken;
  final int maxSnoozes;
  final int snoozeMinutes;
  final int snoozeCount;
  final bool wakeCheck;
  final bool mathTask;
  final bool shabbatSafe;

  /// This is the "are you up?" follow-up, not the original alarm.
  final bool isCheck;

  /// Snoozes, checks and test alarms: not part of the plan, so re-planning
  /// leaves them alone.
  final bool transient;

  /// Only opens Quando so lock mode can start. No ringing screen.
  final bool isLock;

  /// Audio path for the alarm plugin: `assets/...` or relative to the app's
  /// documents folder. null = the phone's alarm sound.
  final String? sound;

  /// A song or playlist in another app (Spotify, SoundCloud…), opened when
  /// you stop the alarm. The alarm itself rings with [sound].
  final String? link;

  /// Shake the phone 30 times before it stops.
  final bool shakeTask;

  final Loudness loudness;

  /// Ways to snooze or stop besides the buttons on screen.
  final Set<StopWay> snoozeBy;
  final Set<StopWay> stopBy;

  /// Each extra snooze is this many minutes shorter (never under 1).
  final int shortenBy;

  /// Snooze by itself after ringing this long untouched. 0 = never.
  final int autoSnoozeMinutes;

  /// What you must do before it snoozes.
  final StopTask snoozeTask;

  /// The soft lead-up before the real alarm: no full screen, no vibration.
  final bool gentle;

  /// Stopping needs more than one tap.
  bool get hasTask => mathTask || shakeTask || puzzle != StopTask.none;

  /// A memory game, a phrase to type or a code to scan before it stops.
  final StopTask puzzle;

  /// What [StopTask.scan] must read.
  final String? scanCode;

  /// The same payload with some fields changed. Every copy goes through
  /// here, so a new field is never dropped by accident.
  RingPayload _copy({
    String? title,
    String? body,
    int? ringSeconds,
    bool? spoken,
    int? maxSnoozes,
    int? snoozeCount,
    bool? wakeCheck,
    bool? mathTask,
    bool? shakeTask,
    bool? isCheck,
    bool? transient,
    String? sound,
    bool keepSound = true,
    String? link,
    bool keepLink = true,
    Loudness? loudness,
    Set<StopWay>? snoozeBy,
    Set<StopWay>? stopBy,
    int? snoozeMinutes,
    int? shortenBy,
    int? autoSnoozeMinutes,
    StopTask? snoozeTask,
    StopTask? puzzle,
    String? scanCode,
    bool? gentle,
  }) => RingPayload(
    title: title ?? this.title,
    body: body ?? this.body,
    ringSeconds: ringSeconds ?? this.ringSeconds,
    spoken: spoken ?? this.spoken,
    maxSnoozes: maxSnoozes ?? this.maxSnoozes,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    snoozeCount: snoozeCount ?? this.snoozeCount,
    wakeCheck: wakeCheck ?? this.wakeCheck,
    mathTask: mathTask ?? this.mathTask,
    shakeTask: shakeTask ?? this.shakeTask,
    shabbatSafe: shabbatSafe,
    isCheck: isCheck ?? this.isCheck,
    transient: transient ?? this.transient,
    isLock: isLock,
    sound: keepSound ? this.sound : sound,
    link: keepLink ? this.link : link,
    loudness: loudness ?? this.loudness,
    snoozeBy: snoozeBy ?? this.snoozeBy,
    stopBy: stopBy ?? this.stopBy,
    shortenBy: shortenBy ?? this.shortenBy,
    autoSnoozeMinutes: autoSnoozeMinutes ?? this.autoSnoozeMinutes,
    snoozeTask: snoozeTask ?? this.snoozeTask,
    puzzle: puzzle ?? this.puzzle,
    scanCode: scanCode ?? this.scanCode,
    gentle: gentle ?? this.gentle,
  );

  RingPayload withLink(String? url) => _copy(link: url, keepLink: false);

  RingPayload withRingSeconds(int seconds) => _copy(ringSeconds: seconds);

  RingPayload withSound(String? path) => _copy(sound: path, keepSound: false);

  /// One alarm's own way of ringing. Inside Shabbat or a festival nothing
  /// asks to be touched, so tasks, wake-up checks and links are left out.
  RingPayload withStyle(RingStyle s) {
    final safe = shabbatSafe || isLock;
    // Scanning needs a code saved first; without one it's a sum.
    final task = safe ? null : (s.task == StopTask.scan && s.scanCode == null ? StopTask.sum : s.task);
    final open = s.openAfter?.trim();
    final plan = s.snooze;
    return _copy(
      maxSnoozes: safe || plan == null ? null : plan.times,
      snoozeMinutes: safe ? null : plan?.minutes,
      shortenBy: safe ? null : plan?.shortenBy,
      autoSnoozeMinutes: safe ? 0 : plan?.autoSnoozeMinutes,
      snoozeTask: safe
          ? null
          : (s.snoozeTask == StopTask.scan && s.scanCode == null
                ? StopTask.sum
                : (s.snoozeTask ?? StopTask.none)),
      loudness: s.loudness,
      snoozeBy: safe ? const {} : s.snoozeBy,
      stopBy: safe ? const {} : s.stopBy,
      mathTask: task == null ? null : task == StopTask.sum,
      shakeTask: task == null ? null : task == StopTask.shake,
      puzzle: task == null ? StopTask.none : (task.isPuzzle ? task : StopTask.none),
      scanCode: s.scanCode,
      wakeCheck: safe ? null : s.wakeCheck,
      link: open,
      keepLink: safe || open == null || open.isEmpty,
    );
  }

  /// The soft lead-up some minutes before this alarm: a calm [sound],
  /// rising slowly over the whole lead-up, asking nothing of you. It ends
  /// just before the real alarm.
  RingPayload gentleLeadUp(int minutesBefore, String? sound) => _copy(
    body: 'Gentle wake-up · $minutesBefore min to go',
    ringSeconds: (minutesBefore * 60 - 15).clamp(30, 3600),
    spoken: false,
    maxSnoozes: 0,
    wakeCheck: false,
    mathTask: false,
    shakeTask: false,
    puzzle: StopTask.none,
    sound: sound,
    keepSound: false,
    link: null,
    keepLink: false,
    loudness: Loudness(
      volume: ((loudness.volume ?? 70) * 0.6).round(),
      fadeInSeconds: (minutesBefore * 60 * 0.85).round(),
    ),
    snoozeBy: const {},
    stopBy: const {},
    autoSnoozeMinutes: 0,
    gentle: true,
  );

  /// A try-out ring from the editor: everything as the real alarm, but
  /// outside the plan.
  RingPayload asPreview() => _copy(body: 'Preview · $body', transient: true);

  bool get canSnooze => snoozeCount < maxSnoozes;

  /// What gets read aloud, e.g. "Candle lighting, Shabbat. 15 minutes before."
  String get spokenText => '${title.replaceAll(' · ', ', ')}. $body.';

  RingPayload snoozed() => _copy(
    body: body.startsWith('Snoozed: ') ? body : 'Snoozed: $body',
    snoozeCount: snoozeCount + 1,
    snoozeMinutes: (snoozeMinutes - shortenBy).clamp(1, 120),
    transient: true,
  );

  RingPayload check() => _copy(
    title: 'Are you up?',
    body: 'Tap "I\'m up" to stop',
    maxSnoozes: 0,
    wakeCheck: false,
    mathTask: false,
    shakeTask: false,
    puzzle: StopTask.none,
    isCheck: true,
    transient: true,
    snoozeBy: const {},
    stopBy: const {},
  );

  String encode() => jsonEncode({
    'title': title,
    'body': body,
    'ringSeconds': ringSeconds,
    'spoken': spoken,
    'maxSnoozes': maxSnoozes,
    'snoozeMinutes': snoozeMinutes,
    'snoozeCount': snoozeCount,
    'wakeCheck': wakeCheck,
    'mathTask': mathTask,
    'shabbatSafe': shabbatSafe,
    'isCheck': isCheck,
    'transient': transient,
    'isLock': isLock,
    'sound': sound,
    'link': link,
    'shakeTask': shakeTask,
    'loudness': loudness.toJson(),
    'snoozeBy': [for (final w in snoozeBy) w.name],
    'stopBy': [for (final w in stopBy) w.name],
    'shortenBy': shortenBy,
    'autoSnoozeMinutes': autoSnoozeMinutes,
    'snoozeTask': snoozeTask.name,
    'puzzle': puzzle.name,
    'scanCode': scanCode,
    'gentle': gentle,
  });

  static RingPayload decode(String? raw, {String fallbackTitle = 'Alarm', String fallbackBody = ''}) {
    try {
      final j = jsonDecode(raw ?? '{}') as Map<String, dynamic>;
      return RingPayload(
        title: j['title'] as String? ?? fallbackTitle,
        body: j['body'] as String? ?? fallbackBody,
        ringSeconds: (j['ringSeconds'] as num?)?.toInt() ?? 60,
        spoken: j['spoken'] as bool? ?? false,
        maxSnoozes: (j['maxSnoozes'] as num?)?.toInt() ?? 0,
        snoozeMinutes: (j['snoozeMinutes'] as num?)?.toInt() ?? 5,
        snoozeCount: (j['snoozeCount'] as num?)?.toInt() ?? 0,
        wakeCheck: j['wakeCheck'] as bool? ?? false,
        mathTask: j['mathTask'] as bool? ?? false,
        shabbatSafe: j['shabbatSafe'] as bool? ?? false,
        isCheck: j['isCheck'] as bool? ?? false,
        transient: j['transient'] as bool? ?? false,
        isLock: j['isLock'] as bool? ?? false,
        sound: j['sound'] as String?,
        link: j['link'] as String?,
        shakeTask: j['shakeTask'] as bool? ?? false,
        loudness: Loudness.fromJson(j['loudness']) ?? Loudness.standard,
        snoozeBy: _ways(j['snoozeBy']),
        stopBy: _ways(j['stopBy']),
        shortenBy: (j['shortenBy'] as num?)?.toInt() ?? 0,
        autoSnoozeMinutes: (j['autoSnoozeMinutes'] as num?)?.toInt() ?? 0,
        snoozeTask: StopTask.values.where((t) => t.name == j['snoozeTask']).firstOrNull ?? StopTask.none,
        puzzle: StopTask.values.where((t) => t.name == j['puzzle']).firstOrNull ?? StopTask.none,
        scanCode: j['scanCode'] as String?,
        gentle: j['gentle'] as bool? ?? false,
      );
    } catch (_) {
      return RingPayload(title: fallbackTitle, body: fallbackBody, ringSeconds: 60);
    }
  }

  static Set<StopWay> _ways(Object? l) => {
    for (final n in (l is List ? l : const [])) ?StopWay.values.where((w) => w.name == n).firstOrNull,
  };
}
