import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../data/spotify_library.dart';
import '../domain/sound.dart';

import 'package:quando/l10n/l10n.dart';

/// Your playlists and liked songs from a music app, or a search of the
/// whole app: tap one to wake up to it, or open a playlist to pick one
/// song from it.
class MusicPickerScreen extends ConsumerStatefulWidget {
  const MusicPickerScreen({
    super.key,
    required this.title,
    required this.load,
    this.search,
    this.prepare,
    this.songsOf,
  });
  final Future<void> Function(SpotifyItem)? prepare;

  /// "My Spotify".
  final String title;

  /// Signs in if needed, then reads the library, one tab per shelf.
  final Future<List<MusicShelf>> Function() load;

  /// The songs in a playlist. When set, playlists open to pick one song.
  final Future<List<SpotifyItem>> Function(SpotifyItem playlist)? songsOf;

  /// Searches the whole app for songs and playlists.
  final Future<List<SpotifyItem>> Function(String query)? search;

  @override
  ConsumerState<MusicPickerScreen> createState() => _MusicPickerScreenState();
}

class _MusicPickerScreenState extends ConsumerState<MusicPickerScreen> {
  bool _picking = false;
  List<MusicShelf>? _shelves;
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
      final shelves = await widget.load();
      if (mounted) setState(() => _shelves = shelves);
    } catch (e) {
      if (mounted) setState(() => _error = '$e'.replaceFirst('Exception: ', ''));
    }
  }

  /// Opens a playlist: the whole playlist first, then each song.
  Future<void> _open(SpotifyItem playlist) async {
    final picked = await Navigator.of(context).push<SpotifyItem>(
      MaterialPageRoute(
        builder: (_) => PlaylistSongsScreen(playlist: playlist, songs: () => widget.songsOf!(playlist)),
      ),
    );
    if (picked != null && mounted) await _pick(picked);
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
        final opens = widget.songsOf != null && it.playlistId != null;
        return MusicItemTile(
          item: it,
          trailing: opens
              ? const Icon(Icons.chevron_right)
              : const Icon(Icons.add_circle_outline, color: QuandoColors.amber),
          onTap: () => opens ? _open(it) : _pick(it),
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
    final shelves = _shelves;
    final tabs = !searching && shelves != null && shelves.length > 1;
    return DefaultTabController(
      key: ValueKey(shelves?.length),
      length: shelves?.length ?? 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight((searchBar == null ? 0 : 56) + (tabs ? 48 : 0)),
            child: Column(
              children: [
                ?searchBar,
                if (tabs)
                  TabBar(
                    isScrollable: shelves.length > 2,
                    tabAlignment: shelves.length > 2 ? TabAlignment.start : null,
                    tabs: [for (final s in shelves) Tab(text: s.label)],
                  ),
              ],
            ),
          ),
        ),
        body: searching
            ? _list(_results, l10n.nothingFound(_searched!), error: _searchError)
            : shelves == null || shelves.length < 2
            ? _list(shelves?.firstOrNull?.items, shelves?.firstOrNull?.empty ?? '', error: _error)
            : TabBarView(children: [for (final s in shelves) _list(s.items, s.empty)]),
      ),
    );
  }
}

/// A song or playlist: its cover, name and artist.
class MusicItemTile extends StatelessWidget {
  const MusicItemTile({super.key, required this.item, required this.trailing, required this.onTap});
  final SpotifyItem item;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox.square(
        dimension: 48,
        child: item.image == null
            ? const ColoredBox(
                color: QuandoColors.raised,
                child: Icon(Icons.music_note, color: QuandoColors.amber),
              )
            : Image.network(
                item.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(color: QuandoColors.raised),
              ),
      ),
    ),
    title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
    subtitle: Text(
      item.detail,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall,
    ),
    trailing: trailing,
    onTap: onTap,
  );
}

/// One playlist, opened: wake up to all of it, or to one song. Pops with
/// the chosen item.
class PlaylistSongsScreen extends StatefulWidget {
  const PlaylistSongsScreen({super.key, required this.playlist, required this.songs});
  final SpotifyItem playlist;
  final Future<List<SpotifyItem>> Function() songs;

  @override
  State<PlaylistSongsScreen> createState() => _PlaylistSongsScreenState();
}

class _PlaylistSongsScreenState extends State<PlaylistSongsScreen> {
  List<SpotifyItem>? _songs;
  String? _error;

  @override
  void initState() {
    super.initState();
    widget.songs().then(
      (songs) => mounted ? setState(() => _songs = songs) : null,
      onError: (Object e) => mounted ? setState(() => _error = '$e'.replaceFirst('Exception: ', '')) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final songs = _songs;
    const add = Icon(Icons.add_circle_outline, color: QuandoColors.amber);
    return Scaffold(
      appBar: AppBar(title: Text(widget.playlist.name, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          ListTile(
            key: const ValueKey('whole-playlist'),
            leading: const SizedBox.square(
              dimension: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: QuandoColors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(Icons.queue_music, color: QuandoColors.ground),
              ),
            ),
            title: Text(l10n.wholePlaylist, style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(widget.playlist.detail, style: text.bodySmall),
            trailing: add,
            onTap: () => Navigator.of(context).pop(widget.playlist),
          ),
          const Divider(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText(_error!, textAlign: TextAlign.center, style: text.bodyLarge),
            )
          else if (songs == null)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (songs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.noSongsInPlaylist, textAlign: TextAlign.center, style: text.bodyLarge),
            )
          else
            for (final song in songs)
              MusicItemTile(item: song, trailing: add, onTap: () => Navigator.of(context).pop(song)),
        ],
      ),
    );
  }
}
