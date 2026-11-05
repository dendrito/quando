import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quando/l10n/l10n.dart';

/// A playlist or song from your Spotify library.
class SpotifyItem {
  const SpotifyItem({required this.name, required this.detail, required this.url, this.image});

  final String name;

  /// "32 songs" or the artist.
  final String detail;

  /// The open.spotify.com link, as a song link stores it.
  final String url;
  final String? image;

  static String? _image(Object? images) =>
      images is List && images.isNotEmpty ? (images.last as Map)['url'] as String? : null;

  static SpotifyItem? playlist(Map<String, dynamic> j) {
    final url = (j['external_urls'] as Map?)?['spotify'] as String?;
    final name = j['name'] as String?;
    if (url == null || name == null || name.isEmpty) return null;
    final count = ((j['tracks'] ?? j['items']) as Map?)?['total'] as num?;
    return SpotifyItem(
      name: name,
      detail: count == null ? l10n.playlist : l10n.songCount(count.toInt()),
      url: url,
      image: _image(j['images']),
    );
  }

  static SpotifyItem? track(Map<String, dynamic> j) {
    final t = (j['track'] ?? j) as Map<String, dynamic>;
    final url = (t['external_urls'] as Map?)?['spotify'] as String?;
    final name = t['name'] as String?;
    if (url == null || name == null || name.isEmpty) return null;
    final artists = [for (final a in (t['artists'] as List? ?? const [])) (a as Map)['name']].join(', ');
    return SpotifyItem(name: name, detail: artists, url: url, image: _image((t['album'] as Map?)?['images']));
  }
}

/// Reads your playlists and liked songs from Spotify's Web API.
class SpotifyLibrary {
  SpotifyLibrary(this.token, {http.Client? client}) : _client = client ?? http.Client();

  final String token;
  final http.Client _client;

  Future<List<SpotifyItem>> playlists() => _get('/v1/me/playlists?limit=50', SpotifyItem.playlist);

  Future<List<SpotifyItem>> likedSongs() => _get('/v1/me/tracks?limit=50', SpotifyItem.track);

  /// Songs first, then playlists, for anything you type.
  Future<List<SpotifyItem>> search(String query) async {
    final q = Uri.encodeQueryComponent(query.trim());
    final j = await _fetch('/v1/search?type=track,playlist&limit=10&q=$q');
    return [..._items(j['tracks'], SpotifyItem.track), ..._items(j['playlists'], SpotifyItem.playlist)];
  }

  Future<List<SpotifyItem>> _get(String path, SpotifyItem? Function(Map<String, dynamic>) parse) async =>
      _items(await _fetch(path), parse);

  static List<SpotifyItem> _items(Object? page, SpotifyItem? Function(Map<String, dynamic>) parse) {
    final items = (page is Map ? page['items'] : null) as List? ?? const [];
    return [
      for (final j in items)
        if (j is Map<String, dynamic>) ?parse(j),
    ];
  }

  Future<Map<String, dynamic>> _fetch(String path) async {
    final r = await _client
        .get(Uri.parse('https://api.spotify.com$path'), headers: {'Authorization': 'Bearer $token'})
        .timeout(const Duration(seconds: 10));
    final body = _json(r.body);
    if (r.statusCode == 403) {
      throw Exception('${l10n.spotifySaidNo}${_why(body)}');
    }
    if (r.statusCode != 200) {
      throw Exception('${l10n.serviceDidntAnswer('Spotify', r.statusCode)}${_why(body)}');
    }
    return body;
  }

  static Map<String, dynamic> _json(String body) {
    try {
      final j = jsonDecode(body);
      return j is Map<String, dynamic> ? j : const {};
    } catch (_) {
      return const {};
    }
  }

  /// Spotify's own words, e.g. "User not registered in the Developer
  /// Dashboard", so the fix is clear.
  static String _why(Map<String, dynamic> body) {
    final e = body['error'];
    final m = e is Map ? e['message'] : e;
    return m is String && m.isNotEmpty ? '\n\n($m)' : '';
  }
}
