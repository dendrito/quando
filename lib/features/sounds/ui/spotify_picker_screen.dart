import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../ringing/data/spotify.dart';
import '../data/spotify_library.dart';
import '../domain/sound.dart';

/// Your Spotify playlists and liked songs: tap one to wake up to it.
class SpotifyPickerScreen extends ConsumerStatefulWidget {
  const SpotifyPickerScreen({super.key, this.library});

  /// For tests; otherwise signs in to Spotify.
  final SpotifyLibrary? library;

  @override
  ConsumerState<SpotifyPickerScreen> createState() => _SpotifyPickerScreenState();
}

class _SpotifyPickerScreenState extends ConsumerState<SpotifyPickerScreen> {
  List<SpotifyItem>? _playlists;
  List<SpotifyItem>? _liked;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      var lib = widget.library;
      if (lib == null) {
        final token = await SpotifyPlay.libraryToken();
        if (token == null) throw Exception('Couldn\'t sign in to Spotify.');
        lib = SpotifyLibrary(token);
      }
      final playlists = await lib.playlists();
      final liked = await lib.likedSongs();
      if (mounted) {
        setState(() {
          _playlists = playlists;
          _liked = liked;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = '$e'.replaceFirst('Exception: ', ''));
    }
  }

  void _pick(SpotifyItem item) {
    final sound = AlarmSound(
      id: 'link.${DateTime.now().millisecondsSinceEpoch}',
      name: item.name,
      path: AlarmSound.builtIns[1].path,
      link: item.url,
      plays: true,
    );
    ref.read(soundsProvider.notifier).add(sound);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${item.name} added. Pick it as the sound for any alarm.')));
    Navigator.of(context).pop();
  }

  Widget _list(List<SpotifyItem>? items, String empty) {
    final text = Theme.of(context).textTheme;
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(_error!, textAlign: TextAlign.center, style: text.bodyLarge),
        ),
      );
    }
    if (items == null) return const Center(child: CircularProgressIndicator());
    if (items.isEmpty) return Center(child: Text(empty, style: text.bodyLarge));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final it = items[i];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox.square(
              dimension: 48,
              child: it.image == null
                  ? const ColoredBox(
                      color: QuandoColors.raised,
                      child: Icon(Icons.music_note, color: QuandoColors.amber),
                    )
                  : Image.network(
                      it.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const ColoredBox(color: QuandoColors.raised),
                    ),
            ),
          ),
          title: Text(it.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(it.detail, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.bodySmall),
          trailing: const Icon(Icons.add_circle_outline, color: QuandoColors.amber),
          onTap: () => _pick(it),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Spotify'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Liked songs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_list(_playlists, 'No playlists yet.'), _list(_liked, 'No liked songs yet.')],
        ),
      ),
    );
  }
}
