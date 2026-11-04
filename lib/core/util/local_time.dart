import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:quando/l10n/l10n.dart';
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

bool _dates = false;

/// The intl name of the language in use. Date names for every language
/// ship with the app; loading them is instant.
String get _lang {
  if (!_dates) {
    initializeDateFormatting();
    _dates = true;
  }
  return currentLocale.scriptCode == 'Hant' ? 'zh_TW' : currentLocale.languageCode;
}

String hhmm(DateTime t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// "Fri 6 Nov", in the language in use.
String dayLabel(DateTime t) => DateFormat('EEE d MMM', _lang).format(t);

/// "M" for Monday ([weekday] 1) to "S" for Sunday (7), in the language in use.
String weekdayNarrow(int weekday) => DateFormat('EEEEE', _lang).format(DateTime(2024, 1, weekday));

/// "Mon" for Monday ([weekday] 1) to "Sun" for Sunday (7), in the language in use.
String weekdayShort(int weekday) => DateFormat('EEE', _lang).format(DateTime(2024, 1, weekday));

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
  if (d == Duration.zero) return l10n.sameTime;
  final sign = d.isNegative ? '−' : '+';
  final m = d.inMinutes.abs();
  return m % 60 == 0 ? '$sign${m ~/ 60} h' : '$sign${m ~/ 60}:${(m % 60).toString().padLeft(2, '0')} h';
}
