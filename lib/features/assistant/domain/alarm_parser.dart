import 'alarm_request.dart';

/// Turns a sentence into an [AlarmRequest], with no network and no model:
/// "wake me 30 minutes before sunrise on weekdays", "me acorda amanhã às
/// 6 e meia", "תעיר אותי בשבע בבוקר בימי חול".
///
/// English, Portuguese and Hebrew are understood, mixed freely. Anything it
/// can't read is left out rather than guessed; [parse] returns null when it
/// found no time at all, so a smarter fallback (an on-device model) can try.
class AlarmParser {
  const AlarmParser();

  AlarmRequest? parse(String input) {
    final p = _Pass(input);
    final req = p.run();
    return req.isEmpty ? null : req;
  }
}

// ---- Shared pieces of pattern ----

const _b0 = r'(?<!\S)';
const _b1 = r'(?!\S)';

const _units = {
  // English
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
  'ten': 10,
  'eleven': 11, 'twelve': 12, 'thirteen': 13, 'fourteen': 14, 'fifteen': 15, 'sixteen': 16, 'seventeen': 17,
  'eighteen': 18, 'nineteen': 19, 'twenty': 20, 'thirty': 30, 'forty': 40, 'fifty': 50,
  // Portuguese (accents stripped)
  'um': 1,
  'uma': 1,
  'dois': 2,
  'duas': 2,
  'tres': 3,
  'quatro': 4,
  'cinco': 5,
  'seis': 6,
  'sete': 7,
  'oito': 8,
  'nove': 9, 'dez': 10, 'onze': 11, 'doze': 12, 'treze': 13, 'catorze': 14, 'quatorze': 14, 'quinze': 15,
  'dezesseis': 16, 'dezessete': 17, 'dezoito': 18, 'dezenove': 19, 'vinte': 20, 'trinta': 30, 'quarenta': 40,
  'cinquenta': 50,
  // Hebrew
  'אחת': 1, 'אחד': 1, 'שתיים': 2, 'שתים': 2, 'שניים': 2, 'שתי': 2, 'שלוש': 3, 'שלושה': 3, 'ארבע': 4,
  'ארבעה': 4, 'חמש': 5, 'חמישה': 5, 'שש': 6, 'שישה': 6, 'שבע': 7, 'שבעה': 7, 'שמונה': 8, 'תשע': 9, 'תשעה': 9,
  'עשר': 10, 'עשרה': 10, 'עשרים': 20, 'שלושים': 30, 'ארבעים': 40, 'חמישים': 50,
};

final String _word = () {
  final words = _units.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
  return '(?:${words.join('|')})';
}();

/// A number: digits, a word, "twenty five", "vinte e cinco", "עשרים וחמש",
/// "חמש עשרה".
final String _num = '(?:\\d{1,3}|$_word(?:(?:\\s+e\\s+|\\s+and\\s+|[\\s-]+|\\s*ו)$_word)?)';

int? _numOf(String text) {
  final t = text.trim();
  final digits = int.tryParse(t);
  if (digits != null) return digits;
  var total = 0;
  var any = false;
  for (var tok in t.split(RegExp(r'[\s-]+'))) {
    if (tok == 'e' || tok == 'and' || tok.isEmpty) continue;
    var v = _units[tok];
    if (v == null && tok.startsWith('ו')) v = _units[tok.substring(1)];
    if (v == null) return null;
    if (v == 10 && (tok.contains('עשר')) && total > 0 && total < 10) {
      total += 10; // חמש עשרה = 15
    } else {
      total += v;
    }
    any = true;
  }
  return any ? total : null;
}

const _min = r"(?:minutes?|mins?|m|minutos?|דקות|דקה|ד')";
const _hr = r'(?:hours?|hrs?|h|horas?|שעות|שעה)';
final String _one = '(?:$_num|an?|uma?)';

/// A length of time: "30 minutes", "an hour and a half", "meia hora",
/// "שעה וחצי", "2h15".
final String _dur = [
  r'(?:an?\s+)?hour\s+and\s+a\s+half',
  r'(?:uma\s+)?hora\s+e\s+meia',
  r'שעה\s+וחצי',
  r'(?:a\s+)?half\s+(?:an\s+)?hour',
  r'meia\s+hora',
  r'חצי\s+שעה',
  r'(?:a\s+)?quarter\s+(?:of\s+)?(?:an\s+)?hour',
  r'(?:um\s+)?quarto\s+de\s+hora',
  r'רבע\s+שעה',
  'שעתיים',
  '$_one\\s*$_hr(?:\\s+and\\s+a\\s+half|\\s+e\\s+meia|\\s+וחצי)?(?:\\s*(?:and\\s+|e\\s+|ו)?$_num\\s*$_min)?',
  '$_one\\s*$_min',
  'שעה',
  'דקה',
].map((p) => '(?:$p)').join('|');

Duration? _durOf(String text) {
  final t = text.trim();
  if (RegExp(r'hour\s+and\s+a\s+half|hora\s+e\s+meia|שעה\s+וחצי').hasMatch(t))
    return const Duration(minutes: 90);
  if (RegExp(r'half|meia\s+hora|חצי').hasMatch(t)) return const Duration(minutes: 30);
  if (RegExp(r'quarter|quarto|רבע').hasMatch(t)) return const Duration(minutes: 15);
  if (t == 'שעתיים') return const Duration(hours: 2);
  if (t == 'שעה') return const Duration(hours: 1);
  if (t == 'דקה') return const Duration(minutes: 1);
  var total = Duration.zero;
  final h = RegExp('^($_one)\\s*$_hr').firstMatch(t);
  var rest = t;
  if (h != null) {
    total += Duration(hours: _oneOf(h.group(1)!) ?? 0);
    rest = t.substring(h.end);
    if (RegExp(r'^\s+(?:and\s+a\s+half|e\s+meia|וחצי)').hasMatch(rest)) total += const Duration(minutes: 30);
  }
  final m = RegExp('($_one)\\s*$_min\\s*\$')
      .firstMatch(rest.replaceFirst(RegExp(r'^\s*(?:and\s+|e\s+|ו)'), ''));
  if (m != null) total += Duration(minutes: _oneOf(m.group(1)!) ?? 0);
  return total == Duration.zero ? null : total;
}

int? _oneOf(String t) => const {'a', 'an', 'um', 'uma'}.contains(t.trim()) ? 1 : _numOf(t);

// ---- Days ----

const _dayNames = <String, int>{
  'monday': 1,
  'mondays': 1,
  'mon': 1,
  'tuesday': 2,
  'tuesdays': 2,
  'tue': 2,
  'tues': 2,
  'wednesday': 3,
  'wednesdays': 3,
  'wed': 3,
  'thursday': 4,
  'thursdays': 4,
  'thu': 4,
  'thur': 4,
  'thurs': 4,
  'friday': 5,
  'fridays': 5,
  'fri': 5,
  'saturday': 6,
  'saturdays': 6,
  'sunday': 7,
  'sundays': 7,
  'segunda': 1,
  'segundas': 1,
  'terca': 2,
  'tercas': 2,
  'quarta': 3,
  'quartas': 3,
  'quinta': 4,
  'quintas': 4,
  'sexta': 5,
  'sextas': 5,
  'sabado': 6,
  'sabados': 6,
  'domingo': 7,
  'domingos': 7,
  'shabbat': 6,
  'shabbos': 6,
  'sabbath': 6,
  'shabat': 6,
  'ראשון': 7,
  'שני': 1,
  'שלישי': 2,
  'רביעי': 3,
  'חמישי': 4,
  'שישי': 5,
  'שבת': 6,
};

final String _latinDay = () {
  final words = _dayNames.keys.where((w) => RegExp(r'^[a-z]').hasMatch(w)).toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  return '(?:${words.join('|')})(?:\\s*feiras?)?';
}();
const _hebrewDay = '(?:ראשון|שני|שלישי|רביעי|חמישי|שישי|שבת)';

/// A day name. Hebrew ones need "יום"/"ימי" or a joining ו before them,
/// because שני is also "two" and "second".
final String _day = '(?:$_latinDay|(?:(?:ב|ו)?(?:יום|ימי)\\s+(?:ה)?|ו|ב)$_hebrewDay)';

int? _dayOf(String text) {
  var t = text.trim().replaceAll(RegExp(r'\s*feiras?$'), '');
  final v = _dayNames[t];
  if (v != null) return v;
  final he = RegExp(_hebrewDay).allMatches(t).lastOrNull;
  return he == null ? null : _dayNames[he.group(0)];
}

Set<int> _range(int from, int to) {
  final out = <int>{};
  for (var d = from; ; d = d % 7 + 1) {
    out.add(d);
    if (d == to || out.length == 7) break;
  }
  return out;
}

// ---- Anchors ----

const _dir =
    r'(?:before|prior\s+to|ahead\s+of|after|antes\s+d[oa]s?|antes\s+de|depois\s+d[oa]s?|depois\s+de|apos\s+[oa]?|לפני|אחרי)';
const _at = r'(?:at\s+|on\s+|ao\s+|no\s+|na\s+|em\s+|when\s+)?(?:the\s+|o\s+|a\s+)?';
const _shabbatWord = r'(?:shabb?at|shabbos|sabbath|saba|yom\s+tov|chag|(?:ה|ל|לה|ב|בה)?(?:שבת|חג))';

const _anchorPatterns = <TimeAnchor, String>{
  TimeAnchor.havdalah: r'(?:havdall?ah?|havdole|end\s+of\s+(?:the\s+)?(?:shabb?at|shabbos|sabbath|yom\s+tov)|(?:shabb?at|shabbos|sabbath)\s+(?:ends|is\s+out|goes\s+out)|motzei\s+shabb?at|motzash|fim\s+d[oa]\s+shabb?at|saida\s+d[oa]\s+shabb?at|(?:ה|ל|לה|ב|בה)?הבדלה|(?:ב|ל)?צאת\s+(?:ה)?(?:שבת|חג)|(?:ב)?מוצאי\s+(?:שבת|חג)|(?:ב)?מוצ"?ש)',
  TimeAnchor.candleLighting: r'(?:(?:(?:shabb?at|shabbos|sabbath)\s+)?(?:candle\s*-?\s*lighting|lighting\s+(?:the\s+)?candles|candles)(?:\s+(?:for\s+|on\s+)?(?:shabb?at|shabbos|sabbath))?|(?:start|beginning)\s+of\s+(?:the\s+)?(?:shabb?at|shabbos|sabbath|yom\s+tov)|(?:shabb?at|shabbos|sabbath)\s+(?:starts|begins|comes\s+in)|(?:o\s+)?acendimento\s+(?:das\s+)?velas(?:\s+d[oa]\s+shabb?at)?|acender\s+(?:as\s+)?velas|velas(?:\s+d[oa]\s+shabb?at)?|(?:entrada|inicio|comeco)\s+d[oa]\s+shabb?at|(?:ל|ה|ב|בה|לה)?הדלקת\s+(?:ה)?נרות|(?:ל|ה|ב|בה|לה)?נרות|(?:ב|ל)?כניסת\s+(?:ה)?(?:שבת|חג))',
  TimeAnchor.sunrise: r'(?:sunrise|sun\s*rise|sunup|dawn|nascer\s+do\s+sol|amanhecer|(?:ה|ב|בה|ל|לה)?זריחה|(?:ה|ב|בה|ל|לה)?נץ(?:\s+החמה)?)',
  TimeAnchor.sunset: r'(?:sunset|sun\s*set|sundown|dusk|por\s+do\s+sol|entardecer|(?:ה|ב|בה|ל|לה)?שקיעה)',
};

// ---- Time of day ----

const _am =
    r'(?:a\s?m|in\s+the\s+morning|this\s+morning|morning|da\s+manha|de\s+manha|pela\s+manha|manha|da\s+madrugada|de\s+madrugada|madrugada|בבוקר|לפנות\s+בוקר|בוקר)';
const _pm =
    r'(?:p\s?m|in\s+the\s+(?:afternoon|evening)|this\s+(?:afternoon|evening)|afternoon|evening|at\s+night|tonight|night|da\s+tarde|de\s+tarde|a\s+tarde|da\s+noite|de\s+noite|a\s+noite|a\s+tardinha|noite|tarde|בערב|בלילה|הערב|הלילה|ערב|אחר\s+הצהריים|אחה"?צ|בצהריים|צהריים)';
const _timePrefix = r'(?:(?:at|as|a|@|by|for|para\s+as|pras?)\s+|(?:ב|ל)(?:שעה\s*)?\s*)?';

// ---- Labels ----

const _labelTrigger =
    r'(?:remind\s+me\s+(?:to|about|of)|reminder\s+(?:to|for|about)|to\s+remind\s+me\s+(?:to|about)|called|named|label(?:l?ed)?|saying|for|to|so\s+i\s+can|me\s+lembr[ae]\s+de|lembr(?:ar|e)\s+de|lembrete\s+(?:de|para|pra)|chamado|com\s+o\s+nome|para|pra|תזכיר\s+לי|להזכיר\s+לי|תזכורת(?:\s+ל)?|בשביל|כדי)';

/// Words that never make a label by themselves.
const _filler = {
  'set',
  'an',
  'a',
  'the',
  'alarm',
  'alarms',
  'please',
  'wake',
  'me',
  'up',
  'at',
  'on',
  'and',
  'every',
  'each',
  'to',
  'for',
  'it',
  'i',
  'want',
  'need',
  'make',
  'create',
  'add',
  'new',
  'remind',
  'reminder',
  'can',
  'you',
  'could',
  'would',
  'get',
  'ring',
  'of',
  'in',
  'from',
  'now',
  'by',
  'acorde',
  'acorda',
  'acordar',
  'despertar',
  'desperta',
  'desperte',
  'alarme',
  'despertador',
  'coloca',
  'coloque',
  'cria',
  'crie',
  'criar',
  'por',
  'favor',
  'um',
  'uma',
  'o',
  'os',
  'as',
  'de',
  'do',
  'da',
  'dos',
  'das',
  'e',
  'em',
  'no',
  'na',
  'para',
  'pra',
  'todo',
  'toda',
  'todos',
  'todas',
  'quero',
  'lembrete',
  'bota',
  'liga',
  'toque',
  'tocar',
  'toca',
  'agora',
  'partir',
  'eu',
  'preciso',
  'תעיר',
  'אותי',
  'להעיר',
  'שעון',
  'מעורר',
  'השעון',
  'תזכורת',
  'תקבע',
  'קבע',
  'תגדיר',
  'הגדר',
  'תשים',
  'שים',
  'לי',
  'בבקשה',
  'את',
  'של',
  'ו',
  'ב',
  'ל',
  'כל',
  'עם',
  'אני',
  'רוצה',
  'צריך',
  'לקום',
  'התראה',
  'צלצול',
  'עכשיו',
  'מעכשיו',
  'יום',
};

class _Pass {
  _Pass(String input) : orig = input {
    final buf = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      buf.write(_norm(input, i));
    }
    s = buf.toString();
    eaten = List.filled(s.length, false);
  }

  final String orig;
  late String s;
  late List<bool> eaten;

  static const _accents = {
    'á': 'a',
    'à': 'a',
    'â': 'a',
    'ã': 'a',
    'ä': 'a',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'í': 'i',
    'ì': 'i',
    'î': 'i',
    'ï': 'i',
    'ó': 'o',
    'ò': 'o',
    'ô': 'o',
    'õ': 'o',
    'ö': 'o',
    'ú': 'u',
    'ù': 'u',
    'û': 'u',
    'ü': 'u',
    'ç': 'c',
    'ñ': 'n',
    '’': "'",
    '‘': "'",
    '״': '"',
    '׳': "'",
    '“': '"',
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

  AlarmRequest run() {
    _relative();
    _anchor();
    _days();
    _noonMidnight();
    _clock();
    _hints();
    _fallbackHour();
    var h = hour;
    if (h != null) {
      if (pm == true && h < 12) h += 12;
      if (pm == false && h == 12) h = 0;
    }
    final repeating = days.isNotEmpty;
    return AlarmRequest(
      hour: after != null || anchor != null ? null : h,
      minute: after != null || anchor != null ? 0 : minute,
      days: after != null ? const {} : days,
      dayOffset: repeating || after != null ? null : dayOffset,
      after: after,
      anchor: after != null ? null : anchor,
      offset: offset,
      label: _label(),
      halfDayUnsure: pm == null && h != null && h >= 1 && h <= 11,
    );
  }

  void _relative() {
    final m =
        _find('(?:in|within|daqui\\s+a|dentro\\s+de|em|בעוד|עוד)\\s+($_dur)') ??
        _find('($_dur)\\s+(?:from\\s+now|a\\s+partir\\s+de\\s+agora|מעכשיו)');
    if (m == null) return;
    final d = _durOf(m.group(1)!);
    if (d == null) return;
    after = d;
    _eat(m.start, m.end);
  }

  void _anchor() {
    for (final MapEntry(key: a, value: pattern) in _anchorPatterns.entries) {
      final m = _find('(?:($_dur)\\s+)?(?:($_dir)\\s+)?$_at($pattern)');
      if (m != null) {
        _setAnchor(a, m.group(1), m.group(2));
        _eat(m.start, m.end);
        return;
      }
    }
    // "Before Shabbat" means candle lighting; "after Shabbat", havdalah.
    final m = _find('(?:($_dur)\\s+)?($_dir)\\s+$_at$_shabbatWord');
    if (m != null) {
      final before = _isBefore(m.group(2)!);
      _setAnchor(before ? TimeAnchor.candleLighting : TimeAnchor.havdalah, m.group(1), m.group(2));
      _eat(m.start, m.end);
    }
  }

  static bool _isBefore(String dir) => RegExp(r'^(?:before|prior|ahead|antes|לפני)').hasMatch(dir);

  void _setAnchor(TimeAnchor a, String? dur, String? dir) {
    anchor = a;
    final d = dur == null ? null : _durOf(dur);
    if (d == null || dir == null) return;
    offset = _isBefore(dir) ? -d : d;
  }

  void _days() {
    for (final (pattern, set) in [
      (r'(?:on\s+|every\s+)?week\s*ends?|(?:nos?\s+)?fins?\s+de\s+semana', {6, 7}),
      (r'(?:ב)?סופ"?ש|(?:ב)?סופי?\s+(?:ה)?שבוע', {5, 6}),
      (
        r'(?:every\s+|on\s+)?(?:week|work|business)\s*days?|(?:nos\s+|em\s+)?dias?\s+ute?is|dia\s+util|durante\s+a\s+semana',
        {1, 2, 3, 4, 5},
      ),
      (r'(?:ב)?ימי\s+(?:ה)?חול', {7, 1, 2, 3, 4, 5}),
      (r'(?:ב)?ימי\s+(?:ה)?עבודה|(?:ב)?אמצע\s+(?:ה)?שבוע', {7, 1, 2, 3, 4}),
      (
        r'every\s*day|everyday|daily|each\s+day|every\s+(?:morning|night|evening)|todos?\s+(?:os\s+)?dias?|todas?\s+as\s+(?:manhas|noites)|toda\s+(?:manha|noite)|diariamente|כל\s+(?:יום|בוקר|ערב|לילה)|(?:ב)?כל\s+יום|יומי',
        {1, 2, 3, 4, 5, 6, 7},
      ),
    ]) {
      final m = _find(pattern);
      if (m == null) continue;
      days.addAll(set);
      if (RegExp(r'morning|manha|בוקר').hasMatch(m.group(0)!)) pm ??= false;
      if (RegExp(r'night|evening|noite|ערב|לילה').hasMatch(m.group(0)!)) pm ??= true;
      _eat(m.start, m.end);
    }
    // Ranges, "Monday to Friday", "de segunda a sexta", "ראשון עד חמישי".
    final rangeHead = '(?:$_latinDay|(?:(?:ב|ו)?(?:יום|ימי)\\s+(?:ה)?|ב|מ)?$_hebrewDay)';
    while (true) {
      final m = _find(
        '(?:from\\s+|de\\s+|da\\s+)?($rangeHead)\\s+(?:to|through|thru|till|until|a|ate|עד|ל)\\s+($rangeHead)',
      );
      if (m == null) break;
      final a = _dayOf(m.group(1)!), b = _dayOf(m.group(2)!);
      if (a == null || b == null) break;
      days.addAll(_range(a, b));
      _eat(m.start, m.end);
    }
    while (true) {
      final m = _find('(?:on\\s+|every\\s+|nas?\\s+|todas?\\s+as?\\s+|todos?\\s+os?\\s+|às\\s+)?($_day)');
      if (m == null) break;
      final d = _dayOf(m.group(1)!);
      if (d == null) break;
      days.add(d);
      _eat(m.start, m.end);
    }
    final rel = <(String, int)>[
      (r'(?:the\s+)?day\s+after\s+tomorrow|depois\s+de\s+amanha|מחרתיים', 2),
      (r'tomorrow|amanha|מחר', 1),
      (r'today|hoje|היום', 0),
      (r'tonight|הערב|הלילה', 0),
    ];
    for (final (pattern, n) in rel) {
      final m = _find(pattern);
      if (m == null) continue;
      dayOffset ??= n;
      if (RegExp(r'tonight|הערב|הלילה').hasMatch(m.group(0)!)) pm ??= true;
      _eat(m.start, m.end);
    }
  }

  void _noonMidnight() {
    final noon = _find('(?:at\\s+|ao\\s+|ב)?(?:noon|midday|meio\\s+dia)');
    if (noon != null) {
      hour = 12;
      pm = null;
      _eat(noon.start, noon.end);
      return;
    }
    final night = _find('(?:at\\s+|a\\s+|ב)?(?:midnight|meia\\s+noite|חצות(?:\\s+הלילה)?)');
    if (night != null) {
      hour = 0;
      pm = null;
      _eat(night.start, night.end);
    }
  }

  void _clock() {
    if (hour != null || after != null || anchor != null) return;
    bool take(RegExpMatch? m, int? h, int mm) {
      if (m == null || h == null || h > 24 || mm < 0 || mm > 59) return false;
      hour = h % 24;
      minute = mm;
      _eat(m.start, m.end);
      return true;
    }

    // 7:30, 7.30, 19h30
    var m = _find('$_timePrefix(\\d{1,2})\\s*[:.h]\\s*(\\d{2})(?:\\s*h)?');
    if (m != null && take(m, int.tryParse(m.group(1)!), int.parse(m.group(2)!))) return;
    // half past seven, quarter to eight
    m = _find('$_timePrefix(?:a\\s+)?(half|quarter)\\s+(past|after|to|before)\\s+($_num)');
    if (m != null) {
      final h = _numOf(m.group(3)!);
      final q = m.group(1) == 'half' ? 30 : 15;
      final to = m.group(2) == 'to' || m.group(2) == 'before';
      if (h != null && take(m, to ? (h + 23) % 24 : h, to ? 60 - q : q)) return;
    }
    // quinze para as sete, רבע ל-7,
    m = _find('($_num|um\\s+quarto)\\s+(?:para|pras?)\\s+(?:as?\\s+)?($_num)');
    m ??= _find('(רבע|$_num\\s+דקות)\\s+ל\\s*($_num)');
    if (m != null) {
      final g = m.group(1)!;
      final q = g.contains('quarto') || g == 'רבע' ? 15 : _numOf(g.replaceAll('דקות', ''));
      final h = _numOf(m.group(2)!);
      if (q != null && h != null && q < 60 && take(m, (h + 23) % 24, 60 - q)) return;
    }
    // sete e meia, שבע וחצי, seven and a half, שבע ורבע
    m = _find(
      '$_timePrefix($_num)\\s*(?:e\\s+meia|and\\s+a\\s+half|וחצי|e\\s+um\\s+quarto|ורבע)(?:\\s+$_pm|\\s+$_am)?',
    );
    if (m != null) {
      final whole = m.group(0)!;
      final q = RegExp(r'quarto|ורבע').hasMatch(whole) ? 15 : 30;
      if (take(m, _numOf(m.group(1)!), q)) {
        _hint(whole);
        return;
      }
    }
    // sete e quinze, שבע ו-20, seven thirty
    m = _find('$_timePrefix($_num)\\s*(?:e\\s+|ו\\s*|\\s)($_num)(?:\\s+(?:minutos|דקות))?');
    if (m != null) {
      final h = _numOf(m.group(1)!), mm = _numOf(m.group(2)!);
      if (h != null && mm != null && h <= 23 && mm >= 10 && take(m, h, mm)) return;
    }
    // at 7, às 7, בשבע, 7 o'clock, 7 horas, 7am
    m = _find(
      '(?:(?:at|as|@|by)\\s+|(?:ב|ל)(?:שעה\\s*)?\\s*)($_num)(?:\\s*(?:o\\s*\'?\\s*clock|horas?|h|em\\s+ponto))?',
    );
    if (m != null && take(m, _numOf(m.group(1)!), 0)) return;
    m = _find('($_num)\\s*(?:o\\s*\'?\\s*clock|horas|h|em\\s+ponto)');
    if (m != null && take(m, _numOf(m.group(1)!), 0)) return;
    m = RegExp('$_b0($_num)\\s*(?=(?:$_am|$_pm)$_b1)').firstMatch(s);
    if (m != null) take(m, _numOf(m.group(1)!), 0);
  }

  void _hint(String text) {
    if (RegExp('$_b0$_pm$_b1').hasMatch(text)) pm = true;
    if (RegExp('$_b0$_am$_b1').hasMatch(text)) pm = false;
  }

  void _hints() {
    final am = _find(_am);
    if (am != null) {
      if (hour != null) pm = false;
      _eat(am.start, am.end);
    }
    final p = _find(_pm);
    if (p != null) {
      if (hour != null) pm = true;
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
    _eat(m.start, m.end);
  }

  /// What's left after the times and days, in the person's own spelling,
  /// following "remind me to", "for", "para", "תזכיר לי"...
  String _label() {
    for (final m in RegExp('$_b0$_labelTrigger$_b1').allMatches(s)) {
      final buf = StringBuffer();
      for (var i = m.end; i < orig.length; i++) {
        buf.write(eaten[i] ? ' ' : orig[i]);
      }
      final words = buf.toString().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
      bool fill(String w) => _filler.contains(_clean(w));
      while (words.isNotEmpty && fill(words.first)) {
        words.removeAt(0);
      }
      while (words.isNotEmpty && fill(words.last)) {
        words.removeLast();
      }
      if (words.isEmpty) continue;
      var label = words.join(' ').replaceAll(RegExp(r'''^[\s,.;:!?'"-]+|[\s,.;:!?'"-]+$'''), '');
      if (label.isEmpty) continue;
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
}
