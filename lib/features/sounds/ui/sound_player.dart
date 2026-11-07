import 'package:just_audio/just_audio.dart';

import '../data/sound_files.dart';
import '../domain/sound.dart';

/// Plays a sound once so you can hear it before choosing it.
class SoundPreview {
  SoundPreview._();
  static final instance = SoundPreview._();

  AudioPlayer? _player;
  String? playingId;

  Future<void> play(AlarmSound s, {void Function()? onDone}) async {
    await stop();
    final player = _player = AudioPlayer();
    playingId = s.id;
    try {
      if (s.builtIn) {
        await player.setAsset(s.playbackPath);
      } else if (s.isRadio) {
        await player.setUrl(s.path);
      } else {
        await player.setFilePath(await SoundFiles.absolute(s.path));
      }
      player.playerStateStream.listen((st) {
        if (st.processingState == ProcessingState.completed) {
          playingId = null;
          onDone?.call();
        }
      });
      await player.play();
    } catch (_) {
      playingId = null;
      onDone?.call();
    }
  }

  Future<void> stop() async {
    playingId = null;
    final p = _player;
    _player = null;
    await p?.stop();
    await p?.dispose();
  }
}
