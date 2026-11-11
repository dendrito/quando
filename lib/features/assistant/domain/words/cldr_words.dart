/// One language's date words from Unicode CLDR (see cldr.g.dart).
class CldrWords {
  const CldrWords({
    required this.days,
    required this.relativeDays,
    required this.morning,
    required this.afternoon,
    required this.inTime,
  });

  /// Weekday names, 1 = Monday.
  final Map<String, int> days;

  /// "today" = 0, "tomorrow" = 1, "the day after tomorrow" = 2.
  final Map<String, int> relativeDays;

  /// "in the morning" and "in the afternoon/evening" words.
  final List<String> morning;
  final List<String> afternoon;

  /// "in {0} minutes" → 'minute', "in {0} hours" → 'hour'.
  final Map<String, String> inTime;
}
