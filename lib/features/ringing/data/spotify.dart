import 'dart:async';

import 'package:spotify_sdk/spotify_sdk.dart';

/// Spotify direct play: Spotify's own kit lets Quando tell the Spotify app
/// exactly which song to play. Needs the Spotify app, Spotify Premium and
/// a one-time sign-in.
class SpotifyPlay {
  /// From Spotify's developer dashboard. Empty = direct play is off and
  /// song links use the phone's media signals instead.
  static const clientId = String.fromEnvironment('SPOTIFY_CLIENT_ID', defaultValue: _clientId);
  static const _clientId = '';
  static const redirectUrl = 'spotify-sdk://auth';
  static const _scope = 'app-remote-control';

  static bool get available => clientId.isNotEmpty;

  /// Set once the user has signed in, kept under [prefKey].
  static bool connected = false;
  static const prefKey = 'spotify.connected';

  /// `spotify:track:abc` for an open.spotify.com link (or a spotify: link
  /// as it is). null for anything else.
  static String? uriOf(String link) {
    if (link.startsWith('spotify:')) return link;
    final u = Uri.tryParse(link);
    if (u == null || !u.host.endsWith('spotify.com')) return null;
    final parts = u.pathSegments.where((s) => !s.startsWith('intl-')).toList();
    const kinds = {'track', 'album', 'playlist', 'artist', 'episode', 'show'};
    if (parts.length < 2 || !kinds.contains(parts[0]) || parts[1].isEmpty) return null;
    return 'spotify:${parts[0]}:${parts[1]}';
  }

  /// Signs in (Spotify shows its consent screen once). true when it worked.
  static Future<bool> signIn() async {
    if (!available) return false;
    try {
      return await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: _scope,
      );
    } catch (_) {
      return false;
    }
  }

  static Future<void> signOut() async {
    try {
      await SpotifySdk.disconnect();
    } catch (_) {}
  }

  /// Plays [link] in Spotify, and pauses it after [playFor] (zero = never).
  /// false when it isn't a Spotify link, or Spotify said no (no Premium,
  /// signed out, not installed…).
  static Future<bool> play(String link, {Duration playFor = Duration.zero}) async {
    final uri = uriOf(link);
    if (!available || !connected || uri == null) return false;
    try {
      final ok = await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: _scope,
      ).timeout(const Duration(seconds: 6));
      if (!ok) return false;
      await SpotifySdk.play(spotifyUri: uri).timeout(const Duration(seconds: 4));
      if (playFor > Duration.zero) {
        Timer(playFor, () => SpotifySdk.pause().catchError((_) {}));
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
