import 'package:timezone/timezone.dart' as tz;

import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../ringing/ring_style.dart';

import 'package:quando/l10n/l10n.dart';

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
    this.zone,
    this.group = '',
    this.style = RingStyle.none,
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

  /// Rings at this time in this zone, e.g. 7:00 in New York. null = your
  /// home zone.
  final String? zone;

  /// A name the user files this alarm under, e.g. "Work" or "Kids".
  /// Empty = no group.
  final String group;

  /// Volume, fades, gentle wake-up, tasks and more for this alarm.
  final RingStyle style;

  bool get repeats => days.isNotEmpty;

  String get title => label.isEmpty ? l10n.alarm : label;

  /// "Weekdays", "Every day", "Mon, Wed" or "Once".
  String get repeatLabel {
    if (days.isEmpty) return l10n.once;
    if (days.length == 7) return l10n.everyDay;
    if (days.length == 5 && !days.contains(6) && !days.contains(7))
      return l10n.weekdays;
    if (days.length == 2 && days.contains(6) && days.contains(7))
      return l10n.weekends;
    return [
      for (var d = 1; d <= 7; d++)
        if (days.contains(d)) weekdayShort(d),
    ].join(', ');
  }

  /// The next time this alarm rings after [now], in [zone]'s wall clock.
  static DateTime nextAt(int hour, int minute, DateTime now, String zone) {
    final local = inZone(now, zone);
    var t = tz.TZDateTime(
      local.location,
      local.year,
      local.month,
      local.day,
      hour,
      minute,
    );
    if (!t.isAfter(local)) {
      t = tz.TZDateTime(
        local.location,
        local.year,
        local.month,
        local.day + 1,
        hour,
        minute,
      );
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
    zone = this.zone ?? zone;
    final end = now.add(horizon);
    final ring = ringSeconds == null
        ? defaultRing
        : Duration(seconds: ringSeconds!);
    final times = <DateTime>[];
    if (!repeats) {
      final at = onceAt;
      if (at != null && at.isAfter(now) && !at.isAfter(end)) times.add(at);
    } else {
      final local = inZone(now, zone);
      for (var i = 0; i <= horizon.inDays + 1; i++) {
        final t = tz.TZDateTime(
          local.location,
          local.year,
          local.month,
          local.day + i,
          hour,
          minute,
        );
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
          body: [
            days.isEmpty ? l10n.alarm : repeatLabel,
            if (this.zone != null)
              l10n.timeInCity(
                hhmm(DateTime(2000, 1, 1, hour, minute)),
                cityOf(this.zone!),
              ),
          ].join(' · '),
          ringDuration: ring,
          ruleId: 'user.$id',
          eventId: 'user.$id',
          offset: Duration.zero,
          soundId: soundId,
          style: style,
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
    String? zone,
    bool homeZone = false,
    String? group,
    RingStyle? style,
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
    zone: homeZone ? null : (zone ?? this.zone),
    group: group ?? this.group,
    style: style ?? this.style,
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
    'zone': zone,
    'group': group,
    'style': style.toJson(),
  };

  factory UserAlarm.fromJson(Map<String, dynamic> j) => UserAlarm(
    id: j['id'] as String,
    hour: (j['hour'] as num).toInt(),
    minute: (j['minute'] as num).toInt(),
    days: {
      for (final d in (j['days'] as List? ?? const [])) (d as num).toInt(),
    },
    label: j['label'] as String? ?? '',
    ringSeconds: (j['ringSeconds'] as num?)?.toInt(),
    enabled: j['enabled'] as bool? ?? true,
    onceAt: j['onceAt'] == null
        ? null
        : DateTime.parse(j['onceAt'] as String).toUtc(),
    soundId: j['soundId'] as String?,
    zone: j['zone'] as String?,
    group: (j['group'] as String? ?? '').trim(),
    style: RingStyle.fromJson(j['style']),
  );
}
