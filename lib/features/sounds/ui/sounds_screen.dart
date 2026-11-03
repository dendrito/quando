import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../data/sound_files.dart';
import '../domain/sound.dart';
import 'sound_player.dart';

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
      messenger.showSnackBar(const SnackBar(content: Text('Quando needs the microphone to record.')));
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
      name: 'Recording $n',
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
      messenger.showSnackBar(SnackBar(content: Text('Could not add that file: $e')));
    }
  }

  Future<void> _rename(AlarmSound s) async {
    final c = TextEditingController(text: s.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name this sound'),
        content: TextField(controller: c, autofocus: true, textCapitalization: TextCapitalization.sentences),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, c.text.trim()), child: const Text('Save')),
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
      appBar: AppBar(title: const Text('Sounds'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
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
                    recording ? 'Stop · ${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')}' : 'Record',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  onPressed: recording ? null : _pickFile,
                  icon: const Icon(Icons.library_music_outlined),
                  label: const Text('Add a file'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Record your voice, a song or anything else, up to 5 minutes. Or add an MP3, M4A or WAV from '
            'your phone. Spotify and SoundCloud come later.',
            style: text.bodySmall,
          ),
          const SizedBox(height: 24),
          Text('YOUR SOUNDS', style: text.labelSmall),
          for (final s in sounds)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: IconButton(
                tooltip: 'Listen',
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
                [if (s.builtIn) 'Built in', if (s.id == defaultId) 'Default'].join(' · '),
                style: text.bodySmall,
              ),
              onTap: s.builtIn ? null : () => _rename(s),
              trailing: s.builtIn
                  ? null
                  : IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        ref.read(soundsProvider.notifier).delete(s.id);
                        SoundFiles.delete(s.path);
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
