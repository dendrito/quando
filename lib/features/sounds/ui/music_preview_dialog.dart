import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/util/format.dart';
import '../../../core/util/platform.dart';
import '../../../l10n/l10n.dart';
import '../../ringing/data/embedded_music.dart';
import '../../ringing/data/music.dart';
import '../../ringing/ui/embedded_music_player.dart';
import '../data/desktop_music.dart';
import '../domain/sound.dart';

/// Listen uses the supported provider in a visible, independently owned preview.
class MusicPreviewDialog extends ConsumerStatefulWidget {
  const MusicPreviewDialog({super.key, required this.sound});
  final AlarmSound sound;
  @override
  ConsumerState<MusicPreviewDialog> createState() => _MusicPreviewDialogState();
}

class _MusicPreviewDialogState extends ConsumerState<MusicPreviewDialog> {
  final _id = -DateTime.now().microsecondsSinceEpoch;
  late final int _seconds = ref.read(alarmOptionsProvider).ringSeconds;
  late final DateTime _deadline = DateTime.now().add(Duration(seconds: _seconds));
  late final EmbeddedMusic? _embedded = EmbeddedMusic.parse(widget.sound.link);
  Timer? _timer;
  bool _loading = true, _failed = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: _seconds), () {
      if (mounted) _close();
    });
    if (_embedded == null) unawaited(_start());
  }

  Future<void> _start() async {
    try {
      final link = widget.sound.link!;
      final service = DesktopMusic.serviceOf(link);
      if (isMacOS && service != null) await DesktopMusic.connect(service, ref.read(prefsProvider));
      if (!mounted) return;
      final ok = await Music.start(link, alarmId: _id, playFor: _deadline.difference(DateTime.now()));
      if (!mounted) {
        await Music.pause(alarmId: _id);
        return;
      }
      setState(() {
        _loading = false;
        _failed = !ok;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _failed = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(Music.pause(alarmId: _id));
    super.dispose();
  }

  void _close() {
    final route = ModalRoute.of(context);
    if (route == null || !route.isActive) return;
    if (route.isCurrent) {
      Navigator.of(context).pop();
    } else {
      route.navigator?.removeRoute(route);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.sound.name),
    content: SizedBox(
      width: 640,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.forSpan(formatSpan(Duration(seconds: _seconds)))),
            const SizedBox(height: 12),
            if (_embedded != null)
              EmbeddedMusicPlayer(
                source: _embedded,
                deadline: _deadline,
                active: ModalRoute.isCurrentOf(context) == true,
              )
            else if (_failed)
              Text(l10n.musicPreviewFailed)
            else if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              const Icon(Icons.graphic_eq, size: 48),
          ],
        ),
      ),
    ),
    actions: [FilledButton(onPressed: _close, child: Text(l10n.stop))],
  );
}
