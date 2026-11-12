import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/lock/domain/lock.dart';
import 'package:quando/features/lock/ui/lock_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime.utc(2026, 11, 3, 12);

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [clockProvider.overrideWithValue(() => _now), prefsProvider.overrideWithValue(prefs)],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  test('Shabbat lock runs from candle lighting to havdalah, with an opening chime', () async {
    final c = await _container();
    expect(c.read(lockPeriodsProvider), isEmpty);
    c.read(lockSettingsProvider.notifier).update((s) => s.copyWith(shabbat: true));
    final first = c.read(lockPeriodsProvider).first;
    expect(first.start, DateTime.utc(2026, 11, 6, 14, 5, 34));
    expect(first.reason, 'Shabbat');
    final chime = c.read(planProvider).singleWhere((a) => a.ruleId == 'lock');
    expect(chime.at, first.start);
    final p = c.read(payloadForProvider)(chime);
    expect((p.isLock, p.ringSeconds, p.spoken), (true, 1, false));
  });

  test('calendar events with the keyword lock from start to end', () {
    final periods = lockPeriods(
      settings: const LockSettings(
        calendarLocks: [CalendarLock(id: 'k', startQuery: 'exam')],
      ),
      holy: const [],
      now: _now,
      calendarEvents: [
        AnchorEvent(
          id: 'cal.1',
          kind: EventKind.calendar,
          title: 'Maths EXAM',
          at: DateTime.utc(2026, 11, 4, 8),
          source: 'x',
        ),
        AnchorEvent(
          id: 'calend.1',
          kind: EventKind.calendarEnd,
          title: 'Maths EXAM (ends)',
          at: DateTime.utc(2026, 11, 4, 10),
          source: 'x',
        ),
        AnchorEvent(
          id: 'cal.2',
          kind: EventKind.calendar,
          title: 'Lunch',
          at: DateTime.utc(2026, 11, 4, 11),
          source: 'x',
        ),
        AnchorEvent(
          id: 'calend.2',
          kind: EventKind.calendarEnd,
          title: 'Lunch (ends)',
          at: DateTime.utc(2026, 11, 4, 12),
          source: 'x',
        ),
      ],
    );
    expect(periods.single.start, DateTime.utc(2026, 11, 4, 8));
    expect(periods.single.end, DateTime.utc(2026, 11, 4, 10));
  });

  test('overlapping locks merge, and unlocking ends all of them', () async {
    final holy = [
      HolyPeriod(
        start: DateTime.utc(2026, 11, 6, 14),
        end: DateTime.utc(2026, 11, 7, 15),
        names: const ['Shabbat'],
      ),
    ];
    final cal = [
      AnchorEvent(
        id: 'cal.9',
        kind: EventKind.calendar,
        title: 'Retreat lock',
        at: DateTime.utc(2026, 11, 7, 14),
        source: 'x',
      ),
      AnchorEvent(
        id: 'calend.9',
        kind: EventKind.calendarEnd,
        title: 'Retreat lock (ends)',
        at: DateTime.utc(2026, 11, 7, 20),
        source: 'x',
      ),
    ];
    final merged = lockPeriods(
      settings: const LockSettings(
        shabbat: true,
        calendarLocks: [CalendarLock(id: 'k', startQuery: 'lock')],
      ),
      holy: holy,
      calendarEvents: cal,
      now: _now,
    ).single;
    expect(merged.end, DateTime.utc(2026, 11, 7, 20));
    expect(
      lockPeriods(
        settings: const LockSettings(
          shabbat: true,
          calendarLocks: [CalendarLock(id: 'k', startQuery: 'lock')],
        ),
        holy: holy,
        calendarEvents: cal,
        now: _now,
        dismissed: merged.allIds,
      ),
      isEmpty,
    );
  });

  testWidgets('lock now covers the app; holding unlocks it', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [clockProvider.overrideWithValue(() => _now), prefsProvider.overrideWithValue(prefs)],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: LockGate(now: () => DateTime.now().toUtc(), child: const Text('app')),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Hold to unlock'), findsNothing);

    c.read(lockSettingsProvider.notifier).lockFor(const Duration(hours: 1));
    await tester.pump();
    expect(find.text('Hold to unlock'), findsOneWidget);

    final hold = await tester.startGesture(tester.getCenter(find.text('Hold to unlock')));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Hold to unlock'), findsOneWidget); // not long enough
    for (var i = 0; i < 25; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await hold.up();
    await tester.pump();
    expect(find.text('Hold to unlock'), findsNothing);
    expect(c.read(lockSettingsProvider).manualUntil, isNull);

    // A new lock later still works.
    c.read(lockSettingsProvider.notifier).lockFor(const Duration(minutes: 30));
    await tester.pump();
    expect(find.text('Hold to unlock'), findsOneWidget);
  });
}
