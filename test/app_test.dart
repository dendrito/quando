import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';

void main() {
  testWidgets('home shows next Shabbat and this week\'s alarms', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12))],
        child: const QuandoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quando'), findsOneWidget);
    expect(find.text('Shabbat'), findsOneWidget);
    // Jerusalem, Fri 6 Nov 2026: candle lighting 16:05 local.
    expect(find.text('16:05'), findsOneWidget);
    expect(find.text('2 hours before · Fri 6 Nov'), findsOneWidget);
    await tester.scrollUntilVisible(find.textContaining('alarms on this phone'), 400);
    expect(find.textContaining('alarms on this phone'), findsOneWidget);
  });
}
