import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/core/util/format.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/alarm_rule.dart';
import 'package:quando/features/rules/domain/presets.dart';

void main() {
  final candles = AnchorEvent(
    id: 'e1',
    kind: EventKind.holyDayStart,
    title: 'Candle lighting · Shabbat',
    at: DateTime.utc(2026, 11, 6, 14, 5),
    source: 'test',
  );
  const scheduler = Scheduler();

  test('countdown preset gives 2h, 1h, 30m, 15m and 5m before', () {
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 6, 8),
      events: [candles],
      rules: [Presets.countdown],
    );
    expect(plan.map((a) => a.at.difference(candles.at).inMinutes), [-120, -60, -30, -15, -5]);
    expect(plan.first.body, '2 hours before');
    expect(plan.last.title, 'Candle lighting · Shabbat');
  });

  test('alarms already in the past are skipped', () {
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 6, 13, 40),
      events: [candles],
      rules: [Presets.countdown],
    );
    expect(plan.map((a) => a.body), ['15 minutes before', '5 minutes before']);
  });

  test('only the next 7 days are planned', () {
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 10, 25),
      events: [candles],
      rules: [Presets.countdown],
    );
    expect(plan, isEmpty);
  });

  test('a series of every hour for 6 hours gives 6 alarms', () {
    final plan = scheduler.plan(now: DateTime.utc(2026, 11, 6), events: [candles], rules: [Presets.hourly]);
    expect(plan, hasLength(6));
    expect(plan.first.body, '6 hours before');
  });

  test('two rules asking for the same minute ring once', () {
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 6),
      events: [candles],
      rules: [Presets.countdown, Presets.hourly],
    );
    // countdown: 2h,1h,30m,15m,5m. hourly: 6h..1h. Shared: 2h and 1h.
    expect(plan, hasLength(5 + 6 - 2));
  });

  test('ids are stable when planning again', () {
    List<int> ids() => scheduler
        .plan(now: DateTime.utc(2026, 11, 6), events: [candles], rules: [Presets.countdown])
        .map((a) => a.id)
        .toList();
    expect(ids(), ids());
    expect(ids().toSet(), hasLength(5));
  });

  test('disabled rules and other event kinds are ignored', () {
    final plan = scheduler.plan(
      now: DateTime.utc(2026, 11, 6),
      events: [candles],
      rules: [Presets.countdown.copyWith(enabled: false), Presets.havdalah],
    );
    expect(plan, isEmpty);
  });

  test('event window covers the furthest offsets', () {
    final now = DateTime.utc(2026, 11, 1);
    final w = scheduler.eventWindow(now, [Presets.countdown, Presets.havdalah]);
    expect(w.from, now.subtract(const Duration(minutes: 15)));
    expect(w.to, now.add(const Duration(days: 7, hours: 2)));
  });

  test('after-event alarms', () {
    const rule = AlarmRule(
      id: 'r',
      name: 'After',
      appliesTo: {EventKind.holyDayStart},
      series: [OffsetSeries(direction: Direction.after, every: Duration(days: 1), span: Duration(days: 3))],
    );
    final plan = scheduler.plan(now: DateTime.utc(2026, 11, 6), events: [candles], rules: [rule]);
    expect(plan.map((a) => a.body), ['1 day after', '2 days after', '3 days after']);
  });

  test('formatting', () {
    expect(formatSpan(const Duration(hours: 1, minutes: 30)), '1 hour 30 minutes');
    expect(describeOffset(Duration.zero), 'now');
    expect(stableId('abc'), stableId('abc'));
    expect(stableId('abc'), isNot(stableId('abd')));
  });
}
