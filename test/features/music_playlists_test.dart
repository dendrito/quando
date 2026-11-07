import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/sounds/data/spotify_library.dart';
import 'package:quando/features/sounds/data/youtube_library.dart';
import 'package:quando/features/sounds/ui/music_picker_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

http.Response _json(Object body) => http.Response(jsonEncode(body), 200);

Map<String, dynamic> _track(String name, String id) => {
  'type': 'track',
  'name': name,
  'external_urls': {'spotify': 'https://open.spotify.com/track/$id'},
  'artists': [
    {'name': 'Gil'},
  ],
};

void main() {
  test('Spotify opens a playlist page by page and skips podcasts and gaps', () async {
    final asked = <String>[];
    final lib = SpotifyLibrary(
      'key',
      client: MockClient((req) async {
        asked.add(req.url.toString());
        if (req.url.queryParameters['offset'] == null) {
          return _json({
            'items': [
              {'item': _track('Aquele Abraço', 'a')},
              {'item': null},
              {
                'item': {
                  'type': 'episode',
                  'name': 'A podcast',
                  'external_urls': {'spotify': 'x'},
                },
              },
            ],
            'next': 'https://api.spotify.com/v1/playlists/p1/items?offset=100&limit=100',
          });
        }
        return _json({
          'items': [
            {'track': _track('Toda Menina Baiana', 'b')},
          ],
          'next': null,
        });
      }),
    );
    final songs = await lib.playlistSongs('p1');
    expect(songs.map((s) => s.name), ['Aquele Abraço', 'Toda Menina Baiana']);
    expect(songs.first.url, 'https://open.spotify.com/track/a');
    expect(asked, hasLength(2));
    expect(Uri.parse(asked.first).path, '/v1/playlists/p1/items');
  });

  test('Spotify falls back to the older playlist tracks list', () async {
    final lib = SpotifyLibrary(
      'key',
      client: MockClient(
        (req) async => req.url.path.endsWith('/items')
            ? http.Response('{}', 404)
            : _json({
                'items': [
                  {'track': _track('Andar com Fé', 'c')},
                ],
              }),
      ),
    );
    expect((await lib.playlistSongs('p1')).single.name, 'Andar com Fé');
  });

  test('Spotify playlists remember their id so they can be opened', () {
    final p = SpotifyItem.playlist({
      'id': 'p9',
      'name': 'Morning',
      'external_urls': {'spotify': 'https://open.spotify.com/playlist/p9'},
    });
    expect(p!.playlistId, 'p9');
  });

  test('YouTube sorts playlists into music and videos by what is in them', () async {
    final lib = YouTubeLibrary(
      'key',
      client: MockClient((req) async {
        final q = req.url.queryParameters;
        switch (req.url.pathSegments.last) {
          case 'playlists':
            return _json({
              'items': [
                for (final (id, name) in [
                  ('PLsongs', 'Morning songs'),
                  ('PLtalks', 'Talks'),
                  ('PLempty', 'New'),
                ])
                  {
                    'id': id,
                    'snippet': {'title': name},
                    'contentDetails': {'itemCount': 3},
                  },
              ],
            });
          case 'playlistItems':
            final ids = switch (q['playlistId']) {
              'PLsongs' => ['s1', 's2', 'v1'],
              'PLtalks' => ['v2', 'v3'],
              _ => <String>[],
            };
            expect(q['maxResults'], '5');
            return _json({
              'items': [
                for (final id in ids)
                  {
                    'contentDetails': {'videoId': id},
                  },
              ],
              'nextPageToken': 'more',
            });
          case 'videos':
            final ids = q['id']!.split(',');
            return _json({
              'items': [
                for (final id in ids)
                  {
                    'id': id,
                    'snippet': {'categoryId': id.startsWith('s') ? '10' : '27'},
                  },
              ],
            });
        }
        return http.Response('', 404);
      }),
    );
    final sorted = await lib.sortedPlaylists();
    expect(sorted.music.map((p) => p.name), ['Morning songs', 'New']);
    expect(sorted.videos.single.name, 'Talks');
    expect(sorted.videos.single.url, 'https://www.youtube.com/playlist?list=PLtalks');
    expect(sorted.music.first.url, 'https://music.youtube.com/playlist?list=PLsongs');
    expect(sorted.music.first.playlistId, 'PLsongs');
  });

  test('YouTube liked videos split into songs and videos', () async {
    final lib = YouTubeLibrary(
      'key',
      client: MockClient(
        (_) async => _json({
          'items': [
            {
              'id': 'song1',
              'snippet': {
                'title': 'Garota de Ipanema',
                'channelTitle': 'Tom Jobim - Topic',
                'categoryId': '10',
              },
            },
            {
              'id': 'vid1',
              'snippet': {'title': 'How to bake bread', 'channelTitle': 'Baker', 'categoryId': '26'},
            },
          ],
        }),
      ),
    );
    final liked = await lib.sortedLiked();
    expect(liked.songs.single.detail, 'Tom Jobim');
    expect(liked.songs.single.url, 'https://music.youtube.com/watch?v=song1');
    expect(liked.videos.single.url, 'https://www.youtube.com/watch?v=vid1');
  });

  test('YouTube playlist songs leave out deleted and private videos', () async {
    final lib = YouTubeLibrary(
      'key',
      client: MockClient(
        (_) async => _json({
          'items': [
            {
              'snippet': {
                'title': 'Mas Que Nada',
                'videoOwnerChannelTitle': 'Jorge Ben Jor - Topic',
                'resourceId': {'videoId': 'abc'},
              },
            },
            {
              'snippet': {
                'title': 'Deleted video',
                'resourceId': {'videoId': 'gone'},
              },
            },
          ],
        }),
      ),
    );
    final songs = await lib.playlistSongs('PLx');
    expect(songs.single.name, 'Mas Que Nada');
    expect(songs.single.detail, 'Jorge Ben Jor');
    expect(songs.single.url, 'https://music.youtube.com/watch?v=abc');
    expect((await lib.playlistSongs('PLx', music: false)).single.url, 'https://www.youtube.com/watch?v=abc');
  });

  testWidgets('a playlist opens to wake up to one of its songs', (tester) async {
    useLocale([const Locale('en')]);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    const playlist = SpotifyItem(
      name: 'Morning songs',
      detail: '2 songs',
      url: 'https://music.youtube.com/playlist?list=PL1',
      playlistId: 'PL1',
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MusicPickerScreen(
                    title: 'My YouTube',
                    load: () async => [
                      MusicShelf(l10n.musicPlaylists, [playlist], empty: ''),
                      MusicShelf(l10n.likedSongs, const [], empty: l10n.noLikedSongs),
                      const MusicShelf('Video playlists', [], empty: ''),
                    ],
                    songsOf: (p) async => [
                      const SpotifyItem(
                        name: 'Mas Que Nada',
                        detail: 'Jorge Ben Jor',
                        url: 'https://music.youtube.com/watch?v=abc',
                      ),
                    ],
                  ),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.musicPlaylists), findsOneWidget);
    expect(find.text('Video playlists'), findsOneWidget);
    await tester.tap(find.text('Morning songs'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.wholePlaylist), findsOneWidget);
    await tester.tap(find.text('Mas Que Nada'));
    await tester.pumpAndSettle();
    final added = c.read(soundsProvider).where((s) => s.isLink).single;
    expect(added.link, 'https://music.youtube.com/watch?v=abc');
    expect(added.name, 'Mas Que Nada');
    expect(find.text('open'), findsOneWidget);
  });
}
