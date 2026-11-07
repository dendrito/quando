import 'package:flutter/services.dart';

/// Silence only this alarm's local backup, retaining the native ringing
/// identity, Stop/Snooze controls and duration timer. Never changes system volume.
class AlarmAudio {
  static const channel = MethodChannel('quando/alarm_audio');
  static Future<bool> mute(int id, bool muted) async {
    try {
      return await channel.invokeMethod<bool>('mute', {'id': id, 'muted': muted}) ?? false;
    } catch (_) {
      return false;
    }
  }
}
