import 'dart:convert';

import '../settings/domain/alarm_options.dart';

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

  RingPayload withRingSeconds(int seconds) => RingPayload(
    title: title,
    body: body,
    ringSeconds: seconds,
    spoken: spoken,
    maxSnoozes: maxSnoozes,
    snoozeMinutes: snoozeMinutes,
    snoozeCount: snoozeCount,
    wakeCheck: wakeCheck,
    mathTask: mathTask,
    shabbatSafe: shabbatSafe,
    isCheck: isCheck,
    transient: transient,
  );

  bool get canSnooze => snoozeCount < maxSnoozes;

  /// What gets read aloud, e.g. "Candle lighting, Shabbat. 15 minutes before."
  String get spokenText => '${title.replaceAll(' · ', ', ')}. $body.';

  RingPayload snoozed() => RingPayload(
    title: title,
    body: 'Snoozed: $body',
    ringSeconds: ringSeconds,
    spoken: spoken,
    maxSnoozes: maxSnoozes,
    snoozeMinutes: snoozeMinutes,
    snoozeCount: snoozeCount + 1,
    wakeCheck: wakeCheck,
    mathTask: mathTask,
    shabbatSafe: shabbatSafe,
    transient: true,
  );

  RingPayload check() => RingPayload(
    title: 'Are you up?',
    body: 'Tap "I\'m up" to stop',
    ringSeconds: ringSeconds,
    spoken: spoken,
    mathTask: false,
    isCheck: true,
    transient: true,
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
      );
    } catch (_) {
      return RingPayload(title: fallbackTitle, body: fallbackBody, ringSeconds: 60);
    }
  }
}
