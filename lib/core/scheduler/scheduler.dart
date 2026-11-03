import '../../features/events/domain/event.dart';
import '../../features/ringing/ring_style.dart';
import '../../features/rules/domain/alarm_rule.dart';
import '../util/format.dart';

/// One concrete ring at an exact moment.
class ScheduledAlarm {
  const ScheduledAlarm({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
    required this.ringDuration,
    required this.ruleId,
    required this.eventId,
    required this.offset,
    this.soundId,
    this.style = RingStyle.none,
  });

  /// Stable across re-planning, so the same alarm is never registered twice.
  final int id;
  final DateTime at;
  final String title;
  final String body;
  final Duration ringDuration;
  final String ruleId;
  final String eventId;
  final Duration offset;

  /// The sound to ring with. null = the default sound.
  final String? soundId;

  /// How this alarm rings and stops, beyond the shared settings.
  final RingStyle style;

  @override
  String toString() => 'ScheduledAlarm(${at.toIso8601String()}, $title, $body)';
}

/// Turns rules + events into the alarms to register with the phone.
///
/// Phones limit how many alarms an app may register, so only the next
/// [horizon] is planned. The app re-plans daily, after a reboot, and whenever
/// a rule or event changes.
class Scheduler {
  const Scheduler({this.horizon = const Duration(days: 7)});

  final Duration horizon;

  /// The window of events needed to plan from [now]: alarms can sit up to
  /// `maxBefore` ahead of their event and `maxAfter` behind it.
  ({DateTime from, DateTime to}) eventWindow(DateTime now, Iterable<AlarmRule> rules) {
    var maxBefore = Duration.zero;
    var maxAfter = Duration.zero;
    for (final r in rules.where((r) => r.enabled)) {
      if (r.maxBefore > maxBefore) maxBefore = r.maxBefore;
      if (r.maxAfter > maxAfter) maxAfter = r.maxAfter;
    }
    return (from: now.subtract(maxAfter), to: now.add(horizon).add(maxBefore));
  }

  List<ScheduledAlarm> plan({
    required DateTime now,
    required Iterable<AnchorEvent> events,
    required Iterable<AlarmRule> rules,
  }) {
    final end = now.add(horizon);
    final byMinute = <String, ScheduledAlarm>{};

    // Labelled rules (reminders) go first, so their text wins a shared minute.
    final ordered = rules.where((r) => r.enabled).toList()
      ..sort((a, b) => (a.label == null ? 1 : 0).compareTo(b.label == null ? 1 : 0));
    for (final rule in ordered) {
      for (final event in events.where(rule.matches)) {
        for (final offset in rule.offsets()) {
          final at = event.at.add(offset);
          if (!at.isAfter(now) || at.isAfter(end)) continue;

          // Two rules asking for the same minute on the same event ring once.
          final minuteKey = '${event.id}|${at.millisecondsSinceEpoch ~/ 60000}';
          byMinute.putIfAbsent(
            minuteKey,
            () => ScheduledAlarm(
              id: stableId('${rule.id}|${event.id}|${offset.inMinutes}'),
              at: at,
              title: event.title,
              body: rule.label ?? (offset == Duration.zero ? 'Now' : describeOffset(offset)),
              ringDuration: rule.ringDuration,
              ruleId: rule.id,
              eventId: event.id,
              offset: offset,
              soundId: rule.soundId,
              style: rule.style,
            ),
          );
        }
      }
    }

    return byMinute.values.toList()..sort((a, b) => a.at.compareTo(b.at));
  }
}
