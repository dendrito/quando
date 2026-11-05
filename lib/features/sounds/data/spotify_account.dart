import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../ringing/data/spotify.dart';

import 'package:quando/l10n/l10n.dart';

/// Your Spotify library: sign in once in Spotify's own web page (no
/// Spotify app or Premium needed, on Android and iPhone alike), then pick
/// playlists, liked songs, or search Spotify for any song.
///
/// Uses the same developer app and redirect address as direct play, so
/// nothing new needs registering in Spotify's dashboard.
class SpotifyAccount {
  static const _scopes = 'playlist-read-private playlist-read-collaborative user-library-read';
  static const _callbackScheme = 'spotify-sdk';

  static const prefKey = 'spotify.library';
  static const _refreshKey = 'spotify.refresh';

  /// Signed in to the library (kept under [prefKey]).
  static bool connected = false;

  static bool get available => !kIsWeb && SpotifyPlay.clientId.isNotEmpty;

  static String? _token;
  static DateTime _expires = DateTime(2000);

  /// Loads whether you're signed in, at launch.
  static void load(SharedPreferences prefs) {
    connected = prefs.getBool(prefKey) ?? false;
  }

  /// A key for Spotify's Web API: a saved one, a refreshed one, or (when
  /// [prompt]) a fresh sign-in. Throws with a reason you can read when it
  /// can't get one; returns null when you closed the sign-in page.
  static Future<String?> token(SharedPreferences prefs, {bool prompt = true}) async {
    if (_token != null && DateTime.now().isBefore(_expires)) return _token;
    final refresh = prefs.getString(_refreshKey);
    if (refresh != null) {
      try {
        return await _exchange(prefs, {'grant_type': 'refresh_token', 'refresh_token': refresh});
      } on SpotifyAuthException {
        // Revoked or expired: sign in again below.
        await prefs.remove(_refreshKey);
      }
    }
    if (!prompt) return null;
    return _signIn(prefs);
  }

  static Future<String?> _signIn(SharedPreferences prefs) async {
    final verifier = _random(64);
    final challenge = base64UrlEncode(sha256.convert(ascii.encode(verifier)).bytes).replaceAll('=', '');
    final state = _random(16);
    final url = Uri.https('accounts.spotify.com', '/authorize', {
      'client_id': SpotifyPlay.clientId,
      'response_type': 'code',
      'redirect_uri': SpotifyPlay.redirectUrl,
      'code_challenge_method': 'S256',
      'code_challenge': challenge,
      'scope': _scopes,
      'state': state,
    });
    final String result;
    try {
      result = await FlutterWebAuth2.authenticate(url: url.toString(), callbackUrlScheme: _callbackScheme);
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') return null;
      throw SpotifyAuthException(l10n.spotifyLoginError(e.message ?? e.code));
    }
    final back = Uri.parse(result).queryParameters;
    final error = back['error'];
    if (error == 'access_denied') return null;
    if (error != null) throw SpotifyAuthException(l10n.spotifyLoginError(error));
    final code = back['code'];
    if (code == null || back['state'] != state) {
      throw SpotifyAuthException(l10n.spotifyLoginError('no code'));
    }
    return _exchange(prefs, {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': SpotifyPlay.redirectUrl,
      'code_verifier': verifier,
    });
  }

  static Future<String> _exchange(SharedPreferences prefs, Map<String, String> body) async {
    final r = await http
        .post(
          Uri.https('accounts.spotify.com', '/api/token'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {...body, 'client_id': SpotifyPlay.clientId},
        )
        .timeout(const Duration(seconds: 15));
    final j = _json(r.body);
    if (r.statusCode != 200 || j['access_token'] is! String) {
      final why = j['error_description'] ?? j['error'] ?? r.statusCode;
      throw SpotifyAuthException(l10n.spotifyLoginError('$why'));
    }
    _token = j['access_token'] as String;
    final secs = (j['expires_in'] as num?)?.toInt() ?? 3600;
    _expires = DateTime.now().add(Duration(seconds: secs - 60));
    final refresh = j['refresh_token'] as String?;
    if (refresh != null) await prefs.setString(_refreshKey, refresh);
    connected = true;
    await prefs.setBool(prefKey, true);
    return _token!;
  }

  static Future<void> signOut(SharedPreferences prefs) async {
    _token = null;
    connected = false;
    await prefs.remove(_refreshKey);
    await prefs.setBool(prefKey, false);
  }

  static Map<String, dynamic> _json(String body) {
    try {
      final j = jsonDecode(body);
      return j is Map<String, dynamic> ? j : const {};
    } catch (_) {
      return const {};
    }
  }

  static String _random(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final r = Random.secure();
    return List.generate(length, (_) => chars[r.nextInt(chars.length)]).join();
  }
}

class SpotifyAuthException implements Exception {
  SpotifyAuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
