import 'package:timezone/timezone.dart' as tz;

import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import 'alarm_request.dart';

/// What saving an [AlarmRequest] will create.
sealed class AlarmPlan {
  const AlarmPlan(this.label);
  final String label;
}

/// One alarm at an exact moment (UTC).
final class OneOffPlan extends AlarmPlan {
  const OneOffPlan(this.at, super.label);
  final DateTime at;
}

/// A repeating alarm at a time of day.
final class RepeatPlan extends AlarmPlan {
  const RepeatPlan(this.hour, this.minute, this.days, super.label);
  final int hour;
  final int minute;
  final Set<int> days;
}

/// A rule on sunrise, sunset or Shabbat times: rings every time it comes,
/// on [days] if any.
final class RulePlan extends AlarmPlan {
  const RulePlan(this.anchor, this.offset, this.days, super.label);
  final TimeAnchor anchor;
  final Duration offset;
  final Set<int> days;
}

const anchorKinds = {
  TimeAnchor.sunrise: {EventKind.sunrise},
  TimeAnchor.sunset: {EventKind.sunset},
  TimeAnchor.candleLighting: {EventKind.holyDayStart, EventKind.secondNightCandles},
  TimeAnchor.havdalah: {EventKind.holyDayEnd},
};

/// Works out when [r] rings. [eventsBetween] gives sun and Shabbat times,
/// for "tomorrow 20 minutes before sunset". null = nothing to ring.
AlarmPlan? planFor(
  AlarmRequest r, {
  required DateTime now,
  required String zone,
  required List<AnchorEvent> Function(DateTime from, DateTime to) eventsBetween,
}) {
  final after = r.after;
  if (after != null) return OneOffPlan(now.add(after), r.label);

  final local = inZone(now, zone);
  final anchor = r.anchor;
  if (anchor != null) {
    final d = r.dayOffset;
    if (d != null && r.days.isEmpty) {
      final day = tz.TZDateTime(local.location, local.year, local.month, local.day + d);
      final kinds = anchorKinds[anchor]!;
      for (final e in eventsBetween(day.toUtc(), day.add(const Duration(days: 1)).toUtc())) {
        final at = e.at.add(r.offset);
        final eDay = inZone(e.at, zone);
        if (kinds.contains(e.kind) && eDay.day == day.day && eDay.month == day.month && at.isAfter(now)) {
          return OneOffPlan(at, r.label);
        }
      }
    }
    return RulePlan(anchor, r.offset, r.days, r.label);
  }

  final h = r.hour;
  if (h == null) return null;
  if (r.repeats) return RepeatPlan(h, r.minute, r.days, r.label);

  // "At 7" with no am/pm: the next 7 o'clock, unless it's for tomorrow
  // or later, which usually means a morning.
  final hours = [h, if (r.halfDayUnsure) h + 12];
  final d = r.dayOffset;
  if (d != null && d > 0) {
    return OneOffPlan(
      tz.TZDateTime(local.location, local.year, local.month, local.day + d, h, r.minute).toUtc(),
      r.label,
    );
  }
  DateTime? best;
  for (final hh in hours) {
    final t = _next(local, hh, r.minute);
    if (best == null || t.isBefore(best)) best = t;
  }
  return OneOffPlan(best!, r.label);
}

DateTime _next(tz.TZDateTime local, int hour, int minute) {
  var t = tz.TZDateTime(local.location, local.year, local.month, local.day, hour, minute);
  if (!t.isAfter(local)) t = tz.TZDateTime(local.location, local.year, local.month, local.day + 1, hour, minute);
  return t.toUtc();
}
