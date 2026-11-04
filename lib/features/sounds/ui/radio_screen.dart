import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/edition.dart';
import '../data/radio_directory.dart';
import '../domain/sound.dart';
import 'sound_player.dart';

import 'package:quando/l10n/l10n.dart';

/// Browse radio by genre and country, tap a station to hear it, and use it
/// as an alarm sound. Search by name and pasting a stream are in the top
/// bar.
class RadioScreen extends ConsumerStatefulWidget {
  const RadioScreen({super.key, this.directory, this.countryCode});

  final RadioDirectory? directory;

  /// Where to start browsing. null = the phone's country.
  final String? countryCode;

  @override
  ConsumerState<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends ConsumerState<RadioScreen> {
  late final _directory = widget.directory ?? RadioDirectory();
  final _query = TextEditingController();
  String? _genre;
  late String? _country = _startCountry();
  var _searching = false;
  List<RadioStation>? _results;
  RadioStation? _picked;
  String? _error;
  var _busy = false;

  String? _startCountry() {
    final code = widget.countryCode ?? PlatformDispatcher.instance.locale.countryCode;
    return radioCountries.any((c) => c.$2 == code) ? code : null;
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    SoundPreview.instance.stop();
    _query.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final name = _searching ? _query.text.trim() : '';
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      // Nothing chosen: the world's most listened.
      final r = name.isEmpty && _genre == null && _country == null
          ? await _directory.search('', tag: kodesh ? 'jewish' : 'pop')
          : await _directory.search(name, tag: _genre, countryCode: _country);
      if (mounted) setState(() => _results = r);
    } catch (_) {
      if (mounted) setState(() => _error = l10n.radioUnreachable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  AlarmSound _sound(String name, String url) =>
      AlarmSound(id: 'radio.${url.hashCode.toUnsigned(32)}', name: name, path: url);

  /// Tap once to pick and hear it, again to stop it.
  Future<void> _tap(RadioStation r) async {
    final s = _sound(r.name, r.url);
    final p = SoundPreview.instance;
    if (_picked?.url == r.url && p.playingId == s.id) {
      await p.stop();
    } else {
      setState(() => _picked = r);
      await p.play(s, onDone: () => mounted ? setState(() {}) : null);
    }
    if (mounted) setState(() {});
  }

  void _add(AlarmSound s) {
    final notifier = ref.read(soundsProvider.notifier);
    if (!ref.read(soundsProvider).any((x) => x.id == s.id)) notifier.add(s);
    SoundPreview.instance.stop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.musicAdded(s.name))));
    Navigator.of(context).pop();
  }

  Future<void> _paste() async {
    final c = TextEditingController();
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addStreamAddress),
        content: TextField(
          controller: c,
          autofocus: true,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(hintText: 'https://stream.example.com/live.mp3'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, c.text.trim()), child: Text(l10n.add)),
        ],
      ),
    );
    c.dispose();
    if (url == null || !mounted) return;
    if (!isStreamUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.notAStream)));
      return;
    }
    _add(_sound(Uri.parse(url).host.replaceFirst('www.', ''), url));
  }

  /// A list to pick one genre or country from, or "any".
  Future<void> _choose(
    String title,
    List<(String, String)> options,
    String? current,
    void Function(String?) set,
  ) async {
    final picked = await showModalBottomSheet<(String?,)>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (context, scroll) => ListView(
          controller: scroll,
          children: [
            ListTile(
              title: Text(title == 'genre' ? l10n.anyGenre : l10n.anywhere),
              leading: Icon(
                current == null ? Icons.radio_button_checked : Icons.radio_button_off,
                color: QuandoColors.amber,
              ),
              onTap: () => Navigator.pop(context, (null,)),
            ),
            for (final (name, value) in options)
              ListTile(
                title: Text(name),
                leading: Icon(
                  current == value ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: QuandoColors.amber,
                ),
                onTap: () => Navigator.pop(context, (value,)),
              ),
          ],
        ),
      ),
    );
    if (picked == null) return;
    set(picked.$1);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final mine = {for (final s in ref.watch(soundsProvider)) s.id};
    final results = _results;
    final genreName = radioGenres.where((g) => g.$2 == _genre).firstOrNull?.$1;
    final countryName = radioCountries.where((c) => c.$2 == _country).firstOrNull?.$1;
    final picked = _picked;

    return Scaffold(
      appBar: AppBar(
        title: _searching
            ? TextField(
                controller: _query,
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l10n.stationName,
                  border: InputBorder.none,
                  filled: false,
                ),
                onSubmitted: (_) => _load(),
              )
            : Text(l10n.onlineRadio),
        actions: [
          if (!_searching)
            IconButton(
              tooltip: l10n.addStreamAddress,
              icon: const Icon(Icons.add_circle_outline),
              onPressed: _paste,
            ),
          IconButton(
            tooltip: _searching ? l10n.closeSearch : l10n.searchByName,
            icon: Icon(_searching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _searching = !_searching;
                if (!_searching) _query.clear();
              });
              if (!_searching) _load();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Row(
              children: [
                _Filter(
                  icon: Icons.music_note,
                  label: genreName ?? l10n.anyGenre,
                  on: genreName != null,
                  onTap: () => _choose('genre', radioGenres, _genre, (v) => _genre = v),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: _Filter(
                    icon: Icons.public,
                    label: countryName ?? l10n.anywhere,
                    on: countryName != null,
                    onTap: () => _choose('country', radioCountries, _country, (v) => _country = v),
                  ),
                ),
              ],
            ),
          ),
          if (_busy) const LinearProgressIndicator(minHeight: 2),
          Expanded(
            child: _error != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(_error!, textAlign: TextAlign.center, style: text.bodyLarge),
                    ),
                  )
                : results == null
                ? const SizedBox()
                : results.isEmpty
                ? Center(child: Text(l10n.noStations, style: text.bodyLarge))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                    itemCount: results.length,
                    itemBuilder: (context, i) {
                      final r = results[i];
                      final s = _sound(r.name, r.url);
                      final isPicked = picked?.url == r.url;
                      final playing = SoundPreview.instance.playingId == s.id;
                      return ListTile(
                        leading: Icon(
                          isPicked ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isPicked ? QuandoColors.amber : QuandoColors.faint,
                        ),
                        title: Text(
                          r.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleMedium,
                        ),
                        subtitle: Text(
                          _country == null
                              ? r.details
                              : r.details.replaceFirst(RegExp('^${RegExp.escape(r.country)}( · )?'), ''),
                          style: text.bodySmall,
                        ),
                        trailing: mine.contains(s.id)
                            ? const Icon(Icons.check, color: QuandoColors.muted)
                            : (playing ? const Icon(Icons.graphic_eq, color: QuandoColors.coral) : null),
                        onTap: () => _tap(r),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: picked == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  onPressed: () => _add(_sound(picked.name, picked.url)),
                  child: Text(l10n.wakeUpTo(picked.name), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
    );
  }
}

/// A rounded filter button: "Jazz", "United States".
class _Filter extends StatelessWidget {
  const _Filter({required this.icon, required this.label, required this.on, required this.onTap});

  final IconData icon;
  final String label;
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: on ? QuandoColors.raised : QuandoColors.surface,
      shape: StadiumBorder(side: BorderSide(color: on ? QuandoColors.amber : QuandoColors.line)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: QuandoColors.amber),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
