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

  /// Stopping needs more than one tap.
  bool get hasTask => mathTask || shakeTask;

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
  }) => RingPayload(
    title: title ?? this.title,
    body: body ?? this.body,
    ringSeconds: ringSeconds ?? this.ringSeconds,
    spoken: spoken ?? this.spoken,
    maxSnoozes: maxSnoozes ?? this.maxSnoozes,
    snoozeMinutes: snoozeMinutes,
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
  );

  RingPayload withLink(String? url) => _copy(link: url, keepLink: false);

  RingPayload withRingSeconds(int seconds) => _copy(ringSeconds: seconds);

  RingPayload withSound(String? path) => _copy(sound: path, keepSound: false);

  /// One alarm's own way of ringing. Inside Shabbat or a festival nothing
  /// asks to be touched, so tasks, wake-up checks and links are left out.
  RingPayload withStyle(RingStyle s) {
    final safe = shabbatSafe || isLock;
    final task = safe ? null : s.task;
    final open = s.openAfter?.trim();
    return _copy(
      loudness: s.loudness,
      snoozeBy: safe ? const {} : s.snoozeBy,
      stopBy: safe ? const {} : s.stopBy,
      mathTask: task == null ? null : task == StopTask.sum,
      shakeTask: task == null ? null : task == StopTask.shake,
      wakeCheck: safe ? null : s.wakeCheck,
      link: open,
      keepLink: safe || open == null || open.isEmpty,
    );
  }

  /// The soft alarm a few minutes before this one: quiet, rising slowly,
  /// and asking nothing of you.
  RingPayload gentle(int minutesBefore) => _copy(
    body: 'Gentle wake-up · $minutesBefore min to go',
    ringSeconds: ringSeconds < 60 ? ringSeconds : 60,
    spoken: false,
    maxSnoozes: 0,
    wakeCheck: false,
    mathTask: false,
    shakeTask: false,
    link: null,
    keepLink: false,
    loudness: Loudness(volume: ((loudness.volume ?? 100) * 0.35).round(), fadeInSeconds: 40),
    snoozeBy: const {},
    stopBy: const {},
  );

  bool get canSnooze => snoozeCount < maxSnoozes;

  /// What gets read aloud, e.g. "Candle lighting, Shabbat. 15 minutes before."
  String get spokenText => '${title.replaceAll(' · ', ', ')}. $body.';

  RingPayload snoozed() => _copy(body: 'Snoozed: $body', snoozeCount: snoozeCount + 1, transient: true);

  RingPayload check() => _copy(
    title: 'Are you up?',
    body: 'Tap "I\'m up" to stop',
    maxSnoozes: 0,
    wakeCheck: false,
    mathTask: false,
    shakeTask: false,
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
      );
    } catch (_) {
      return RingPayload(title: fallbackTitle, body: fallbackBody, ringSeconds: 60);
    }
  }

  static Set<StopWay> _ways(Object? l) => {
    for (final n in (l is List ? l : const [])) ?StopWay.values.where((w) => w.name == n).firstOrNull,
  };
}
