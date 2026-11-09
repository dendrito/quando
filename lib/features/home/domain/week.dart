import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/local_time.dart';

import 'package:quando/l10n/l10n.dart';

/// Alarms that belong together on one day: every "Candle lighting · Shabbat"
/// reminder on Friday, say. Shown as one row that opens up.
class AlarmSeries {
  const AlarmSeries(this.title, this.alarms);

  final String title;

  /// Earliest first. Never empty.
  final List<ScheduledAlarm> alarms;

  DateTime get first => alarms.first.at;
  DateTime get last => alarms.last.at;
}

/// One day of the week ahead.
class DayPlan {
  const DayPlan(this.day, this.series);

  /// Midnight of the day, in the zone the plan was built for.
  final DateTime day;
  final List<AlarmSeries> series;

  int get count => series.fold(0, (n, s) => n + s.alarms.length);
}

/// Splits [plan] into days in [zone], and each day into series of alarms
/// with the same title, ordered by when each series starts.
List<DayPlan> weekPlan(List<ScheduledAlarm> plan, String zone) {
  final days = <DateTime, Map<String, List<ScheduledAlarm>>>{};
  for (final a in [...plan]..sort((a, b) => a.at.compareTo(b.at))) {
    final l = inZone(a.at, zone);
    final day = DateTime(l.year, l.month, l.day);
    days.putIfAbsent(day, () => {}).putIfAbsent(a.title, () => []).add(a);
  }
  final out = [
    for (final MapEntry(key: day, value: byTitle) in days.entries)
      DayPlan(day, [for (final MapEntry(:key, :value) in byTitle.entries) AlarmSeries(key, value)]),
  ]..sort((a, b) => a.day.compareTo(b.day));
  return out;
}

/// "Today", "Tomorrow" or "Fri 6 Nov".
String dayHeading(DateTime day, DateTime today) {
  final d = DateTime(day.year, day.month, day.day);
  final t = DateTime(today.year, today.month, today.day);
  final diff = (d.difference(t).inHours / 24).round();
  if (diff == 0) return l10n.today;
  if (diff == 1) return l10n.tomorrow;
  return dayLabel(d);
}

/// One day on the week ribbon: a dot for each alarm, in its group's colour.
class RibbonDay {
  const RibbonDay({required this.day, required this.dots, required this.holy, required this.today});

  /// Midnight of the day, in the zone the ribbon was built for.
  final DateTime day;
  final List<String> dots;

  /// Shabbat or a festival falls on this day.
  final bool holy;
  final bool today;

  bool sameDay(DateTime d) => d.year == day.year && d.month == day.month && d.day == day.day;
}

/// The seven days from today in [zone]. [dotOf] names the colour key of each
/// alarm (its group, or '' for none); [holyDays] are the days Shabbat or a
/// festival touches.
List<RibbonDay> weekRibbon({
  required List<ScheduledAlarm> plan,
  required DateTime now,
  required String zone,
  required String Function(ScheduledAlarm) dotOf,
  Iterable<(DateTime, DateTime)> holyDays = const [],
}) {
  final today = inZone(now, zone);
  final start = DateTime(today.year, today.month, today.day);
  return [
    for (var i = 0; i < 7; i++)
      () {
        final day = DateTime(start.year, start.month, start.day + i);
        bool on(DateTime utc) {
          final l = inZone(utc, zone);
          return l.year == day.year && l.month == day.month && l.day == day.day;
        }

        // Shabbat starts the evening before; it counts for the days it covers, from candle lighting to Havdalah.
        final holy = holyDays.any((p) {
          final from = inZone(p.$1, zone), to = inZone(p.$2, zone);
          final a = DateTime(from.year, from.month, from.day), b = DateTime(to.year, to.month, to.day);
          return !day.isBefore(a) && !day.isAfter(b);
        });
        return RibbonDay(
          day: day,
          dots: [
            for (final a in plan)
              if (on(a.at)) dotOf(a),
          ],
          holy: holy,
          today: i == 0,
        );
      }(),
  ];
}
