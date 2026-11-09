import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/l10n/l10n.dart';

import 'shabbat_on.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tearDown(() => useLocale(const [Locale('en')]));

  test('every language has every phrase, with the same placeholders', () {
    final dir = Directory('lib/l10n');
    Map<String, dynamic> read(String f) =>
        jsonDecode(File('${dir.path}/$f').readAsStringSync()) as Map<String, dynamic>;
    final en = read('app_en.arb');
    final keys = en.keys.where((k) => !k.startsWith('@')).toSet();
    final files = dir.listSync().map((f) => f.uri.pathSegments.last).where((f) => f.endsWith('.arb'));
    final holes = RegExp(r'\{(\w+)[,}]');
    for (final f in files) {
      final arb = read(f);
      final missing = keys.difference(arb.keys.toSet());
      expect(missing, isEmpty, reason: '$f is missing $missing');
      for (final k in keys) {
        final want = holes.allMatches(en[k] as String).map((m) => m[1]).toSet();
        final got = holes.allMatches(arb[k] as String).map((m) => m[1]).toSet();
        expect(got.containsAll(want), isTrue, reason: '$f $k needs $want, has $got');
      }
    }
  });

  test('the phone\'s language picks the closest one Quando speaks', () {
    expect(resolveLocale(const [Locale('pt', 'BR')]), const Locale('pt'));
    expect(resolveLocale(const [Locale('iw')]), const Locale('he'));
    expect(resolveLocale(const [Locale('zh', 'TW')]).scriptCode, 'Hant');
    expect(resolveLocale(const [Locale('zh', 'CN')]), const Locale('zh'));
    expect(resolveLocale(const [Locale('xx'), Locale('es', 'MX')]), const Locale('es'));
    expect(resolveLocale(const [Locale('xx')]), const Locale('en'));
  });

  test('dates follow the language', () {
    useLocale(const [Locale('pt')]);
    expect(dayLabel(DateTime(2026, 11, 6)), 'sex. 6 nov.');
    expect(l10n.spanHours(2), '2 horas');
  });

  testWidgets('Hebrew reads right to left, with Hebrew Shabbat words', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({...shabbatOn, 'language': 'he'});
    final prefs = await SharedPreferences.getInstance();
    useLocale(const [Locale('he')]);
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
    expect(find.textContaining('הדלקת נרות'), findsWidgets);
    expect(find.text('שבת'), findsOneWidget);
    expect(Directionality.of(tester.element(find.text('Quando?'))), TextDirection.rtl);
  });

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('home, Shabbat and settings fit on a phone in $locale', (tester) async {
      tester.view.physicalSize = const Size(1080, 2160);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      addTearDown(() => useLocale(const [Locale('en')]));
      final tag = locale.scriptCode == null
          ? locale.languageCode
          : '${locale.languageCode}_${locale.scriptCode}';
      SharedPreferences.setMockInitialValues({'language': tag});
      final prefs = await SharedPreferences.getInstance();
      useLocale([locale]);
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
      final router = GoRouter.of(tester.element(find.byType(Scaffold).first));
      addTearDown(() => router.go('/'));
      router.go('/');
      await tester.pumpAndSettle();
      expect(find.text('Quando?'), findsWidgets);

      router.go('/shabbat');
      await tester.pumpAndSettle();
      expect(find.text(l10n.shabbatAndFestivals), findsWidgets);

      router.go('/settings');
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text(l10n.language),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(l10n.language), findsWidgets);
    });
  }
}
