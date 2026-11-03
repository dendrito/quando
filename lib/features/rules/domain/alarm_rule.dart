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

  bool matches(AnchorEvent e) => appliesTo.contains(e.kind);

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

  AlarmRule copyWith({bool? enabled, Duration? ringDuration}) => AlarmRule(
    id: id,
    name: name,
    appliesTo: appliesTo,
    before: before,
    after: after,
    series: series,
    atEvent: atEvent,
    ringDuration: ringDuration ?? this.ringDuration,
    enabled: enabled ?? this.enabled,
    label: label,
  );
}
