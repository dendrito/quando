import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import '../../lock/domain/shabbat_calendar.dart';
import 'alarm_parser.dart';
import 'alarm_request.dart';
import 'phrasebook.dart';

/// "When is candle lighting this Friday?", "que horas é a havdalá?",
/// "מתי השקיעה מחר?": a question about a time, not an alarm to set.
class TimeQuestion {
  const TimeQuestion({required this.anchor, this.weekday, this.dayOffset});

  final TimeAnchor anchor;

  /// "This Friday" = 5 (1 = Monday ... 7 = Sunday). null = the next one.
  final int? weekday;

  /// "Tomorrow" = 1.
  final int? dayOffset;
}

/// The answer, and where it came from.
class TimeAnswer {
  const TimeAnswer({required this.at, required this.title, this.calendarId});

  final DateTime at;

  /// The event's own title, e.g. "Candle lighting: 17:52".
  final String title;

  /// Read from this calendar of the user's; null = Quando?'s own times.
  final String? calendarId;

  bool get fromCalendar => calendarId != null;
}

/// Question marks in every script: ?, full-width ？ and Arabic ؟.
final _questionMark = RegExp(r'[?？؟]$');

/// A question about sunrise, sunset, candle lighting or havdalah; null for
/// anything else, including "wake me before candle lighting".
TimeQuestion? readTimeQuestion(String input, {String? lang, AlarmParser parser = const AlarmParser()}) {
  final lex = Lexicon.forLanguage(lang);
  final text = _plain(rewriteForParser(input, lang));
  final asks =
      RegExp('^\\s*¿?\\s*(?:${lex.question})(?![\\p{L}])', unicode: true).hasMatch(text) ||
      _questionMark.hasMatch(text.trim()) ||
      (hasPhrasebook(lang) && RegExp(r'(?<![a-z])(?:when|what\s+time)(?![a-z])').hasMatch(text));
  if (!asks || RegExp('(?<![\\p{L}])(?:${lex.command})', unicode: true).hasMatch(text)) return null;
  final r = parser.parse(input, lang: lang);
  final anchor = r?.anchor;
  if (r == null || anchor == null || r.hour != null || r.after != null) return null;
  return TimeQuestion(
    anchor: anchor,
    weekday: r.onWeekday ?? (r.days.length == 1 ? r.days.first : null),
    dayOffset: r.dayOffset,
  );
}

/// The answer: the user's own calendars first for Shabbat times (their
/// Hebcal or synagogue times win), then Quando?'s [builtIn] times.
TimeAnswer? answerTimeQuestion(
  TimeQuestion q, {
  required DateTime now,
  required String zone,
  List<AnchorEvent> calendarEvents = const [],
  List<AnchorEvent> builtIn = const [],
}) {
  final today = inZone(now, zone);
  final todayDate = DateTime(today.year, today.month, today.day);
  bool onAskedDay(AnchorEvent e) {
    final l = inZone(e.at, zone);
    final d = DateTime(l.year, l.month, l.day);
    if (q.dayOffset != null) return d.difference(todayDate).inDays == q.dayOffset;
    if (q.weekday != null) return l.weekday == q.weekday && d.difference(todayDate).inDays <= 7;
    return true;
  }

  bool fits(AnchorEvent e) => e.at.isAfter(now) && onAskedDay(e);
  AnchorEvent? first(Iterable<AnchorEvent> l) {
    final s = l.where(fits).toList()..sort((a, b) => a.at.compareTo(b.at));
    return s.firstOrNull;
  }

  final calendarTitle = switch (q.anchor) {
    TimeAnchor.candleLighting => isCandleLightingTitle,
    TimeAnchor.havdalah => isHavdalahTitle,
    _ => null,
  };
  if (calendarTitle != null) {
    final e = first(calendarEvents.where((e) => e.kind == EventKind.calendar && calendarTitle(e.title)));
    if (e != null) return TimeAnswer(at: e.at, title: e.title, calendarId: e.source);
  }

  final kinds = switch (q.anchor) {
    TimeAnchor.candleLighting => {EventKind.holyDayStart, EventKind.secondNightCandles},
    TimeAnchor.havdalah => {EventKind.holyDayEnd},
    TimeAnchor.sunrise => {EventKind.sunrise},
    TimeAnchor.sunset => {EventKind.sunset},
  };
  final e = first(builtIn.where((e) => kinds.contains(e.kind)));
  return e == null ? null : TimeAnswer(at: e.at, title: e.title);
}

String _plain(String s) {
  const accents = {
    'á': 'a',
    'à': 'a',
    'â': 'a',
    'ã': 'a',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'í': 'i',
    'ó': 'o',
    'ô': 'o',
    'õ': 'o',
    'ú': 'u',
    'ü': 'u',
    'ç': 'c',
    'ñ': 'n',
  };
  return s.toLowerCase().split('').map((c) => accents[c] ?? c).join();
}
