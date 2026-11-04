import 'package:kosher_dart/kosher_dart.dart';

/// Today's Hebrew date and this week's parasha, such as
/// ("15 Cheshvan, 5787", "Vayera") or ("ט״ו חשון תשפ״ז", "וירא").
///
/// The Jewish day starts at nightfall: pass [afterSunset] to show tomorrow's
/// date in the evening. The parasha is empty on weeks a festival takes its
/// place.
(String, String) hebrewDate(
  DateTime local, {
  bool inIsrael = false,
  bool afterSunset = false,
  bool hebrew = false,
}) {
  var day = DateTime(local.year, local.month, local.day);
  if (afterSunset) day = day.add(const Duration(days: 1));
  final jc = JewishCalendar.fromDateTime(day)..inIsrael = inIsrael;
  final f = HebrewDateFormatter()..hebrewFormat = hebrew;
  return (f.format(jc), f.formatWeeklyParsha(jc));
}
