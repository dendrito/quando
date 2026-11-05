import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/features/sounds/data/spotify_library.dart';
import 'package:quando/features/sounds/data/youtube_library.dart';

void main() {
  test('Spotify search lists songs, then playlists, and skips gaps', () async {
    late Uri asked;
    final lib = SpotifyLibrary(
      'key',
      client: MockClient((req) async {
        asked = req.url;
        return http.Response(
          jsonEncode({
            'tracks': {
              'items': [
                {
                  'name': 'Here Comes the Sun',
                  'external_urls': {'spotify': 'https://open.spotify.com/track/abc'},
                  'artists': [
                    {'name': 'The Beatles'},
                  ],
                },
              ],
            },
            'playlists': {
              'items': [
                null,
                {
                  'name': 'Morning',
                  'external_urls': {'spotify': 'https://open.spotify.com/playlist/xyz'},
                  'items': {'total': 12},
                },
              ],
            },
          }),
          200,
        );
      }),
    );
    final found = await lib.search('here comes the sun ');
    expect(asked.path, '/v1/search');
    expect(asked.queryParameters['q'], 'here comes the sun');
    expect(found.map((f) => f.name), ['Here Comes the Sun', 'Morning']);
    expect(found.first.detail, 'The Beatles');
    expect(found.last.url, 'https://open.spotify.com/playlist/xyz');
  });

  test("Spotify's own reason shows when it says no", () async {
    final lib = SpotifyLibrary(
      'key',
      client: MockClient(
        (_) async => http.Response(
          jsonEncode({
            'error': {'status': 403, 'message': 'User not registered in the Developer Dashboard'},
          }),
          403,
        ),
      ),
    );
    expect(
      () => lib.playlists(),
      throwsA(predicate((e) => '$e'.contains('User not registered in the Developer Dashboard'))),
    );
  });

  test('YouTube search finds songs and playlists with readable titles', () async {
    final lib = YouTubeLibrary(
      'key',
      client: MockClient(
        (req) async => http.Response(
          jsonEncode({
            'items': [
              {
                'id': {'kind': 'youtube#video', 'videoId': 'v1'},
                'snippet': {'title': 'Rock &amp; Roll', 'channelTitle': 'Led Zeppelin - Topic'},
              },
              {
                'id': {'kind': 'youtube#playlist', 'playlistId': 'p1'},
                'snippet': {'title': 'Wake up', 'channelTitle': 'Me'},
              },
              {
                'id': {'kind': 'youtube#channel', 'channelId': 'c1'},
                'snippet': {'title': 'A channel'},
              },
            ],
          }),
          200,
        ),
      ),
    );
    final found = await lib.search('rock');
    expect(found.map((f) => f.name), ['Rock & Roll', 'Wake up']);
    expect(found.first.detail, 'Led Zeppelin');
    expect(found.first.url, 'https://music.youtube.com/watch?v=v1');
    expect(found.last.url, 'https://music.youtube.com/playlist?list=p1');
  });
}
