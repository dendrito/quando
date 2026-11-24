import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/settings/domain/ui_level.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main screens at a 390 x 844 phone and 200% text must not overflow
/// (WCAG 1.4.4 and 1.4.10).
void main() {
  setUp(() => useLocale([const Locale('en')]));

  for (final route in ['/', '/settings', '/alarm/new', '/sounds', '/ready']) {
    for (final simple in [true, false]) {
      testWidgets('$route at 200% text (${simple ? 'Simple' : 'Everything'})', (tester) async {
        SharedPreferences.setMockInitialValues({'ui_level': simple ? 'simple' : 'everything', 'first_run_done': true});
        final prefs = await SharedPreferences.getInstance();
        UiLevelStore.init(prefs);
        tester.view.physicalSize = const Size(1170, 2532);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);
        final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
        addTearDown(c.dispose);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: c,
            child: const MediaQuery(
              data: MediaQueryData(size: Size(390, 844), disableAnimations: true, textScaler: TextScaler.linear(2)),
              child: QuandoApp(),
            ),
          ),
        );
        final router = GoRouter.of(tester.element(find.byType(Scaffold).first));
        addTearDown(() => router.go('/'));
        router.go(route);
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(tester.takeException(), isNull);
        if (route == '/' || route == '/alarm/new') {
          final h = tester.ensureSemantics();
          await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
          await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
          h.dispose();
        }
      });
    }
  }
}
