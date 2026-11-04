import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/util/local_time.dart';
import 'features/ringing/data/spotify.dart';
import 'features/sounds/data/youtube_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ensureTimeZones();
  final prefs = await SharedPreferences.getInstance();
  SpotifyPlay.connected = prefs.getBool(SpotifyPlay.prefKey) ?? false;
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
