import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show LicenseEntryWithLineBreaks, LicenseRegistry;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/util/local_time.dart';
import 'l10n/l10n.dart';
import 'features/ringing/data/spotify.dart';
import 'features/sounds/data/spotify_account.dart';
import 'features/sounds/data/youtube_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'SunCalc lunar astronomy',
    ], await rootBundle.loadString('third_party/suncalc/LICENSE'));
  });
  ensureTimeZones();
  final prefs = await SharedPreferences.getInstance();
  // Speak the chosen language (or the phone's) from the very first word,
  // including alarms set before any screen is built.
  final language = prefs.getString('language');
  useLocale(
    language == null ? WidgetsBinding.instance.platformDispatcher.locales : [localeFromTag(language)],
  );
  await initializeDateFormatting();
  SpotifyPlay.connected = prefs.getBool(SpotifyPlay.prefKey) ?? false;
  SpotifyAccount.load(prefs);
  YouTubeAccount.connected = prefs.getBool(YouTubeAccount.prefKey) ?? false;
  String? deviceZone;
  try {
    deviceZone = (await FlutterTimezone.getLocalTimezone()).identifier;
    inZone(DateTime.now().toUtc(), deviceZone); // known to the tz database?
  } catch (_) {
    deviceZone = null;
  }
  runApp(
    ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs), deviceZoneProvider.overrideWithValue(deviceZone)],
      child: const QuandoApp(),
    ),
  );
}
