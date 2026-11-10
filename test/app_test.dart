import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';

import 'shabbat_on.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // First: the app's router remembers the last screen between tests.
  testWidgets('a fresh Quando? keeps Shabbat out of the way until you ask', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
          prefsProvider.overrideWithValue(prefs),
        ],
        child: const QuandoApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Shabbat'), findsNothing);
    expect(find.text('16:05'), findsNothing);
    expect(find.textContaining('— '), findsOneWidget); // a quote under the countdown
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Shabbat & festivals'), findsOneWidget);
    expect(find.text('Off'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();
  });
  testWidgets('home shows next Shabbat and this week\'s alarms', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({...shabbatOn});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
          prefsProvider.overrideWithValue(prefs),
        ],
        child: const QuandoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quando?'), findsOneWidget);
    expect(find.text('Tap When? to add an alarm.'), findsOneWidget);
    expect(find.text('Shabbat'), findsOneWidget);
    // Jerusalem, Fri 6 Nov 2026: candle lighting 16:05 local.
    expect(find.text('16:05'), findsOneWidget);
    // Friday's candle-lighting reminders fold into one row that opens.
    final series = find.textContaining('alarms · ');
    await tester.scrollUntilVisible(series.first, 400, scrollable: find.byType(Scrollable).first);
    // Lift the row clear of the floating When? button.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -200));
    await tester.pumpAndSettle();
    expect(find.text('2 hours before'), findsNothing);
    await tester.tap(series.first);
    await tester.pumpAndSettle();
    expect(find.text('2 hours before'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('set themselves on this phone'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('set themselves on this phone'), findsOneWidget);
  });

  testWidgets('a week row has quick actions: remove a time, turn off, undo', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({...shabbatOn});
    final prefs = await SharedPreferences.getInstance();
    late ProviderContainer c;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
          prefsProvider.overrideWithValue(prefs),
        ],
        child: Consumer(
          builder: (context, ref, _) {
            c = ProviderScope.containerOf(context);
            return const QuandoApp();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    final series = find.textContaining('alarms · ');
    await tester.scrollUntilVisible(series.first, 400, scrollable: find.byType(Scrollable).first);
    // Lift the row clear of the floating When? button.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -200));
    await tester.pumpAndSettle();
    final before = c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown').offsets().length;

    // One alarm: take its time out of the rule, then put it back.
    await tester.tap(series.first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('2 hours before').first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Remove “2 hours before”'));
    await tester.pumpAndSettle();
    expect(c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown').offsets().length, before - 1);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown').offsets().length, before);

    // The whole row: turn its rule off from the ⋯ menu, then undo.
    final more = find.descendant(
      of: find.ancestor(of: series.first, matching: find.byType(ListTile)),
      matching: find.byTooltip('More'),
    );
    await tester.tap(more);
    await tester.pumpAndSettle();
    // This row mixes two presets, so each gets its own switch.
    final countdown = c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown');
    await tester.tap(find.text('Turn off “${countdown.name}”'));
    await tester.pumpAndSettle();
    expect(c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown').enabled, isFalse);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(c.read(rulesProvider).firstWhere((r) => r.id == 'preset.countdown').enabled, isTrue);
  });
  testWidgets('the Shabbat card opens the Shabbat screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({...shabbatOn});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
          prefsProvider.overrideWithValue(prefs),
        ],
        child: const QuandoApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('READY-MADE ALARMS'), findsNothing);
    await tester.tap(find.text('Shabbat'));
    await tester.pumpAndSettle();
    expect(find.text('Shabbat & festivals'), findsOneWidget);
    expect(find.text('Lock the phone for Shabbat'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('READY-MADE ALARMS'), 300);
    expect(find.text('Countdown to candle lighting'), findsOneWidget);
  });
}
