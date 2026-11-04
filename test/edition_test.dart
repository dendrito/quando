import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quando/app/widgets/brand.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/edition.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/quotes/domain/quote.dart';
import 'package:quando/features/shabbat/domain/hebrew_date.dart';
import 'package:quando/features/sounds/data/radio_directory.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Run with `--dart-define=QUANDO_EDITION=kodesh` for Quando? Shabbat;
/// without it, for the main Quando?.
void main() {
  Future<ProviderContainer> container() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
  }

  test('quotes match the edition', () async {
    final c = await container();
    final quotes = c.read(quotesProvider);
    final sources = c.read(quoteSourcesProvider);
    if (kodesh) {
      expect(quotes, isNotEmpty);
      expect(quotes.every((q) => q.isJewish), isTrue);
      expect(sources, jewishSources);
      expect(c.read(quoteOccasionsProvider), isEmpty);
    } else {
      expect(quotes.any((q) => !q.isJewish), isTrue);
      expect(sources, QuoteSource.values.toSet());
    }
  });

  test('Quando? Shabbat locks the phone on Shabbat out of the box', () async {
    final c = await container();
    expect(c.read(lockSettingsProvider).shabbat, kodesh);
  });

  test('Quando? Shabbat never shows a secular quote, any day of the year', () async {
    if (!kodesh) return;
    final c = await container();
    final quotes = c.read(quotesProvider);
    for (var d = DateTime(2027, 1, 1); d.year == 2027; d = d.add(const Duration(days: 1))) {
      for (final h in [7, 13, 19, 23]) {
        final q = pickQuote(
          quotes: quotes,
          sources: jewishSources,
          local: DateTime(d.year, d.month, d.day, h),
        );
        if (q != null) expect(q.isJewish, isTrue, reason: '$d $h: $q');
      }
    }
  });

  test('Hebrew date and parasha, turning over at nightfall', () {
    // Wednesday 4 November 2026 is 24 Cheshvan 5787, week of Chayei Sara.
    expect(hebrewDate(DateTime(2026, 11, 4, 10)), ('24 Cheshvan 5787', 'Chayei Sara'));
    expect(hebrewDate(DateTime(2026, 11, 4, 20), afterSunset: true).$1, '25 Cheshvan 5787');
    expect(hebrewDate(DateTime(2026, 11, 4, 10), hebrew: true).$2, 'חיי שרה');
  });

  test('Israeli and Jewish radio stations', () {
    expect(isJewishStation(const RadioStation(name: 'Kan Bet', url: 'https://x', countryCode: 'IL')), isTrue);
    expect(
      isJewishStation(const RadioStation(name: 'JM in the AM', url: 'https://x', tags: 'jewish,talk')),
      isTrue,
    );
    expect(
      isJewishStation(const RadioStation(name: 'Rock FM', url: 'https://x', countryCode: 'GB', tags: 'rock')),
      isFalse,
    );
    if (kodesh) expect(radioGenres.map((g) => g.$2), isNot(contains('rock')));
  });

  testWidgets('the logo draws in both editions', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: Row(children: [QMark(), QMark(tile: false)])),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
