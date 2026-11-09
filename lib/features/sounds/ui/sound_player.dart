import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../data/sound_files.dart';
import '../data/radio_stream.dart';
import '../domain/sound.dart';

/// Local and radio previews. Provider links use their official player instead.
class SoundPreview extends ChangeNotifier {
  SoundPreview._();
  static final instance = SoundPreview._();
  AudioPlayer? _player;
  StreamSubscription<PlayerState>? _state;
  StreamSubscription<PlayerException>? _errors;
  int _generation = 0;
  String? playingId;

  Future<void> play(
    AlarmSound s, {
    void Function()? onDone,
    void Function(Object)? onError,
    void Function(String)? onResolved,
  }) async {
    final run = _generation + 1;
    await stop();
    if (run != _generation) return;
    final player = _player = AudioPlayer();
    playingId = s.id;
    notifyListeners();
    void failed(Object error) {
      if (run != _generation) return;
      unawaited(stop());
      onError?.call(error);
      onDone?.call();
    }

    _errors = player.errorStream.listen(failed);
    _state = player.playerStateStream.listen((state) {
      if (run == _generation && state.processingState == ProcessingState.completed) {
        unawaited(stop());
        onDone?.call();
      }
    });
    try {
      if (s.builtIn || s.path.startsWith('assets/')) {
        await player.setAsset(s.playbackPath).timeout(const Duration(seconds: 12));
      } else if (s.isRadio) {
        final url = await radioPlaybackUrl(s.path);
        if (run != _generation) return;
        await player.setUrl(url).timeout(const Duration(seconds: 12));
        if (run == _generation && url != s.path) onResolved?.call(url);
      } else {
        await player.setFilePath(await SoundFiles.absolute(s.path)).timeout(const Duration(seconds: 12));
      }
      if (run != _generation) return;
      // play() completes when playback ends, not when it starts. Waiting for
      // it kept the row's Stop button from updating during a live station.
      unawaited(player.play().catchError(failed));
    } catch (error) {
      failed(error);
    }
  }

  Future<void> stop() async {
    _generation++;
    final changed = playingId != null;
    playingId = null;
    final player = _player;
    final state = _state;
    final errors = _errors;
    _player = null;
    _state = null;
    _errors = null;
    if (changed) notifyListeners();
    await state?.cancel();
    await errors?.cancel();
    await player?.dispose();
  }
}
