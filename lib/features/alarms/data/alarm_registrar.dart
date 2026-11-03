import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';

import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../ringing/ring_payload.dart';

/// Registers planned alarms with the phone and keeps them in step with the
/// plan: alarms no longer planned are removed, new ones are added. Snoozes,
/// wake-up checks and test alarms are left alone.
class AlarmRegistrar {
  final _stopTimers = <int, Timer>{};
  StreamSubscription<AlarmSet>? _ringingSub;
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    await Alarm.init();
    _ready = true;
    _ringingSub ??= Alarm.ringing.listen(_enforceRingDuration);
  }

  Future<int> sync(List<ScheduledAlarm> plan, RingPayload Function(ScheduledAlarm) payloadFor) async {
    await init();
    final existing = await Alarm.getAlarms();
    final wanted = {for (final a in plan) a.id: a};

    for (final e in existing) {
      if (RingPayload.decode(e.payload).transient) continue;
      if (!wanted.containsKey(e.id)) await Alarm.stop(e.id);
    }
    // Re-set everything so changed options (spoken, snooze...) apply.
    var added = 0;
    for (final a in plan) {
      if (await set(a.id, a.at, payloadFor(a))) added++;
    }
    return added;
  }

  Future<bool> set(int id, DateTime at, RingPayload p) async {
    await init();
    return Alarm.set(
      alarmSettings: AlarmSettings(
        id: id,
        dateTime: at.toLocal(),
        // null = the phone's alarm sound; otherwise built-in or the user's own.
        assetAudioPath: p.sound,
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
        warningNotificationOnKill: true,
        // Fade in gently, but a 2-second alarm must be loud from the start.
        volumeSettings: p.isLock
            ? const VolumeSettings.fixed(volume: 0.15)
            : p.ringSeconds >= 30
            ? VolumeSettings.fade(fadeDuration: const Duration(seconds: 10))
            : VolumeSettings.fixed(),
        notificationSettings: NotificationSettings(
          title: p.title,
          body: p.body,
          // A check must be answered on the ringing screen.
          stopButton: p.isCheck || p.mathTask || p.isLock ? null : 'Stop',
        ),
        payload: p.encode(),
      ),
    );
  }

  /// Rings once more in [RingPayload.snoozeMinutes]. Returns false when the
  /// snooze limit is reached.
  Future<bool> snooze(AlarmSettings ringing) async {
    final p = RingPayload.decode(ringing.payload, fallbackTitle: ringing.notificationSettings.title);
    if (!p.canSnooze) return false;
    await Alarm.stop(ringing.id);
    final next = p.snoozed();
    await set(
      stableId('snooze|${ringing.id}|${next.snoozeCount}'),
      DateTime.now().add(Duration(minutes: p.snoozeMinutes)),
      next,
    );
    return true;
  }

  /// Stops a ringing alarm. With the wake-up check on, schedules "Are you
  /// up?" in 3 minutes and returns its id, so the screen can cancel it.
  Future<int?> stop(AlarmSettings ringing) async {
    await Alarm.stop(ringing.id);
    return _scheduleCheck(ringing);
  }

  Future<void> cancel(int id) => Alarm.stop(id);

  static const checkDelay = Duration(minutes: 3);

  Future<int?> _scheduleCheck(AlarmSettings ringing) async {
    final p = RingPayload.decode(ringing.payload);
    if (!p.wakeCheck || p.isCheck) return null;
    final id = stableId('check|${ringing.id}');
    await set(id, DateTime.now().add(checkDelay), p.check());
    return id;
  }

  /// Stops each alarm after its ring duration, so nobody needs to touch the
  /// phone (important on Shabbat).
  ///
  /// This runs while the app process is alive, which the alarm plugin keeps
  /// going while ringing. A native stop timer that survives the app being
  /// killed is planned for milestone 2.
  void _enforceRingDuration(AlarmSet ringing) {
    for (final settings in ringing.alarms) {
      if (_stopTimers.containsKey(settings.id)) continue;
      final seconds = RingPayload.decode(settings.payload).ringSeconds;
      _stopTimers[settings.id] = Timer(Duration(seconds: seconds), () async {
        _stopTimers.remove(settings.id);
        if (await Alarm.isRinging(settings.id)) {
          await Alarm.stop(settings.id);
          // Slept through it? The wake-up check still comes.
          await _scheduleCheck(settings);
        }
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

  Future<void> dispose() async {
    await _ringingSub?.cancel();
    for (final t in _stopTimers.values) {
      t.cancel();
    }
  }
}
