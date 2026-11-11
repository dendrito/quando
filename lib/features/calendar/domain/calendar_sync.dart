import '../../events/domain/event.dart';
import 'calendar_rule.dart';

/// How a calendar rule follows the calendar after it is saved.
enum CalendarSync {
  /// Follow the calendar (default): new matching events get alarms, a moved
  /// event moves its alarms, a deleted or cancelled event loses them.
  live,

  /// Keep what I first saw: new matching events still get alarms, but each
  /// event's alarms stay where they were when Quando? first saw it, even if
  /// it later moves or is deleted.
  keepFirst,

  /// Only events that exist now: the matching events there when the rule is
  /// saved, as they were then. Nothing new is added later.
  snapshot,
}

/// What one rule remembers: the events it has seen, as it first saw them.
class RuleMemory {
  const RuleMemory({required this.key, this.events = const {}});

  /// [CalendarRule.searchKey] when this was filled. A new search starts over.
  final String key;

  /// By event id.
  final Map<String, AnchorEvent> events;

  Map<String, dynamic> toJson() => {
    'key': key,
    'events': [for (final e in events.values) e.toJson()],
  };

  static RuleMemory? fromJson(Object? j) {
    if (j is! Map) return null;
    final events = <String, AnchorEvent>{};
    for (final raw in (j['events'] as List? ?? const [])) {
      final e = raw is Map ? AnchorEvent.fromJson(raw.cast<String, dynamic>()) : null;
      if (e != null) events[e.id] = e;
    }
    return RuleMemory(key: j['key'] as String? ?? '', events: events);
  }
}

/// How long a past event is kept in memory, so an alarm "after it ends"
/// still has its event.
const _keepPast = Duration(days: 2);

/// Updates what each rule remembers from the calendar as read just now
/// ([events]). Live rules remember nothing. Rules not in [rules] are
/// forgotten.
Map<String, RuleMemory> rememberEvents({
  required List<CalendarRule> rules,
  required List<AnchorEvent> events,
  required Map<String, RuleMemory> memory,
  required DateTime now,
}) {
  final out = <String, RuleMemory>{};
  final cutoff = now.subtract(_keepPast);
  for (final rule in rules) {
    if (rule.sync == CalendarSync.live) continue;
    final old = memory[rule.id];
    final fresh = old == null || old.key != rule.searchKey;
    final kept = <String, AnchorEvent>{
      if (!fresh)
        for (final e in old.events.values)
          if (e.at.isAfter(cutoff)) e.id: e,
    };
    // "Only events that exist now" looks once, when the rule is new or its
    // search changed. "Keep what I first saw" adds every new event it meets.
    if (fresh || rule.sync == CalendarSync.keepFirst) {
      // An event's end goes with its start, whatever the end is called.
      final starts = {
        for (final e in events)
          if (e.kind == EventKind.calendar && rule.wants(e)) e.id,
      };
      for (final e in events) {
        if (kept.containsKey(e.id) || !e.at.isAfter(cutoff)) continue;
        final wanted = e.kind == EventKind.calendarEnd
            ? starts.contains(e.id.replaceFirst('calend.', 'cal.')) || rule.wants(e)
            : starts.contains(e.id);
        if (wanted) kept[e.id] = e.ownedBy(null);
      }
    }
    out[rule.id] = RuleMemory(key: rule.searchKey, events: kept);
  }
  return out;
}

/// Each remembered event, as its rule's own copy, to plan alongside the
/// live calendar.
List<AnchorEvent> rememberedEvents(List<CalendarRule> rules, Map<String, RuleMemory> memory) => [
  for (final rule in rules)
    if (rule.sync != CalendarSync.live && memory[rule.id]?.key == rule.searchKey)
      for (final e in memory[rule.id]!.events.values) e.ownedBy(rule.id),
];
