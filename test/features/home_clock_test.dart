import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/home/domain/home_display.dart';
import 'package:quando/features/home/ui/clock_hero.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('the clock size is remembered, and Large is the default', () {
    expect(HomeDisplay.fromJson({}).clock, ClockSize.large);
    final json = const HomeDisplay(clock: ClockSize.small).toJson();
    expect(HomeDisplay.fromJson(json).clock, ClockSize.small);
    expect(HomeDisplay.fromJson({'clock': 'nonsense'}).clock, ClockSize.large);
  });

  for (final size in ClockSize.values) {
    testWidgets('home clock: ${size.name}', (tester) async {
      tester.view.physicalSize = const Size(1080, 4000);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({'home.display': '{"clock":"${size.name}"}'});
      final prefs = await SharedPreferences.getInstance();
      final c = ProviderContainer(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 8, 18, 30)),
          prefsProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const QuandoApp()));
      await tester.pumpAndSettle();
      if (size == ClockSize.off) {
        expect(find.byType(ClockHero), findsNothing);
      } else {
        expect(tester.widget<ClockHero>(find.byType(ClockHero)).size, size);
      }
    });
  }
}
