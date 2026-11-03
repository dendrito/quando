import 'package:timezone/timezone.dart' as tz;

import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';

/// An everyday alarm the user sets: "7:00 on weekdays".
class UserAlarm {
  const UserAlarm({
    required this.id,
    required this.hour,
    required this.minute,
    this.days = const {},
    this.label = '',
    this.ringSeconds,
    this.enabled = true,
    this.onceAt,
    this.soundId,
  });

  final String id;
  final int hour;
  final int minute;

  /// Weekdays it repeats on, 1 = Monday ... 7 = Sunday. Empty = rings once.
  final Set<int> days;
  final String label;

  /// Overrides the default ring length. null = use the setting.
  final int? ringSeconds;
  final bool enabled;

  /// For a one-off alarm: the moment it was set for (UTC).
  final DateTime? onceAt;

  /// null = the default sound.
  final String? soundId;

  bool get repeats => days.isNotEmpty;

  String get title => label.isEmpty ? 'Alarm' : label;

  /// "Weekdays", "Every day", "Mon, Wed" or "Once".
  String get repeatLabel {
    if (days.isEmpty) return 'Once';
    if (days.length == 7) return 'Every day';
    if (days.length == 5 && !days.contains(6) && !days.contains(7)) return 'Weekdays';
    if (days.length == 2 && days.contains(6) && days.contains(7)) return 'Weekends';
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return [
      for (var d = 1; d <= 7; d++)
        if (days.contains(d)) names[d - 1],
    ].join(', ');
  }

  /// The next time this alarm rings after [now], in [zone]'s wall clock.
  static DateTime nextAt(int hour, int minute, DateTime now, String zone) {
    final local = inZone(now, zone);
    var t = tz.TZDateTime(local.location, local.year, local.month, local.day, hour, minute);
    if (!t.isAfter(local)) {
      t = tz.TZDateTime(local.location, local.year, local.month, local.day + 1, hour, minute);
    }
    return t.toUtc();
  }

  /// Every time it rings between [now] and [now] + [horizon].
  List<ScheduledAlarm> plan({
    required DateTime now,
    required Duration horizon,
    required String zone,
    required Duration defaultRing,
  }) {
    if (!enabled) return const [];
    final end = now.add(horizon);
    final ring = ringSeconds == null ? defaultRing : Duration(seconds: ringSeconds!);
    final times = <DateTime>[];
    if (!repeats) {
      final at = onceAt;
      if (at != null && at.isAfter(now) && !at.isAfter(end)) times.add(at);
    } else {
      final local = inZone(now, zone);
      for (var i = 0; i <= horizon.inDays + 1; i++) {
        final t = tz.TZDateTime(local.location, local.year, local.month, local.day + i, hour, minute);
        if (!days.contains(t.weekday)) continue;
        final utc = t.toUtc();
        if (utc.isAfter(now) && !utc.isAfter(end)) times.add(utc);
      }
    }
    return [
      for (final at in times)
        ScheduledAlarm(
          id: stableId('user|$id|${at.millisecondsSinceEpoch ~/ 60000}'),
          at: at,
          title: title,
          body: repeatLabel == 'Once' ? 'Alarm' : repeatLabel,
          ringDuration: ring,
          ruleId: 'user.$id',
          eventId: 'user.$id',
          offset: Duration.zero,
          soundId: soundId,
        ),
    ];
  }

  UserAlarm copyWith({
    int? hour,
    int? minute,
    Set<int>? days,
    String? label,
    int? ringSeconds,
    bool clearRingSeconds = false,
    bool? enabled,
    DateTime? onceAt,
    String? soundId,
    bool defaultSound = false,
  }) => UserAlarm(
    id: id,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    days: days ?? this.days,
    label: label ?? this.label,
    ringSeconds: clearRingSeconds ? null : (ringSeconds ?? this.ringSeconds),
    enabled: enabled ?? this.enabled,
    onceAt: onceAt ?? this.onceAt,
    soundId: defaultSound ? null : (soundId ?? this.soundId),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'hour': hour,
    'minute': minute,
    'days': days.toList()..sort(),
    'label': label,
    'ringSeconds': ringSeconds,
    'enabled': enabled,
    'onceAt': onceAt?.toIso8601String(),
    'soundId': soundId,
  };

  factory UserAlarm.fromJson(Map<String, dynamic> j) => UserAlarm(
    id: j['id'] as String,
    hour: (j['hour'] as num).toInt(),
    minute: (j['minute'] as num).toInt(),
    days: {for (final d in (j['days'] as List? ?? const [])) (d as num).toInt()},
    label: j['label'] as String? ?? '',
    ringSeconds: (j['ringSeconds'] as num?)?.toInt(),
    enabled: j['enabled'] as bool? ?? true,
    onceAt: j['onceAt'] == null ? null : DateTime.parse(j['onceAt'] as String).toUtc(),
    soundId: j['soundId'] as String?,
  );
}
