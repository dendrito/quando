import '../../events/domain/event.dart';
import 'calendar_sync.dart';
import '../../ringing/ring_style.dart';
import '../../rules/domain/alarm_rule.dart';
import '../../rules/domain/reminder_delivery.dart';

import 'package:quando/l10n/l10n.dart';

/// Alarms around calendar events, as the user sets them up: "15 minutes and
/// 1 hour before every event containing 'dentist'", "every day for a week
/// before", "5 minutes after it ends".
class CalendarRule {
  const CalendarRule({
    required this.id,
    this.name = '',
    this.keyword = '',
    this.calendarIds = const {},
    this.before = const [],
    this.atStart = false,
    this.after = const [],
    this.repeatEvery,
    this.repeatFor,
    this.enabled = true,
    this.soundId,
    this.includeTimes = false,
    this.style = RingStyle.none,
    this.deliveries = const {},
    this.eventReminders = false,
    this.busy = false,
    this.days = const {},
    this.sync = CalendarSync.live,
  });

  /// How the rule follows the calendar after it is saved: live (default),
  /// keep each event as first seen, or only the events there when saved.
  final CalendarSync sync;

  /// Only on these weekdays, 1 = Monday ... 7 = Sunday. Empty = any day.
  final Set<int> days;

  final String id;
  final String name;

  /// A search over event titles: words, wildcards, AND / OR / NOT, see
  /// EventQuery. Empty = every event.
  final String keyword;

  /// Also search Shabbat, festival, sunrise and sunset times, not only
  /// calendar events.
  final bool includeTimes;

  /// Only these calendars. Empty = every calendar you picked.
  final Set<String> calendarIds;

  /// Before the event starts.
  final List<Duration> before;
  final bool atStart;

  /// After the event ends.
  final List<Duration> after;

  /// "Every [repeatEvery] for [repeatFor] before it starts".
  final Duration? repeatEvery;
  final Duration? repeatFor;

  final bool enabled;

  /// null = the default sound.
  final String? soundId;

  /// Volume, fades, tasks and more for these alarms.
  final RingStyle style;

  /// Negative offsets are before start; positive offsets are after end.
  /// Zero applies to the selected anchor moment.
  final Map<int, ReminderDelivery> deliveries;

  /// Also ring, loud, at each event's own reminders from the calendar app.
  final bool eventReminders;

  /// Busy mode from each matching event's start to its end.
  final bool busy;

  String get title {
    if (name.isNotEmpty) return name;
    if (keyword.isNotEmpty) return l10n.eventsMatching(keyword);
    return l10n.everyEvent;
  }

  bool get hasAlarms => eventReminders || before.isNotEmpty || atStart || after.isNotEmpty || _series != null;

  OffsetSeries? get _series => repeatEvery != null && repeatFor != null && repeatEvery! > Duration.zero
      ? OffsetSeries(direction: Direction.before, every: repeatEvery!, span: repeatFor!)
      : null;

  /// The scheduler's rules for this: one off the start, one off the end.
  List<AlarmRule> toAlarmRules() {
    final sources = calendarIds.isEmpty ? null : calendarIds;
    final kw = keyword.trim().isEmpty ? null : keyword.trim();
    final owner = sync == CalendarSync.live ? null : id;
    return [
      AlarmRule(
        id: 'cal.$id.start',
        name: title,
        appliesTo: const {EventKind.calendar},
        before: before,
        atEvent: atStart,
        series: [?_series],
        enabled: enabled,
        sources: sources,
        keyword: kw,
        soundId: soundId,
        style: style,
        deliveries: deliveries,
        eventReminders: eventReminders,
        days: days,
        owner: owner,
      ),
      AlarmRule(
        id: 'cal.$id.end',
        name: title,
        appliesTo: const {EventKind.calendarEnd},
        after: after,
        enabled: enabled && after.isNotEmpty,
        sources: sources,
        keyword: kw,
        soundId: soundId,
        style: style,
        deliveries: deliveries,
        days: days,
        owner: owner,
      ),
      // Shabbat, festival and sun times are single moments: before, at and
      // after all hang off the moment itself.
      AlarmRule(
        id: 'cal.$id.times',
        name: title,
        appliesTo: const {
          EventKind.holyDayStart,
          EventKind.secondNightCandles,
          EventKind.holyDayEnd,
          EventKind.sunrise,
          EventKind.sunset,
        },
        before: before,
        atEvent: atStart,
        after: after,
        series: [?_series],
        enabled: enabled && includeTimes,
        keyword: kw,
        soundId: soundId,
        style: style,
        deliveries: deliveries,
        days: days,
      ),
    ];
  }

  /// A calendar event (start or end) this rule looks for, whatever it
  /// would ring for it. Used to remember events.
  bool wants(AnchorEvent e) {
    if (!e.kind.isCalendar || e.owner != null) return false;
    final r = toAlarmRules();
    final live = (e.kind == EventKind.calendar ? r[0] : r[1]);
    return AlarmRule(
      id: live.id,
      name: live.name,
      appliesTo: live.appliesTo,
      sources: live.sources,
      keyword: live.keyword,
      days: live.days,
    ).matches(e);
  }

  /// What decides which events the rule finds. When it changes, what the
  /// rule remembered starts again.
  String get searchKey => [keyword.trim(), (calendarIds.toList()..sort()).join(','), sync.name].join('|');

  CalendarRule copyWith({
    String? name,
    String? keyword,
    Set<String>? calendarIds,
    List<Duration>? before,
    bool? atStart,
    List<Duration>? after,
    Duration? repeatEvery,
    Duration? repeatFor,
    bool clearRepeat = false,
    bool? enabled,
    String? soundId,
    RingStyle? style,
    Map<int, ReminderDelivery>? deliveries,
    bool defaultSound = false,
    bool? includeTimes,
    bool? eventReminders,
    bool? busy,
    Set<int>? days,
    CalendarSync? sync,
  }) => CalendarRule(
    id: id,
    name: name ?? this.name,
    keyword: keyword ?? this.keyword,
    calendarIds: calendarIds ?? this.calendarIds,
    before: before ?? this.before,
    atStart: atStart ?? this.atStart,
    after: after ?? this.after,
    repeatEvery: clearRepeat ? null : (repeatEvery ?? this.repeatEvery),
    repeatFor: clearRepeat ? null : (repeatFor ?? this.repeatFor),
    enabled: enabled ?? this.enabled,
    soundId: defaultSound ? null : (soundId ?? this.soundId),
    style: style ?? this.style,
    deliveries: deliveries ?? this.deliveries,
    includeTimes: includeTimes ?? this.includeTimes,
    eventReminders: eventReminders ?? this.eventReminders,
    busy: busy ?? this.busy,
    days: days ?? this.days,
    sync: sync ?? this.sync,
  );

  static List<int> _mins(List<Duration> l) => [for (final d in l) d.inMinutes];
  static List<Duration> _durs(Object? l) => [
    for (final m in (l as List? ?? const [])) Duration(minutes: (m as num).toInt()),
  ];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'keyword': keyword,
    'calendarIds': calendarIds.toList(),
    'before': _mins(before),
    'atStart': atStart,
    'after': _mins(after),
    'repeatEvery': repeatEvery?.inMinutes,
    'repeatFor': repeatFor?.inMinutes,
    'enabled': enabled,
    'soundId': soundId,
    'style': style.toJson(),
    if (deliveries.isNotEmpty) 'deliveries': ReminderDelivery.encode(deliveries),
    'includeTimes': includeTimes,
    if (eventReminders) 'eventReminders': true,
    if (busy) 'busy': true,
    if (days.isNotEmpty) 'days': days.toList()..sort(),
    if (sync != CalendarSync.live) 'sync': sync.name,
  };

  factory CalendarRule.fromJson(Map<String, dynamic> j) => CalendarRule(
    id: j['id'] as String,
    name: j['name'] as String? ?? '',
    keyword: j['keyword'] as String? ?? '',
    calendarIds: {for (final c in (j['calendarIds'] as List? ?? const [])) c as String},
    before: _durs(j['before']),
    atStart: j['atStart'] as bool? ?? false,
    after: _durs(j['after']),
    repeatEvery: j['repeatEvery'] == null ? null : Duration(minutes: (j['repeatEvery'] as num).toInt()),
    repeatFor: j['repeatFor'] == null ? null : Duration(minutes: (j['repeatFor'] as num).toInt()),
    enabled: j['enabled'] as bool? ?? true,
    soundId: j['soundId'] as String?,
    style: RingStyle.fromJson(j['style']),
    deliveries: ReminderDelivery.decode(j['deliveries']),
    includeTimes: j['includeTimes'] as bool? ?? false,
    eventReminders: j['eventReminders'] as bool? ?? false,
    busy: j['busy'] as bool? ?? false,
    days: {for (final d in (j['days'] as List? ?? const [])) (d as num).toInt()},
    sync: CalendarSync.values.where((s) => s.name == j['sync']).firstOrNull ?? CalendarSync.live,
  );
}
