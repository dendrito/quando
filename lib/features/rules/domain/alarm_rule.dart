import '../../events/domain/event.dart';

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
    this.label,
    this.sources,
    this.keyword,
    this.soundId,
  });

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

  final bool enabled;

  /// Text shown and spoken instead of "1 hour before", e.g. a reminder.
  final String? label;

  /// Only events from these sources (e.g. calendar ids). null = any.
  final Set<String>? sources;

  /// Only events whose title contains this, ignoring case. null = any.
  final String? keyword;

  /// The sound to ring with. null = the default sound.
  final String? soundId;

  bool matches(AnchorEvent e) =>
      appliesTo.contains(e.kind) &&
      (sources == null || sources!.contains(e.source)) &&
      (keyword == null || keyword!.isEmpty || e.title.toLowerCase().contains(keyword!.toLowerCase()));

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
  }) => AlarmRule(
    id: id,
    name: name,
    appliesTo: appliesTo,
    before: before ?? this.before,
    after: after ?? this.after,
    series: series ?? this.series,
    atEvent: atEvent ?? this.atEvent,
    ringDuration: ringDuration ?? this.ringDuration,
    enabled: enabled ?? this.enabled,
    label: label,
    sources: sources,
    keyword: keyword,
    soundId: defaultSound ? null : (soundId ?? this.soundId),
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
  };

  AlarmRule withCustom(Map<String, dynamic> j) {
    final mins = (j['offsets'] as List?)?.map((m) => Duration(minutes: (m as num).toInt()));
    final r = mins == null ? this : withOffsets(mins);
    final sound = j['soundId'] as String?;
    return sound == null ? r.copyWith(defaultSound: true) : r.copyWith(soundId: sound);
  }
}
