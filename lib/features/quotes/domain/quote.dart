import 'dart:math';

import 'package:kosher_dart/kosher_dart.dart';

/// Where a quote comes from. The user picks which ones they want.
enum QuoteSource { songs, movies, literature, tanakh, sages, speeches, philosophy, proverbs }

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
/// * `roshhashana`, `yomkippur`, `sukkot`, `chanukah`, `tubishvat`, `purim`,
///   `pesach`, `shavuot`: Jewish festivals.
/// * `event:<name>`: a matching event in the phone's calendar today,
///   see [eventKeywords].
class Quote {
  const Quote(this.text, this.by, this.source, this.tags);

  final String text;
  final String by;
  final QuoteSource source;
  final String tags;

  Set<String> get tagSet => tags.split(',').toSet();

  bool get isJewish => source == QuoteSource.tanakh || source == QuoteSource.sages;

  @override
  String toString() => '$text — $by';
}

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
    _ => null,
  };
  if (festival != null) tags.add(festival);
  if (day.weekday == DateTime.friday) tags.add('erev');
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

const _quietSources = {QuoteSource.tanakh, QuoteSource.sages, QuoteSource.literature, QuoteSource.philosophy};

/// Picks the quote for a part of the day.
///
/// The same day and slot always give the same quote, so the line stays put
/// for a few hours; [skip] moves to another one (a tap).
///
/// * One quote a day may be special: a festival, a date, a calendar event,
///   and now and then a weekday or month. It takes the slot it is tagged
///   for, or the daytime slot.
/// * When Tanakh or sages are among [sources], the morning quote is the
///   day's one Jewish quote, and the other slots come from the rest. When
///   they are the only sources, every slot uses them.
/// * On solemn days (see [isSolemnDay]) for users of Jewish sources, only
///   quiet sources are used, and nothing is shown if none are picked.
Quote? pickQuote({
  required List<Quote> quotes,
  required Set<QuoteSource> sources,
  required DateTime local,
  Iterable<String> eventTitles = const [],
  bool idle = false,
  int skip = 0,
}) {
  if (sources.any((s) => s == QuoteSource.tanakh || s == QuoteSource.sages) && isSolemnDay(local)) {
    sources = sources.intersection(_quietSources);
  }
  final pool = [
    for (final q in quotes)
      if (sources.contains(q.source)) q,
  ];
  if (pool.isEmpty) return null;
  final slot = slotOf(local);
  final slotName = slot.name;
  final dayKey = local.year * 10000 + local.month * 100 + local.day;
  final rnd = Random(dayKey * 7 + slot.index * 131 + skip * 7919);

  // The day's special quote.
  if (skip == 0) {
    final always = dateTags(local, eventTitles: eventTitles);
    final dayRnd = Random(dayKey);
    final sometimes = {
      if (dayRnd.nextInt(4) == 0) _weekdays[local.weekday - 1],
      if (dayRnd.nextInt(5) == 0) _months[local.month - 1],
    };
    final special = [
      for (final q in pool)
        if (q.tagSet.intersection(always).isNotEmpty || q.tagSet.intersection(sometimes).isNotEmpty) q,
    ];
    if (special.isNotEmpty) {
      final q = special[dayRnd.nextInt(special.length)];
      final names = DaySlot.values.map((s) => s.name).toSet();
      final pinned = [
        for (final t in q.tagSet)
          if (t.startsWith('@')) t.substring(1),
      ];
      final slots = q.tagSet.intersection(names);
      // Keep it to one Jewish quote a day: a Jewish special takes the morning.
      final mixed = pool.any((x) => !x.isJewish);
      final home = q.isJewish && mixed
          ? DaySlot.morning.name
          : pinned.isNotEmpty
          ? pinned.first
          : (slots.isEmpty ? DaySlot.day.name : slots.first);
      if (home == slotName) return q;
    }
  }

  bool fits(Quote q) {
    final t = q.tagSet;
    return t.contains('any') || t.contains(slotName);
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
  final hasJewish = candidates.any((q) => q.isJewish);
  final hasOther = candidates.any((q) => !q.isJewish);
  if (hasJewish && hasOther) {
    final morning = slot == DaySlot.morning;
    candidates = [
      for (final q in candidates)
        if (q.isJewish == morning) q,
    ];
  }
  if (candidates.isEmpty) candidates = pool;
  return candidates[rnd.nextInt(candidates.length)];
}
