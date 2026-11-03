import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

bool _loaded = false;

void ensureTimeZones() {
  if (_loaded) return;
  tzdata.initializeTimeZones();
  _loaded = true;
}

/// The wall-clock time of [utc] in [zone], e.g. `Asia/Jerusalem`.
tz.TZDateTime inZone(DateTime utc, String zone) {
  ensureTimeZones();
  return tz.TZDateTime.from(utc, tz.getLocation(zone));
}

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String hhmm(DateTime t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// "Fri 6 Nov".
String dayLabel(DateTime t) => '${_days[t.weekday - 1]} ${t.day} ${_months[t.month - 1]}';
