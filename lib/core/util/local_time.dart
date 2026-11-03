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

/// "New York" for `America/New_York`.
String cityOf(String zone) => zone.split('/').last.replaceAll('_', ' ');

/// Every zone in the tz database with a city in it, e.g. `Europe/Lisbon`.
List<String> allZones() {
  ensureTimeZones();
  return tz.timeZoneDatabase.locations.keys
      .where((z) => z.contains('/') && !z.startsWith('Etc/') && !z.startsWith('SystemV/'))
      .toList()
    ..sort((a, b) => cityOf(a).compareTo(cityOf(b)));
}

/// "+3 h", "−5:30 h" or "same time" compared with [home].
String offsetFrom(String zone, String home, DateTime utc) {
  final d = inZone(utc, zone).timeZoneOffset - inZone(utc, home).timeZoneOffset;
  if (d == Duration.zero) return 'same time';
  final sign = d.isNegative ? '−' : '+';
  final m = d.inMinutes.abs();
  return m % 60 == 0 ? '$sign${m ~/ 60} h' : '$sign${m ~/ 60}:${(m % 60).toString().padLeft(2, '0')} h';
}
