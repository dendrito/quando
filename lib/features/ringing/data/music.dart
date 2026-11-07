import 'dart:async';

import 'package:flutter/services.dart';

import '../../../core/util/platform.dart';
import '../../sounds/data/desktop_music.dart';

import 'spotify.dart';

/// Owns an external music session while its alarm remains active. Desktop
/// apps use scoped native playback controls; Android retains media controls.
/// Official embedded YouTube/SoundCloud players are owned by their ring card.
class Music {
  static const _channel = MethodChannel('quando/media');
  static int _generation = DateTime.now().microsecondsSinceEpoch;
  static int? _alarmId;
  static String? _desktopSession;
  static Timer? _pauseTimer;
  static bool _hasSession = false;
  static bool owns(int alarmId) => _hasSession && _alarmId == alarmId;

  static Future<bool> playingFor(int alarmId) async {
    if (!owns(alarmId)) return false;
    try {
      final session = _desktopSession;
      return session == null ? await playing() : await DesktopMusic.playing(session);
    } catch (_) {
      return false;
    }
  }

  /// Opens [url] in its app. false when no app takes it.
  static Future<bool> open(String url) => _call('open', {'url': url});

  /// The phone's "play" signal, for apps that open a song without playing.
  static Future<bool> play() => _call('play');

  /// The phone's "pause" signal, now or after [after].
  static Future<bool> pause({Duration after = Duration.zero, int? alarmId}) async {
    if (alarmId != null && alarmId != _alarmId) return false;
    if (!_hasSession) return false;
    if (after > Duration.zero) {
      final generation = _generation;
      _pauseTimer?.cancel();
      _pauseTimer = Timer(after, () {
        if (_generation == generation) unawaited(pause(alarmId: alarmId));
      });
      return true;
    }
    _generation++;
    _pauseTimer?.cancel();
    _pauseTimer = null;
    _alarmId = null;
    _hasSession = false;
    final session = _desktopSession;
    _desktopSession = null;
    return _pauseNative(session);
  }

  static Future<bool> _pauseNative(String? session) async {
    if (session != null) {
      try {
        await DesktopMusic.pause(session);
        return true;
      } catch (_) {
        return false;
      }
    }
    await SpotifyPlay.pause();
    return _call('pause', {'afterMs': 0});
  }

  /// Whether any app is playing music right now.
  static Future<bool> playing() => _call('playing');

  /// Opens and plays [url], and pauses it [playFor] after it starts
  /// (zero = never). Tells within [wait] whether music actually started,
  /// so the alarm's own sound can take over if not.
  static Future<bool> start(
    String url, {
    Duration playFor = Duration.zero,
    Duration wait = const Duration(seconds: 10),
    int? alarmId,
  }) async {
    final previousSession = _desktopSession;
    final hadSession = _hasSession;
    final generation = ++_generation;
    _pauseTimer?.cancel();
    _alarmId = alarmId;
    _hasSession = true;
    _desktopSession = isMacOS ? 'alarm.${alarmId ?? 'link'}.$generation' : null;
    if (hadSession) await _pauseNative(previousSession);
    if (generation != _generation) return false;
    if (isMacOS) {
      final session = _desktopSession!;
      try {
        if (!await DesktopMusic.play(url, session)) return false;
        for (var s = 0; s <= wait.inSeconds; s++) {
          if (generation != _generation) {
            unawaited(DesktopMusic.pause(session));
            return false;
          }
          if (await DesktopMusic.playing(session)) {
            if (generation != _generation) {
              unawaited(DesktopMusic.pause(session));
              return false;
            }
            if (playFor > Duration.zero) await pause(after: playFor, alarmId: alarmId);
            return true;
          }
          if (s < wait.inSeconds) await Future<void>.delayed(const Duration(seconds: 1));
        }
        await DesktopMusic.pause(session);
      } catch (_) {
        /* The local alarm remains active. */
      }
      return false;
    }
    // Spotify direct play first, when signed in; then the media signals.
    final direct = await SpotifyPlay.play(url);
    if (generation != _generation) return false;
    if (!direct && !await open(url)) return false;
    for (var s = 1; s <= wait.inSeconds; s++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (generation != _generation) return false;
      if (await playing()) {
        if (playFor > Duration.zero) await pause(after: playFor, alarmId: alarmId);
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
