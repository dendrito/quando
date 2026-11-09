import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/home/data/home_grid_provider.dart';
import 'package:quando/features/home/data/home_information_providers.dart';
import 'package:quando/features/home/domain/home_grid.dart';
import 'package:quando/features/home/ui/home_grid_view.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sun_weather_test.dart' show sampleReport;

void main() {
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });

  Future<ProviderContainer> pumpHome(WidgetTester tester, Size size, {String style = 'auto'}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({'home.display.allOn': true, 'home.display': '{"style":"$style"}'});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 8, 18, 30)),
        prefsProvider.overrideWithValue(prefs),
        weatherReportProvider.overrideWith((ref, key) async => sampleReport(afternoon: 'clearsky_day')),
      ],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MediaQuery(
          data: MediaQueryData(size: size, disableAnimations: true),
          child: const QuandoApp(),
        ),
      ),
    );
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    return c;
  }

  testWidgets('iPad shows cards by default, with the 3-in-1 tools card', (tester) async {
    final c = await pumpHome(tester, const Size(1180, 1600));
    expect(find.byType(HomeGridView), findsOneWidget);
    final grid = c.read(homeGridProvider.notifier).of(12);
    expect(grid.has(HomeCard.tools), isTrue);
    expect(grid.has(HomeCard.stopwatch), isFalse);
    expect(find.text(l10n.timerStopwatch), findsOneWidget);
  });

  testWidgets('a phone keeps the classic home unless cards are chosen', (tester) async {
    await pumpHome(tester, const Size(390, 900));
    expect(find.byType(HomeGridView), findsNothing);
  });

  testWidgets('arranging removes and adds cards, and keeps them', (tester) async {
    final c = await pumpHome(tester, const Size(1180, 1600));
    await tester.tap(find.byKey(const ValueKey('arrange-home')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('remove-quick')));
    await tester.pump();
    expect(c.read(homeGridProvider.notifier).of(12).has(HomeCard.quick), isFalse);

    await tester.tap(find.byKey(const ValueKey('add-card')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('add-stopwatch')));
    await tester.pumpAndSettle();
    expect(c.read(homeGridProvider.notifier).of(12).has(HomeCard.stopwatch), isTrue);
    final saved = HomeGrid.decode(c.read(prefsProvider).getString('home.grid.12'), 12)!;
    expect(saved.has(HomeCard.stopwatch), isTrue);
    expect(saved.has(HomeCard.quick), isFalse);
  });
}
