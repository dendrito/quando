import 'package:flutter/services.dart';

import 'spotify.dart';

/// Plays a song link in its own app (Spotify, YouTube Music, Apple Music,
/// Amazon Music…) using the phone's own media controls, the same ones as
/// the play button on headphones. Quando can't play those songs itself.
class Music {
  static const _channel = MethodChannel('quando/media');

  /// Opens [url] in its app. false when no app takes it.
  static Future<bool> open(String url) => _call('open', {'url': url});

  /// The phone's "play" signal, for apps that open a song without playing.
  static Future<bool> play() => _call('play');

  /// The phone's "pause" signal, now or after [after].
  static Future<bool> pause({Duration after = Duration.zero}) =>
      _call('pause', {'afterMs': after.inMilliseconds});

  /// Whether any app is playing music right now.
  static Future<bool> playing() => _call('playing');

  /// Opens and plays [url], and pauses it [playFor] after it starts
  /// (zero = never). Tells within [wait] whether music actually started,
  /// so the alarm's own sound can take over if not.
  static Future<bool> start(
    String url, {
    Duration playFor = Duration.zero,
    Duration wait = const Duration(seconds: 10),
  }) async {
    // Spotify direct play first, when signed in; then the media signals.
    final direct = await SpotifyPlay.play(url, playFor: playFor);
    if (!direct && !await open(url)) return false;
    for (var s = 1; s <= wait.inSeconds; s++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (await playing()) {
        if (playFor > Duration.zero && !direct) await pause(after: playFor);
        return true;
      }
      // Some apps open the song without playing it.
      if (s == 3 && !direct) await play();
    }
    return false;
  }

  static Future<bool> _call(String method, [Map<String, Object?>? args]) async {
    try {
      return await _channel.invokeMethod<bool>(method, args) ?? false;
    } catch (_) {
      return false; // Not on Android, or the phone said no.
    }
  }
}
