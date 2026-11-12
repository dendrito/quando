import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/assistant/data/voice_log.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_plan.dart';
import 'package:quando/features/assistant/ui/ask_sheet.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tue 3 Nov 2026, 12:00 UTC = 14:00 in Jerusalem.
final _now = DateTime.utc(2026, 11, 3, 12);
const _zone = 'Asia/Jerusalem';

AlarmPlan? _plan(String text, {List<AnchorEvent> events = const []}) => planFor(
  const AlarmParser().parse(text)!,
  now: _now,
  zone: _zone,
  eventsBetween: (from, to) => [
    for (final e in events)
      if (!e.at.isBefore(from) && e.at.isBefore(to)) e,
  ],
);

void main() {
  setUpAll(ensureTimeZones);

  test('in 20 minutes', () {
    expect((_plan('in 20 minutes')! as OneOffPlan).at, _now.add(const Duration(minutes: 20)));
  });

  test('"at 7" said at 2 pm means 7 tonight; tomorrow at 7 means the morning', () {
    expect((_plan('wake me at 7')! as OneOffPlan).at, DateTime.utc(2026, 11, 3, 17));
    expect((_plan('tomorrow at 7')! as OneOffPlan).at, DateTime.utc(2026, 11, 4, 5));
    expect((_plan('at 7am')! as OneOffPlan).at, DateTime.utc(2026, 11, 4, 5));
  });

  test('repeating alarms keep their time and days', () {
    final p = _plan('6:30 on weekdays to go running')! as RepeatPlan;
    expect((p.hour, p.minute, p.label), (6, 30, 'Go running'));
    expect(p.days, {1, 2, 3, 4, 5});
  });

  test('sun times become a rule, or one alarm when a day is named', () {
    final rule = _plan('30 minutes before sunrise on weekdays')! as RulePlan;
    expect(rule.offset, const Duration(minutes: -30));
    expect(rule.days, {1, 2, 3, 4, 5});

    final sunrise = AnchorEvent(
      id: 'sun.rise',
      kind: EventKind.sunrise,
      title: 'Sunrise',
      at: DateTime.utc(2026, 11, 4, 4, 5),
      source: 'sun',
    );
    final once = _plan('tomorrow 30 minutes before sunrise', events: [sunrise])! as OneOffPlan;
    expect(once.at, DateTime.utc(2026, 11, 4, 3, 35));
  });

  test('a rule on weekdays only rings on weekdays', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [clockProvider.overrideWithValue(() => _now), prefsProvider.overrideWithValue(prefs)],
    );
    addTearDown(c.dispose);
    c
        .read(calendarRulesProvider.notifier)
        .save(
          const CalendarRule(
            id: 'r',
            keyword: 'sunrise',
            includeTimes: true,
            before: [Duration(minutes: 30)],
            days: {1, 2, 3, 4, 5},
          ),
        );
    final mine = c.read(planProvider).where((a) => a.ruleId.startsWith('cal.r')).toList();
    expect(mine, isNotEmpty);
    expect(mine.every((a) => a.at.add(const Duration(minutes: 30)).toLocal().weekday <= 5), isTrue);
    // And the days survive a restart.
    final again = CalendarRule.fromJson(c.read(calendarRulesProvider).single.toJson());
    expect(again.days, {1, 2, 3, 4, 5});
  });

  testWidgets('type a sentence, see what it understood, save', (tester) async {
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
          home: Scaffold(
            body: Builder(
              builder: (context) =>
                  TextButton(onPressed: () => showAskSheet(context), child: const Text('open')),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'remind me to take my pills at 8pm every day');
    await tester.pump();
    expect(find.text('20:00 · Every day'), findsOneWidget);
    expect(find.text('Take my pills'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final saved = c.read(userAlarmsProvider).single;
    expect((saved.hour, saved.minute, saved.label, saved.days.length), (20, 0, 'Take my pills', 7));
    // Once, after the first saved voice or typed alarm: may we learn from it?
    expect(find.text("Quando? has a student's heart."), findsOneWidget);
    expect(c.read(voiceLogProvider), isFalse);
    await tester.tap(find.text('Yes, help'));
    await tester.pumpAndSettle();
    expect(c.read(voiceLogProvider), isTrue);
  });
}
