import '../../events/domain/event.dart';
import '../../ringing/ring_style.dart';
import '../../rules/domain/alarm_rule.dart';

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
  });

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

  String get title {
    if (name.isNotEmpty) return name;
    if (keyword.isNotEmpty) return 'Events matching "$keyword"';
    return 'Every event';
  }

  bool get hasAlarms => before.isNotEmpty || atStart || after.isNotEmpty || _series != null;

  OffsetSeries? get _series => repeatEvery != null && repeatFor != null && repeatEvery! > Duration.zero
      ? OffsetSeries(direction: Direction.before, every: repeatEvery!, span: repeatFor!)
      : null;

  /// The scheduler's rules for this: one off the start, one off the end.
  List<AlarmRule> toAlarmRules() {
    final sources = calendarIds.isEmpty ? null : calendarIds;
    final kw = keyword.trim().isEmpty ? null : keyword.trim();
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
      ),
    ];
  }

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
    bool defaultSound = false,
    bool? includeTimes,
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
    includeTimes: includeTimes ?? this.includeTimes,
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
    'includeTimes': includeTimes,
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
    includeTimes: j['includeTimes'] as bool? ?? false,
  );
}
