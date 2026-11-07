import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/util/platform.dart';
import '../../ringing/data/spotify.dart';
import 'spotify_library.dart';

/// Scoped controls for the user's installed Mac apps. No account password,
/// web cookie, private streaming URL or developer secret is collected.
class DesktopMusic {
  static const channel = MethodChannel('quando/desktop_music');
  static bool get available => isMacOS;
  static String key(String service) => 'music.desktop.$service';

  static String? serviceOf(String link) {
    if (SpotifyPlay.uriOf(link) != null) return 'spotify';
    if (RegExp(r'^quando-music:(playlist|track):[A-Fa-f0-9]{16}$').hasMatch(link)) return 'apple';
    // Apple's scoped playback API accepts library objects. Store links can
    // still open after Stop, but are not guaranteed playable library entries.
    return null;
  }

  static Future<void> connect(String service, SharedPreferences prefs) async {
    await channel.invokeMethod<void>('connect', {'service': service});
    await prefs.setBool(key(service), true); // OS authorization stays on this Mac.
  }

  static Future<bool> play(String link, String session) async {
    final service = serviceOf(link);
    if (!available || service == null) return false;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key(service)) != true) return false;
    return await channel.invokeMethod<bool>('play', {
          'service': service,
          'link': service == 'spotify' ? SpotifyPlay.uriOf(link) : link,
          'session': session,
        }) ??
        false;
  }

  static Future<bool> playing(String session) async =>
      await channel.invokeMethod<bool>('playing', {'session': session}) ?? false;

  static Future<void> pause(String session) => channel.invokeMethod<void>('pause', {'session': session});

  static Future<(List<SpotifyItem>, List<SpotifyItem>)> appleLibrary() async {
    final result = await channel.invokeMapMethod<String, dynamic>('library', {'service': 'apple'}) ?? {};
    List<SpotifyItem> parse(String key, String kind) => [
      for (final row in result[key] as List? ?? [])
        if (row is Map && row['id'] is String && row['name'] is String)
          SpotifyItem(
            name: row['name'] as String,
            detail: 'Apple Music',
            url: 'quando-music:$kind:${row['id']}',
          ),
    ];
    return (parse('playlists', 'playlist'), parse('songs', 'track'));
  }
}
