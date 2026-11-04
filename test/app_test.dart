import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('home shows next Shabbat and this week\'s alarms', (tester) async {
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

    expect(find.text('Quando?'), findsOneWidget);
    expect(find.text('Tap When? to add an alarm.'), findsOneWidget);
    expect(find.text('Shabbat'), findsOneWidget);
    // Jerusalem, Fri 6 Nov 2026: candle lighting 16:05 local.
    expect(find.text('16:05'), findsOneWidget);
    // Friday's candle-lighting reminders fold into one row that opens.
    final series = find.textContaining('alarms · ');
    await tester.scrollUntilVisible(series.first, 400);
    expect(find.text('2 hours before'), findsNothing);
    await tester.tap(series.first);
    await tester.pumpAndSettle();
    expect(find.text('2 hours before'), findsOneWidget);
    await tester.scrollUntilVisible(find.textContaining('set themselves on this phone'), 400);
    expect(find.textContaining('set themselves on this phone'), findsOneWidget);
  });

  testWidgets('the Shabbat card opens the Shabbat screen', (tester) async {
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
    expect(find.text('READY-MADE ALARMS'), findsNothing);
    await tester.tap(find.text('Shabbat'));
    await tester.pumpAndSettle();
    expect(find.text('Shabbat & festivals'), findsOneWidget);
    expect(find.text('Lock the phone for Shabbat'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('READY-MADE ALARMS'), 300);
    expect(find.text('Countdown to candle lighting'), findsOneWidget);
  });
}
