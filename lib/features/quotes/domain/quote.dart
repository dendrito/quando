import 'dart:math';

import 'package:kosher_dart/kosher_dart.dart';

/// Where a quote comes from. The user picks which ones they want.
enum QuoteSource { songs, movies, literature, tanakh, sages, siddur, speeches, philosophy, proverbs }

/// A quote about time, with its author.
///
/// [tags] says when it fits, comma separated:
/// * `any`, `morning`, `day`, `evening`, `night`: the part of the day.
///   A quote with none of these is only shown on its special days.
/// * `@morning`…`@night`: for a special-day quote, the part of the day it
///   shows in, without making it an everyday quote.
/// * `idle`: when no alarm is set.
/// * `erev`: Friday, before Shabbat.
/// * `mon`…`sun`, `jan`…`dec`: a weekday or month (shown now and then).
/// * `MM-DD`: a date, such as `12-31`.
/// * `roshhashana`, `yomkippur`, `sukkot`, `simchattorah`, `chanukah`,
///   `chanukah1`…`chanukah8` (each night), `tubishvat`, `purim`, `pesach`,
///   `shavuot`, `tishabav`: Jewish festivals and fasts.
/// * `MM-DD..MM-DD`: a stretch of dates, such as late March.
/// * `carnaval`: Brazil's Carnaval, Saturday to Ash Wednesday. Only for users
///   who turn on Carnaval quotes.
/// * `place:<name>`: only for users who turn on "Near me" and live there,
///   see [placeTags]. Combine with a date for local days.
/// * `yomhaatzmaut`, `yomyerushalayim`: Israeli national days.
/// * `event:<name>`: a matching event in the phone's calendar today,
///   see [eventKeywords].
class Quote {
  const Quote(this.text, this.by, this.source, this.tags, [this.original]);

  /// In the language in use.
  final String text;
  final String by;
  final QuoteSource source;
  final String tags;

  /// The words it was first said in, when that is another language.
  final String? original;

  Set<String> get tagSet => tags.split(',').toSet();

  bool get isJewish => jewishSources.contains(source);

  @override
  String toString() => '$text — $by';
}

/// Tanakh, Talmud and sages, and the Siddur.
const jewishSources = {QuoteSource.tanakh, QuoteSource.sages, QuoteSource.siddur};

/// The four parts of the day. One quote is shown in each.
enum DaySlot { morning, day, evening, night }

DaySlot slotOf(DateTime local) => switch (local.hour) {
  >= 5 && < 11 => DaySlot.morning,
  >= 11 && < 17 => DaySlot.day,
  >= 17 && < 22 => DaySlot.evening,
  _ => DaySlot.night,
};

/// Words in calendar event titles that turn on `event:` tags, in any language.
const eventKeywords = <String, List<String>>{
  'rock': [
    'rock day', 'dia do rock', 'dia mundial do rock', 'día del rock', 'día mundial del rock', //
    'journée du rock', 'tag des rock', 'giornata del rock',
  ],
  'birthday': [
    'birthday', 'aniversário', 'cumpleaños', 'geburtstag', 'anniversaire', 'compleanno', //
    'verjaardag', 'urodziny', 'день рождения', 'день народження', 'doğum günü', 'عيد ميلاد',
    'יום הולדת', 'जन्मदिन', 'ulang tahun', '誕生日', '생일', '生日', 'sinh nhật',
  ],
};

const _weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
const _months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];

/// Extra kinds of quotes the user can opt into.
enum QuoteOccasion { carnaval, nearMe }

/// Easter Sunday (Gregorian), for Carnaval.
DateTime easter(int year) {
  final a = year % 19, b = year ~/ 100, c = year % 100, d = b ~/ 4, e = b % 4;
  final f = (b + 8) ~/ 25, g = (b - f + 1) ~/ 3, h = (19 * a + b - d - g + 15) % 30;
  final i = c ~/ 4, k = c % 4, l = (32 + 2 * e + 2 * i - h - k) % 7, m = (a + 11 * h + 22 * l) ~/ 451;
  final month = (h + l - 7 * m + 114) ~/ 31, day = ((h + l - 7 * m + 114) % 31) + 1;
  return DateTime(year, month, day);
}

/// Saturday before Carnaval to Ash Wednesday.
bool isCarnaval(DateTime day) {
  final d = DateTime(day.year, day.month, day.day);
  final e = easter(day.year);
  final ashWednesday = DateTime(e.year, e.month, e.day - 46);
  final saturday = DateTime(e.year, e.month, e.day - 51);
  return !d.isBefore(saturday) && !d.isAfter(ashWednesday);
}

const _brazil = {
  'Sao_Paulo', 'Recife', 'Bahia', 'Fortaleza', 'Belem', 'Manaus', 'Cuiaba', 'Campo_Grande', //
  'Porto_Velho', 'Boa_Vista', 'Maceio', 'Araguaina', 'Santarem', 'Rio_Branco', 'Noronha',
};
const _us = {'New_York', 'Chicago', 'Denver', 'Los_Angeles', 'Phoenix', 'Anchorage', 'Detroit'};

/// Where the user is, as `place:` tags, from the phone's time zone and the
/// city picked for Shabbat times: a country (`place:br`) and a city
/// (`place:sao_paulo`).
Set<String> placeTags(String zone, {String? city}) {
  final name = zone.split('/').last;
  final country = switch (zone) {
    _ when zone.startsWith('America/') && _brazil.contains(name) => 'br',
    'Europe/Lisbon' || 'Atlantic/Madeira' || 'Atlantic/Azores' => 'pt',
    'Asia/Jerusalem' || 'Asia/Tel_Aviv' => 'il',
    _ when zone.startsWith('America/') && _us.contains(name) => 'us',
    'Europe/London' => 'gb',
    _ => null,
  };
  String slug(String s) => s
      .toLowerCase()
      .replaceAll(RegExp('[ãâáà]'), 'a')
      .replaceAll(RegExp('[éê]'), 'e')
      .replaceAll(RegExp('[^a-z]+'), '_');
  return {if (country != null) 'place:$country', 'place:${slug(name)}', if (city != null) 'place:${slug(city)}'};
}

bool _inRange(String tag, String mmdd) {
  final i = tag.indexOf('..');
  if (i < 0) return false;
  return tag.substring(0, i).compareTo(mmdd) <= 0 && mmdd.compareTo(tag.substring(i + 2)) <= 0;
}

/// Tags that are always true on [day], from the date alone.
Set<String> dateTags(DateTime day, {Iterable<String> eventTitles = const []}) {
  final mmdd = '${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
  final tags = <String>{mmdd};
  final jc = JewishCalendar.fromDateTime(DateTime(day.year, day.month, day.day));
  final festival = switch (jc.getYomTovIndex()) {
    JewishCalendar.ROSH_HASHANA => 'roshhashana',
    JewishCalendar.YOM_KIPPUR => 'yomkippur',
    JewishCalendar.SUCCOS || JewishCalendar.CHOL_HAMOED_SUCCOS || JewishCalendar.HOSHANA_RABBA => 'sukkot',
    JewishCalendar.CHANUKAH => 'chanukah',
    JewishCalendar.TU_BESHVAT => 'tubishvat',
    JewishCalendar.PURIM => 'purim',
    JewishCalendar.PESACH || JewishCalendar.CHOL_HAMOED_PESACH => 'pesach',
    JewishCalendar.SHAVUOS => 'shavuot',
    JewishCalendar.SHEMINI_ATZERES || JewishCalendar.SIMCHAS_TORAH => 'simchattorah',
    JewishCalendar.TISHA_BEAV => 'tishabav',
    JewishCalendar.YOM_HAATZMAUT => 'yomhaatzmaut',
    JewishCalendar.YOM_YERUSHALAYIM => 'yomyerushalayim',
    _ => null,
  };
  if (festival != null) tags.add(festival);
  if (festival == 'chanukah') tags.add('chanukah${jc.getDayOfChanukah()}');
  if (day.weekday == DateTime.friday) tags.add('erev');
  if (isCarnaval(day)) tags.add('carnaval');
  for (final title in eventTitles) {
    final t = title.toLowerCase();
    for (final e in eventKeywords.entries) {
      if (e.value.any(t.contains)) tags.add('event:${e.key}');
    }
  }
  return tags;
}

/// Fast days and days of mourning. When the user follows Jewish sources,
/// songs, films, speeches and proverbs stay quiet on these days.
bool isSolemnDay(DateTime day) {
  final jc = JewishCalendar.fromDateTime(DateTime(day.year, day.month, day.day));
  return const {
    JewishCalendar.TISHA_BEAV,
    JewishCalendar.YOM_KIPPUR,
    JewishCalendar.YOM_HASHOAH,
    JewishCalendar.YOM_HAZIKARON,
    JewishCalendar.SEVENTEEN_OF_TAMMUZ,
    JewishCalendar.TENTH_OF_TEVES,
    JewishCalendar.FAST_OF_GEDALYAH,
    JewishCalendar.FAST_OF_ESTHER,
  }.contains(jc.getYomTovIndex());
}

const _quietSources = {...jewishSources, QuoteSource.literature, QuoteSource.philosophy};

/// Picks the quote for a part of the day.
///
/// The same day and slot always give the same quote, so the line stays put
/// for a few hours; [skip] moves to another one (a tap).
///
/// * Special quotes (a festival, a date, a calendar event, Carnaval, a local
///   day, and now and then a weekday or month) take the slot they are tagged
///   for, or the next free one, so a day like January 25 can fill several.
/// * When Tanakh or sages are among [sources], the morning quote is the
///   day's one Jewish quote, and the other slots come from the rest. When
///   they are the only sources, every slot uses them.
/// * Carnaval and `place:` quotes only appear when opted into
///   ([occasions]); `place:` ones also need the user to be there ([places]).
/// * On solemn days (see [isSolemnDay]) for users of Jewish sources, only
///   quiet sources are used, and nothing is shown if none are picked.
Quote? pickQuote({
  required List<Quote> quotes,
  required Set<QuoteSource> sources,
  required DateTime local,
  Set<QuoteOccasion> occasions = const {},
  Set<String> places = const {},
  Iterable<String> eventTitles = const [],
  bool idle = false,
  int skip = 0,
}) {
  if (sources.any(jewishSources.contains) && isSolemnDay(local)) {
    sources = sources.intersection(_quietSources);
  }
  bool allowed(Quote q) {
    if (!sources.contains(q.source)) return false;
    final t = q.tagSet;
    if (t.contains('carnaval') && !occasions.contains(QuoteOccasion.carnaval)) return false;
    final here = [
      for (final x in t)
        if (x.startsWith('place:')) x,
    ];
    if (here.isNotEmpty && !(occasions.contains(QuoteOccasion.nearMe) && here.any(places.contains))) {
      return false;
    }
    return true;
  }

  final pool = [
    for (final q in quotes)
      if (allowed(q)) q,
  ];
  if (pool.isEmpty) return null;
  final slot = slotOf(local);
  final dayKey = local.year * 10000 + local.month * 100 + local.day;
  final rnd = Random(dayKey * 7 + slot.index * 131 + skip * 7919);
  final mixed = pool.any((q) => q.isJewish) && pool.any((q) => !q.isJewish);

  // The day's special quotes, one per slot at most.
  if (skip == 0) {
    final mmdd = '${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final always = dateTags(local, eventTitles: eventTitles);
    final dayRnd = Random(dayKey);
    final sometimes = {
      if (dayRnd.nextInt(4) == 0) _weekdays[local.weekday - 1],
      if (dayRnd.nextInt(5) == 0) _months[local.month - 1],
    };
    final special = [
      for (final q in pool)
        if (q.tagSet.any((t) => always.contains(t) || _inRange(t, mmdd))) q,
    ]..shuffle(dayRnd);
    // Festivals before plain Fridays, so a Chanukah Friday keeps its candle.
    special.sortStable((q) => q.tagSet.contains('erev') ? 1 : 0);
    final now = [
      for (final q in pool)
        if (q.tagSet.any(sometimes.contains)) q,
    ]..shuffle(dayRnd);
    if (now.isNotEmpty) special.add(now.first);

    final names = DaySlot.values.map((s) => s.name).toSet();
    final taken = <DaySlot, Quote>{};
    for (final q in special) {
      final pinned = [
        for (final t in q.tagSet)
          if (t.startsWith('@')) t.substring(1),
      ];
      final tagged = q.tagSet.intersection(names);
      DaySlot? want;
      if (q.isJewish && mixed) {
        // Keep it to one Jewish quote a day: a Jewish special takes the morning.
        want = DaySlot.morning;
      } else {
        // A Jewish special leads the day; others default to daytime.
        final fallback = q.isJewish ? 'morning' : 'day';
        final name = pinned.isNotEmpty ? pinned.first : (tagged.isEmpty ? fallback : tagged.first);
        want = DaySlot.values.byName(name);
        if (taken.containsKey(want) || (mixed && want == DaySlot.morning)) {
          want = [
            DaySlot.day,
            DaySlot.evening,
            DaySlot.night,
            if (!mixed) DaySlot.morning,
          ].where((s) => !taken.containsKey(s)).firstOrNull;
        }
      }
      if (want != null && !taken.containsKey(want)) taken[want] = q;
    }
    if (taken[slot] case final q?) return q;
  }

  bool fits(Quote q) {
    final t = q.tagSet;
    return t.contains('any') || t.contains(slot.name);
  }

  var candidates = [
    for (final q in pool)
      if (fits(q)) q,
  ];
  if (idle && slot != DaySlot.morning) {
    final idleOnes = [
      for (final q in pool)
        if (q.tagSet.contains('idle')) q,
    ];
    if (idleOnes.isNotEmpty && rnd.nextInt(3) == 0) candidates = idleOnes;
  }
  if (mixed && candidates.any((q) => q.isJewish) && candidates.any((q) => !q.isJewish)) {
    final morning = slot == DaySlot.morning;
    candidates = [
      for (final q in candidates)
        if (q.isJewish == morning) q,
    ];
  }
  if (candidates.isEmpty) candidates = pool;
  return candidates[rnd.nextInt(candidates.length)];
}

extension<T> on List<T> {
  /// Sorts by [rank], keeping the order of equal ones.
  void sortStable(int Function(T) rank) {
    final ranked = [for (var i = 0; i < length; i++) (rank(this[i]), i, this[i])]
      ..sort((a, b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2);
    setAll(0, ranked.map((r) => r.$3));
  }
}
