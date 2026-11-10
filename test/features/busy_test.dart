import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/busy/domain/busy.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/lock/domain/lock.dart';

void main() {
  final now = DateTime.utc(2026, 11, 12, 8);
  final until = now.add(const Duration(days: 7));
  final meeting = AnchorEvent(
    id: 'cal.9',
    kind: EventKind.calendar,
    title: 'Team meeting',
    at: DateTime.utc(2026, 11, 12, 10),
    source: 'work',
  );
  final meetingEnd = AnchorEvent(
    id: 'calend.9',
    kind: EventKind.calendarEnd,
    title: 'Team meeting ends',
    at: DateTime.utc(2026, 11, 12, 11),
    source: 'work',
  );
  final lunch = AnchorEvent(
    id: 'cal.10',
    kind: EventKind.calendar,
    title: 'Lunch',
    at: DateTime.utc(2026, 11, 12, 12),
    source: 'work',
  );

  List<BusyWindow> windows({
    List<CalendarRule> rules = const [],
    List<ScheduledAlarm> plan = const [],
    Map<String, int> minutes = const {},
    List<LockPeriod> locks = const [],
    BusySettings settings = const BusySettings(),
  }) => busyWindows(
    now: now,
    until: until,
    events: [meeting, meetingEnd, lunch],
    calendarRules: rules,
    plan: plan,
    busyMinutesByAlarm: minutes,
    locks: locks,
    settings: settings,
  );

  test('a busy calendar alarm makes you busy from start to end of matching events', () {
    final w = windows(
      rules: const [CalendarRule(id: 'r', keyword: 'meeting', busy: true)],
    );
    expect(w, hasLength(1));
    expect(w.single.start, meeting.at);
    expect(w.single.end, meetingEnd.at);
    expect(w.single.label, 'Team meeting');
    // Lunch has no end event here: skipped.
    expect(windows(rules: const [CalendarRule(id: 'r', busy: true)]), hasLength(1));
  });

  test('calendar alarms without Busy, or switched off, do nothing', () {
    expect(
      windows(
        rules: const [CalendarRule(id: 'r', keyword: 'meeting')],
      ),
      isEmpty,
    );
    expect(windows(rules: const [CalendarRule(id: 'r', busy: true, enabled: false)]), isEmpty);
  });

  test('an alarm can make you busy for a while after it rings', () {
    final alarm = ScheduledAlarm(
      id: 5,
      at: DateTime.utc(2026, 11, 12, 7, 30),
      title: 'Gym',
      body: '',
      ringDuration: const Duration(minutes: 1),
      ruleId: 'user.gym',
      eventId: 'user.gym',
      offset: Duration.zero,
    );
    final w = windows(plan: [alarm], minutes: {'gym': 60});
    // Rang 30 minutes ago and still on.
    expect(w.single.contains(now), isTrue);
    expect(w.single.end, DateTime.utc(2026, 11, 12, 8, 30));
    expect(windows(plan: [alarm]), isEmpty);
  });

  test('lock mode makes you busy only when asked', () {
    final lock = LockPeriod(
      id: 'shabbat',
      start: DateTime.utc(2026, 11, 13, 15),
      end: DateTime.utc(2026, 11, 14, 16),
      reason: 'Shabbat',
    );
    expect(windows(locks: [lock]), isEmpty);
    expect(windows(locks: [lock], settings: const BusySettings(duringLock: true)), hasLength(1));
  });

  test('settings survive a restart; answers are off and groups skipped by default', () {
    const s = BusySettings();
    expect(s.replies, isFalse);
    expect(s.groups, isFalse);
    expect(s.repliesOnShabbat, isFalse);
    final back = BusySettings.fromJson(s.copyWith(replies: true, replyText: 'Back at {until}').toJson());
    expect(back.replies, isTrue);
    expect(back.replyText, 'Back at {until}');
    expect(BusySettings.decode('not json').dnd, isTrue);
  });

  test('alarms and calendar alarms keep their Busy choice', () {
    final a = UserAlarm.fromJson(const UserAlarm(id: 'a', hour: 7, minute: 0, busyMinutes: 90).toJson());
    expect(a.busyMinutes, 90);
    expect(CalendarRule.fromJson(const CalendarRule(id: 'r', busy: true).toJson()).busy, isTrue);
  });
}
