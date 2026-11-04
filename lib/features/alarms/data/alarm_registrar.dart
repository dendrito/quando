import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';

import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../integrations/domain/integrations.dart';
import '../../ringing/data/music.dart';
import '../../ringing/ring_payload.dart';

import 'package:quando/l10n/l10n.dart';

/// Registers planned alarms with the phone and keeps them in step with the
/// plan: alarms no longer planned are removed, new ones are added. Snoozes,
/// wake-up checks and test alarms are left alone.
class AlarmRegistrar {
  /// Told when an alarm rings, is stopped, snoozed or stops by itself
  /// (Pushover, Zapier, IFTTT...).
  void Function(AlarmHappening what, RingPayload p)? onHappening;

  void _tell(AlarmHappening what, AlarmSettings s) {
    try {
      onHappening?.call(what, RingPayload.decode(s.payload, fallbackTitle: s.notificationSettings.title));
    } catch (_) {}
  }

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
        // The gentle lead-up only plays sound: no buzzing, no screen.
        vibrate: !p.gentle,
        androidFullScreenIntent: !p.gentle,
        warningNotificationOnKill: true,
        // Each alarm's own volume and fades, shrunk to fit a short ring.
        volumeSettings: p.isLock
            ? const VolumeSettings.fixed(volume: 0.15)
            : (p.song == null ? p.loudness : p.loudness.backupForSong).toVolumeSettings(p.ringSeconds),
        notificationSettings: NotificationSettings(
          title: p.title,
          body: p.body,
          // A check must be answered on the ringing screen.
          stopButton: p.gentle ? l10n.stop : (p.isCheck || p.hasTask || p.isLock ? null : l10n.stop),
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
    _tell(AlarmHappening.snoozed, ringing);
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
    _tell(AlarmHappening.stopped, ringing);
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
      _tell(AlarmHappening.ring, settings);
      final p = RingPayload.decode(settings.payload);
      // The real alarm takes over from its gentle lead-up.
      if (!p.gentle) {
        for (final other in ringing.alarms) {
          if (other.id != settings.id && RingPayload.decode(other.payload).gentle) {
            unawaited(Alarm.stop(other.id));
          }
        }
      }
      if (p.song != null && !p.gentle) unawaited(_playSong(settings, p));
      // Auto-snooze: untouched for its set time with snoozes left, so it
      // snoozes instead of ringing on or stopping.
      final autoSnooze = p.autoSnoozeMinutes > 0 && p.canSnooze && !p.isCheck;
      final seconds = autoSnooze && p.autoSnoozeMinutes * 60 < p.ringSeconds
          ? p.autoSnoozeMinutes * 60
          : p.ringSeconds;
      _stopTimers[settings.id] = Timer(Duration(seconds: seconds), () async {
        _stopTimers.remove(settings.id);
        if (await Alarm.isRinging(settings.id)) {
          if (autoSnooze && await snooze(settings)) return;
          await Alarm.stop(settings.id);
          _tell(AlarmHappening.autoStopped, settings);
          // Slept through it? The wake-up check still comes.
          if (!p.gentle) await _scheduleCheck(settings);
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

  /// The song is the alarm: once its app is playing it, Quando's own
  /// backup sound stops. If it stays silent, the backup rings on as usual.
  Future<void> _playSong(AlarmSettings settings, RingPayload p) async {
    final ok = await Music.start(p.song!, playFor: Duration(seconds: p.songSeconds));
    if (!ok || !await Alarm.isRinging(settings.id)) return;
    _stopTimers.remove(settings.id)?.cancel();
    await Alarm.stop(settings.id);
    _tell(AlarmHappening.stopped, settings);
    await _scheduleCheck(settings);
  }

  Future<void> dispose() async {
    await _ringingSub?.cancel();
    for (final t in _stopTimers.values) {
      t.cancel();
    }
  }
}
