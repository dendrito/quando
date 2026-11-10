import '../../events/domain/event.dart';
import 'reminder_delivery.dart';
import '../../events/domain/event_query.dart';
import '../../ringing/ring_style.dart';

enum Direction { before, after }

/// "Every [every], for [span] before/after the event", e.g. every hour for
/// 6 hours before, or every day for a week before.
class OffsetSeries {
  const OffsetSeries({required this.direction, required this.every, required this.span});

  final Direction direction;
  final Duration every;
  final Duration span;

  /// Offsets from the event, negative = before. The event moment itself is
  /// not included.
  Iterable<Duration> offsets() sync* {
    if (every <= Duration.zero) return;
    for (var d = every; d <= span; d += every) {
      yield direction == Direction.before ? -d : d;
    }
  }
}

/// "Alarms before and/or after an event". Presets are ready-made rules.
class AlarmRule {
  const AlarmRule({
    required this.id,
    required this.name,
    required this.appliesTo,
    this.before = const [],
    this.after = const [],
    this.series = const [],
    this.atEvent = false,
    this.ringDuration = const Duration(minutes: 1),
    this.enabled = true,
    this.useRingDuration = false,
    this.label,
    this.sources,
    this.keyword,
    this.soundId,
    this.style = RingStyle.none,
    this.deliveries = const {},
    this.days = const {},
  });

  /// Only events on these weekdays (1 = Monday ... 7 = Sunday, local
  /// time). Empty = any day.
  final Set<int> days;

  final String id;
  final String name;

  /// Which kinds of event this rule hangs off.
  final Set<EventKind> appliesTo;

  /// Single offsets before the event, e.g. 2h, 1h, 30m.
  final List<Duration> before;

  /// Single offsets after the event.
  final List<Duration> after;

  final List<OffsetSeries> series;

  /// Also ring at the exact moment of the event.
  final bool atEvent;

  /// How long the alarm rings before stopping by itself.
  final Duration ringDuration;
  final bool useRingDuration;

  final bool enabled;

  /// Text shown and spoken instead of "1 hour before", e.g. a reminder.
  final String? label;

  /// Only events from these sources (e.g. calendar ids). null = any.
  final Set<String>? sources;

  /// Only events whose title contains this, ignoring case. null = any.
  final String? keyword;

  /// The sound to ring with. null = the default sound.
  final String? soundId;

  /// Volume, fades, tasks and more for this rule's alarms.
  final RingStyle style;

  /// Overrides by signed minute offset; missing entries inherit this rule.
  final Map<int, ReminderDelivery> deliveries;

  ReminderDelivery deliveryAt(Duration offset) => deliveries[offset.inMinutes] ?? ReminderDelivery.inherit;

  /// [keyword] is a search: words, wildcards, AND / OR / NOT (see
  /// [EventQuery]). [sources] only narrows calendar events, so a rule can
  /// also catch Shabbat, festival and sun times.
  bool matches(AnchorEvent e) =>
      appliesTo.contains(e.kind) &&
      (days.isEmpty || days.contains(e.at.toLocal().weekday)) &&
      (sources == null || !e.kind.isCalendar || sources!.contains(e.source)) &&
      (keyword == null || keyword!.isEmpty || _search(keyword!, e));

  static bool _search(String keyword, AnchorEvent e) {
    final q = EventQuery.parse(keyword);
    return q.matches(e.title) || (e.alias != null && q.matches(e.alias!));
  }

  /// Every offset from the event, negative = before, duplicates removed,
  /// sorted earliest first.
  List<Duration> offsets() {
    final all = <Duration>{
      ...before.map((d) => -d),
      ...after,
      for (final s in series) ...s.offsets(),
      if (atEvent) Duration.zero,
    }.toList()..sort();
    return all;
  }

  /// The furthest before and after any alarm can be, so callers know how
  /// wide a window of events they need.
  Duration get maxBefore => offsets().fold(Duration.zero, (m, d) => d < -m ? -d : m);
  Duration get maxAfter => offsets().fold(Duration.zero, (m, d) => d > m ? d : m);

  AlarmRule copyWith({
    bool? enabled,
    Duration? ringDuration,
    List<Duration>? before,
    List<Duration>? after,
    List<OffsetSeries>? series,
    bool? atEvent,
    String? soundId,
    bool defaultSound = false,
    RingStyle? style,
    Map<int, ReminderDelivery>? deliveries,
  }) => AlarmRule(
    id: id,
    name: name,
    appliesTo: appliesTo,
    before: before ?? this.before,
    after: after ?? this.after,
    series: series ?? this.series,
    atEvent: atEvent ?? this.atEvent,
    ringDuration: ringDuration ?? this.ringDuration,
    useRingDuration: ringDuration != null || useRingDuration,
    enabled: enabled ?? this.enabled,
    label: label,
    sources: sources,
    keyword: keyword,
    soundId: defaultSound ? null : (soundId ?? this.soundId),
    style: style ?? this.style,
    deliveries: deliveries ?? this.deliveries,
    days: days,
  );

  /// The same rule ringing at exactly [offsets] (negative = before, zero =
  /// at the event), with any series spelled out.
  AlarmRule withOffsets(Iterable<Duration> offsets) {
    final all = offsets.toSet();
    return copyWith(
      before: [for (final d in all.where((d) => d.isNegative).toList()..sort()) -d],
      after: [for (final d in all.where((d) => d > Duration.zero).toList()..sort()) d],
      series: const [],
      atEvent: all.contains(Duration.zero),
    );
  }

  /// What a user changed on a preset, to keep across restarts.
  Map<String, dynamic> customJson() => {
    'offsets': [for (final d in offsets()) d.inMinutes],
    'soundId': soundId,
    if (useRingDuration) 'ringSeconds': ringDuration.inSeconds,
    'style': style.toJson(),
    if (deliveries.isNotEmpty) 'deliveries': ReminderDelivery.encode(deliveries),
  };

  AlarmRule withCustom(Map<String, dynamic> j) {
    final mins = (j['offsets'] as List?)?.map((m) => Duration(minutes: (m as num).toInt()));
    final r = mins == null ? this : withOffsets(mins);
    final sound = j['soundId'] as String?;
    final styled = r.copyWith(
      ringDuration: j['ringSeconds'] == null
          ? null
          : Duration(seconds: (j['ringSeconds'] as num).toInt().clamp(1, 3600)),
      style: RingStyle.fromJson(j['style']),
      deliveries: ReminderDelivery.decode(j['deliveries']),
    );
    return sound == null ? styled.copyWith(defaultSound: true) : styled.copyWith(soundId: sound);
  }
}
