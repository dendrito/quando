import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'spotify_library.dart';

import 'package:quando/l10n/l10n.dart';

/// Your SoundCloud: sign in on SoundCloud's own page, then pick from your
/// playlists and likes. Off until Quando has its own SoundCloud app keys
/// (SoundCloud approves each app by hand), given at build time with
/// `--dart-define=SOUNDCLOUD_CLIENT_ID=… --dart-define=SOUNDCLOUD_CLIENT_SECRET=…`.
/// The redirect to register is [redirectUrl].
class SoundCloudAccount {
  static const clientId = String.fromEnvironment('SOUNDCLOUD_CLIENT_ID');
  static const _clientSecret = String.fromEnvironment('SOUNDCLOUD_CLIENT_SECRET');
  static const _callbackScheme = 'quando-soundcloud';
  static const redirectUrl = '$_callbackScheme://auth';

  static const prefKey = 'soundcloud.library';
  static const _refreshKey = 'soundcloud.refresh';

  static bool connected = false;
  static bool get available => !kIsWeb && clientId.isNotEmpty;

  static String? _token;
  static DateTime _expires = DateTime(2000);

  static void load(SharedPreferences prefs) => connected = prefs.getBool(prefKey) ?? false;

  /// A key for SoundCloud's API: saved, refreshed or (when [prompt]) from a
  /// fresh sign-in. null when you closed the sign-in page.
  static Future<String?> token(SharedPreferences prefs, {bool prompt = true, http.Client? client}) async {
    if (_token != null && DateTime.now().isBefore(_expires)) return _token;
    final refresh = prefs.getString(_refreshKey);
    if (refresh != null) {
      try {
        return await _exchange(prefs, {'grant_type': 'refresh_token', 'refresh_token': refresh}, client: client);
      } on SoundCloudException catch (e) {
        if (e.code != 'invalid_grant') rethrow;
        await signOut(prefs);
      }
    }
    if (!prompt) return null;
    final verifier = _random(64);
    final challenge = base64UrlEncode(sha256.convert(ascii.encode(verifier)).bytes).replaceAll('=', '');
    final state = _random(16);
    final url = Uri.https('secure.soundcloud.com', '/authorize', {
      'client_id': clientId,
      'redirect_uri': redirectUrl,
      'response_type': 'code',
      'code_challenge': challenge,
      'code_challenge_method': 'S256',
      'state': state,
    });
    final String result;
    try {
      result = await FlutterWebAuth2.authenticate(url: url.toString(), callbackUrlScheme: _callbackScheme);
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') return null;
      throw SoundCloudException(l10n.serviceDidntAnswer('SoundCloud', 0), e.message);
    }
    final back = Uri.parse(result).queryParameters;
    if (back['error'] == 'access_denied') return null;
    final code = back['code'];
    if (code == null || back['state'] != state) {
      throw SoundCloudException(l10n.serviceDidntAnswer('SoundCloud', 0), back['error'] ?? 'no code');
    }
    return _exchange(prefs, {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUrl,
      'code_verifier': verifier,
    }, client: client);
  }

  static Future<String> _exchange(SharedPreferences prefs, Map<String, String> body, {http.Client? client}) async {
    final r = await (client?.post ?? http.post)(
      Uri.https('secure.soundcloud.com', '/oauth/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json; charset=utf-8'},
      body: {...body, 'client_id': clientId, if (_clientSecret.isNotEmpty) 'client_secret': _clientSecret},
    ).timeout(const Duration(seconds: 15));
    final j = _json(r.body);
    if (r.statusCode != 200 || j['access_token'] is! String) {
      throw SoundCloudException(
        l10n.serviceDidntAnswer('SoundCloud', r.statusCode),
        '${j['error_description'] ?? j['error'] ?? ''}',
        code: j['error'] as String?,
      );
    }
    _token = j['access_token'] as String;
    _expires = DateTime.now().add(Duration(seconds: ((j['expires_in'] as num?)?.toInt() ?? 3600) - 60));
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

class SoundCloudException implements Exception {
  SoundCloudException(this.message, this.why, {this.code});
  final String message;
  final String? why;
  final String? code;

  @override
  String toString() => why == null || why!.isEmpty ? message : '$message\n\n($why)';
}

/// Your playlists and likes from SoundCloud's API. Songs open in
/// SoundCloud's official player by their public link; tracks SoundCloud
/// blocks from playing elsewhere are left out.
class SoundCloudLibrary {
  SoundCloudLibrary(this.token, {http.Client? client}) : _client = client ?? http.Client();

  final String token;
  final http.Client _client;

  Future<List<SpotifyItem>> playlists() => _pages('/me/playlists?limit=50&show_tracks=false', _playlist);

  Future<List<SpotifyItem>> likes() => _pages('/me/likes/tracks?limit=50', track);

  Future<List<SpotifyItem>> playlistSongs(String id) {
    if (!RegExp(r'^[A-Za-z0-9:_-]{1,80}$').hasMatch(id)) throw ArgumentError.value(id, 'playlist');
    return _pages('/playlists/${Uri.encodeComponent(id)}/tracks?limit=100', track, limit: 500);
  }

  Future<List<SpotifyItem>> search(String query) async {
    final q = Uri.encodeQueryComponent(query.trim());
    final songs = await _pages('/tracks?q=$q&limit=25', track, limit: 25);
    final lists = await _pages('/playlists?q=$q&limit=10&show_tracks=false', _playlist, limit: 10);
    return [...songs, ...lists];
  }

  static SpotifyItem? _playlist(Map<String, dynamic> j) {
    final url = j['permalink_url'] as String?;
    final name = j['title'] as String?;
    if (url == null || name == null || name.isEmpty) return null;
    final count = j['track_count'] as num?;
    return SpotifyItem(
      name: name,
      detail: count == null ? l10n.playlist : l10n.songCount(count.toInt()),
      url: url,
      image: j['artwork_url'] as String?,
      playlistId: (j['urn'] ?? j['id'])?.toString(),
    );
  }

  /// A track, or null when it can't play outside SoundCloud.
  static SpotifyItem? track(Map<String, dynamic> j) {
    final t = (j['track'] is Map<String, dynamic> ? j['track'] : j) as Map<String, dynamic>;
    final url = t['permalink_url'] as String?;
    final name = t['title'] as String?;
    if (url == null || name == null || name.isEmpty) return null;
    if (t['access'] == 'blocked' || t['streamable'] == false) return null;
    final user = (t['user'] as Map?)?['username'] as String? ?? '';
    return SpotifyItem(name: name, detail: user, url: url, image: t['artwork_url'] as String?);
  }

  Future<List<SpotifyItem>> _pages(
    String path,
    SpotifyItem? Function(Map<String, dynamic>) parse, {
    int limit = 500,
  }) async {
    var uri = Uri.parse('https://api.soundcloud.com$path${path.contains('?') ? '&' : '?'}linked_partitioning=true');
    final out = <SpotifyItem>[];
    while (true) {
      final r = await _client
          .get(uri, headers: {'Authorization': 'OAuth $token', 'Accept': 'application/json; charset=utf-8'})
          .timeout(const Duration(seconds: 10));
      if (r.statusCode != 200) {
        String? why;
        try {
          final j = jsonDecode(r.body);
          why = j is Map ? '${j['message'] ?? j['error'] ?? ''}' : null;
        } catch (_) {}
        throw SoundCloudException(l10n.serviceDidntAnswer('SoundCloud', r.statusCode), why);
      }
      final body = jsonDecode(r.body);
      final items = body is List ? body : (body is Map ? body['collection'] as List? : null) ?? const [];
      for (final j in items) {
        if (j is Map<String, dynamic>) {
          final item = parse(j);
          if (item != null) out.add(item);
        }
      }
      final next = body is Map ? body['next_href'] : null;
      if (out.length >= limit || next is! String || !next.startsWith('https://api.soundcloud.com/')) break;
      uri = Uri.parse(next);
    }
    return out.take(limit).toList();
  }

  void close() => _client.close();
}
