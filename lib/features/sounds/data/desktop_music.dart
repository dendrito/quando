import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/util/platform.dart';
import '../../ringing/data/spotify.dart';
import 'spotify_library.dart';

import 'package:quando/l10n/l10n.dart';

/// Scoped controls for the user's installed Mac apps. No account password,
/// web cookie, private streaming URL or developer secret is collected.
class DesktopMusic {
  static const channel = MethodChannel('quando/desktop_music');
  static bool get available => isMacOS || appleOnIPhone;

  /// Apple Music on iPhone and iPad through Apple's MusicKit. Needs MusicKit
  /// switched on for the app's identifier in Apple's developer account (paid
  /// membership), so it stays off until the build says
  /// `--dart-define=APPLE_MUSIC=true`.
  static const appleMusicKit = bool.fromEnvironment('APPLE_MUSIC');
  static bool get appleOnIPhone => appleMusicKit && !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Apple Music can be picked and played here.
  static bool get appleAvailable => isMacOS || appleOnIPhone;

  /// This link plays through the scoped music bridge: every link on a Mac,
  /// Apple Music library items on iPhone.
  static bool routes(String link) => isMacOS || (appleOnIPhone && serviceOf(link) == 'apple');
  static String key(String service) => 'music.desktop.$service';

  static String? serviceOf(String link) {
    if (SpotifyPlay.uriOf(link) != null) return 'spotify';
    // Mac library persistent IDs, or MusicKit library IDs on iPhone.
    if (RegExp(r'^quando-music:(playlist|track):[A-Za-z0-9._-]{1,64}$').hasMatch(link)) return 'apple';
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

  static Future<List<MusicShelf>> appleLibrary() async {
    final result = await channel.invokeMapMethod<String, dynamic>('library', {'service': 'apple'}) ?? {};
    return [
      MusicShelf(l10n.playlists, applePlaylists(result['playlists']), empty: l10n.noPlaylists),
      MusicShelf(l10n.musicSongs, appleSongs(result['songs']), empty: l10n.noMusicSongs),
    ];
  }

  /// The songs in one of your Music playlists, so you can wake to just one.
  static Future<List<SpotifyItem>> applePlaylistSongs(SpotifyItem playlist) async =>
      appleSongs(await channel.invokeListMethod<Object?>('playlistTracks', {'id': playlist.playlistId}));

  /// Music's own search of your library.
  static Future<List<SpotifyItem>> appleSearch(String query) async =>
      appleSongs(await channel.invokeListMethod<Object?>('search', {'query': query.trim()}));

  static final _id = RegExp(r'^[A-Za-z0-9._-]{1,64}$');

  static List<SpotifyItem> applePlaylists(Object? rows) => [
    for (final row in rows is List ? rows : const [])
      if (row is Map && row['id'] is String && _id.hasMatch(row['id'] as String) && row['name'] is String)
        SpotifyItem(
          name: row['name'] as String,
          detail: switch (int.tryParse('${row['count']}')) {
            final n? => l10n.songCount(n),
            null => l10n.playlist,
          },
          url: 'quando-music:playlist:${row['id']}',
          playlistId: row['id'] as String,
        ),
  ];

  static List<SpotifyItem> appleSongs(Object? rows) => [
    for (final row in rows is List ? rows : const [])
      if (row is Map && row['id'] is String && _id.hasMatch(row['id'] as String) && row['name'] is String)
        SpotifyItem(
          name: row['name'] as String,
          detail: (row['artist'] as String?)?.isNotEmpty == true ? row['artist'] as String : 'Apple Music',
          url: 'quando-music:track:${row['id']}',
        ),
  ];
}
