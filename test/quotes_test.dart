import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/quotes/data/quote_bank.dart';
import 'package:quando/features/quotes/domain/quote.dart';
import 'package:quando/l10n/app_localizations.dart';

List<Quote> quotesFor(String lang) => [...quoteBank[lang]!, ...sharedQuotes];

void main() {
  const all = {...QuoteSource.values};
  // A plain Wednesday in March 2026, nothing special about it.
  DateTime at(int hour, {int day = 11, int month = 3}) => DateTime(2026, month, day, hour);

  test('every app language has plenty of quotes', () {
    for (final l in AppLocalizations.supportedLocales) {
      final key = l.scriptCode == 'Hant' ? 'zh_Hant' : l.languageCode;
      expect(quoteBank[key], isNotNull, reason: key);
      expect(quotesFor(key).length, greaterThan(80), reason: key);
    }
  });

  test('the quote stays put within a part of the day, and a tap moves on', () {
    final q = quotesFor('pt');
    final a = pickQuote(quotes: q, sources: all, local: at(13));
    expect(pickQuote(quotes: q, sources: all, local: at(16)), a);
    expect(pickQuote(quotes: q, sources: all, local: at(13), skip: 1), isNot(a));
    expect(pickQuote(quotes: q, sources: all, local: at(19)), isNot(a));
  });

  test('one Jewish quote a day, in the morning', () {
    final q = quotesFor('en');
    for (var d = 1; d <= 28; d++) {
      final picks = [
        for (final h in [7, 13, 19, 23])
          pickQuote(
            quotes: q,
            sources: all,
            local: at(h, day: d, month: 2),
          )!,
      ];
      expect(picks.where((p) => p.isJewish).length, 1, reason: 'Feb $d: $picks');
      expect(picks.first.isJewish, isTrue);
    }
  });

  test('only Jewish sources picked: every slot uses them', () {
    final q = quotesFor('he');
    for (final h in [7, 13, 19, 23]) {
      expect(
        pickQuote(quotes: q, sources: {QuoteSource.tanakh, QuoteSource.sages}, local: at(h))!.isJewish,
        isTrue,
      );
    }
  });

  test('no sources: no quote', () {
    expect(pickQuote(quotes: quotesFor('en'), sources: {}, local: at(9)), isNull);
  });

  test('Rock Day in the calendar brings Iron Maiden at night', () {
    final q = pickQuote(
      quotes: quotesFor('pt'),
      sources: all,
      local: DateTime(2026, 7, 13, 23),
      eventTitles: ['Dia Mundial do Rock'],
    );
    expect(q!.by, 'Iron Maiden');
  });

  test('September 30 wakes Green Day up', () {
    expect(
      pickQuote(quotes: quotesFor('en'), sources: all, local: DateTime(2026, 9, 30, 13))!.by,
      'Green Day',
    );
  });

  test('on Tisha B\'Av, users of Jewish sources get no songs, films or proverbs', () {
    // 9 Av 5786 falls on 23 July 2026.
    final loud = {QuoteSource.songs, QuoteSource.movies, QuoteSource.proverbs, QuoteSource.speeches};
    expect(isSolemnDay(DateTime(2026, 7, 23)), isTrue);
    for (final h in [7, 13, 19, 23]) {
      for (var skip = 0; skip < 10; skip++) {
        final q = pickQuote(
          quotes: quotesFor('en'),
          sources: all,
          local: DateTime(2026, 7, 23, h),
          skip: skip,
        )!;
        expect(loud.contains(q.source), isFalse, reason: '$q');
      }
    }
    // Without Jewish sources the day is an ordinary day.
    final secular = {QuoteSource.songs};
    expect(pickQuote(quotes: quotesFor('en'), sources: secular, local: DateTime(2026, 7, 23, 13)), isNotNull);
  });

  test('Shabbat quotes only come with Jewish sources', () {
    for (final list in [...quoteBank.values, sharedQuotes]) {
      for (final q in list) {
        if (q.tagSet.contains('erev')) expect(q.isJewish, isTrue, reason: '$q');
      }
    }
  });
}
