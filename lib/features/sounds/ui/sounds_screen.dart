import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../data/sound_files.dart';
import '../data/spotify_library.dart';
import '../data/youtube_library.dart';
import '../../../core/util/platform.dart';
import '../../ringing/data/spotify.dart';
import '../domain/sound.dart';
import 'radio_screen.dart';
import 'music_picker_screen.dart';
import 'sound_player.dart';

import 'package:quando/l10n/l10n.dart';

/// Your sounds: record one, add a file, listen, rename, delete.
class SoundsScreen extends ConsumerStatefulWidget {
  const SoundsScreen({super.key});

  @override
  ConsumerState<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends ConsumerState<SoundsScreen> {
  final _recorder = AudioRecorder();
  String? _recordingPath;
  Duration _elapsed = Duration.zero;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    SoundPreview.instance.stop();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final messenger = ScaffoldMessenger.of(context);
    if (!await _recorder.hasPermission()) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.needsMic)));
      return;
    }
    await SoundPreview.instance.stop();
    await SoundFiles.ensureFolder();
    final rel = SoundFiles.newRelative('rec', 'm4a');
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: await SoundFiles.absolute(rel),
    );
    setState(() {
      _recordingPath = rel;
      _elapsed = Duration.zero;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
      if (_elapsed >= const Duration(minutes: 5)) _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _recorder.stop();
    final rel = _recordingPath;
    setState(() => _recordingPath = null);
    if (rel == null || !mounted) return;
    final n = ref.read(soundsProvider).where((s) => !s.builtIn).length + 1;
    final sound = AlarmSound(
      id: 'mine.${DateTime.now().millisecondsSinceEpoch}',
      name: l10n.recordingN(n),
      path: rel,
    );
    ref.read(soundsProvider.notifier).add(sound);
    _rename(sound);
  }

  Future<void> _pickFile() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final files = await FilePicker.pickFiles(type: FileType.audio);
      final file = files.isEmpty ? null : files.single;
      final path = file?.path;
      if (file == null || path == null) return;
      final rel = await SoundFiles.import(path);
      final name = file.name.replaceAll(RegExp(r'\.[^.]+$'), '');
      ref
          .read(soundsProvider.notifier)
          .add(AlarmSound(id: 'mine.${DateTime.now().millisecondsSinceEpoch}', name: name, path: rel));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.couldNotAddFile('$e'))));
    }
  }

  /// A song or playlist from Spotify, YouTube Music, Apple Music…: played
  /// in its own app as the alarm, or opened when you stop it. [editing] is
  /// a song link already saved.
  Future<void> _addLink({AlarmSound? editing}) async {
    final url = TextEditingController(text: editing?.link);
    final name = TextEditingController(text: editing?.name);
    var ringWith = AlarmSound.builtIns.firstWhere(
      (b) => b.path == editing?.path,
      orElse: () => AlarmSound.builtIns[1],
    );
    // Only Android can start and pause other apps' music.
    var plays = isAndroid && (editing?.plays ?? true);
    var playFor = editing?.playSeconds ?? 0;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) {
          final text = Theme.of(context).textTheme;
          return AlertDialog(
            title: Text(editing == null ? l10n.addSongLink : l10n.songLink),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (editing == null) ...[
                    Text(l10n.songLinkHowTo),
                    const SizedBox(height: 12),
                    TextField(
                      controller: url,
                      autofocus: true,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(hintText: 'https://open.spotify.com/track/…'),
                    ),
                    const SizedBox(height: 8),
                  ],
                  TextField(
                    controller: name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(hintText: l10n.songNameHint),
                  ),
                  const SizedBox(height: 16),
                  if (isAndroid) ...[
                    Text(l10n.whenAlarmGoesOffHeading, style: text.labelSmall),
                    const SizedBox(height: 8),
                    SegmentedButton<bool>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(value: true, label: Text(l10n.playTheSong)),
                        ButtonSegment(value: false, label: Text(l10n.ringThenOpen)),
                      ],
                      selected: {plays},
                      onSelectionChanged: (v) => setLocal(() => plays = v.first),
                    ),
                    const SizedBox(height: 6),
                    Text(plays ? l10n.playTheSongHint : l10n.ringThenOpenHint, style: text.bodySmall),
                    const SizedBox(height: 16),
                    Text(l10n.playForHeading, style: text.labelSmall),
                    DropdownButton<int>(
                      value: playFor,
                      isExpanded: true,
                      items: [
                        for (final s in AlarmSound.playLengths)
                          DropdownMenuItem(value: s, child: Text(AlarmSound.playLength(s))),
                      ],
                      onChanged: (v) => setLocal(() => playFor = v ?? playFor),
                    ),
                    Text(l10n.pausesAfter, style: text.bodySmall),
                  ],
                  const SizedBox(height: 16),
                  Text(l10n.backupSoundHeading, style: text.labelSmall),
                  DropdownButton<AlarmSound>(
                    value: ringWith,
                    isExpanded: true,
                    items: [
                      for (final b in AlarmSound.builtIns) DropdownMenuItem(value: b, child: Text(b.name)),
                    ],
                    onChanged: (b) => setLocal(() => ringWith = b ?? ringWith),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(editing == null ? l10n.add : l10n.save),
              ),
            ],
          );
        },
      ),
    );
    final link = url.text.trim();
    final label = name.text.trim();
    url.dispose();
    name.dispose();
    if (ok != true || !mounted) return;
    final sounds = ref.read(soundsProvider.notifier);
    if (editing != null) {
      sounds.replace(
        editing.copyWith(
          name: label.isNotEmpty ? label : null,
          path: ringWith.path,
          plays: plays,
          playSeconds: playFor,
        ),
      );
      return;
    }
    final uri = Uri.tryParse(link);
    if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http' || uri.scheme == 'spotify')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.notALink)));
      return;
    }
    final sound = AlarmSound(
      id: 'link.${DateTime.now().millisecondsSinceEpoch}',
      name: '',
      path: ringWith.path,
      link: link,
      plays: plays,
      playSeconds: playFor,
    );
    sounds.add(sound.rename(label.isNotEmpty ? label : l10n.songOn(sound.linkApp ?? l10n.theWeb)));
  }

  /// YouTube and YouTube Music: sign in with Google, then pick from your
  /// playlists and liked videos.
  Widget _youTubeTile(TextTheme text) {
    final on = YouTubeAccount.connected;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(on ? Icons.check_circle : Icons.smart_display_outlined, color: QuandoColors.amber),
      title: Text(on ? l10n.pickFromYouTube : l10n.youTubeAndMusic),
      subtitle: Text(
        YouTubeAccount.available ? (on ? l10n.youTubeOn : l10n.youTubeSignIn) : l10n.addSongLinkInstead,
        style: text.bodySmall,
      ),
      trailing: on ? const Icon(Icons.chevron_right) : null,
      onLongPress: !on
          ? null
          : () async {
              await YouTubeAccount.signOut();
              YouTubeAccount.connected = false;
              await ref.read(prefsProvider).setBool(YouTubeAccount.prefKey, false);
              if (mounted) setState(() {});
            },
      onTap: !YouTubeAccount.available
          ? null
          : () async {
              final prefs = ref.read(prefsProvider);
              final token = await YouTubeAccount.token();
              YouTubeAccount.connected = token != null;
              await prefs.setBool(YouTubeAccount.prefKey, YouTubeAccount.connected);
              if (!mounted) return;
              setState(() {});
              if (token == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.googleSignInFailed)));
                return;
              }
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MusicPickerScreen(
                    title: l10n.myYouTube,
                    load: () async {
                      final lib = YouTubeLibrary(await YouTubeAccount.token() ?? token);
                      return (await lib.playlists(), await lib.liked());
                    },
                  ),
                ),
              );
            },
    );
  }

  /// Spotify direct play: sign in once and Spotify plays the exact song.
  Widget _spotifyTile(TextTheme text) {
    final on = SpotifyPlay.connected;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(on ? Icons.check_circle : Icons.play_circle_outline, color: QuandoColors.amber),
      title: Text(on ? l10n.spotifyDirectOn : l10n.spotifyDirect),
      subtitle: Text(
        SpotifyPlay.available
            ? (on ? l10n.spotifyDirectOnHint : l10n.spotifyDirectHint)
            : l10n.spotifyComingSoon,
        style: text.bodySmall,
      ),
      onTap: !SpotifyPlay.available
          ? null
          : () async {
              final prefs = ref.read(prefsProvider);
              if (on) {
                await SpotifyPlay.signOut();
                SpotifyPlay.connected = false;
              } else {
                SpotifyPlay.connected = await SpotifyPlay.signIn();
                if (!SpotifyPlay.connected && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.spotifyFailed)));
                }
              }
              await prefs.setBool(SpotifyPlay.prefKey, SpotifyPlay.connected);
              if (mounted) setState(() {});
            },
    );
  }

  Future<void> _rename(AlarmSound s) async {
    final c = TextEditingController(text: s.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.nameThisSound),
        content: TextField(controller: c, autofocus: true, textCapitalization: TextCapitalization.sentences),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, c.text.trim()), child: Text(l10n.save)),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) ref.read(soundsProvider.notifier).rename(s.id, name);
  }

  Future<void> _toggle(AlarmSound s) async {
    final p = SoundPreview.instance;
    if (p.playingId == s.id) {
      await p.stop();
    } else {
      await p.play(s, onDone: () => mounted ? setState(() {}) : null);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sounds = ref.watch(soundsProvider);
    final defaultId = ref.watch(alarmOptionsProvider).soundId;
    final text = Theme.of(context).textTheme;
    final recording = _recordingPath != null;
    final secs = _elapsed.inSeconds;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.sounds), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          FeatureHeader(icon: Icons.music_note, sentence: l10n.soundsSentence),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: recording ? Colors.redAccent : null,
                  ),
                  onPressed: recording ? _stopRecording : _startRecording,
                  icon: Icon(recording ? Icons.stop : Icons.mic),
                  label: Text(
                    recording
                        ? l10n.stopTimer('${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')}')
                        : l10n.record,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  onPressed: recording ? null : _pickFile,
                  icon: const Icon(Icons.library_music_outlined),
                  label: Text(l10n.addAFile),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: recording ? null : _addLink,
            icon: const Icon(Icons.link),
            label: Text(l10n.addSongLinkLong),
          ),
          const SizedBox(height: 20),
          Text(l10n.musicAppsHeading, style: text.labelSmall),
          _spotifyTile(text),
          if (SpotifyPlay.connected)
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: const Icon(Icons.library_music, color: QuandoColors.amber),
              title: Text(l10n.pickFromSpotify),
              subtitle: Text(l10n.yourPlaylistsAndLiked, style: text.bodySmall),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MusicPickerScreen(
                    title: l10n.mySpotify,
                    load: () async {
                      final token = await SpotifyPlay.libraryToken();
                      if (token == null) throw Exception(l10n.spotifySignInFailed);
                      final lib = SpotifyLibrary(token);
                      return (await lib.playlists(), await lib.likedSongs());
                    },
                  ),
                ),
              ),
            ),
          _youTubeTile(text),
          for (final (app, note) in [
            ('Apple Music', l10n.appleMusicNote),
            ('Amazon Music', l10n.noSignInNote('Amazon')),
            ('SoundCloud', l10n.noSignInNote('SoundCloud')),
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.music_note_outlined, color: QuandoColors.faint),
              title: Text(app),
              subtitle: Text(note, style: text.bodySmall),
              onTap: recording ? null : _addLink,
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: recording
                ? null
                : () =>
                      Navigator.of(context)
                          .push(MaterialPageRoute<void>(builder: (_) => const RadioScreen())),
            icon: const Icon(Icons.radio),
            label: Text(l10n.wakeToRadio),
          ),
          const SizedBox(height: 8),
          Text(l10n.soundsExplain, style: text.bodySmall),
          const SizedBox(height: 24),
          Text(l10n.yourSoundsHeading, style: text.labelSmall),
          for (final s in sounds)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: IconButton(
                tooltip: l10n.listen,
                icon: Icon(
                  SoundPreview.instance.playingId == s.id
                      ? Icons.stop_circle_outlined
                      : Icons.play_circle_outline,
                  color: QuandoColors.amber,
                ),
                onPressed: () => _toggle(s),
              ),
              title: Text(s.name),
              subtitle: Text(
                [
                  if (s.builtIn) l10n.builtIn,
                  if (s.isLink) s.plays ? l10n.playsIn(s.linkApp ?? '') : l10n.opensIn(s.linkApp ?? ''),
                  if (s.isLink && s.playSeconds > 0) l10n.forSpan(AlarmSound.playLength(s.playSeconds)),
                  if (s.isRadio) l10n.onlineRadio,
                  if (s.id == defaultId) l10n.defaultLabel,
                ].join(' · '),
                style: text.bodySmall,
              ),
              onTap: s.builtIn ? null : () => s.isLink ? _addLink(editing: s) : _rename(s),
              trailing: s.builtIn
                  ? null
                  : IconButton(
                      tooltip: l10n.delete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        ref.read(soundsProvider.notifier).delete(s.id);
                        if (!s.isLink && !s.isRadio) SoundFiles.delete(s.path);
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
