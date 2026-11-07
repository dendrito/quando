import 'dart:async';
import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/service/alarm_storage.dart';
import 'package:alarm/src/generated/platform_bindings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/ringing/data/alarm_audio.dart';
import 'package:quando/features/ringing/data/embedded_music.dart';
import 'package:quando/features/ringing/data/music.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/sounds/data/desktop_music.dart';
import 'package:quando/features/sounds/data/youtube_library.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  late AlarmRegistrar registrar;
  final calls = <MethodCall>[];
  final nativeRings = <int>{};
  final pauses = <String>[];
  var providerPlaying = true, providerStarts = true, muteWorks = true;
  String? nativeSession;
  Completer<bool>? delayedStart;

  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    SharedPreferences.setMockInitialValues({DesktopMusic.key('spotify'): true});
    await AlarmStorage.init();
    registrar = AlarmRegistrar();
    calls.clear();
    nativeRings.clear();
    pauses.clear();
    nativeSession = null;
    providerPlaying = true;
    providerStarts = true;
    muteWorks = true;
    delayedStart = null;
    binding.defaultBinaryMessenger.setMockMethodCallHandler(DesktopMusic.channel, (call) async {
      calls.add(call);
      final session = (call.arguments as Map?)?['session'] as String?;
      switch (call.method) {
        case 'play':
          final ok = delayedStart == null ? providerStarts : await delayedStart!.future;
          if (ok) nativeSession = session;
          return ok;
        case 'playing':
          return providerPlaying && session == nativeSession;
        case 'pause':
          pauses.add(session!);
          if (session == nativeSession) nativeSession = null;
          return null;
      }
      return null;
    });
    binding.defaultBinaryMessenger.setMockMethodCallHandler(AlarmAudio.channel, (call) async {
      calls.add(call);
      return muteWorks;
    });
    for (final method in ['stopAll', 'stopAlarm', 'setAlarm', 'isRinging', 'getPendingAlarmEvents']) {
      final channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.alarm.AlarmApi.$method',
        AlarmApi.pigeonChannelCodec,
      );
      binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (message) async {
        calls.add(MethodCall(method, message));
        if (method == 'getPendingAlarmEvents') return [<Object?>[]];
        if (method == 'stopAll') return [null];
        final args = message as List;
        if (method == 'isRinging') return [nativeRings.contains(args.first)];
        if (method == 'stopAlarm') nativeRings.remove(args.first);
        return [null];
      });
      addTearDown(() => binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null));
    }
  });

  tearDown(() async {
    await registrar.dispose();
    await Music.pause();
    Alarm.resetForTesting();
    AlarmStorage.resetForTesting();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(DesktopMusic.channel, null);
    binding.defaultBinaryMessenger.setMockMethodCallHandler(AlarmAudio.channel, null);
    debugDefaultTargetPlatformOverride = null;
  });

  void musicTest(String name, Future<void> Function() body) => test(name, body);

  Future<AlarmSettings> ring({int seconds = 4, int songSeconds = 1}) async {
    final settings = AlarmRegistrar.settingsFor(
      17,
      DateTime.now(),
      RingPayload(
        title: 'Music alarm',
        body: '',
        spoken: false,
        ringSeconds: seconds,
        song: 'https://open.spotify.com/track/abc123',
        songSeconds: songSeconds,
      ),
    );
    await registrar.init();
    await AlarmStorage.saveAlarm(settings);
    nativeRings.add(settings.id);
    Alarm.alarmRang(settings);
    for (var i = 0; i < 8; i++) {
      await Future<void>.delayed(Duration.zero);
    }
    return settings;
  }

  musicTest('music keeps the alarm active and follows Ring for, ignoring a song timer', () async {
    await ring();
    expect(Alarm.ringing.value.alarms.map((a) => a.id), contains(17));
    expect(calls.where((c) => c.method == 'stopAlarm'), isEmpty);
    expect(calls.any((c) => c.method == 'mute' && (c.arguments as Map)['muted'] == true), isTrue);
    await Future<void>.delayed(const Duration(seconds: 2));
    expect(nativeSession, isNotNull); // legacy one-second song timer is ignored
    expect(nativeRings, contains(17));
    await Future<void>.delayed(const Duration(seconds: 2));
    await Future<void>.delayed(Duration.zero);
    expect(nativeRings, isEmpty);
    expect(nativeSession, isNull);
    expect(Alarm.ringing.value.alarms, isEmpty);
  });

  for (final action in ['Stop', 'Snooze']) {
    musicTest('$action pauses the owned music session immediately', () async {
      final settings = await ring();
      if (action == 'Stop') {
        await registrar.stop(settings);
      } else {
        // This alarm has no snoozes, so stopping is not allowed to masquerade
        // as a successful snooze. Give it a real snooze-enabled payload.
        final snoozable = settings.copyWith(
          payload: () => const RingPayload(
            title: 'Music alarm',
            body: '',
            ringSeconds: 4,
            spoken: false,
            maxSnoozes: 1,
          ).encode(),
        );
        await registrar.snooze(snoozable);
      }
      await Future<void>.delayed(Duration.zero);
      expect(nativeSession, isNull);
      expect(pauses, isNotEmpty);
    });
  }

  musicTest('provider failure leaves the local alarm and duration timer intact', () async {
    providerStarts = false;
    await ring();
    expect(calls.where((c) => c.method == 'mute'), isEmpty);
    expect(nativeRings, contains(17));
    await Future<void>.delayed(const Duration(seconds: 4));
    await Future<void>.delayed(Duration.zero);
    expect(nativeRings, isEmpty);
  });

  musicTest('a provider that pauses restores the local backup', () async {
    await ring();
    providerPlaying = false;
    await Future<void>.delayed(const Duration(seconds: 1));
    await Future<void>.delayed(Duration.zero);
    expect(calls.lastWhere((c) => c.method == 'mute').arguments, {'id': 17, 'muted': false});
    expect(nativeRings, contains(17));
  });

  musicTest('Stop during a slow start cannot leave music playing later', () async {
    delayedStart = Completer<bool>();
    final settings = await ring();
    await registrar.stop(settings);
    delayedStart!.complete(true);
    for (var i = 0; i < 8; i++) {
      await Future<void>.delayed(Duration.zero);
    }
    expect(nativeSession, isNull);
    expect(nativeRings, isEmpty);
  });

  musicTest('an older timer or alarm cannot pause a newer session', () async {
    await Music.start('spotify:track:abc123', alarmId: 1, playFor: const Duration(seconds: 1));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await Music.start('spotify:track:def456', alarmId: 2);
    final second = nativeSession;
    await Music.pause(alarmId: 1);
    await Future<void>.delayed(const Duration(seconds: 1));
    expect(nativeSession, second);
    expect(Music.owns(2), isTrue);
  });

  test('YouTube playlists paginate, including private-list video resolution', () async {
    var requests = 0;
    final library = YouTubeLibrary(
      'oauth-stays-in-dart',
      client: MockClient((request) async {
        expect(request.headers['Authorization'], 'Bearer oauth-stays-in-dart');
        expect(request.url.path, '/youtube/v3/playlistItems');
        expect(request.url.queryParameters['playlistId'], 'PLprivate');
        requests++;
        return http.Response(
          jsonEncode({
            'items': [
              {
                'contentDetails': {'videoId': requests == 1 ? 'abcdefghijk' : 'lmnopqrstuv'},
              },
            ],
            if (requests == 1) 'nextPageToken': 'page2',
          }),
          200,
        );
      }),
    );
    expect(await library.playlistVideos('PLprivate'), ['abcdefghijk', 'lmnopqrstuv']);
    expect(requests, 2);
    library.close();
  });

  test('Mac supports Google library sign-in and embedded links reject lookalike hosts', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(YouTubeAccount.available, isTrue);
    debugDefaultTargetPlatformOverride = null;
    expect(EmbeddedMusic.parse('https://music.youtube.com/playlist?list=PLone')?.playlist, 'PLone');
    expect(EmbeddedMusic.parse('https://youtu.be/abcdefghijk')?.video, 'abcdefghijk');
    expect(EmbeddedMusic.parse('https://youtube.com.attacker.test/watch?v=abcdefghijk'), isNull);
    expect(EmbeddedMusic.parse('https://youtube.com@attacker.test/watch?v=abcdefghijk'), isNull);
  });

  test('official player uses app identity, visible controls and the alarm deadline', () {
    final source = EmbeddedMusic.parse('https://music.youtube.com/playlist?list=PLone')!;
    final html = source.html(remaining: const Duration(seconds: 7), videos: ['abcdefghijk']);
    expect(html, contains('https://www.youtube.com/iframe_api'));
    expect(html, contains('https://com.dendrito.quando'));
    expect(html, contains('controls:1'));
    expect(html, contains('setTimeout(quandoStop,7000)'));
    expect(html, contains('visibilitychange'));
    expect(html, isNot(contains('oauth-stays-in-dart')));
  });

  test('SoundCloud link text cannot escape the player script', () {
    final source = EmbeddedMusic.parse(
      'https://soundcloud.com/artist/song?title=</script><script>alert(1)</script>',
    )!;
    final html = source.html(remaining: const Duration(seconds: 5));
    expect(html, isNot(contains('</script><script>alert(1)')));
    expect(html, contains(r'\u003c/script\u003e'));
    expect(html, contains('https://w.soundcloud.com/player/api.js'));
    expect(html, contains('setTimeout(quandoStop,5000)'));
  });
}
