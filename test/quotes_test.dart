import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/quotes/data/quote_bank.dart';
import 'package:quando/features/quotes/domain/quote.dart';
import 'package:quando/l10n/app_localizations.dart';

List<Quote> quotesFor(String lang) => quoteBank[lang]!;

void main() {
  const all = {...QuoteSource.values};
  // A plain Wednesday in March 2026, nothing special about it.
  DateTime at(int hour, {int day = 11, int month = 3}) => DateTime(2026, month, day, hour);

  test('every app language has plenty of quotes', () {
    for (final l in AppLocalizations.supportedLocales) {
      final key = l.scriptCode == 'Hant' ? 'zh_Hant' : l.languageCode;
      expect(quoteBank[key], isNotNull, reason: key);
      expect(quotesFor(key).length, greaterThan(120), reason: key);
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
      expect(pickQuote(quotes: q, sources: jewishSources, local: at(h))!.isJewish, isTrue);
    }
  });

  test('no sources: no quote', () {
    expect(pickQuote(quotes: quotesFor('en'), sources: {}, local: at(9)), isNull);
  });

  test('translations carry the original words', () {
    final goethe = quotesFor('pt').firstWhere((q) => q.by == 'Goethe');
    expect(goethe.original, 'Verweile doch! Du bist so schön!');
    final daydream = quotesFor('pt').firstWhere((q) => q.by == 'The Monkees');
    expect(daydream.original, contains('six o\'clock alarm'));
    // In the original language, no second line.
    expect(quotesFor('de').firstWhere((q) => q.by.contains('Goethe')).original, isNull);
  });

  test('Freddie Mercury gets the whole day on September 5, after the Jewish morning', () {
    final picks = [
      for (final h in [7, 13, 19, 23])
        pickQuote(quotes: quotesFor('en'), sources: all, local: DateTime(2027, 9, 5, h))!,
    ];
    expect(picks.first.isJewish, isTrue);
    expect(picks.skip(1).map((q) => q.by), everyElement('Queen'));
  });

  test('each night of Chanukah has its own quote', () {
    // Chanukah 5787 starts on the evening of 4 December 2026; day one is 5 December.
    final seen = <String>{};
    for (var d = 0; d < 8; d++) {
      final q = pickQuote(
        quotes: quotesFor('en'),
        sources: jewishSources,
        local: DateTime(2026, 12, 5 + d, 8),
      )!;
      expect(q.tagSet, contains('chanukah${d + 1}'), reason: 'day ${d + 1}: $q');
      seen.add(q.text);
    }
    expect(seen.length, 8);
  });

  test('Carnaval quotes only for those who want them', () {
    // Carnaval Tuesday 2027 is February 9.
    expect(isCarnaval(DateTime(2027, 2, 9)), isTrue);
    expect(isCarnaval(DateTime(2027, 2, 20)), isFalse);
    bool carnavalDay(Set<QuoteOccasion> o) => [
      for (final h in [7, 13, 19, 23])
        pickQuote(quotes: quotesFor('pt'), sources: all, occasions: o, local: DateTime(2027, 2, 9, h))!,
    ].any((q) => q.tags.contains('carnaval'));
    expect(carnavalDay({}), isFalse);
    expect(carnavalDay({QuoteOccasion.carnaval}), isTrue);
  });

  test('25 de Abril in Lisbon, only near me', () {
    final lisbon = placeTags('Europe/Lisbon');
    expect(lisbon, containsAll(['place:pt', 'place:lisbon']));
    bool grandola(Set<QuoteOccasion> o) => [
      for (final h in [7, 13, 19, 23])
        pickQuote(
          quotes: quotesFor('pt'),
          sources: all,
          occasions: o,
          places: lisbon,
          local: DateTime(2027, 4, 25, h),
        )!,
    ].any((q) => q.by == 'José Afonso');
    expect(grandola({}), isFalse);
    expect(grandola({QuoteOccasion.nearMe}), isTrue);
  });

  test('no Christian figures or New Testament anywhere', () {
    for (final list in quoteBank.values) {
      for (final q in list) {
        expect(q.by, isNot(matches(RegExp('Augustin|Agostinho|Agustín|Jesus|Matthew|Mateus'))), reason: '$q');
      }
    }
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
    for (final list in quoteBank.values) {
      for (final q in list) {
        if (q.tagSet.contains('erev')) expect(q.isJewish, isTrue, reason: '$q');
      }
    }
  });
}
