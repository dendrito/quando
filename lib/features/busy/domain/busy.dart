import 'dart:convert';

import '../../../core/scheduler/scheduler.dart';
import '../../calendar/domain/calendar_rule.dart';
import '../../events/domain/event.dart';
import '../../lock/domain/lock.dart';

/// A messaging app Busy mode can answer for you (Android only).
class ReplyApp {
  const ReplyApp(this.package, this.name);

  final String package;
  final String name;

  static const known = [
    ReplyApp('com.whatsapp', 'WhatsApp'),
    ReplyApp('com.whatsapp.w4b', 'WhatsApp Business'),
    ReplyApp('org.telegram.messenger', 'Telegram'),
    ReplyApp('com.google.android.apps.messaging', 'Messages'),
    ReplyApp('com.samsung.android.messaging', 'Samsung Messages'),
    ReplyApp('org.thoughtcrime.securesms', 'Signal'),
  ];
}

/// How Busy mode behaves, whatever switched it on.
class BusySettings {
  const BusySettings({
    this.dnd = true,
    this.replies = false,
    this.replyText = '',
    this.apps = const {'com.whatsapp', 'com.whatsapp.w4b'},
    this.groups = false,
    this.duringLock = false,
    this.repliesOnShabbat = false,
  });

  /// Turn on Do Not Disturb (alarms still ring) while busy.
  final bool dnd;

  /// Answer messages while busy, once per person.
  final bool replies;

  /// The answer. `{until}` becomes the time Busy mode ends. Empty = the
  /// default text in your language.
  final String replyText;

  final Set<String> apps;

  /// Also answer in group chats. Off: groups are never answered.
  final bool groups;

  /// Busy while lock mode is on (Shabbat and festivals, calendar locks).
  final bool duringLock;

  /// Answer messages during Shabbat and festivals too. Off by default:
  /// ask your rabbi.
  final bool repliesOnShabbat;

  BusySettings copyWith({
    bool? dnd,
    bool? replies,
    String? replyText,
    Set<String>? apps,
    bool? groups,
    bool? duringLock,
    bool? repliesOnShabbat,
  }) => BusySettings(
    dnd: dnd ?? this.dnd,
    replies: replies ?? this.replies,
    replyText: replyText ?? this.replyText,
    apps: apps ?? this.apps,
    groups: groups ?? this.groups,
    duringLock: duringLock ?? this.duringLock,
    repliesOnShabbat: repliesOnShabbat ?? this.repliesOnShabbat,
  );

  Map<String, dynamic> toJson() => {
    'dnd': dnd,
    'replies': replies,
    'replyText': replyText,
    'apps': apps.toList()..sort(),
    'groups': groups,
    'duringLock': duringLock,
    'repliesOnShabbat': repliesOnShabbat,
  };

  factory BusySettings.fromJson(Map<String, dynamic> j) => BusySettings(
    dnd: j['dnd'] as bool? ?? true,
    replies: j['replies'] as bool? ?? false,
    replyText: j['replyText'] as String? ?? '',
    apps: {
      for (final a in (j['apps'] as List? ?? const ['com.whatsapp', 'com.whatsapp.w4b'])) a as String,
    },
    groups: j['groups'] as bool? ?? false,
    duringLock: j['duringLock'] as bool? ?? false,
    repliesOnShabbat: j['repliesOnShabbat'] as bool? ?? false,
  );

  static BusySettings decode(String? raw) {
    if (raw == null) return const BusySettings();
    try {
      return BusySettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const BusySettings();
    }
  }
}

/// A stretch of time when you're busy.
class BusyWindow {
  const BusyWindow({required this.id, required this.start, required this.end, required this.label});

  final String id;
  final DateTime start;
  final DateTime end;

  /// What made you busy, e.g. the event's title.
  final String label;

  bool contains(DateTime t) => !t.isBefore(start) && t.isBefore(end);

  List<Object> toWire() => [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch, id];

  @override
  String toString() => 'BusyWindow($label, $start → $end)';
}

/// Every busy stretch from [now] to [until]:
/// * calendar alarms set to "Busy during these events": from each event's
///   start to its end;
/// * alarms with "Busy after it rings": from the ring for that long;
/// * lock mode, when [BusySettings.duringLock] is on.
List<BusyWindow> busyWindows({
  required DateTime now,
  required DateTime until,
  required List<AnchorEvent> events,
  required List<CalendarRule> calendarRules,
  required List<ScheduledAlarm> plan,
  required Map<String, int> busyMinutesByAlarm,
  required List<LockPeriod> locks,
  required BusySettings settings,
}) {
  final out = <BusyWindow>[];
  final ends = {
    for (final e in events)
      if (e.kind == EventKind.calendarEnd) e.id: e.at,
  };
  for (final r in calendarRules.where((r) => r.enabled && r.busy)) {
    final start = r.toAlarmRules().first.copyWith(enabled: true);
    for (final e in events.where((e) => e.kind == EventKind.calendar && start.matches(e))) {
      final end = ends[e.id.replaceFirst('cal.', 'calend.')];
      if (end == null || !end.isAfter(e.at)) continue;
      out.add(BusyWindow(id: 'cal.${r.id}.${e.id}', start: e.at, end: end, label: e.title));
    }
  }
  for (final a in plan) {
    if (!a.ruleId.startsWith('user.')) continue;
    final minutes = busyMinutesByAlarm[a.ruleId.substring(5)] ?? 0;
    if (minutes <= 0) continue;
    out.add(
      BusyWindow(
        id: 'alarm.${a.id}',
        start: a.at,
        end: a.at.add(Duration(minutes: minutes)),
        label: a.title,
      ),
    );
  }
  if (settings.duringLock) {
    for (final p in locks) {
      out.add(BusyWindow(id: 'lock.${p.id}', start: p.start, end: p.end, label: p.reason));
    }
  }
  return out.where((w) => w.end.isAfter(now) && w.start.isBefore(until)).toList()
    ..sort((a, b) => a.start.compareTo(b.start));
}
