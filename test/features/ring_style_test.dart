import 'package:alarm/alarm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/ringing/data/apps.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_style.dart';
import 'package:quando/features/sounds/domain/loudness.dart';

void main() {
  group('loudness', () {
    test('fades in, holds, fades out by the end of the ring', () {
      final v = const Loudness(volume: 70, fadeInSeconds: 10, fadeOutSeconds: 20).toVolumeSettings(60);
      expect(v.volume, 0.7);
      expect(
        [for (final s in v.fadeSteps) (s.time.inSeconds, s.volume)],
        [(0, 0.0), (10, 1.0), (40, 1.0), (60, 0.0)],
      );
    });

    test('no fades plays at a fixed volume', () {
      final v = const Loudness(volume: 50, fadeInSeconds: 0).toVolumeSettings(60);
      expect(v.fadeSteps, isEmpty);
      expect(v.fadeDuration, isNull);
      expect(v.volume, 0.5);
    });

    test('phone volume leaves the level alone', () {
      expect(Loudness.standard.toVolumeSettings(60).volume, isNull);
    });

    test('fades longer than the ring shrink to fit', () {
      final v = const Loudness(fadeInSeconds: 60, fadeOutSeconds: 60).toVolumeSettings(30);
      final times = [for (final s in v.fadeSteps) s.time.inMilliseconds];
      expect(times.last, 30000);
      expect(times[1], 12000); // 60 / 120 of 80% of 30 s
      for (var i = 1; i < times.length; i++) {
        expect(times[i], greaterThan(times[i - 1]));
      }
    });

    test('fade out alone starts loud', () {
      final v = const Loudness(fadeInSeconds: 0, fadeOutSeconds: 10).toVolumeSettings(60);
      expect([for (final s in v.fadeSteps) s.volume], [1.0, 1.0, 0.0]);
    });

    test('summary reads plainly', () {
      expect(
        const Loudness(volume: 70, fadeInSeconds: 90, fadeOutSeconds: 0).summary,
        '70% · fades in 1 min 30 s',
      );
      expect(const Loudness(fadeInSeconds: 0).summary, 'Phone volume · no fade');
    });
  });

  group('ring style', () {
    const style = RingStyle(
      loudness: Loudness(volume: 40, fadeInSeconds: 30, fadeOutSeconds: 10),
      gentleMinutes: 10,
      snoozeBy: {StopWay.volumeKeys},
      stopBy: {StopWay.shake},
      task: StopTask.shake,
      wakeCheck: true,
      openAfter: 'https://news.google.com',
    );

    test('survives a restart with the alarm', () {
      const a = UserAlarm(id: 'a', hour: 7, minute: 0, days: {1}, style: style);
      expect(UserAlarm.fromJson(a.toJson()).style, style);
      expect(const UserAlarm(id: 'b', hour: 7, minute: 0).toJson()['style'], isNull);
    });

    test('goes into the ringing payload and back', () {
      const base = RingPayload(title: 'Wake', body: 'Alarm', ringSeconds: 60, maxSnoozes: 2);
      final p = RingPayload.decode(base.withStyle(style).encode());
      expect(p.loudness, style.loudness);
      expect(p.snoozeBy, {StopWay.volumeKeys});
      expect(p.stopBy, {StopWay.shake});
      expect(p.shakeTask, isTrue);
      expect(p.mathTask, isFalse);
      expect(p.wakeCheck, isTrue);
      expect(p.link, 'https://news.google.com');
      // Snoozing keeps all of it.
      expect(p.snoozed().loudness, style.loudness);
      expect(p.snoozed().stopBy, {StopWay.shake});
    });

    test('on Shabbat nothing asks to be touched, but volume still applies', () {
      const base = RingPayload(title: 'Candles', body: 'Now', ringSeconds: 60, shabbatSafe: true);
      final p = base.withStyle(style);
      expect(p.loudness, style.loudness);
      expect(p.hasTask, isFalse);
      expect(p.stopBy, isEmpty);
      expect(p.snoozeBy, isEmpty);
      expect(p.wakeCheck, isFalse);
      expect(p.link, isNull);
    });

    test('a gentle alarm comes first, quiet and asking nothing', () {
      final now = DateTime.utc(2026, 11, 2, 5);
      final a = ScheduledAlarm(
        id: 1,
        at: DateTime.utc(2026, 11, 2, 7),
        title: 'Wake',
        body: 'Weekdays',
        ringDuration: const Duration(minutes: 1),
        ruleId: 'user.a',
        eventId: 'user.a',
        offset: Duration.zero,
        style: style,
      );
      final g = gentleBefore(a, now)!;
      expect(g.at, DateTime.utc(2026, 11, 2, 6, 50));
      expect(g.id, isNot(a.id));
      expect(gentleBefore(a, DateTime.utc(2026, 11, 2, 6, 55)), isNull);

      const base = RingPayload(title: 'Wake', body: 'Weekdays', ringSeconds: 300, maxSnoozes: 2);
      final p = base.withStyle(style).gentleLeadUp(10, 'assets/sounds/gentle_waves.ogg');
      expect(p.gentle, isTrue);
      expect(p.sound, 'assets/sounds/gentle_waves.ogg');
      expect(p.loudness.volume, 24); // 60% of the alarm's 40%
      expect(p.loudness.fadeInSeconds, 510); // rises over most of the 10 minutes
      expect(p.ringSeconds, 585); // ends just before the real alarm
      expect(p.hasTask, isFalse);
      expect(p.canSnooze, isFalse);
      expect(p.link, isNull);
    });
  });

  test('VolumeSettings accepts what Quando builds', () {
    expect(
      const Loudness(volume: 100, fadeInSeconds: 300, fadeOutSeconds: 300).toVolumeSettings(5),
      isA<VolumeSettings>(),
    );
  });

  test('snooze plan: length, limit, shorter each time, by itself, a task', () {
    const style = RingStyle(
      snooze: SnoozePlan(minutes: 10, times: 3, shortenBy: 3, autoSnooze: true),
      snoozeTask: StopTask.sum,
    );
    expect(RingStyle.fromJson(style.toJson()), style);
    const base = RingPayload(title: 'Wake', body: 'Alarm', ringSeconds: 60, maxSnoozes: 2);
    var p = RingPayload.decode(base.withStyle(style).encode());
    expect(p.maxSnoozes, 3);
    expect(p.autoSnooze, isTrue);
    expect(p.snoozeTask, StopTask.sum);
    final lengths = <int>[];
    while (p.canSnooze) {
      lengths.add(p.snoozeMinutes);
      p = p.snoozed();
    }
    expect(lengths, [10, 7, 4]);
    expect(const SnoozePlan(minutes: 3, shortenBy: 5).lengthOf(2), 1);
    expect(
      const SnoozePlan(minutes: 10, times: 3, shortenBy: 2, autoSnooze: true).summary,
      '10 min, up to 3×, 2 min shorter each time, snoozes by itself',
    );

    final shabbat = const RingPayload(
      title: 'x',
      body: 'y',
      ringSeconds: 60,
      shabbatSafe: true,
    ).withStyle(style);
    expect(shabbat.canSnooze, isFalse);
    expect(shabbat.autoSnooze, isFalse);
    expect(shabbat.snoozeTask, StopTask.none);
  });

  test('an app to open after is kept by its package', () {
    final s = AppLink.of(const PhoneApp(package: 'com.example.news', label: 'Daily News'));
    expect(AppLink.isApp(s), isTrue);
    expect(AppLink.package(s), 'com.example.news');
    expect(AppLink.label(s), 'Daily News');
    expect(AppLink.isApp('https://news.google.com'), isFalse);
    const base = RingPayload(title: 'Wake', body: 'Alarm', ringSeconds: 60);
    expect(RingPayload.decode(base.withStyle(RingStyle(openAfter: s)).encode()).link, s);
  });
}
