/// Rewrites a sentence in one of Quando?'s other languages into the plain
/// English the [AlarmParser] reads: "завтра в 7 утра" → "tomorrow at 7
/// morning", "明日7時に起こして" → "tomorrow 7:00 wake me". Only the
/// words that carry a time, a day or a Shabbat/sun moment are rewritten;
/// everything else (a label, say) is left as it is.
///
/// English, Portuguese, Spanish, French, German, Italian and Hebrew are
/// read by the parser directly and need no phrasebook.
bool hasPhrasebook(String? lang) => _books.containsKey(lang?.split(RegExp('[-_]')).first);

///
/// Without a phrasebook for [lang] the input comes back as it was (with
/// [keepCase]) or lower-cased, digits from other scripts made 0-9.
String rewriteForParser(String input, String? lang, {bool keepCase = false}) {
  final book = _books[lang == null ? '' : lang.split(RegExp('[-_]')).first];
  if (book == null) return _digits(keepCase ? input : input.toLowerCase());
  var s = _digits(input.toLowerCase());
  if (lang!.startsWith('zh') || lang.startsWith('ja')) s = _hanNumbers(s);
  if (lang.startsWith('ko')) s = _koreanHours(s);
  for (final (pattern, out) in book) {
    s = s.replaceAllMapped(pattern, (m) => ' ${_fill(out, m)} ');
  }
  // Glue-free scripts: keep digits and English apart from the rest.
  s = s
      .replaceAllMapped(RegExp(r'(\p{L})(\d)', unicode: true), (m) => _apart(m[1]!, m[2]!))
      .replaceAllMapped(RegExp(r'(\d)(\p{L})', unicode: true), (m) => _apart(m[1]!, m[2]!));
  return s.replaceAll(RegExp(r'\s+'), ' ').trim();
}

String _apart(String a, String b) {
  // "7h", "6h30", "19h" are times the parser reads as they are.
  if ((a == 'h' && RegExp(r'\d').hasMatch(b)) || (b == 'h' && RegExp(r'\d').hasMatch(a))) return '$a$b';
  return '$a $b';
}

String _fill(String template, Match m) =>
    template.replaceAllMapped(RegExp(r'\$(\d)'), (g) => m.group(int.parse(g[1]!)) ?? '');

/// Arabic, Persian, Devanagari and full-width digits → 0-9.
String _digits(String s) {
  final b = StringBuffer();
  for (final r in s.runes) {
    int? d;
    if (r >= 0x0660 && r <= 0x0669) d = r - 0x0660;
    if (r >= 0x06F0 && r <= 0x06F9) d = r - 0x06F0;
    if (r >= 0x0966 && r <= 0x096F) d = r - 0x0966;
    if (r >= 0xFF10 && r <= 0xFF19) d = r - 0xFF10;
    b.write(d == null ? String.fromCharCode(r) : '$d');
  }
  return b.toString();
}

/// 七 → 7, 十二 → 12, 三十 → 30, 二十五 → 25 (Chinese and Japanese).
String _hanNumbers(String s) {
  const digit = {
    '〇': 0,
    '零': 0,
    '一': 1,
    '二': 2,
    '两': 2,
    '兩': 2,
    '三': 3,
    '四': 4,
    '五': 5,
    '六': 6,
    '七': 7,
    '八': 8,
    '九': 9,
  };
  // Not right after 星期 / 周 / 礼拜: those are weekdays.
  return s.replaceAllMapped(RegExp('(?<![期周週拜])[〇零一二两兩三四五六七八九十]+'), (m) {
    final t = m[0]!;
    if (t.contains('十')) {
      final parts = t.split('十');
      final tens = parts[0].isEmpty ? 1 : digit[parts[0]] ?? 1;
      final ones = parts.length > 1 && parts[1].isNotEmpty ? digit[parts[1]] ?? 0 : 0;
      return '${tens * 10 + ones}';
    }
    return t.split('').map((c) => digit[c] ?? '').join();
  });
}

/// 일곱 시 → 7시 (Korean says hours in native numbers).
String _koreanHours(String s) {
  const n = {
    '열한': 11, '열두': 12, '한': 1, '두': 2, '세': 3, '네': 4, '다섯': 5, '여섯': 6, //
    '일곱': 7, '여덟': 8, '아홉': 9, '열': 10,
  };
  return s.replaceAllMapped(RegExp(r'(열한|열두|다섯|여섯|일곱|여덟|아홉|한|두|세|네|열)\s*시(?!간)'), (m) => '${n[m[1]]}시');
}

// A word on its own: no letter or mark right before or after.
const _b = r'(?<![\p{L}\p{M}])';
const _e = r'(?![\p{L}\p{M}])';

RegExp _w(String p) => RegExp('$_b(?:$p)$_e', unicode: true, caseSensitive: false);
RegExp _r(String p) => RegExp(p, unicode: true, caseSensitive: false);

typedef _Book = List<(RegExp, String)>;

final Map<String, _Book> _books = {
  'nl': _dutch,
  'pl': _polish,
  'ru': _russian,
  'uk': _ukrainian,
  'tr': _turkish,
  'id': _indonesian,
  'vi': _vietnamese,
  'hi': _hindi,
  'ar': _arabic,
  'ja': _japanese,
  'zh': _chinese,
  'ko': _korean,
};

/// Number words → digits, for the hours and minutes people say.
_Book _numbers(Map<String, int> words) {
  final keys = words.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
  return [for (final k in keys) (_w(k), '${words[k]}')];
}

final _Book _dutch = [
  ..._numbers({
    'een': 1, 'twee': 2, 'drie': 3, 'vier': 4, 'vijf': 5, 'zes': 6, 'zeven': 7, 'acht': 8, 'negen': 9, //
    'tien': 10, 'elf': 11, 'twaalf': 12, 'vijftien': 15, 'twintig': 20, 'dertig': 30, 'veertig': 40,
  }),
  (_w(r'half\s+(\d+)'), 'halb \$1'),
  (_w(r'kwart\s+over\s+(\d+)'), 'quarter past \$1'),
  (_w(r'kwart\s+voor\s+(\d+)'), 'quarter to \$1'),
  (_w(r'(\d+)\s+uur'), 'at \$1'),
  (_w(r'(?:een\s+)?half\s+uur|een\s+halfuur|halfuur'), 'half an hour'),
  (_w(r'(?:een\s+)?kwartier'), 'a quarter hour'),
  (_w('overmorgen'), 'day after tomorrow'),
  (_w('morgenochtend'), 'tomorrow morning'),
  (_w('morgenavond'), 'tomorrow evening'),
  (_w('morgen'), 'tomorrow'),
  (_w('vandaag'), 'today'),
  (_w('vanavond|vannacht'), 'tonight'),
  (_w(r"'s\s*ochtends|'s\s*morgens|in\s+de\s+ochtend|ochtend"), 'morning'),
  (_w(r"'s\s*avonds|'s\s*middags|in\s+de\s+avond|avond|middag"), 'evening'),
  (_w(r"'s\s*nachts|nacht"), 'night'),
  (_w('middernacht'), 'midnight'),
  (_w(r'minuten|minuut'), 'minutes'),
  (_w(r'uren|uur'), 'hours'),
  (_w(r'elke\s+dag|iedere\s+dag|dagelijks'), 'every day'),
  (_w(r'(?:op\s+)?werkdagen|doordeweeks'), 'weekdays'),
  (_w(r'(?:in\s+het\s+)?weekend'), 'weekends'),
  (_w(r'maandag(?:en|s)?'), 'monday'),
  (_w(r'dinsdag(?:en|s)?'), 'tuesday'),
  (_w(r'woensdag(?:en|s)?'), 'wednesday'),
  (_w(r'donderdag(?:en|s)?'), 'thursday'),
  (_w(r'vrijdag(?:en|s)?'), 'friday'),
  (_w(r'zaterdag(?:en|s)?'), 'saturday'),
  (_w(r'zondag(?:en|s)?'), 'sunday'),
  (_w('zonsopgang'), 'sunrise'),
  (_w('zonsondergang'), 'sunset'),
  (_w(r'(?:het\s+)?(?:kaarsen\s+aansteken|aansteken\s+van\s+de\s+kaarsen)|kaarsen'), 'candle lighting'),
  (_w(r'sjabbat'), 'shabbat'),
  (_w(r'wek\s+me|maak\s+me\s+wakker'), 'wake me'),
  (_w(r'herinner\s+me\s+(?:eraan\s+)?(?:om|aan)?'), 'remind me to'),
  (_w('wekker'), 'alarm'),
  (_w('wanneer'), 'when'),
  (_w(r'hoe\s+laat'), 'what time'),
  (_w('over|binnen'), 'in'),
  (_w('om'), 'at'),
  (_w('van'), 'from'),
  (_w('tot'), 'to'),
  (_w('voor'), 'before'),
  (_w('na'), 'after'),
  (_w('elke|iedere'), 'every'),
];

final _Book _polish = [
  ..._numbers({
    'pierwszej': 1, 'drugiej': 2, 'trzeciej': 3, 'czwartej': 4, 'piątej': 5, 'szóstej': 6, 'siódmej': 7, //
    'ósmej': 8, 'dziewiątej': 9, 'dziesiątej': 10, 'jedenastej': 11, 'dwunastej': 12,
    'jeden': 1, 'dwa': 2, 'trzy': 3, 'cztery': 4, 'pięć': 5, 'sześć': 6, 'siedem': 7, 'osiem': 8,
    'dziewięć': 9, 'dziesięć': 10, 'piętnaście': 15, 'dwadzieścia': 20, 'trzydzieści': 30, 'czterdzieści': 40,
  }),
  (_w(r'pół\s+godziny'), 'half an hour'),
  (_w('kwadrans'), 'a quarter hour'),
  (_w('pojutrze'), 'day after tomorrow'),
  (_w('jutro'), 'tomorrow'),
  (_w(r'(?:dziś|dzisiaj)\s+wieczorem'), 'tonight'),
  (_w(r'dziś|dzisiaj'), 'today'),
  (_w(r'rano|rankiem|z\s+rana'), 'morning'),
  (_w(r'po\s+południu|wieczorem|wieczór|wieczora'), 'evening'),
  (_w(r'w\s+nocy'), 'night'),
  (_w('północ|północy'), 'midnight'),
  (_w('południe|południa'), 'noon'),
  (_w(r'minut[yęa]?'), 'minutes'),
  (_w(r'godzin[yęa]?|godzinę'), 'hours'),
  (_w(r'codziennie|każdego\s+dnia|co\s+dzień'), 'every day'),
  (_w(r'(?:w\s+)?dni\s+robocze|w\s+tygodniu'), 'weekdays'),
  (_w(r'(?:w\s+)?weekendy?'), 'weekends'),
  (_w(r'(?:w\s+)?poniedział\p{L}*'), 'monday'),
  (_w(r'(?:we?\s+)?wtor\p{L}*'), 'tuesday'),
  (_w(r'(?:w\s+)?środ\p{L}*'), 'wednesday'),
  (_w(r'(?:w\s+)?czwart\p{L}*'), 'thursday'),
  (_w(r'(?:w\s+)?piąt(?:ek|ki|ku|kami)'), 'friday'),
  (_w(r'(?:w\s+)?sobot\p{L}*'), 'saturday'),
  (_w(r'(?:w\s+)?niedziel\p{L}*'), 'sunday'),
  (_w(r'wsch\p{L}*\s+słońca'), 'sunrise'),
  (_w(r'zach\p{L}*\s+słońca'), 'sunset'),
  (_w(r'zapal\p{L}*\s+świec|świec\p{L}*'), 'candle lighting'),
  (_w(r'hawdal\p{L}*'), 'havdalah'),
  (_w(r'szabat\p{L}*'), 'shabbat'),
  (_w(r'obudź\s+mnie'), 'wake me'),
  (_w(r'przypomnij\s+mi(?:\s+(?:żeby|aby|o))?'), 'remind me to'),
  (_w('budzik'), 'alarm'),
  (_w('kiedy'), 'when'),
  (_w(r'o\s+której(?:\s+godzinie)?'), 'what time'),
  (_w('za'), 'in'),
  (_w('o'), 'at'),
  (_w('od'), 'from'),
  (_w('do'), 'to'),
  (_w('przed'), 'before'),
  (_w('po'), 'after'),
];

final _Book _russian = [
  ..._numbers({
    'один': 1, 'одна': 1, 'два': 2, 'две': 2, 'три': 3, 'четыре': 4, 'пять': 5, 'шесть': 6, 'семь': 7, //
    'восемь': 8, 'девять': 9, 'десять': 10, 'одиннадцать': 11, 'двенадцать': 12, 'пятнадцать': 15,
    'двадцать': 20, 'тридцать': 30, 'сорок': 40, 'пятьдесят': 50,
  }),
  (_r(r'за\s+([^\s]+(?:\s+[^\s]+)?)\s+до'), '\$1 before'),
  (_w('полчаса'), 'half an hour'),
  (_w(r'четверть\s+часа'), 'a quarter hour'),
  (_w('послезавтра'), 'day after tomorrow'),
  (_w('завтра'), 'tomorrow'),
  (_w(r'сегодня\s+(?:вечером|ночью)'), 'tonight'),
  (_w('сегодня'), 'today'),
  (_w(r'утра|утром'), 'morning'),
  (_w(r'вечера|вечером|дня|днём|днем'), 'evening'),
  (_w(r'ночи|ночью'), 'night'),
  (_w('полдень'), 'noon'),
  (_w('полночь'), 'midnight'),
  (_w(r'минут[уы]?'), 'minutes'),
  (_w(r'час(?:а|ов)?'), 'hours'),
  (_w(r'каждый\s+день|ежедневно'), 'every day'),
  (_w(r'(?:по\s+)?будн\p{L}*'), 'weekdays'),
  (_w(r'(?:по\s+|на\s+)?выходн\p{L}*'), 'weekends'),
  (_w(r'(?:в\s+)?понедельник\p{L}*'), 'monday'),
  (_w(r'(?:во\s+)?вторник\p{L}*'), 'tuesday'),
  (_w(r'(?:в\s+)?сред[аыуе]\p{L}*'), 'wednesday'),
  (_w(r'(?:в\s+)?четверг\p{L}*'), 'thursday'),
  (_w(r'(?:в\s+)?пятниц\p{L}*'), 'friday'),
  (_w(r'(?:в\s+)?суббот\p{L}*'), 'saturday'),
  (_w(r'(?:в\s+)?воскресень\p{L}*'), 'sunday'),
  (_w(r'восход\p{L}*(?:\s+солнца)?'), 'sunrise'),
  (_w(r'закат\p{L}*(?:\s+солнца)?'), 'sunset'),
  (_w(r'зажигани\p{L}*\s+свеч\p{L}*|свеч\p{L}*'), 'candle lighting'),
  (_w(r'[аг]?авдал\p{L}*|гавдал\p{L}*'), 'havdalah'),
  (_w(r'шаб+ат\p{L}*'), 'shabbat'),
  (_w(r'разбуди\s+меня'), 'wake me'),
  (_w(r'напомни(?:\s+мне)?(?:\s+(?:о|об|про))?'), 'remind me to'),
  (_w('будильник'), 'alarm'),
  (_w('когда'), 'when'),
  (_w(r'во\s+сколько|в\s+котором\s+часу'), 'what time'),
  (_w('через'), 'in'),
  (_w('в|во'), 'at'),
  (_w('с|со'), 'from'),
  (_w('по'), 'to'),
  (_w('до'), 'before'),
  (_w('после'), 'after'),
];

final _Book _ukrainian = [
  ..._numbers({
    'один': 1, 'одна': 1, 'два': 2, 'дві': 2, 'три': 3, 'чотири': 4, "п'ять": 5, 'пʼять': 5, 'шість': 6, //
    'сім': 7, 'вісім': 8, "дев'ять": 9, 'девʼять': 9, 'десять': 10, 'одинадцять': 11, 'дванадцять': 12,
    "п'ятнадцять": 15, 'двадцять': 20, 'тридцять': 30, 'сорок': 40,
  }),
  (_r(r'за\s+([^\s]+(?:\s+[^\s]+)?)\s+до'), '\$1 before'),
  (_w('півгодини'), 'half an hour'),
  (_w(r'чверть\s+години'), 'a quarter hour'),
  (_w('післязавтра'), 'day after tomorrow'),
  (_w('завтра'), 'tomorrow'),
  (_w(r'сьогодні\s+(?:ввечері|вночі)'), 'tonight'),
  (_w('сьогодні'), 'today'),
  (_w(r'ранку|вранці|зранку'), 'morning'),
  (_w(r'вечора|ввечері|дня|вдень'), 'evening'),
  (_w(r'ночі|вночі'), 'night'),
  (_w('полудень|опівдні'), 'noon'),
  (_w('північ|опівночі'), 'midnight'),
  (_w(r'хвилин[уи]?'), 'minutes'),
  (_w(r'годин[уи]?'), 'hours'),
  (_w(r'щодня|кожного\s+дня|кожен\s+день'), 'every day'),
  (_w(r'(?:у\s+|в\s+)?будн\p{L}*'), 'weekdays'),
  (_w(r'(?:на\s+)?вихідн\p{L}*'), 'weekends'),
  (_w(r'(?:у\s+|в\s+)?понеділ\p{L}*'), 'monday'),
  (_w(r'(?:у\s+|в\s+)?вівтор\p{L}*'), 'tuesday'),
  (_w(r'(?:у\s+|в\s+)?серед\p{L}*'), 'wednesday'),
  (_w(r'(?:у\s+|в\s+)?четвер\p{L}*'), 'thursday'),
  (_w(r"(?:у\s+|в\s+)?п['ʼ’]?ятниц\p{L}*"), 'friday'),
  (_w(r'(?:у\s+|в\s+)?субот\p{L}*'), 'saturday'),
  (_w(r'(?:у\s+|в\s+)?неділ\p{L}*'), 'sunday'),
  (_w(r'сх[іо]д\p{L}*\s+сонця'), 'sunrise'),
  (_w(r'зах[іо]д\p{L}*\s+сонця'), 'sunset'),
  (_w(r'запалюванн\p{L}*\s+свіч\p{L}*|свіч\p{L}*'), 'candle lighting'),
  (_w(r'[аг]?авдал\p{L}*|гавдал\p{L}*'), 'havdalah'),
  (_w(r'шаб+ат\p{L}*'), 'shabbat'),
  (_w(r'розбуди\s+мене'), 'wake me'),
  (_w(r'нагадай(?:\s+мені)?(?:\s+(?:про))?'), 'remind me to'),
  (_w('будильник'), 'alarm'),
  (_w('коли'), 'when'),
  (_w(r'о\s+котрій(?:\s+годині)?'), 'what time'),
  (_w('через'), 'in'),
  (_w('о|об'), 'at'),
  (_w('з|із'), 'from'),
  (_w('до'), 'before'),
  (_w('після'), 'after'),
];

const _trDays = {
  'pazartesi': 'monday',
  'salı': 'tuesday',
  'çarşamba': 'wednesday',
  'perşembe': 'thursday',
  'cumartesi': 'saturday',
  'cuma': 'friday',
  'pazar': 'sunday',
};

final _Book _turkish = [
  ..._numbers({
    'iki': 2, 'üç': 3, 'dört': 4, 'beş': 5, 'altı': 6, 'yedi': 7, 'sekiz': 8, 'dokuz': 9, //
    'on': 10, 'on bir': 11, 'on iki': 12, 'on beş': 15, 'yirmi': 20, 'otuz': 30, 'kırk': 40,
  }),
  (_r(r"(\d+(?::\d+)?)'?\s*(?:de|da|te|ta)(?![\p{L}])"), '\$1'),
  (_w(r'(\d+)\s+buçuk'), '\$1:30'),
  (_w(r'(\d+)\s*dakika\s+(?:sonra|içinde)'), 'in \$1 minutes'),
  (_w(r'(\d+)\s*saat\s+(?:sonra|içinde)'), 'in \$1 hours'),
  (_w(r'yarım\s+saat\s+(?:sonra|içinde)'), 'in half an hour'),
  (_w(r'yarım\s+saat'), 'half an hour'),
  (_w(r'çeyrek\s+saat'), 'a quarter hour'),
  // "pazartesiden cumaya": Monday to Friday
  for (final MapEntry(:key, :value) in _trDays.entries) ...[
    (_w("$key(?:'?(?:den|dan|ten|tan))"), '$value to'),
    (_w("$key(?:'?(?:ya|ye|a|e|ları|leri|günleri|günü|ı|i))?"), value),
  ],
  (_w(r'öbür\s+gün|yarından\s+sonra'), 'day after tomorrow'),
  (_w(r'yarın(?:ki)?'), 'tomorrow'),
  (_w(r'bu\s+akşam|bu\s+gece'), 'tonight'),
  (_w('bugün'), 'today'),
  (_w(r'gece\s+yarısı'), 'midnight'),
  (_w(r'öğlen|öğle'), 'noon'),
  (_w('sabah|sabahları'), 'morning'),
  (_w(r'öğleden\s+sonra|akşam|akşamları'), 'evening'),
  (_w('gece|geceleri'), 'night'),
  (_w('dakika'), 'minutes'),
  (_w(r'her\s+gün|hergün'), 'every day'),
  (_w(r'hafta\s+içi'), 'weekdays'),
  (_w(r'hafta\s+sonu|hafta\s+sonları'), 'weekends'),
  (_w(r'gün\s+doğumu\p{L}*|güneş\s+doğuşu\p{L}*'), 'sunrise'),
  (_w(r'gün\s+batımı\p{L}*|güneş\s+batışı\p{L}*'), 'sunset'),
  (_w(r'mum\s+yakma\p{L}*|mumlar\p{L}*'), 'candle lighting'),
  (_w(r'havdala\p{L}*'), 'havdalah'),
  (_w(r'şabat\p{L}*'), 'shabbat'),
  (_w(r'beni\s+uyandır|uyandır\s+beni|uyandır'), 'wake me'),
  (_w(r'(?:bana\s+)?hatırlat'), 'remind me to'),
  (_w(r'ne\s+zaman'), 'when'),
  (_w(r'saat\s+kaçta'), 'what time'),
  (_w('saat'), 'at'),
  (_w('önce'), 'before'),
  (_w('sonra'), 'after'),
];

final _Book _indonesian = [
  ..._numbers({
    'satu': 1, 'dua': 2, 'tiga': 3, 'empat': 4, 'lima': 5, 'enam': 6, 'tujuh': 7, 'delapan': 8, //
    'sembilan': 9, 'sepuluh': 10, 'sebelas': 11, 'dua belas': 12, 'lima belas': 15, 'dua puluh': 20,
    'tiga puluh': 30, 'empat puluh': 40,
  }),
  (_w(r'setengah\s+jam'), 'half an hour'),
  (_w(r'seperempat\s+jam'), 'a quarter hour'),
  (_w(r'setengah\s+(\d+)'), 'halb \$1'),
  (_w(r'dalam\s+(\d+)\s+jam'), 'in \$1 hours'),
  (_w(r'(\d+)\s+jam\s+lagi'), 'in \$1 hours'),
  (_w(r'(\d+)\s+menit\s+lagi'), 'in \$1 minutes'),
  (_w('lusa'), 'day after tomorrow'),
  (_w('besok'), 'tomorrow'),
  (_w(r'hari\s+ini'), 'today'),
  (_w(r'nanti\s+malam|malam\s+ini'), 'tonight'),
  (_w(r'tengah\s+malam'), 'midnight'),
  (_w(r'tengah\s+hari'), 'noon'),
  (_w('pagi'), 'morning'),
  (_w(r'sore|petang|siang'), 'evening'),
  (_w('malam'), 'night'),
  (_w('menit'), 'minutes'),
  (_w(r'(?:setiap|tiap)\s+hari'), 'every day'),
  (_w(r'hari\s+kerja'), 'weekdays'),
  (_w(r'akhir\s+(?:pekan|minggu)'), 'weekends'),
  (_w(r'(?:hari\s+)?senin'), 'monday'),
  (_w(r'(?:hari\s+)?selasa'), 'tuesday'),
  (_w(r'(?:hari\s+)?rabu'), 'wednesday'),
  (_w(r'(?:hari\s+)?kamis'), 'thursday'),
  (_w(r"(?:hari\s+)?jum'?at"), 'friday'),
  (_w(r'(?:hari\s+)?sabtu'), 'saturday'),
  (_w(r'(?:hari\s+)?minggu|(?:hari\s+)?ahad'), 'sunday'),
  (_w(r'matahari\s+terbit'), 'sunrise'),
  (_w(r'matahari\s+terbenam'), 'sunset'),
  (_w(r'(?:menyalakan|penyalaan|nyala)\s+lilin|lilin'), 'candle lighting'),
  (_w(r'havdala\p{L}*'), 'havdalah'),
  (_w(r'sabat'), 'shabbat'),
  (_w(r'bangunkan\s+(?:saya|aku)'), 'wake me'),
  (_w(r'ingatkan(?:\s+(?:saya|aku))?(?:\s+untuk)?'), 'remind me to'),
  (_w('kapan'), 'when'),
  (_w(r'(?:jam|pukul)\s+berapa'), 'what time'),
  (_w(r'jam|pukul'), 'at'),
  (_w('dalam'), 'in'),
  (_w('dari'), 'from'),
  (_w('sampai|hingga'), 'to'),
  (_w('sebelum'), 'before'),
  (_w(r'sesudah|setelah'), 'after'),
];

final _Book _vietnamese = [
  ..._numbers({
    'một': 1, 'hai': 2, 'ba': 3, 'bốn': 4, 'năm': 5, 'sáu': 6, 'bảy': 7, 'tám': 8, 'chín': 9, //
    'mười': 10, 'mười một': 11, 'mười hai': 12, 'mười lăm': 15, 'hai mươi': 20, 'ba mươi': 30,
  }),
  // Weekdays first: "thứ hai" is Monday, not "two".
  (_w(r'thứ\s+2|thứ\s+hai'), 'monday'),
  (_w(r'thứ\s+3|thứ\s+ba'), 'tuesday'),
  (_w(r'thứ\s+4|thứ\s+tư'), 'wednesday'),
  (_w(r'thứ\s+5|thứ\s+năm'), 'thursday'),
  (_w(r'thứ\s+6|thứ\s+sáu'), 'friday'),
  (_w(r'thứ\s+7|thứ\s+bảy'), 'saturday'),
  (_w(r'chủ\s+nhật'), 'sunday'),
  (_w(r'nửa\s+tiếng\s+nữa'), 'in half an hour'),
  (_w(r'(\d+)\s+phút\s+nữa|sau\s+(\d+)\s+phút'), 'in \$1\$2 minutes'),
  (_w(r'(\d+)\s+(?:giờ|tiếng)\s+nữa'), 'in \$1 hours'),
  (_w(r'(\d+)\s*giờ\s*rưỡi'), '\$1:30'),
  (_w(r'(\d+)\s*giờ\s*(\d+)(?:\s*phút)?'), '\$1:\$2'),
  (_w(r'(\d+)\s*giờ'), '\$1:00'),
  (_w(r'nửa\s+tiếng'), 'half an hour'),
  (_w(r'ngày\s+kia|ngày\s+mốt'), 'day after tomorrow'),
  (_w(r'ngày\s+mai'), 'tomorrow'),
  (_w(r'hôm\s+nay'), 'today'),
  (_w(r'tối\s+nay|đêm\s+nay'), 'tonight'),
  (_w(r'nửa\s+đêm'), 'midnight'),
  (_w(r'buổi\s+sáng|sáng'), 'morning'),
  (_w(r'buổi\s+chiều|chiều|buổi\s+tối|tối'), 'evening'),
  (_w('đêm'), 'night'),
  (_w('trưa'), 'noon'),
  (_w('phút'), 'minutes'),
  (_w(r'mỗi\s+ngày|hàng\s+ngày|hằng\s+ngày'), 'every day'),
  (_w(r'ngày\s+thường|các\s+ngày\s+trong\s+tuần'), 'weekdays'),
  (_w(r'cuối\s+tuần'), 'weekends'),
  (_w(r'mặt\s+trời\s+mọc|bình\s+minh'), 'sunrise'),
  (_w(r'mặt\s+trời\s+lặn|hoàng\s+hôn'), 'sunset'),
  (_w(r'thắp\s+nến|nến'), 'candle lighting'),
  (_w(r'havdalah|havdala'), 'havdalah'),
  (_w(r'(?:ngày\s+)?sabát|sa\s*bát|shabbat'), 'shabbat'),
  (_w(r'đánh\s+thức\s+tôi|gọi\s+tôi\s+dậy'), 'wake me'),
  (_w(r'nhắc\s+tôi'), 'remind me to'),
  (_w(r'báo\s+thức'), 'alarm'),
  (_w(r'khi\s+nào|lúc\s+nào'), 'when'),
  (_w(r'mấy\s+giờ'), 'what time'),
  (_w(r'lúc|vào\s+lúc'), 'at'),
  (_w('từ'), 'from'),
  (_w('đến|tới'), 'to'),
  (_w('trước'), 'before'),
  (_w('sau'), 'after'),
];

final _Book _hindi = [
  (_w(r'साढ़े\s*(\d+)'), '\$1:30'),
  (_w(r'सवा\s*(\d+)'), '\$1:15'),
  (_w(r'पौने\s*(\d+)'), 'quarter to \$1'),
  (_w(r'आधे\s+घंटे\s+(?:में|बाद)'), 'in half an hour'),
  (_w(r'(\d+)\s*मिनट\s+(?:में|बाद)'), 'in \$1 minutes'),
  (_w(r'(\d+)\s*घंटे?\s+(?:में|बाद)'), 'in \$1 hours'),
  (_w(r'(\d+(?::\d+)?)\s*बजे'), 'at \$1'),
  (_w(r'आधा\s+घंटा|आधे\s+घंटे'), 'half an hour'),
  (_w('परसों'), 'day after tomorrow'),
  (_w('कल'), 'tomorrow'),
  (_w(r'आज\s+रात'), 'tonight'),
  (_w('आज'), 'today'),
  (_w(r'आधी\s+रात'), 'midnight'),
  (_w('सुबह'), 'morning'),
  (_w(r'शाम|दोपहर'), 'evening'),
  (_w('रात'), 'night'),
  (_w('मिनट'), 'minutes'),
  (_w(r'घंटे|घंटा'), 'hours'),
  (_w(r'हर\s+दिन|रोज़|रोज|रोजाना|रोज़ाना|प्रतिदिन'), 'every day'),
  (_w(r'कार्यदिवस\p{L}*|हफ्ते\s+के\s+दिन\p{L}*'), 'weekdays'),
  (_w(r'सप्ताहांत|वीकेंड'), 'weekends'),
  (_w(r'सोमवार(?:\s+को)?'), 'monday'),
  (_w(r'मंगलवार(?:\s+को)?'), 'tuesday'),
  (_w(r'बुधवार(?:\s+को)?'), 'wednesday'),
  (_w(r'(?:गुरुवार|बृहस्पतिवार)(?:\s+को)?'), 'thursday'),
  (_w(r'शुक्रवार(?:\s+को)?'), 'friday'),
  (_w(r'शनिवार(?:\s+को)?'), 'saturday'),
  (_w(r'रविवार(?:\s+को)?'), 'sunday'),
  (_w('सूर्योदय'), 'sunrise'),
  (_w('सूर्यास्त'), 'sunset'),
  (_w(r'मोमबत्ती\p{L}*\s+जला\p{L}*|मोमबत्ति\p{L}*|मोमबत्ती'), 'candle lighting'),
  (_w(r'हवदाला|हावदाला'), 'havdalah'),
  (_w(r'शब्बत|शबात|सब्त'), 'shabbat'),
  (_w(r'मुझे\s+जगा\p{L}*|जगा\s+देना'), 'wake me'),
  (_w(r'(?:मुझे\s+)?याद\s+दिला\p{L}*'), 'remind me to'),
  (_w('अलार्म'), 'alarm'),
  (_w('कब'), 'when'),
  (_w(r'कितने\s+बजे'), 'what time'),
  (_w('से'), 'to'),
  (_w('तक'), ''),
  (_w('पहले'), 'before'),
  (_w('बाद'), 'after'),
];

final _Book _arabic = [
  ..._numbers({
    'الحادية عشرة': 11, 'الثانية عشرة': 12, 'الواحدة': 1, 'الثانية': 2, 'الثالثة': 3, 'الرابعة': 4, //
    'الخامسة': 5, 'السادسة': 6, 'السابعة': 7, 'الثامنة': 8, 'التاسعة': 9, 'العاشرة': 10,
    'خمس عشرة': 15, 'عشرين': 20, 'عشرون': 20, 'ثلاثين': 30, 'ثلاثون': 30,
  }),
  (_r(r'(\d+)\s*و\s*ال?نصف|(\d+)\s*ونص'), '\$1\$2:30'),
  (_r(r'(\d+)\s*و\s*الربع'), '\$1:15'),
  (_r(r'(\d+)\s*إلا\s*ربع[اًا]*'), 'quarter to \$1'),
  (_w(r'بعد\s+(?=\d)'), 'in'),
  (_w(r'(?:بعد\s+)?نصف\s+ساعة'), 'half an hour'),
  (_w(r'ربع\s+ساعة'), 'a quarter hour'),
  (_w('ساعتين'), '2 hours'),
  (_w(r'بعد\s+(?:ال)?غد'), 'day after tomorrow'),
  (_w(r'غدا|غداً|غدًا|بكرة|بكره'), 'tomorrow'),
  (_w(r'الليلة|هذا\s+المساء'), 'tonight'),
  (_w('اليوم'), 'today'),
  (_w(r'منتصف\s+الليل'), 'midnight'),
  (_w(r'بعد\s+الظهر|مساء|مساءً|مساءا|المساء|عصرا'), 'evening'),
  (_w(r'الظهر|الظهيرة|ظهرا|ظهراً'), 'noon'),
  (_w(r'صباحا|صباحاً|الصباح|في\s+الصباح|فجرا'), 'morning'),
  (_w(r'ليلا|ليلاً|بالليل'), 'night'),
  (_w(r'دقيقة|دقائق'), 'minutes'),
  (_w(r'ساعات|ساعة'), 'hours'),
  (_w(r'كل\s+يوم|يوميا|يومياً'), 'every day'),
  (_w(r'أيام\s+العمل|ايام\s+العمل|أيام\s+الأسبوع'), 'weekdays'),
  (_w(r'(?:عطلة\s+)?نهاية\s+الأسبوع|الويكند'), 'weekends'),
  (_w(r'(?:يوم\s+|أيام\s+|كل\s+)?(?:الاثنين|الإثنين)'), 'monday'),
  (_w(r'(?:يوم\s+|كل\s+)?الثلاثاء'), 'tuesday'),
  (_w(r'(?:يوم\s+|كل\s+)?الأربعاء|الاربعاء'), 'wednesday'),
  (_w(r'(?:يوم\s+|كل\s+)?الخميس'), 'thursday'),
  (_w(r'(?:يوم\s+|كل\s+)?الجمعة'), 'friday'),
  (_w(r'(?:يوم\s+|كل\s+)?السبت'), 'saturday'),
  (_w(r'(?:يوم\s+|كل\s+)?الأحد|الاحد'), 'sunday'),
  (_w(r'شروق\s+الشمس|الشروق|طلوع\s+الشمس'), 'sunrise'),
  (_w(r'غروب\s+الشمس|الغروب'), 'sunset'),
  (_w(r'إشعال\s+الشموع|اشعال\s+الشموع|إضاءة\s+الشموع|الشموع'), 'candle lighting'),
  (_w(r'الهفدالا|هفدالا|هافدالا|الهافدالا'), 'havdalah'),
  (_w(r'أيقظني|ايقظني|صحيني|صحّيني'), 'wake me'),
  (_w(r'ذكرني|ذكّرني'), 'remind me to'),
  (_w(r'منبه|المنبه'), 'alarm'),
  (_w('متى'), 'when'),
  (_w(r'(?:في\s+)?أي\s+ساعة|في\s+اي\s+ساعة'), 'what time'),
  (_w('الساعة'), 'at'),
  (_w('بـ|ب'), 'by'),
  (_w('من'), 'from'),
  (_w(r'إلى|الى|حتى'), 'to'),
  (_w('قبل'), 'before'),
  (_w('بعد'), 'after'),
  (_w('في'), ''),
];

final _Book _japanese = [
  (_r(r'(\d+)\s*時間\s*(?:後|ご|たったら|経ったら)'), 'in \$1 hours'),
  (_r(r'(\d+)\s*分\s*(?:後|ご|たったら|経ったら)'), 'in \$1 minutes'),
  (_r(r'(?:30分|半時間)\s*後'), 'in half an hour'),
  (_r(r'何時'), 'what time'),
  (_r(r'(\d+)\s*時\s*(\d+)\s*分'), '\$1:\$2'),
  (_r(r'(\d+)\s*時\s*半'), '\$1:30'),
  (_r(r'(\d+)\s*時(?!間)'), '\$1:00'),
  (_r(r'(\d+)\s*分'), '\$1 minutes'),
  (_r('時間'), 'hours'),
  (_r('明後日|あさって'), 'day after tomorrow'),
  (_r('明日|あした|あす'), 'tomorrow'),
  (_r('今夜|今晩|こんばん'), 'tonight'),
  (_r('今日|きょう'), 'today'),
  (_r('真夜中|深夜'), 'midnight'),
  (_r('正午|お昼'), 'noon'),
  (_r('朝|午前'), 'morning'),
  (_r('夜|晩|夕方|午後'), 'evening'),
  (_r('毎日'), 'every day'),
  (_r('平日'), 'weekdays'),
  (_r('週末|土日'), 'weekends'),
  (_r('(?:毎週)?月曜日?'), 'monday'),
  (_r('(?:毎週)?火曜日?'), 'tuesday'),
  (_r('(?:毎週)?水曜日?'), 'wednesday'),
  (_r('(?:毎週)?木曜日?'), 'thursday'),
  (_r('(?:毎週)?金曜日?'), 'friday'),
  (_r('(?:毎週)?土曜日?'), 'saturday'),
  (_r('(?:毎週)?日曜日?'), 'sunday'),
  (_r('日の出'), 'sunrise'),
  (_r('日の入り?|日没|夕日'), 'sunset'),
  (_r('(?:キャンドル|ろうそく|ロウソク|蝋燭)(?:の)?(?:点灯|に火を灯す|に火)?'), 'candle lighting'),
  (_r('ハヴダラー?|ハブダラー?'), 'havdalah'),
  (_r('安息日|シャバット|シャバス'), 'shabbat'),
  (_r('起こして|起こす|起きる'), 'wake me'),
  (_r('アラーム|目覚まし'), 'alarm'),
  (_r('いつ'), 'when'),
  (_r('から'), 'to'),
  (_r('まで'), ''),
  (_r('前'), 'before'),
  (_r('後'), 'after'),
  (_r('[のにをはがでへ]'), ''),
];

final _Book _chinese = [
  (_r(r'(\d+)\s*(?:个|個)?\s*(?:小时|小時|钟头|鐘頭)\s*(?:后|後|以后|以後)'), 'in \$1 hours'),
  (_r(r'(\d+)\s*(?:分钟|分鐘)\s*(?:后|後|以后|以後)'), 'in \$1 minutes'),
  (_r(r'半\s*(?:个|個)?\s*(?:小时|小時|钟头|鐘頭)\s*(?:后|後|以后|以後)'), 'in half an hour'),
  (_r(r'几点|幾點|什么时间|什麼時間'), 'what time'),
  (_r(r'(\d+)\s*[点點]\s*(\d+)\s*分?'), '\$1:\$2'),
  (_r(r'(\d+)\s*[点點]\s*半'), '\$1:30'),
  (_r(r'(\d+)\s*[点點]\s*(?:一|1)\s*刻'), '\$1:15'),
  (_r(r'(\d+)\s*[点點]\s*(?:钟|鐘|整)?'), '\$1:00'),
  (_r(r'(\d+)\s*(?:分钟|分鐘)'), '\$1 minutes'),
  (_r(r'小时|小時|钟头|鐘頭'), 'hours'),
  (_r(r'后天|後天'), 'day after tomorrow'),
  (_r(r'明天|明早'), 'tomorrow'),
  (_r(r'今晚|今天晚上'), 'tonight'),
  (_r(r'今天'), 'today'),
  (_r(r'午夜|半夜|凌晨12'), 'midnight'),
  (_r(r'中午'), 'noon'),
  (_r(r'早上|上午|早晨|凌晨|清晨'), 'morning'),
  (_r(r'下午|晚上|傍晚|晚'), 'evening'),
  (_r(r'每天|每日|天天'), 'every day'),
  (_r(r'工作日'), 'weekdays'),
  (_r(r'周末|週末'), 'weekends'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[一1]'), 'monday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[二2]'), 'tuesday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[三3]'), 'wednesday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[四4]'), 'thursday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[五5]'), 'friday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[六6]'), 'saturday'),
  (_r(r'(?:星期|周|週|礼拜|禮拜)[日天7]'), 'sunday'),
  (_r(r'日出'), 'sunrise'),
  (_r(r'日落'), 'sunset'),
  (_r(r'点蜡烛|點蠟燭|点燃蜡烛|點燃蠟燭|蜡烛|蠟燭'), 'candle lighting'),
  (_r(r'哈夫达拉|哈夫達拉|哈弗达拉'), 'havdalah'),
  (_r(r'安息日'), 'shabbat'),
  (_r(r'叫醒我|叫我起床'), 'wake me'),
  (_r(r'提醒我'), 'remind me to'),
  (_r(r'闹钟|鬧鐘'), 'alarm'),
  (_r(r'什么时候|什麼時候|何时|何時'), 'when'),
  (_r(r'从|從'), 'from'),
  (_r(r'到|至'), 'to'),
  (_r(r'之前|以前|前'), 'before'),
  (_r(r'之后|之後|以后|以後|后|後'), 'after'),
  (_r(r'[的在是吗嗎呢]'), ''),
];

final _Book _korean = [
  (_r(r'(\d+)\s*시간\s*(?:후|뒤|있다가)'), 'in \$1 hours'),
  (_r(r'(\d+)\s*분\s*(?:후|뒤|있다가)'), 'in \$1 minutes'),
  (_r(r'(?:30분|반\s*시간)\s*(?:후|뒤)'), 'in half an hour'),
  (_r(r'몇\s*시'), 'what time'),
  (_r(r'(\d+)\s*시\s*(\d+)\s*분'), '\$1:\$2'),
  (_r(r'(\d+)\s*시\s*반'), '\$1:30'),
  (_r(r'(\d+)\s*시(?!간)'), '\$1:00'),
  (_r(r'(\d+)\s*분'), '\$1 minutes'),
  (_r('시간'), 'hours'),
  (_r('모레'), 'day after tomorrow'),
  (_r('내일'), 'tomorrow'),
  (_r(r'오늘\s*밤|오늘\s*저녁'), 'tonight'),
  (_r('오늘'), 'today'),
  (_r('자정'), 'midnight'),
  (_r('정오'), 'noon'),
  (_r('아침|오전|새벽'), 'morning'),
  (_r('저녁|오후|밤'), 'evening'),
  (_r('매일|날마다'), 'every day'),
  (_r('평일|주중'), 'weekdays'),
  (_r('주말'), 'weekends'),
  (_r(r'(?:매주\s*)?월요일'), 'monday'),
  (_r(r'(?:매주\s*)?화요일'), 'tuesday'),
  (_r(r'(?:매주\s*)?수요일'), 'wednesday'),
  (_r(r'(?:매주\s*)?목요일'), 'thursday'),
  (_r(r'(?:매주\s*)?금요일'), 'friday'),
  (_r(r'(?:매주\s*)?토요일'), 'saturday'),
  (_r(r'(?:매주\s*)?일요일'), 'sunday'),
  (_r(r'일출|해돋이|해\s*뜨는'), 'sunrise'),
  (_r(r'일몰|해넘이|해질녘|해\s*지는'), 'sunset'),
  (_r(r'촛불\s*(?:점화|켜기|을\s*켜는|켜는)?'), 'candle lighting'),
  (_r('하브달라|하브달라'), 'havdalah'),
  (_r('안식일|샤밧|샤바트'), 'shabbat'),
  (_r(r'깨워\s*줘|깨워\s*주세요|깨워'), 'wake me'),
  (_r(r'알려\s*줘|알려\s*주세요|리마인드'), 'remind me to'),
  (_r('알람'), 'alarm'),
  (_r('언제'), 'when'),
  (_r('부터'), 'to'),
  (_r('까지'), ''),
  (_r('전'), 'before'),
  (_r('후|뒤'), 'after'),
  (_r(r'(?<=\p{L})(?:에는|에|을|를|은|는|의|이|가)(?=\s|$)'), ''),
];
