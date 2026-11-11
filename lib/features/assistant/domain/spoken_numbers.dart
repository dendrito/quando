import 'alarm_parser.dart';

/// Times said in words become digits before anything else is read:
/// "seven thirty" → 7:30, "sete e meia" → 7:30, "five hundred and thirty
/// am" → 5:30 am (how speech recognition writes "530"), "five p. m." →
/// "5 pm". Only numbers that are clearly a time change; "take two pills"
/// keeps its words.
String spokenNumbers(String text, Lexicon lex) {
  var s = text.replaceAllMapped(
    RegExp(r'(?<![\p{L}])([ap])\s*\.\s*m\s*\.?(?![\p{L}])', unicode: true, caseSensitive: false),
    (m) => '${m[1]!.toLowerCase()}m',
  );
  final w = lex.word;
  final num = lex.num;
  final joins = lex.numberJoins.isEmpty ? '' : '\\s+(?:${lex.numberJoins.join('|')})\\s+|';
  final run = '$w(?:(?:$joins[\\s-]+)$w)?';
  final units = '(?:${lex.minute}|${lex.hour})';

  /// Matches on a plain copy (lower case, no accents, same length) and
  /// replaces in [s], so "três" is read like "tres".
  void sub(String pattern, String? Function(RegExpMatch m) out) {
    final plain = _plain(s);
    final matches = RegExp('(?<![\\p{L}\\d])(?:$pattern)(?![\\p{L}\\d])', unicode: true).allMatches(plain).toList();
    for (final m in matches.reversed) {
      final r = out(m);
      if (r != null) s = s.replaceRange(m.start, m.end, r);
    }
  }

  String two(int n) => n.toString().padLeft(2, '0');

  if (lex.codes.contains('en')) {
    // "one thousand two hundred" = 12:00, "five hundred and thirty" = 5:30.
    sub('one\\s+thousand\\s+($w)\\s+hundred(?:\\s+(?:and\\s+)?($run))?', (m) {
      final h = lex.numOf(m[1]!), mm = m[2] == null ? 0 : lex.numOf(m[2]!);
      if (h == null || mm == null || h + 10 > 23 || mm > 59) return null;
      return '${10 + h}:${two(mm)}';
    });
    sub('($w)\\s+hundred(?:\\s+(?:and\\s+)?($run))?', (m) {
      final h = lex.numOf(m[1]!), mm = m[2] == null ? 0 : lex.numOf(m[2]!);
      if (h == null || mm == null || h > 23 || mm > 59) return null;
      return '$h:${two(mm)}';
    });
  }

  // "seven thirty", "sete e quinze", "sieben uhr zwanzig": an hour, then
  // minutes from 10 to 59, and not "minutes" after them.
  sub(
    '($w)\\s+(?:(?:${lex.hourWord})\\s+)?(?:(?:${lex.connector})\\s+)?($run)(?!\\s+$units(?![\\p{L}]))',
    (m) {
      final h = lex.numOf(m[1]!), mm = lex.numOf(m[2]!);
      if (h == null || mm == null || h > 23 || mm < 10 || mm > 59) return null;
      if (RegExp(r'^\s*עשרה?\s*$').hasMatch(m[2]!)) return null; // שתיים עשרה = 12
      return '$h:${two(mm)}';
    },
  );
  // "seven and a half", "sete e meia", "sept heures et quart".
  sub('($num)\\s+(?:(?:${lex.hourWord})\\s+)?((?:${lex.halfPast})|(?:${lex.quarterPast}))', (m) {
    final h = lex.numOf(m[1]!);
    if (h == null || h > 23) return null;
    final quarter = RegExp('^(?:${lex.quarterPast})\$').hasMatch(m[2]!);
    return '$h:${quarter ? 15 : 30}';
  });
  // A number word right before am/pm, o'clock or a unit: "seven am",
  // "sete horas", "twenty minutes".
  sub('($run)(?=\\s*(?:${lex.am}|${lex.pm}|${lex.oclock}|${lex.hourWord}|$units)(?![\\p{L}]))', (m) {
    return lex.numOf(m[1]!)?.toString();
  });
  return s;
}

const _accents = {
  'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e', 'í': 'i',
  'ì': 'i', 'î': 'i', 'ï': 'i', 'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ú': 'u', 'ù': 'u',
  'û': 'u', 'ü': 'u', 'ç': 'c', 'ñ': 'n', 'ß': 's',
};

String _plain(String s) {
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    var l = s[i].toLowerCase();
    if (l.length != 1) l = s[i];
    b.write(_accents[l] ?? l);
  }
  return b.toString();
}
