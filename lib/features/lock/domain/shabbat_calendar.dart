import '../../calendar/data/calendar_reader.dart';
import '../../events/domain/event.dart';

/// Spotting a Shabbat calendar (Hebcal, Chabad, a synagogue's zmanim...)
/// among the calendars the user picked, so Shabbat things only ever show
/// up for people who already keep one. Nobody else sees a trace of them.

final _shabbatName = RegExp(
  r'hebcal|shabb?at|shabbos|sabbath|jewish|judaic|zmanim|chabad|candle|'
  r'שבת|יהדות|זמנים|לוח עברי|הדלקת',
  caseSensitive: false,
);

final _candles = RegExp(
  r'candle[\s-]*lighting|light(ing)?\s+candles|\bcandles\b|הדלקת\s*נרות|'
  r'acendimento\s+(das\s+)?velas|encendido\s+de\s+velas|allumage\s+des\s+bougies|kerzen\s*z[üu]nden|lichtz[üu]nden',
  caseSensitive: false,
);

final _havdalah = RegExp(r'havdal|habdal|הבדלה|motz(a|e)i\s+shabb?at|shabb?at\s+ends', caseSensitive: false);

/// "Candle lighting: 17:52" and the like, in the languages calendars use.
bool isCandleLightingTitle(String title) => _candles.hasMatch(title);

/// "Havdalah (50 min): 18:58" and the like.
bool isHavdalahTitle(String title) => _havdalah.hasMatch(title);

/// The search a calendar lock uses to start and end at Shabbat times.
const candleLightingQuery = 'candle* OR candles OR הדלקת OR velas OR bougies OR kerzen';
const havdalahQuery = 'havdal* OR habdal* OR הבדלה';

/// Calendars that are clearly Shabbat calendars: by name, or because they
/// hold candle lighting or havdalah times.
Set<String> shabbatCalendarIds(List<PhoneCalendar> calendars, List<AnchorEvent> events) => {
  for (final c in calendars)
    if (_shabbatName.hasMatch(c.name)) c.id,
  for (final e in events)
    if (e.kind == EventKind.calendar && (isCandleLightingTitle(e.title) || isHavdalahTitle(e.title)))
      e.source,
};

/// The answer to "When is candle lighting this Friday?".
class CandleLightingAnswer {
  const CandleLightingAnswer({required this.at, required this.title, this.calendarId});

  final DateTime at;

  /// The event's own title, e.g. "Candle lighting: 17:52".
  final String title;

  /// The calendar it was read from; null = Quando?'s own times.
  final String? calendarId;

  bool get fromCalendar => calendarId != null;
}

/// The next candle lighting after [after]: searched in the user's calendars
/// first (their own Hebcal or synagogue times win), then Quando?'s own
/// times as a fallback. [before] limits it to e.g. "this Friday".
CandleLightingAnswer? nextCandleLighting({
  required DateTime after,
  required List<AnchorEvent> calendarEvents,
  List<AnchorEvent> builtIn = const [],
  DateTime? before,
}) {
  bool inRange(AnchorEvent e) => e.at.isAfter(after) && (before == null || e.at.isBefore(before));
  final fromCal = [
    for (final e in calendarEvents)
      if (e.kind == EventKind.calendar && isCandleLightingTitle(e.title) && inRange(e)) e,
  ]..sort((a, b) => a.at.compareTo(b.at));
  if (fromCal.isNotEmpty) {
    final e = fromCal.first;
    return CandleLightingAnswer(at: e.at, title: e.title, calendarId: e.source);
  }
  final own = [
    for (final e in builtIn)
      if ((e.kind == EventKind.holyDayStart || e.kind == EventKind.secondNightCandles) && inRange(e)) e,
  ]..sort((a, b) => a.at.compareTo(b.at));
  if (own.isEmpty) return null;
  return CandleLightingAnswer(at: own.first.at, title: own.first.title);
}
