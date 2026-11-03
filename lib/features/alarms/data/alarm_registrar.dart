import 'dart:async';
import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';

import '../../../core/scheduler/scheduler.dart';

/// Registers planned alarms with the phone and keeps them in step with the
/// plan: alarms no longer planned are removed, new ones are added.
class AlarmRegistrar {
  final _stopTimers = <int, Timer>{};
  StreamSubscription<AlarmSet>? _ringingSub;

  Future<void> init() async {
    await Alarm.init();
    _ringingSub ??= Alarm.ringing.listen(_enforceRingDuration);
  }

  Future<int> sync(List<ScheduledAlarm> plan) async {
    final existing = await Alarm.getAlarms();
    final wanted = {for (final a in plan) a.id: a};
    final existingIds = existing.map((e) => e.id).toSet();

    for (final e in existing) {
      if (!wanted.containsKey(e.id)) await Alarm.stop(e.id);
    }
    var added = 0;
    for (final a in plan) {
      if (existingIds.contains(a.id)) continue;
      if (await Alarm.set(alarmSettings: _settings(a))) added++;
    }
    return added;
  }

  AlarmSettings _settings(ScheduledAlarm a) => AlarmSettings(
    id: a.id,
    dateTime: a.at.toLocal(),
    // null = the phone's default alarm sound. Custom sounds come later.
    assetAudioPath: null,
    loopAudio: true,
    vibrate: true,
    androidFullScreenIntent: true,
    warningNotificationOnKill: true,
    volumeSettings: VolumeSettings.fade(fadeDuration: Duration(seconds: 10)),
    notificationSettings: NotificationSettings(title: a.title, body: a.body, stopButton: 'Stop'),
    payload: jsonEncode({'ringSeconds': a.ringDuration.inSeconds, 'rule': a.ruleId}),
  );

  /// Stops each alarm after its ring duration, so nobody needs to touch the
  /// phone (important on Shabbat).
  ///
  /// This runs while the app process is alive, which the alarm plugin keeps
  /// going while ringing. A native stop timer that survives the app being
  /// killed is planned for milestone 2.
  void _enforceRingDuration(AlarmSet ringing) {
    for (final settings in ringing.alarms) {
      if (_stopTimers.containsKey(settings.id)) continue;
      final seconds = _ringSeconds(settings.payload);
      _stopTimers[settings.id] = Timer(Duration(seconds: seconds), () {
        Alarm.stop(settings.id);
        _stopTimers.remove(settings.id);
      });
    }
    // Forget timers for alarms the user already stopped.
    final ids = ringing.alarms.map((a) => a.id).toSet();
    _stopTimers.removeWhere((id, t) {
      if (ids.contains(id)) return false;
      t.cancel();
      return true;
    });
  }

  static int _ringSeconds(String? payload) {
    try {
      final map = jsonDecode(payload ?? '{}') as Map<String, dynamic>;
      return (map['ringSeconds'] as num?)?.toInt() ?? 60;
    } catch (_) {
      return 60;
    }
  }

  Future<void> dispose() async {
    await _ringingSub?.cancel();
    for (final t in _stopTimers.values) {
      t.cancel();
    }
  }
}
