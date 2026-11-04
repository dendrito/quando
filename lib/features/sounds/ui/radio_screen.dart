import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../data/radio_directory.dart';
import '../domain/sound.dart';
import 'sound_player.dart';

/// Find a radio station by name, listen, and add it as an alarm sound. Or
/// paste a stream address.
class RadioScreen extends ConsumerStatefulWidget {
  const RadioScreen({super.key, this.directory});

  final RadioDirectory? directory;

  @override
  ConsumerState<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends ConsumerState<RadioScreen> {
  late final _directory = widget.directory ?? RadioDirectory();
  final _query = TextEditingController();
  final _url = TextEditingController();
  List<RadioStation>? _results;
  String? _error;
  var _busy = false;

  @override
  void dispose() {
    SoundPreview.instance.stop();
    _query.dispose();
    _url.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final q = _query.text.trim();
    if (q.isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final r = await _directory.search(q);
      if (mounted) setState(() => _results = r);
    } catch (_) {
      if (mounted) setState(() => _error = 'Couldn\'t reach the radio directory. Check your connection.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  AlarmSound _sound(String name, String url) =>
      AlarmSound(id: 'radio.${url.hashCode.toUnsigned(32)}', name: name, path: url);

  Future<void> _listen(AlarmSound s) async {
    final p = SoundPreview.instance;
    if (p.playingId == s.id) {
      await p.stop();
    } else {
      setState(() {});
      await p.play(s, onDone: () => mounted ? setState(() {}) : null);
    }
    if (mounted) setState(() {});
  }

  void _add(AlarmSound s) {
    final notifier = ref.read(soundsProvider.notifier);
    if (!ref.read(soundsProvider).any((x) => x.id == s.id)) notifier.add(s);
    SoundPreview.instance.stop();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${s.name} added. Pick it as the sound for any alarm.')));
    Navigator.of(context).pop();
  }

  void _addPasted() {
    final url = _url.text.trim();
    if (!isStreamUrl(url)) {
      setState(() => _error = 'That doesn\'t look like a stream address (it starts with http).');
      return;
    }
    _add(_sound(Uri.parse(url).host.replaceFirst('www.', ''), url));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final mine = {for (final s in ref.watch(soundsProvider)) s.id};
    final results = _results;

    return Scaffold(
      appBar: AppBar(title: const Text('Online radio')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const FeatureHeader(
            icon: Icons.radio,
            sentence: 'Wake up to a live station from anywhere in the world.',
          ),
          TextField(
            controller: _query,
            autofocus: true,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Station name, e.g. BBC, jazz, Kol Chai',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _busy
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    )
                  : IconButton(icon: const Icon(Icons.arrow_forward), onPressed: _search),
            ),
            onSubmitted: (_) => _search(),
          ),
          const SizedBox(height: 8),
          Text(
            'Stations come from radio-browser.info. The alarm plays the station live; if it can\'t connect '
            'within a few seconds, the phone\'s alarm sound rings instead. On Shabbat and festivals a '
            'built-in sound rings, not the radio.',
            style: text.bodySmall,
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: text.bodyMedium?.copyWith(color: QuandoColors.coral)),
          ],
          if (results != null) ...[
            const SizedBox(height: 16),
            Text(results.isEmpty ? 'NO STATIONS FOUND' : 'STATIONS', style: text.labelSmall),
            for (final r in results)
              Builder(
                builder: (context) {
                  final s = _sound(r.name, r.url);
                  final playing = SoundPreview.instance.playingId == s.id;
                  final added = mine.contains(s.id);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      tooltip: 'Listen',
                      icon: Icon(
                        playing ? Icons.stop_circle_outlined : Icons.play_circle_outline,
                        color: QuandoColors.amber,
                      ),
                      onPressed: () => _listen(s),
                    ),
                    title: Text(r.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(r.details, style: text.bodySmall),
                    trailing: added
                        ? const Icon(Icons.check, color: QuandoColors.muted)
                        : TextButton(onPressed: () => _add(s), child: const Text('Add')),
                  );
                },
              ),
          ],
          const SizedBox(height: 28),
          Text('OR PASTE A STREAM ADDRESS', style: text.labelSmall),
          const SizedBox(height: 8),
          TextField(
            controller: _url,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(hintText: 'https://stream.example.com/live.mp3'),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(onPressed: _addPasted, child: const Text('Add this stream')),
          ),
        ],
      ),
    );
  }
}
