/// Something alarms hang off: a Shabbat or festival time, a calendar entry,
/// a sun time, or a time the user typed in.
enum EventKind {
  /// Candle lighting that starts Shabbat or a festival (before sunset).
  holyDayStart,

  /// Candle lighting on a second holy night, after nightfall
  /// (e.g. second night of a festival, or a festival that follows Shabbat).
  secondNightCandles,

  /// Havdalah: the end of Shabbat or a festival.
  holyDayEnd,

  sunrise,
  sunset,

  /// A calendar event's start.
  calendar,

  /// A calendar event's end.
  calendarEnd,
  manual;

  bool get isCalendar => this == calendar || this == calendarEnd;
}

class AnchorEvent {
  const AnchorEvent({
    required this.id,
    required this.kind,
    required this.title,
    required this.at,
    required this.source,
    this.alias,
  });

  /// Stable id: the same real-world event always gets the same id, so
  /// re-planning produces the same alarms.
  final String id;
  final EventKind kind;
  final String title;

  /// The exact moment, in UTC.
  final DateTime at;

  /// Where it came from, e.g. `jewish`, `google`, `manual`.
  final String source;

  /// The English title of a built-in time ("Candle lighting · Shabbat"),
  /// so searches like `candle*` work in every language. null = [title] only.
  final String? alias;

  @override
  String toString() => 'AnchorEvent($kind, $title, ${at.toIso8601String()})';
}

/// A stretch of time when Shabbat or festival mode is on: from the first
/// candle lighting until havdalah. Back-to-back holy days are one period.
class HolyPeriod {
  const HolyPeriod({required this.start, required this.end, required this.names});

  final DateTime start;
  final DateTime end;

  /// The days it covers, e.g. `['Rosh Hashana', 'Rosh Hashana', 'Shabbat']`.
  final List<String> names;

  bool contains(DateTime t) => !t.isBefore(start) && t.isBefore(end);

  Duration get length => end.difference(start);

  @override
  String toString() => 'HolyPeriod(${names.join(' + ')}, $start → $end)';
}
