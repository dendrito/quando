import 'package:kosher_dart/kosher_dart.dart';

import 'parasha_references.dart';

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

/// The same upcoming Shabbat as [hebrewDate], including Israel/diaspora and
/// Saturday-evening rollover. No approximate name-to-URL transliteration.
Uri? parashaSefaria(DateTime local, {bool inIsrael = false, bool afterSunset = false}) {
  var day = DateTime(local.year, local.month, local.day);
  if (afterSunset) day = day.add(const Duration(days: 1));
  day = day.add(Duration(days: (DateTime.saturday - day.weekday + 7) % 7));
  final calendar = JewishCalendar.fromDateTime(day)..inIsrael = inIsrael;
  final reference = parashaReferences[calendar.getParshah()];
  return reference == null ? null : Uri.https('www.sefaria.org', '/$reference', {'aliyot': '1'});
}

class RoshHodeshDate {
  const RoshHodeshDate({required this.first, required this.last, required this.month});
  final DateTime first, last;
  final String month;
  DateTime get begins => DateTime(first.year, first.month, first.day - 1);

  static RoshHodeshDate next(DateTime local, {bool afterSunset = false, bool hebrew = false}) {
    var today = DateTime(local.year, local.month, local.day);
    if (afterSunset) today = today.add(const Duration(days: 1));
    final format = HebrewDateFormatter()..hebrewFormat = hebrew;
    for (var i = 0; i < 65; i++) {
      final day = DateTime(today.year, today.month, today.day + i);
      final calendar = JewishCalendar.fromDateTime(day);
      if (!calendar.isRoshChodesh()) continue;
      final first =
          calendar.getJewishDayOfMonth() == 1 &&
              JewishCalendar.fromDateTime(DateTime(day.year, day.month, day.day - 1)).isRoshChodesh()
          ? DateTime(day.year, day.month, day.day - 1)
          : day;
      final last = calendar.getJewishDayOfMonth() == 30 ? DateTime(day.year, day.month, day.day + 1) : day;
      return RoshHodeshDate(
        first: first,
        last: last,
        month: format.formatMonth(JewishCalendar.fromDateTime(last)),
      );
    }
    throw StateError('No Rosh Hodesh within 65 days');
  }
}
