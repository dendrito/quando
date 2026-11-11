import 'alarm_request.dart';
import 'phrasebook.dart';
import 'spoken_numbers.dart';
import 'words/cldr.g.dart';
import 'words/lang_words.dart';

/// Turns a sentence into an [AlarmRequest], with no network and no model:
/// "wake me 30 minutes before sunrise on weekdays", "me acorda amanhã às
/// 6 e meia", "תעיר אותי בשבע בבוקר בימי חול".
///
/// The words for each language live in `words/` (one file per language,
/// see docs/alarm-vocabulary.md). With the app's language given, only that
/// language and English are read, so a word in one language can't be
/// mistaken for another (Portuguese "um" is 1, German "um" is "at").
/// Quando?'s other languages are first rewritten into English by the
/// phrasebook. Anything it can't read is left out rather than guessed;
/// [parse] returns null when it found no time at all, so a smarter
/// fallback can try.
class AlarmParser {
  const AlarmParser();

  /// [lang] is the app's language; null reads every language at once.
  AlarmRequest? parse(String input, {String? lang}) {
    final req = read(input, lang: lang);
    return req.isEmpty ? null : req;
  }

  /// Like [parse], but always answers, with what was understood: the
  /// parts of the sentence that were read, and how sure it is.
  AlarmReading read(String input, {String? lang}) {
    final lex = Lexicon.forLanguage(lang);
    final text = spokenNumbers(rewriteForParser(input, lang, keepCase: true), lex);
    return _Pass(text, lex).run();
  }
}

/// The words of the languages being read, joined into patterns once.
class Lexicon {
  Lexicon._(List<LangWords> own, this.codes) {
    // Each language's official CLDR words join its own list, where its
    // own list doesn't already read them (and knows better: Spanish
    // "mañana" is "tomorrow", but not in "de la mañana").
    bool known(String word, Iterable<String> patterns) =>
        patterns.any((p) => p.isNotEmpty && RegExp('^(?:$p)\$').hasMatch(word));
    final langs = [
      ...own,
      for (final c in codes)
        if (cldrWords[c] case final cl?)
          LangWords(
            days: {
              for (final MapEntry(:key, :value) in cl.days.entries)
                if (!own.any((w) => w.days.containsKey(key))) key: value,
            },
            relativeDays: [
              for (final MapEntry(:key, :value) in cl.relativeDays.entries)
                if (!known(key, [for (final w in own) ...w.relativeDays.map((r) => r.$1), for (final w in own) w.am, for (final w in own) w.pm]))
                  (RegExp.escape(key), value),
            ],
            am: cl.morning.where((x) => !known(x, own.map((w) => w.am))).map(RegExp.escape).join('|'),
            pm: cl.afternoon.where((x) => !known(x, own.map((w) => w.pm))).map(RegExp.escape).join('|'),
          ),
    ];
    String alt(String Function(LangWords w) f) {
      final parts = [
        for (final w in langs)
          if (f(w).isNotEmpty) f(w),
      ];
      return parts.isEmpty ? r'(?!x)x' : '(?:${parts.join('|')})';
    }

    String words(Iterable<String> ws) {
      final l = ws.toSet().toList()..sort((a, b) => b.length.compareTo(a.length));
      return l.isEmpty ? r'(?!x)x' : '(?:${l.join('|')})';
    }

    numbers = {for (final w in langs) ...w.numbers};
    hebrew = codes.contains('he');
    numberJoins = {for (final w in langs) w.numberJoin}..remove('');
    word = words(numbers.keys);
    final joins = [for (final j in numberJoins) '\\s+$j\\s+', r'[\s-]+', if (hebrew) r'\s*ו'];
    num = '(?:\\d{1,3}|$word(?:(?:${joins.join('|')})$word)?)';
    oneWords = {for (final w in langs) ...w.oneWords};
    one = '(?:$num|${words(oneWords)})';
    minute = alt((w) => w.minute);
    hour = alt((w) => w.hour);
    halfHourAfter = alt((w) => w.halfHourAfter);
    final multi = <String, int>{}, single = <String, int>{};
    for (final w in langs) {
      for (final MapEntry(:key, :value) in w.durations.entries) {
        (key.contains(r'\s') ? multi : single)[key] = value;
      }
    }
    durationPhrases = {...multi, ...single};
    final connectors = [for (final j in numberJoins) '$j\\s+', if (hebrew) 'ו'];
    dur = [
      ...multi.keys,
      '$one\\s*$hour(?:\\s+$halfHourAfter)?(?:\\s*(?:${connectors.isEmpty ? '' : '${connectors.join('|')}'})?$num\\s*$minute)?',
      '$one\\s*$minute',
      ...single.keys,
    ].map((p) => '(?:$p)').join('|');
    inWords = alt((w) => w.inWords);
    fromNow = alt((w) => w.fromNow);
    days = {for (final w in langs) ...w.days};
    final latin = days.keys.where((d) => !RegExp(r'[֐-׿]').hasMatch(d));
    final suffix = alt((w) => w.daySuffix);
    latinDay = '${words(latin)}$suffix?';
    day = hebrew ? '(?:$latinDay|(?:(?:ב|ו|ל)?(?:יום|ימי)\\s+(?:ה)?|ו|ב)$_hebrewDay)' : latinDay;
    rangeHead = hebrew ? '(?:$latinDay|(?:(?:ב|ו)?(?:יום|ימי)\\s+(?:ה)?|ב|מ)?$_hebrewDay)' : latinDay;
    dayPrefix = alt((w) => w.dayPrefix);
    dayGroups = [for (final w in langs) ...w.dayGroups];
    morning = alt((w) => w.morning);
    evening = alt((w) => w.evening);
    rangeFrom = alt((w) => w.rangeFrom);
    rangeTo = alt((w) => w.rangeTo);
    relativeDays = [for (final w in langs) ...w.relativeDays];
    tonight = alt((w) => w.tonight);
    thisNext = alt((w) => w.thisNext);
    before = alt((w) => w.before);
    after = alt((w) => w.after);
    dir = '(?:$before|$after)';
    article = alt((w) => w.article);
    at = '(?:${alt((w) => w.at)}\\s+)?(?:${alt((w) => w.article)}\\s*)?';
    moments = {
      for (final a in TimeAnchor.values) a: alt((w) => w.moments[a] ?? ''),
    };
    am = alt((w) => w.am);
    pm = alt((w) => w.pm);
    noon = alt((w) => w.noon);
    midnight = alt((w) => w.midnight);
    atHour = '(?:(?:${alt((w) => w.atHour)})\\s+${hebrew ? r'|(?:ב|ל)(?:שעה\s*)?\s*' : ''})';
    timePrefix = '(?:(?:${alt((w) => w.timePrefix)})\\s+${hebrew ? r'|(?:ב|ל)(?:שעה\s*)?\s*' : ''})?';
    oclock = alt((w) => w.oclock);
    hourWord = alt((w) => w.hourWord);
    halfPast = alt((w) => w.halfPast);
    quarterPast = alt((w) => w.quarterPast);
    quarterTo = alt((w) => w.quarterTo);
    minutesTo = alt((w) => w.minutesTo);
    connector = alt((w) => w.connector);
    labelTriggers = alt((w) => w.labelTriggers);
    filler = {for (final w in langs) ...w.filler};
    question = alt((w) => w.question);
    command = alt((w) => w.command);
    remove = alt((w) => w.remove);
    skip = alt((w) => w.skip);
    months = {for (final w in langs) ...w.months};
    month = words(months.keys);
    ordinalDay = alt((w) => w.ordinalDay);
    myEvent = alt((w) => w.myEvent);
    soundWords = {for (final w in langs) ...w.soundWords};
    snooze = alt((w) => w.snooze);
  }

  /// The app's language and English; null = every language.
  factory Lexicon.forLanguage(String? lang) {
    final code = lang?.split(RegExp('[-_]')).first;
    // Phrasebook languages arrive rewritten into English, with "halb 8"
    // for the Dutch and Indonesian half hour.
    final key = code == null ? '*' : (parserLanguages.containsKey(code) ? code : 'book');
    return _cache[key] ??= Lexicon._(
      switch (key) {
        '*' => parserLanguages.values.toList(),
        'book' || 'en' => [parserLanguages['en']!],
        _ => [parserLanguages['en']!, parserLanguages[key]!],
      },
      switch (key) {
        '*' => parserLanguages.keys.toSet(),
        'book' => {'en', 'halb'},
        _ => {'en', key},
      },
    );
  }

  static final _cache = <String, Lexicon>{};

  final Set<String> codes;
  late final Map<String, int> numbers;
  late final bool hebrew;
  late final Set<String> numberJoins;
  late final String word, num, one, minute, hour, halfHourAfter, dur, inWords, fromNow;
  late final Set<String> oneWords;
  late final Map<String, int> durationPhrases, days, months;
  late final String latinDay, day, rangeHead, dayPrefix, morning, evening, rangeFrom, rangeTo;
  late final List<(String, Set<int>)> dayGroups;
  late final List<(String, int)> relativeDays;
  late final String tonight, thisNext, before, after, dir, at, am, pm, noon, midnight;
  late final Map<TimeAnchor, String> moments;
  late final String atHour, timePrefix, oclock, hourWord, halfPast, quarterPast, quarterTo, minutesTo;
  late final String connector, labelTriggers, question, command, remove, skip, month, ordinalDay;
  late final String myEvent, snooze, article;
  late final Set<String> filler;
  late final Map<String, String> soundWords;

  static const _hebrewDay = '(?:ראשון|שני|שלישי|רביעי|חמישי|שישי|שבת)';

  int? numOf(String text) {
    final t = text.trim();
    final digits = int.tryParse(t);
    if (digits != null) return digits;
    var total = 0;
    var any = false;
    for (var tok in t.split(RegExp(r'[\s-]+'))) {
      if (numberJoins.contains(tok) || tok.isEmpty) continue;
      var v = numbers[tok];
      if (v == null && hebrew && tok.startsWith('ו')) v = numbers[tok.substring(1)];
      if (v == null) return null;
      if (v == 10 && tok.contains('עשר') && total > 0 && total < 10) {
        total += 10; // חמש עשרה = 15
      } else {
        total += v;
      }
      any = true;
    }
    return any ? total : null;
  }

  int? oneOf(String t) => oneWords.contains(t.trim()) ? 1 : numOf(t);

  Duration? durOf(String text) {
    final t = text.trim();
    for (final MapEntry(:key, :value) in durationPhrases.entries) {
      if (RegExp('^(?:$key)\$').hasMatch(t)) return Duration(minutes: value);
    }
    var total = Duration.zero;
    final h = RegExp('^($one)\\s*$hour').firstMatch(t);
    var rest = t;
    if (h != null) {
      total += Duration(hours: oneOf(h.group(1)!) ?? 0);
      rest = t.substring(h.end);
      if (RegExp('^\\s+$halfHourAfter').hasMatch(rest)) {
        total += const Duration(minutes: 30);
        rest = rest.replaceFirst(RegExp('^\\s+$halfHourAfter'), '');
      }
    }
    final joins = [for (final j in numberJoins) '$j\\s+', if (hebrew) 'ו'];
    final m = RegExp('($one)\\s*$minute\\s*\$')
        .firstMatch(joins.isEmpty ? rest : rest.replaceFirst(RegExp('^\\s*(?:${joins.join('|')})'), ''));
    if (m != null) total += Duration(minutes: oneOf(m.group(1)!) ?? 0);
    return total == Duration.zero ? null : total;
  }

  int? dayOf(String text) {
    var t = text.trim().replaceAll(RegExp(r'\s*feiras?$'), '');
    final v = days[t];
    if (v != null) return v;
    if (!hebrew) return null;
    final he = RegExp(_hebrewDay).allMatches(t).lastOrNull;
    return he == null ? null : days[he.group(0)];
  }

  bool isBefore(String d) => RegExp('^(?:$before)').hasMatch(d);
}

/// What the parser understood, and how sure it is.
class AlarmReading extends AlarmRequest {
  const AlarmReading({
    super.hour,
    super.minute,
    super.days,
    super.dayOffset,
    super.after,
    super.anchor,
    super.offset,
    super.label,
    super.halfDayUnsure,
    super.onWeekday,
    super.month,
    super.dayOfMonth,
    super.eventQuery,
    super.action,
    super.sound,
    super.snoozeMinutes,
    this.text = '',
    this.understood = const [],
    this.confidence = 0,
  });

  /// The sentence as the parser read it: after other languages were
  /// rewritten into English and number words into digits.
  final String text;

  /// Where in the sentence each understood part is: start and end.
  final List<(int, int)> understood;

  /// 0 to 1: how much of the sentence was read. Below [unsure], an
  /// on-device AI (if there is one) is asked too.
  final double confidence;

  static const unsure = 0.5;

  /// The plain request, without the reading details.
  AlarmRequest get request => AlarmRequest(
    hour: hour,
    minute: minute,
    days: days,
    dayOffset: dayOffset,
    after: after,
    anchor: anchor,
    offset: offset,
    label: label,
    halfDayUnsure: halfDayUnsure,
    onWeekday: onWeekday,
    month: month,
    dayOfMonth: dayOfMonth,
    eventQuery: eventQuery,
    action: action,
    sound: sound,
    snoozeMinutes: snoozeMinutes,
  );
}

const _b0 = r'(?<!\S)';
const _b1 = r'(?!\S)';
const _shabbatWord =
    r'(?:shabb?at|shabbos|sabbath|chabb?at|schabbat|saba|yom\s+tov|chag|(?:ה|ל|לה|ב|בה)?(?:שבת|חג))';

class _Pass {
  _Pass(String input, this.lex) : orig = input {
    final buf = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      buf.write(_norm(input, i));
    }
    s = buf.toString();
    eaten = List.filled(s.length, false);
  }

  final Lexicon lex;
  final String orig;
  late String s;
  late List<bool> eaten;
  final _labelEaten = <(int, int)>[];

  static const _accents = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e', 'í': 'i',
    'ì': 'i', 'î': 'i', 'ï': 'i', 'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ú': 'u', 'ù': 'u',
    'û': 'u', 'ü': 'u', 'ç': 'c', 'ñ': 'n', 'ß': 's', '’': "'", '‘': "'", '״': '"', '׳': "'", '“': '"',
    '”': '"',
  };

  /// One character in, one out, so positions match [orig].
  static String _norm(String input, int i) {
    final c = input[i];
    var l = c.toLowerCase();
    if (l.length != 1) l = c;
    l = _accents[l] ?? l;
    bool digit(int j) => j >= 0 && j < input.length && RegExp(r'\d').hasMatch(input[j]);
    if (l == ':' || l == '.') return digit(i - 1) && digit(i + 1) ? l : ' ';
    if (RegExp(r'''[,;!?()\[\]{}\-–—/\\]''').hasMatch(l)) return ' ';
    return l;
  }

  void _eat(int start, int end) {
    s = s.replaceRange(start, end, ' ' * (end - start));
    for (var i = start; i < end; i++) {
      eaten[i] = true;
    }
  }

  RegExpMatch? _find(String pattern) => RegExp('$_b0(?:$pattern)$_b1').firstMatch(s);

  int? hour;
  var minute = 0;
  bool? pm;
  final days = <int>{};
  int? dayOffset;
  Duration? after;
  TimeAnchor? anchor;
  var offset = Duration.zero;
  int? onWeekday;
  int? month;
  int? dayOfMonth;
  String? eventQuery;
  var action = AlarmAction.set;
  String? sound;
  int? snoozeMinutes;

  AlarmReading run() {
    _action();
    _relative();
    _anchor();
    _date();
    _days();
    _noonMidnight();
    _clock();
    _hints();
    _fallbackHour();
    _event();
    _extras();
    var h = hour;
    if (h != null) {
      if (pm == true && h < 12) h += 12;
      if (pm == false && h == 12) h = 0;
    }
    final repeating = days.isNotEmpty;
    final timed = after != null || anchor != null || eventQuery != null;
    final label = _label();
    return AlarmReading(
      hour: timed ? null : h,
      minute: timed ? 0 : minute,
      days: after != null ? const {} : days,
      dayOffset: repeating || after != null ? null : dayOffset,
      after: after,
      anchor: after != null ? null : anchor,
      offset: offset,
      label: label,
      halfDayUnsure: !timed && pm == null && h != null && h >= 1 && h <= 11,
      onWeekday: repeating || after != null ? null : onWeekday,
      month: month,
      dayOfMonth: dayOfMonth,
      eventQuery: after != null ? null : eventQuery,
      action: action,
      sound: sound,
      snoozeMinutes: snoozeMinutes,
      text: orig,
      understood: _spans(),
      confidence: _confidence(),
    );
  }

  // ---- What to do: set, remove, skip ----

  void _action() {
    final skip = _find('(?:${lex.skip})(?:\\s+(?:${lex.article}))?(?:\\s+(?:alarm|alarme|alarma|wecker|sveglia))?');
    if (skip != null) {
      action = AlarmAction.skip;
      _eat(skip.start, skip.end);
      return;
    }
    final remove = _find(
      '(?:${lex.remove})(?:\\s+(?:all\\s+)?(?:${lex.myEvent}|${lex.article}))?(?:\\s+(?:alarms?|alarmes?|alarmas?|wecker|sveglie|sveglia|reveils?|השעון|שעון))?',
    );
    if (remove != null) {
      action = AlarmAction.remove;
      _eat(remove.start, remove.end);
    }
  }

  // ---- In a while ----

  void _relative() {
    final m =
        _find('(?:${lex.inWords})\\s+(${lex.dur})') ??
        _find('(${lex.dur})\\s+(?:${lex.fromNow})');
    if (m == null) return;
    final d = lex.durOf(m.group(1)!);
    if (d == null) return;
    after = d;
    _eat(m.start, m.end);
  }

  // ---- Moments ----

  void _anchor() {
    final dur = lex.dur, dir = lex.dir, at = lex.at;
    for (final MapEntry(key: a, value: pattern) in lex.moments.entries) {
      // Word orders other languages use: "sunrise 30 minutes before"
      // (Japanese, Korean, Turkish, Hindi), "sunrise before 30 minutes"
      // (Chinese), "before sunrise by 30 minutes" (Arabic).
      for (final (re, d, r) in [
        ('$at($pattern)\\s+(?:of\\s+|from\\s+|to\\s+)?($dur)\\s+($dir)', 2, 3),
        ('$at($pattern)\\s+($dir)\\s+($dur)', 3, 2),
        ('($dir)\\s+$at($pattern)\\s+(?:by\\s+)?($dur)', 3, 1),
      ]) {
        final m = _find(re);
        if (m != null) {
          _setAnchor(a, m.group(d), m.group(r));
          _eat(m.start, m.end);
          return;
        }
      }
      final m = _find('(?:($dur)\\s+)?(?:($dir)\\s+)?$at($pattern)');
      if (m != null) {
        _setAnchor(a, m.group(1), m.group(2));
        _eat(m.start, m.end);
        return;
      }
    }
    // "Before Shabbat" means candle lighting; "after Shabbat", havdalah.
    final m = _find('(?:($dur)\\s+)?($dir)\\s+$at$_shabbatWord');
    if (m != null) {
      final before = lex.isBefore(m.group(2)!);
      _setAnchor(before ? TimeAnchor.candleLighting : TimeAnchor.havdalah, m.group(1), m.group(2));
      _eat(m.start, m.end);
    }
  }

  void _setAnchor(TimeAnchor a, String? dur, String? dir) {
    anchor = a;
    _setOffset(dur, dir);
  }

  void _setOffset(String? dur, String? dir) {
    final d = dur == null ? null : lex.durOf(dur);
    if (d == null || dir == null) return;
    offset = lex.isBefore(dir) ? -d : d;
  }

  /// "30 minutes before my exam": any calendar event is a moment too.
  void _event() {
    if (anchor != null || after != null || hour != null) return;
    final m = _find('(${lex.dur})\\s+(${lex.dir})\\s+(?:(?:${lex.myEvent})\\s+)?(\\S+(?:\\s+\\S+){0,3})');
    if (m == null) return;
    final words = orig.substring(m.end - m.group(3)!.length, m.end).split(RegExp(r'\s+'));
    while (words.isNotEmpty && lex.filler.contains(_clean(words.last))) {
      words.removeLast();
    }
    if (words.isEmpty) return;
    eventQuery = words.join(' ');
    _setOffset(m.group(1), m.group(2));
    _eat(m.start, m.end);
  }

  // ---- Days and dates ----

  /// "on the 15th", "25 May", "May 25", "15/11", "next Friday".
  void _date() {
    final ord = lex.ordinalDay;
    final dm = _find(
      '(?:(?:on\\s+)?(?:the\\s+)?|(?:no\\s+dia|el\\s+dia|le|am|il)\\s+)?(\\d{1,2})(?:$ord)?\\s+(?:of\\s+|de\\s+|di\\s+)?(${lex.month})',
    );
    final md = dm == null ? _find('(${lex.month})\\s+(?:the\\s+)?(\\d{1,2})(?:$ord)?') : null;
    if (dm != null || md != null) {
      final m = (dm ?? md)!;
      final day = int.parse(dm != null ? m.group(1)! : m.group(2)!);
      final mon = lex.months[dm != null ? m.group(2)! : m.group(1)!];
      if (day >= 1 && day <= 31 && mon != null) {
        dayOfMonth = day;
        month = mon;
        _eat(m.start, m.end);
        return;
      }
    }
    final slash = _find(r'(?:on\s+)?(\d{1,2})[/.](\d{1,2})');
    if (slash != null) {
      // Day first, as nearly every Quando? language writes it.
      final d = int.parse(slash.group(1)!), mo = int.parse(slash.group(2)!);
      if (d >= 1 && d <= 31 && mo >= 1 && mo <= 12) {
        dayOfMonth = d;
        month = mo;
        _eat(slash.start, slash.end);
        return;
      }
    }
    final nth = _find(
      '(?:on\\s+)?the\\s+(\\d{1,2})(?:$ord)|(?:no\\s+)?dia\\s+(\\d{1,2})|el\\s+(?:dia\\s+)?(\\d{1,2})(?=\\s+(?:a\\s+las|de))|le\\s+(\\d{1,2})(?=\\s+(?:a|du))|am\\s+(\\d{1,2})\\.',
    );
    if (nth != null) {
      final g = [1, 2, 3, 4, 5].map((i) => nth.group(i)).whereType<String>().first;
      final d = int.parse(g);
      if (d >= 1 && d <= 31) {
        dayOfMonth = d;
        _eat(nth.start, nth.end);
        return;
      }
    }
    final next = _find('(?:${lex.thisNext})\\s+(${lex.day})|(${lex.day})\\s+(?:${lex.thisNext})');
    if (next != null) {
      final d = lex.dayOf(next.group(1) ?? next.group(2)!);
      if (d != null) {
        onWeekday = d;
        _eat(next.start, next.end);
      }
    }
  }

  void _days() {
    for (final (pattern, set) in lex.dayGroups) {
      final m = _find(pattern);
      if (m == null) continue;
      days.addAll(set);
      if (RegExp(lex.morning).hasMatch(m.group(0)!)) pm ??= false;
      if (RegExp(lex.evening).hasMatch(m.group(0)!)) pm ??= true;
      _eat(m.start, m.end);
    }
    // Ranges, "Monday to Friday", "de segunda a sexta", "ראשון עד חמישי".
    while (true) {
      final m = _find(
        '(?:(?:${lex.rangeFrom})\\s+)?(${lex.rangeHead})\\s+(?:${lex.rangeTo})\\s+(${lex.rangeHead})',
      );
      if (m == null) break;
      final a = lex.dayOf(m.group(1)!), b = lex.dayOf(m.group(2)!);
      if (a == null || b == null) break;
      days.addAll(_range(a, b));
      _eat(m.start, m.end);
    }
    while (true) {
      final m = _find('(?:(?:${lex.dayPrefix})\\s+)?(${lex.day})');
      if (m == null) break;
      final d = lex.dayOf(m.group(1)!);
      if (d == null) break;
      days.add(d);
      _eat(m.start, m.end);
    }
    for (final (pattern, n) in lex.relativeDays) {
      final m = _find(pattern);
      if (m == null) continue;
      dayOffset ??= n;
      _eat(m.start, m.end);
    }
    final t = _find(lex.tonight);
    if (t != null) {
      dayOffset ??= 0;
      pm ??= true;
      _eat(t.start, t.end);
    }
  }

  static Set<int> _range(int from, int to) {
    final out = <int>{};
    for (var d = from; ; d = d % 7 + 1) {
      out.add(d);
      if (d == to || out.length == 7) break;
    }
    return out;
  }

  // ---- Time of day ----

  void _noonMidnight() {
    final noon = _find('(?:${lex.atHour})?(?:${lex.noon})');
    if (noon != null) {
      hour = 12;
      pm = null;
      _eat(noon.start, noon.end);
      return;
    }
    final night = _find('(?:${lex.atHour})?(?:${lex.midnight})');
    if (night != null) {
      hour = 0;
      pm = null;
      _eat(night.start, night.end);
    }
  }

  void _clock() {
    if (hour != null || after != null || anchor != null) return;
    final num = lex.num, tp = lex.timePrefix, am = lex.am, pmw = lex.pm;
    bool take(RegExpMatch? m, int? h, int mm) {
      if (m == null || h == null || h > 24 || mm < 0 || mm > 59) return false;
      hour = h % 24;
      minute = mm;
      _eat(m.start, m.end);
      return true;
    }

    // 7:30, 7.30, 19h30
    var m = _find('$tp(\\d{1,2})\\s*[:.h]\\s*(\\d{2})(?:\\s*h)?');
    if (m != null && take(m, int.tryParse(m.group(1)!), int.parse(m.group(2)!))) return;
    if (lex.codes.contains('en')) {
      // half past seven, quarter to eight
      m = _find('$tp(?:a\\s+)?(half|quarter)\\s+(past|after|to|before)\\s+($num)');
      if (m != null) {
        final h = lex.numOf(m.group(3)!);
        final q = m.group(1) == 'half' ? 30 : 15;
        final to = m.group(2) == 'to' || m.group(2) == 'before';
        if (h != null && take(m, to ? (h + 23) % 24 : h, to ? 60 - q : q)) return;
      }
    }
    if (lex.codes.contains('de') || lex.codes.contains('halb')) {
      // halb acht = 7:30, viertel nach sieben, viertel vor acht
      m = _find('$tp(?:halb)\\s+($num)');
      if (m != null) {
        final h = lex.numOf(m.group(1)!);
        if (h != null && take(m, (h + 23) % 24, 30)) return;
      }
      m = _find('$tp(viertel|dreiviertel)\\s+(nach|vor)?\\s*($num)');
      if (m != null) {
        final h = lex.numOf(m.group(3)!);
        final before = m.group(2) == 'vor' || m.group(1) == 'dreiviertel';
        if (h != null && take(m, before ? (h + 23) % 24 : h, before ? 45 : 15)) return;
      }
    }
    // ocho menos cuarto, huit heures moins le quart, otto meno un quarto
    m = _find('$tp($num)\\s*(?:(?:${lex.hourWord})\\s+)?(?:${lex.quarterTo})(?:\\s+$pmw|\\s+$am)?');
    if (m != null) {
      final h = lex.numOf(m.group(1)!);
      if (h != null && take(m, (h + 23) % 24, 45)) {
        _hint(m.group(0)!);
        return;
      }
    }
    // quinze para as sete, רבע ל-7
    if (lex.codes.contains('pt')) m = _find('($num|um\\s+quarto)\\s+(?:${lex.minutesTo})\\s+(?:as?\\s+)?($num)');
    if (lex.hebrew) m ??= _find('(רבע|$num\\s+דקות)\\s+ל\\s*($num)');
    if (m != null && (lex.codes.contains('pt') || lex.hebrew)) {
      final g = m.group(1)!;
      final q = g.contains('quarto') || g == 'רבע' ? 15 : lex.numOf(g.replaceAll('דקות', ''));
      final h = lex.numOf(m.group(2)!);
      if (q != null && h != null && q < 60 && take(m, (h + 23) % 24, 60 - q)) return;
    }
    // sete e meia, שבע וחצי, seven and a half, שבע ורבע
    m = _find(
      '$tp($num)\\s*(?:(?:${lex.hourWord})\\s+)?((?:${lex.halfPast})|(?:${lex.quarterPast}))(?:\\s+$pmw|\\s+$am)?',
    );
    if (m != null) {
      final q = RegExp('^(?:${lex.quarterPast})\$').hasMatch(m.group(2)!) ? 15 : 30;
      if (take(m, lex.numOf(m.group(1)!), q)) {
        _hint(m.group(0)!);
        return;
      }
    }
    // sete e quinze, שבע ו-20, seven thirty
    final hw = lex.hourWord;
    m = _find(
      '$tp(?!um\\s)($num)\\s*(?:(?:$hw)\\s+)?(?:(?:${lex.connector})\\s+|${lex.hebrew ? r'ו\s*|' : ''}\\s)($num)(?:\\s+(?:${lex.minute}))?',
    );
    if (m != null) {
      final h = lex.numOf(m.group(1)!), mm = lex.numOf(m.group(2)!);
      final teen = RegExp(r'^\s*עשרה?\s*$').hasMatch(m.group(2)!); // שתיים עשרה = 12
      if (h != null && mm != null && h <= 23 && mm >= 10 && !teen && take(m, h, mm)) return;
    }
    // at 7, às 7, בשבע, 7 o'clock, 7 horas, 7am
    final units = '(?!\\s*(?:${lex.minute}|${lex.hour})$_b1)';
    m = _find('${lex.atHour}($num)$units(?:\\s*(?:${lex.oclock}|${lex.hourWord}|h))?');
    if (m != null && take(m, lex.numOf(m.group(1)!), 0)) return;
    m = _find('($num)\\s*(?:${lex.oclock}|${lex.hourWord}|h)');
    if (m != null && take(m, lex.numOf(m.group(1)!), 0)) return;
    m = RegExp('$_b0($num)\\s*(?=(?:$am|$pmw)$_b1)').firstMatch(s);
    if (m != null) take(m, lex.numOf(m.group(1)!), 0);
  }

  void _hint(String text) {
    if (RegExp('$_b0${lex.pm}$_b1').hasMatch(text)) pm = true;
    if (RegExp('$_b0${lex.am}$_b1').hasMatch(text)) pm = false;
  }

  bool? _halfHint;

  void _hints() {
    final am = _find(lex.am);
    if (am != null) {
      if (hour != null) pm = false;
      _halfHint = false;
      _eat(am.start, am.end);
    }
    final p = _find(lex.pm);
    if (p != null) {
      if (hour != null) pm = true;
      _halfHint = true;
      _eat(p.start, p.end);
    }
  }

  void _fallbackHour() {
    if (hour != null || after != null || anchor != null) return;
    final m = _find(r'(\d{1,2})');
    if (m == null) return;
    final h = int.parse(m.group(1)!);
    if (h > 23) return;
    hour = h;
    minute = 0;
    pm ??= _halfHint;
    _eat(m.start, m.end);
  }

  // ---- Sound and snooze ----

  void _extras() {
    final sn = _find('(?:${lex.snooze})\\s+(?:(?:${lex.atHour})|of\\s+|de\\s+)?(\\d{1,2})\\s*(?:${lex.minute})?');
    if (sn != null) {
      snoozeMinutes = int.parse(sn.group(1)!);
      _eat(sn.start, sn.end);
    }
    for (final MapEntry(:key, :value) in lex.soundWords.entries) {
      final m = _find('(?:(?:with|to|com|con|avec|mit|con|עם)\\s+)?(?:(?:the|a|my|o|a|la|le|el|il|die|das|ה)\\s+)?(?:$key)');
      if (m != null) {
        sound = value;
        _eat(m.start, m.end);
        break;
      }
    }
  }

  // ---- Label ----

  /// What's left after the times and days, in the person's own spelling,
  /// following "remind me to", "for", "para", "תזכיר לי"...
  String _label() {
    for (final m in RegExp('$_b0${lex.labelTriggers}$_b1').allMatches(s)) {
      final buf = StringBuffer();
      for (var i = m.end; i < orig.length; i++) {
        buf.write(eaten[i] ? ' ' : orig[i]);
      }
      final words = buf.toString().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
      bool fill(String w) => lex.filler.contains(_clean(w));
      while (words.isNotEmpty && fill(words.first)) {
        words.removeAt(0);
      }
      while (words.isNotEmpty && fill(words.last)) {
        words.removeLast();
      }
      if (words.isEmpty) continue;
      final label = words.join(' ').replaceAll(RegExp(r'''^[\s,.;:!?'"-]+|[\s,.;:!?'"-]+$'''), '');
      if (label.isEmpty) continue;
      final start = orig.indexOf(words.first, m.end);
      if (start >= 0) _labelEaten.add((start, start + label.length));
      return label[0].toUpperCase() + label.substring(1);
    }
    return '';
  }

  static String _clean(String w) {
    final b = StringBuffer();
    for (var i = 0; i < w.length; i++) {
      b.write(_norm(w, i));
    }
    return b.toString().trim();
  }

  /// The stretches of the sentence that were read.
  List<(int, int)> _spans() {
    final out = <(int, int)>[];
    int? start;
    for (var i = 0; i <= eaten.length; i++) {
      final on = i < eaten.length && eaten[i];
      if (on && start == null) start = i;
      if (!on && start != null) {
        // Trim spaces at the edges.
        var a = start, b = i;
        while (a < b && orig[a].trim().isEmpty) {
          a++;
        }
        while (b > a && orig[b - 1].trim().isEmpty) {
          b--;
        }
        if (b > a) out.add((a, b));
        start = null;
      }
    }
    return out;
  }

  /// The share of the sentence's real words that were read (times, days,
  /// moments, the label), ignoring words like "please" and "alarm".
  double _confidence() {
    final words = RegExp(r'\S+').allMatches(orig).toList();
    var counted = 0, read = 0;
    for (final w in words) {
      if (lex.filler.contains(_clean(w.group(0)!))) continue;
      counted++;
      final inLabel = _labelEaten.any((l) => w.start >= l.$1 && w.end <= l.$2);
      if (inLabel || eaten.sublist(w.start, w.end).any((e) => e)) read++;
    }
    if (counted == 0) return 0;
    return read / counted;
  }
}
