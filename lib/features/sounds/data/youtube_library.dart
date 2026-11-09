import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../app/edition.dart';
import '../../sync/sync_config.dart';
import 'spotify_library.dart';

import 'package:quando/l10n/l10n.dart';

/// YouTube and YouTube Music: sign in with Google and read your playlists
/// and liked videos (liked songs in YouTube Music are among them).
class YouTubeAccount {
  /// Quando's web client in Google Cloud (not a secret).
  static const serverClientId = '299909596314-e9loi4jur2h3aqki3csa0h7h2s0rjrn5.apps.googleusercontent.com';
  static const scope = 'https://www.googleapis.com/auth/youtube.readonly';

  /// Kept under [prefKey] once signed in.
  static bool connected = false;
  static const prefKey = 'youtube.connected';

  static bool get available =>
      !kIsWeb &&
      {TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.macOS}.contains(defaultTargetPlatform);

  static var _ready = false;

  /// Google sign-in is set up once, for YouTube and for sync alike.
  static Future<void> init() async {
    if (_ready) return;
    await GoogleSignIn.instance.initialize(
      clientId: SyncConfig.iosClient,
      serverClientId: SyncConfig.iosClient != null || mine ? SyncConfig.webClientId : serverClientId,
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
          (prompt ? await GoogleSignIn.instance.authenticate(scopeHint: const [scope]) : null);
      if (account == null) return null;
      final client = account.authorizationClient;
      final auth =
          await client.authorizationForScopes(const [scope]) ??
          (prompt ? await client.authorizeScopes(const [scope]) : null);
      return auth?.accessToken;
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        lastError = '${e.code.name}${e.description == null ? '' : ': ${e.description}'}';
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
  YouTubeLibrary(this.token, {http.Client? client, this.music = true}) : _client = client ?? http.Client();

  final String token;
  final http.Client _client;

  /// Links open in YouTube Music, otherwise in YouTube.
  final bool music;

  String get _host => music ? 'https://music.youtube.com' : 'https://www.youtube.com';

  Future<List<SpotifyItem>> playlists() =>
      _get('playlists?part=snippet,contentDetails&mine=true&maxResults=50', (j) {
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
          playlistId: id,
        );
      });

  /// YouTube's "Music" category.
  static const musicCategory = '10';

  /// Your playlists, split into music and videos: YouTube keeps both in one
  /// list, so a few videos from each playlist are looked at. A playlist is
  /// music when most of them are. Video playlists open in YouTube.
  Future<({List<SpotifyItem> music, List<SpotifyItem> videos})> sortedPlaylists() async {
    final all = await playlists();
    final samples = <List<String>>[];
    for (var i = 0; i < all.length; i += 10) {
      samples.addAll(
        await Future.wait([
          for (final p in all.skip(i).take(10))
            _sample(p.playlistId!).catchError((Object _) => const <String>[]),
        ]),
      );
    }
    final categories = await _categories({for (final s in samples) ...s}.toList());
    final music = <SpotifyItem>[], videos = <SpotifyItem>[];
    for (var i = 0; i < all.length; i++) {
      final known = [for (final v in samples[i]) ?categories[v]];
      final songs = known.where((c) => c == musicCategory).length;
      if (known.isEmpty || songs * 2 >= known.length) {
        music.add(all[i]);
      } else {
        videos.add(all[i].withUrl('https://www.youtube.com/playlist?list=${all[i].playlistId}'));
      }
    }
    return (music: music, videos: videos);
  }

  Future<List<String>> _sample(String id) async {
    final items = await _get('playlistItems?part=contentDetails&maxResults=5&playlistId=$id', (j) {
      final video = (j['contentDetails'] as Map?)?['videoId'];
      return video is String ? SpotifyItem(name: '', detail: '', url: video) : null;
    }, allPages: false);
    return [for (final i in items) i.url];
  }

  /// Each video's category, 50 at a time.
  Future<Map<String, String>> _categories(List<String> ids) async {
    final out = <String, String>{};
    for (var i = 0; i < ids.length; i += 50) {
      final batch = ids.skip(i).take(50).join(',');
      await _get('videos?part=snippet&maxResults=50&id=$batch', (j) {
        final id = j['id'], cat = (j['snippet'] as Map?)?['categoryId'];
        if (id is String && cat is String) out[id] = cat;
        return null;
      }, allPages: false);
    }
    return out;
  }

  /// Your liked videos, split into songs (YouTube's Music category, which
  /// is where YouTube Music likes land) and everything else.
  Future<({List<SpotifyItem> songs, List<SpotifyItem> videos})> sortedLiked() async {
    final songs = <SpotifyItem>[], videos = <SpotifyItem>[];
    await _get('videos?part=snippet&myRating=like&maxResults=50', (j) {
      final item = _liked(j);
      if (item == null) return null;
      if ((j['snippet'] as Map?)?['categoryId'] == musicCategory) {
        songs.add(item);
      } else {
        videos.add(item.withUrl(item.url.replaceFirst(_host, 'https://www.youtube.com')));
      }
      return null;
    });
    return (songs: songs, videos: videos);
  }

  /// The songs in one of your playlists, in order (the first 500), so you
  /// can wake up to just one of them. Deleted and private videos are left
  /// out.
  Future<List<SpotifyItem>> playlistSongs(String id, {bool music = true}) async {
    if (!RegExp(r'^[A-Za-z0-9_-]{1,150}$').hasMatch(id)) throw ArgumentError.value(id, 'playlist');
    final host = music ? _host : 'https://www.youtube.com';
    final items = await _get('playlistItems?part=snippet&maxResults=50&playlistId=$id', (j) {
      final sn = j['snippet'] as Map?;
      final video = (sn?['resourceId'] as Map?)?['videoId'];
      final name = sn?['title'] as String?;
      final owner = sn?['videoOwnerChannelTitle'] as String?;
      // Deleted and private videos have no owner.
      if (video is! String || name == null || name.isEmpty || owner == null) return null;
      return SpotifyItem(
        name: name,
        detail: owner.replaceFirst(RegExp(r' - Topic$'), ''),
        url: '$host/watch?v=$video',
        image: _thumb(sn),
      );
    }, limit: 500);
    return items;
  }

  Future<List<SpotifyItem>> liked() => _get('videos?part=snippet&myRating=like&maxResults=50', _liked);

  SpotifyItem? _liked(Map<String, dynamic> j) {
    final id = j['id'] as String?;
    final sn = j['snippet'] as Map?;
    final name = sn?['title'] as String?;
    if (id == null || name == null || name.isEmpty) return null;
    final channel = (sn?['channelTitle'] as String? ?? '').replaceFirst(RegExp(r' - Topic$'), '');
    return SpotifyItem(name: name, detail: channel, url: '$_host/watch?v=$id', image: _thumb(sn));
  }

  /// Resolve the signed-in user's playlist through the official Data API.
  /// Only video IDs reach the IFrame player; the OAuth token stays in Dart.
  Future<List<String>> playlistVideos(String id) async {
    if (!RegExp(r'^[A-Za-z0-9_-]{1,150}$').hasMatch(id)) throw ArgumentError.value(id, 'playlist');
    final items = await _get('playlistItems?part=contentDetails&maxResults=50&playlistId=$id', (j) {
      final video = (j['contentDetails'] as Map?)?['videoId'];
      if (video is! String || !RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(video)) return null;
      return SpotifyItem(name: '', detail: '', url: video);
    });
    return items.map((item) => item.url).toList();
  }

  /// Videos (songs) and playlists for anything you type.
  Future<List<SpotifyItem>> search(String query) {
    final q = Uri.encodeQueryComponent(query.trim());
    return _get('search?part=snippet&type=video,playlist&maxResults=25&q=$q', (j) {
      final id = j['id'] as Map?;
      final sn = j['snippet'] as Map?;
      final name = sn?['title'] as String?;
      if (id == null || name == null || name.isEmpty) return null;
      final channel = (sn?['channelTitle'] as String? ?? '').replaceFirst(RegExp(r' - Topic$'), '');
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
          playlistId: list,
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

  static String? _thumb(Map? sn) => ((sn?['thumbnails'] as Map?)?['default'] as Map?)?['url'] as String?;

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
    SpotifyItem? Function(Map<String, dynamic>) parse, {
    bool allPages = true,
    int? limit,
  }) async {
    var uri = Uri.parse('https://www.googleapis.com/youtube/v3/$path');
    final out = <SpotifyItem>[], pages = <String>{};
    do {
      final r = await _client
          .get(uri, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 10));
      if (r.statusCode == 403) throw Exception('${l10n.youTubeSaidNo}${_why(r.body)}');
      if (r.statusCode != 200) {
        throw Exception('${l10n.serviceDidntAnswer('YouTube', r.statusCode)}${_why(r.body)}');
      }
      final data = jsonDecode(r.body) as Map<String, dynamic>;
      for (final j in data['items'] as List? ?? const []) {
        if (j is Map<String, dynamic>) {
          final item = parse(j);
          if (item != null) out.add(item);
        }
      }
      final next = data['nextPageToken'] as String?;
      if (next == null || next.isEmpty || !pages.add(next)) break;
      // Search stays deliberately small; playlist/liked collections are complete.
      if (!allPages || uri.path.endsWith('/search')) break;
      if (limit != null && out.length >= limit) break;
      uri = uri.replace(queryParameters: {...uri.queryParameters, 'pageToken': next});
    } while (true);
    return out;
  }

  void close() => _client.close();
}
