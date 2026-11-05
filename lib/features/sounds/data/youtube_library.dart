import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../sync/sync_config.dart';
import 'spotify_library.dart';

import 'package:quando/l10n/l10n.dart';

/// YouTube and YouTube Music: sign in with Google and read your playlists
/// and liked videos (liked songs in YouTube Music are among them).
class YouTubeAccount {
  /// Quando's web client in Google Cloud (not a secret).
  static const serverClientId =
      '299909596314-e9loi4jur2h3aqki3csa0h7h2s0rjrn5.apps.googleusercontent.com';
  static const scope = 'https://www.googleapis.com/auth/youtube.readonly';

  /// Kept under [prefKey] once signed in.
  static bool connected = false;
  static const prefKey = 'youtube.connected';

  static bool get available =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static var _ready = false;

  /// Google sign-in is set up once, for YouTube and for sync alike.
  static Future<void> init() async {
    if (_ready) return;
    await GoogleSignIn.instance.initialize(
      clientId: SyncConfig.iosClient,
      serverClientId: SyncConfig.iosClient != null
          ? SyncConfig.webClientId
          : serverClientId,
    );
    _ready = true;
  }

  /// A key to read your YouTube library: signs in (once) and asks for
  /// permission (once). null when you said no or it failed.
  /// Why the last sign-in failed, in Google's words. null when it worked
  /// or you cancelled.
  static String? lastError;

  static Future<String?> token({bool prompt = true}) async {
    lastError = null;
    try {
      await init();
      final account =
          await GoogleSignIn.instance.attemptLightweightAuthentication() ??
          (prompt
              ? await GoogleSignIn.instance.authenticate(
                  scopeHint: const [scope],
                )
              : null);
      if (account == null) return null;
      final client = account.authorizationClient;
      final auth =
          await client.authorizationForScopes(const [scope]) ??
          (prompt ? await client.authorizeScopes(const [scope]) : null);
      return auth?.accessToken;
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        lastError =
            '${e.code.name}${e.description == null ? '' : ': ${e.description}'}';
      }
      return null;
    } catch (e) {
      lastError = '$e';
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await init();
      await GoogleSignIn.instance.disconnect();
    } catch (_) {}
  }
}

/// Reads playlists and liked videos from the YouTube Data API.
class YouTubeLibrary {
  YouTubeLibrary(this.token, {http.Client? client, this.music = true})
    : _client = client ?? http.Client();

  final String token;
  final http.Client _client;

  /// Links open in YouTube Music, otherwise in YouTube.
  final bool music;

  String get _host =>
      music ? 'https://music.youtube.com' : 'https://www.youtube.com';

  Future<List<SpotifyItem>> playlists() => _get(
    'playlists?part=snippet,contentDetails&mine=true&maxResults=50',
    (j) {
      final id = j['id'] as String?;
      final sn = j['snippet'] as Map?;
      final name = sn?['title'] as String?;
      if (id == null || name == null || name.isEmpty) return null;
      final count = (j['contentDetails'] as Map?)?['itemCount'] as num?;
      return SpotifyItem(
        name: name,
        detail: count == null ? l10n.playlist : l10n.songCount(count.toInt()),
        url: '$_host/playlist?list=$id',
        image: _thumb(sn),
      );
    },
  );

  Future<List<SpotifyItem>> liked() =>
      _get('videos?part=snippet&myRating=like&maxResults=50', (j) {
        final id = j['id'] as String?;
        final sn = j['snippet'] as Map?;
        final name = sn?['title'] as String?;
        if (id == null || name == null || name.isEmpty) return null;
        final channel = (sn?['channelTitle'] as String? ?? '').replaceFirst(
          RegExp(r' - Topic$'),
          '',
        );
        return SpotifyItem(
          name: name,
          detail: channel,
          url: '$_host/watch?v=$id',
          image: _thumb(sn),
        );
      });

  /// Videos (songs) and playlists for anything you type.
  Future<List<SpotifyItem>> search(String query) {
    final q = Uri.encodeQueryComponent(query.trim());
    return _get('search?part=snippet&type=video,playlist&maxResults=25&q=$q', (
      j,
    ) {
      final id = j['id'] as Map?;
      final sn = j['snippet'] as Map?;
      final name = sn?['title'] as String?;
      if (id == null || name == null || name.isEmpty) return null;
      final channel = (sn?['channelTitle'] as String? ?? '').replaceFirst(
        RegExp(r' - Topic$'),
        '',
      );
      final video = id['videoId'] as String?;
      final list = id['playlistId'] as String?;
      if (video != null) {
        return SpotifyItem(
          name: _unescape(name),
          detail: channel,
          url: '$_host/watch?v=$video',
          image: _thumb(sn),
        );
      }
      if (list != null) {
        return SpotifyItem(
          name: _unescape(name),
          detail: '${l10n.playlist} · $channel',
          url: '$_host/playlist?list=$list',
          image: _thumb(sn),
        );
      }
      return null;
    });
  }

  /// Search titles come HTML-escaped ("Rock &amp; Roll").
  static String _unescape(String s) => s
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>');

  static String? _thumb(Map? sn) =>
      ((sn?['thumbnails'] as Map?)?['default'] as Map?)?['url'] as String?;

  /// Google's own words, e.g. "YouTube Data API v3 has not been used in
  /// project … or it is disabled", so the fix is clear.
  static String _why(String body) {
    try {
      final m = ((jsonDecode(body) as Map)['error'] as Map)['message'];
      return m is String && m.isNotEmpty ? '\n\n($m)' : '';
    } catch (_) {
      return '';
    }
  }

  Future<List<SpotifyItem>> _get(
    String path,
    SpotifyItem? Function(Map<String, dynamic>) parse,
  ) async {
    final r = await _client
        .get(
          Uri.parse('https://www.googleapis.com/youtube/v3/$path'),
          headers: {'Authorization': 'Bearer $token'},
        )
        .timeout(const Duration(seconds: 10));
    if (r.statusCode == 403) {
      throw Exception('${l10n.youTubeSaidNo}${_why(r.body)}');
    }
    if (r.statusCode != 200) {
      throw Exception(
        '${l10n.serviceDidntAnswer('YouTube', r.statusCode)}${_why(r.body)}',
      );
    }
    final items =
        (jsonDecode(r.body) as Map<String, dynamic>)['items'] as List? ??
        const [];
    return [
      for (final j in items)
        if (j is Map<String, dynamic>) ?parse(j),
    ];
  }
}
