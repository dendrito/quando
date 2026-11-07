import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../data/spotify_library.dart';
import '../domain/sound.dart';

import 'package:quando/l10n/l10n.dart';

/// Your playlists and liked songs from a music app, or a search of the
/// whole app: tap one to wake up to it.
class MusicPickerScreen extends ConsumerStatefulWidget {
  const MusicPickerScreen({
    super.key,
    required this.title,
    required this.load,
    this.search,
    this.songs = false,
    this.prepare,
  });
  final bool songs;
  final Future<void> Function(SpotifyItem)? prepare;

  /// "My Spotify".
  final String title;

  /// Signs in if needed, then reads playlists and liked songs.
  final Future<(List<SpotifyItem>, List<SpotifyItem>)> Function() load;

  /// Searches the whole app for songs and playlists.
  final Future<List<SpotifyItem>> Function(String query)? search;

  @override
  ConsumerState<MusicPickerScreen> createState() => _MusicPickerScreenState();
}

class _MusicPickerScreenState extends ConsumerState<MusicPickerScreen> {
  bool _picking = false;
  List<SpotifyItem>? _playlists;
  List<SpotifyItem>? _liked;
  String? _error;

  final _query = TextEditingController();

  /// The search being shown, its results (null while loading) and error.
  String? _searched;
  List<SpotifyItem>? _results;
  String? _searchError;
  var _searchRun = 0;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _search(String q) async {
    final query = q.trim();
    if (query.isEmpty) {
      _clearSearch();
      return;
    }
    final run = ++_searchRun;
    setState(() {
      _searched = query;
      _results = null;
      _searchError = null;
    });
    try {
      final found = await widget.search!(query);
      if (mounted && run == _searchRun) setState(() => _results = found);
    } catch (e) {
      if (mounted && run == _searchRun) setState(() => _searchError = '$e'.replaceFirst('Exception: ', ''));
    }
  }

  void _clearSearch() {
    _searchRun++;
    _query.clear();
    setState(() {
      _searched = null;
      _results = null;
      _searchError = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final (playlists, liked) = await widget.load();
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

  Future<void> _pick(SpotifyItem item) async {
    if (_picking) return;
    _picking = true;
    try {
      await widget.prepare?.call(item);
    } catch (e) {
      _picking = false;
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      return;
    }
    if (!mounted) return;
    final sound = AlarmSound(
      id: 'link.${DateTime.now().millisecondsSinceEpoch}',
      name: item.name,
      path: AlarmSound.builtIns[1].path,
      link: item.url,
      plays: true,
    );
    ref.read(soundsProvider.notifier).add(sound);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.musicAdded(item.name))));
    Navigator.of(context).pop();
  }

  Widget _list(List<SpotifyItem>? items, String empty, {String? error}) {
    final text = Theme.of(context).textTheme;
    if (error != null) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: SelectableText(error, textAlign: TextAlign.center, style: text.bodyLarge),
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
    final searching = _searched != null;
    final searchBar = widget.search == null
        ? null
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _query,
              textInputAction: TextInputAction.search,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: l10n.searchSongsHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searching
                    ? IconButton(icon: const Icon(Icons.close), tooltip: l10n.cancel, onPressed: _clearSearch)
                    : null,
                isDense: true,
              ),
            ),
          );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight((searchBar == null ? 0 : 56) + (searching ? 0 : 48)),
            child: Column(
              children: [
                ?searchBar,
                if (!searching)
                  TabBar(
                    tabs: [
                      Tab(text: l10n.playlists),
                      Tab(text: widget.songs ? l10n.musicSongs : l10n.likedSongs),
                    ],
                  ),
              ],
            ),
          ),
        ),
        body: searching
            ? _list(_results, l10n.nothingFound(_searched!), error: _searchError)
            : TabBarView(
                children: [
                  _list(_playlists, l10n.noPlaylists, error: _error),
                  _list(_liked, widget.songs ? l10n.noMusicSongs : l10n.noLikedSongs, error: _error),
                ],
              ),
      ),
    );
  }
}
