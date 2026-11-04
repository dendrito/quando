import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/features/ringing/data/spotify.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_style.dart';
import 'package:quando/features/sounds/data/radio_directory.dart';
import 'package:quando/features/sounds/domain/sound.dart';
import 'package:quando/features/sounds/ui/sound_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container() async {
  ensureTimeZones();
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
      prefsProvider.overrideWithValue(prefs),
    ],
  );
  addTearDown(c.dispose);
  return c;
}

RingPayload _payloadOf(ProviderContainer c, String ruleId) =>
    c.read(payloadForProvider)(c.read(planProvider).firstWhere((a) => a.ruleId == ruleId));

void main() {
  test('built-in sounds are always there and point at bundled files', () async {
    final c = await _container();
    final sounds = c.read(soundsProvider);
    expect(sounds.map((s) => s.name), containsAll(['Soft chime', 'Morning rise', 'Classic beep']));
    expect(sounds.every((s) => s.path.startsWith('assets/sounds/')), isTrue);
    // Lead-up sounds belong to the gentle wake-up only.
    expect(sounds.where((s) => s.id.startsWith('calm.')), isEmpty);
  });

  test('default sound, per-alarm sound, and phone sound', () async {
    final c = await _container();
    c
        .read(soundsProvider.notifier)
        .add(const AlarmSound(id: 'mine.1', name: 'My voice', path: 'sounds/rec_1.m4a'));
    final alarms = c.read(userAlarmsProvider.notifier);
    alarms.save(const UserAlarm(id: 'a', hour: 7, minute: 0, days: {1, 2, 3, 4, 5}));
    alarms.save(const UserAlarm(id: 'b', hour: 8, minute: 0, days: {1, 2, 3, 4, 5}, soundId: 'mine.1'));
    alarms.save(
      const UserAlarm(id: 'p', hour: 9, minute: 0, days: {1, 2, 3, 4, 5}, soundId: SoundPickerTile.phone),
    );

    expect(_payloadOf(c, 'user.a').sound, isNull); // phone sound by default
    c.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(soundId: 'builtin.chime'));
    expect(_payloadOf(c, 'user.a').sound, 'assets/sounds/soft_chime.wav');
    expect(_payloadOf(c, 'user.b').sound, 'sounds/rec_1.m4a');
    expect(_payloadOf(c, 'user.p').sound, isNull);
  });

  test('calendar alarms and snoozes keep their sound', () async {
    final c = await _container();
    const rule = CalendarRule(id: 'r', atStart: true, soundId: 'builtin.beep');
    expect(rule.toAlarmRules().first.soundId, 'builtin.beep');
    expect(CalendarRule.fromJson(rule.toJson()).soundId, 'builtin.beep');
    c
        .read(userAlarmsProvider.notifier)
        .save(const UserAlarm(id: 'a', hour: 7, minute: 0, days: {1, 2, 3, 4, 5}, soundId: 'builtin.rise'));
    final p = RingPayload.decode(_payloadOf(c, 'user.a').encode());
    expect(p.snoozed().sound, 'assets/sounds/morning_rise.wav');
  });

  test('deleting the default sound falls back to the phone sound; sounds survive restart', () async {
    final c = await _container();
    c.read(soundsProvider.notifier).add(const AlarmSound(id: 'mine.1', name: 'Rec', path: 'sounds/r.m4a'));
    c.read(alarmOptionsProvider.notifier).update((o) => o.copyWith(soundId: 'mine.1'));
    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(c.read(prefsProvider))]);
    addTearDown(again.dispose);
    expect(again.read(soundsProvider).where((s) => !s.builtIn).single.name, 'Rec');
    c.read(soundsProvider.notifier).delete('mine.1');
    expect(c.read(alarmOptionsProvider).soundId, isNull);
  });

  test('a song link rings with a built-in sound and opens the link on stop', () async {
    final c = await _container();
    const song = AlarmSound(
      id: 'link.1',
      name: 'Morning playlist',
      path: 'assets/sounds/morning_rise.wav',
      link: 'https://open.spotify.com/playlist/abc',
    );
    c.read(soundsProvider.notifier).add(song);
    expect(song.linkApp, 'Spotify');
    String? app(String url) => AlarmSound(id: 'x', name: 'x', path: 'x', link: url).linkApp;
    expect(app('https://music.youtube.com/watch?v=1'), 'YouTube Music');
    expect(app('https://youtu.be/abc'), 'YouTube');
    expect(app('https://music.apple.com/us/album/1'), 'Apple Music');
    expect(app('https://music.amazon.com/albums/B0'), 'Amazon Music');
    expect(app('https://amzn.to/xyz'), 'Amazon Music');
    c
        .read(userAlarmsProvider.notifier)
        .save(const UserAlarm(id: 's', hour: 7, minute: 0, days: {1, 2, 3, 4}, soundId: 'link.1'));
    final p = _payloadOf(c, 'user.s');
    expect(p.sound, 'assets/sounds/morning_rise.wav');
    expect(p.link, 'https://open.spotify.com/playlist/abc');
    expect(RingPayload.decode(p.encode()).link, p.link);
    expect(RingPayload.decode(p.snoozed().encode()).link, p.link);

    // Kept across a restart.
    final again = c.read(soundsProvider).firstWhere((s) => s.id == 'link.1');
    expect(AlarmSound.fromJson(again.toJson()).link, song.link);
  });

  test('a song link can play as the alarm, with a backup sound and a play length', () async {
    final c = await _container();
    const song = AlarmSound(
      id: 'link.2',
      name: 'Wake song',
      path: 'assets/sounds/soft_chime.wav',
      link: 'https://music.youtube.com/watch?v=abc',
      plays: true,
      playSeconds: 5,
    );
    expect(AlarmSound.fromJson(song.toJson()).plays, isTrue);
    expect(AlarmSound.fromJson(song.toJson()).playSeconds, 5);
    c.read(soundsProvider.notifier).add(song);
    final alarms = c.read(userAlarmsProvider.notifier);
    alarms.save(const UserAlarm(id: 'tue', hour: 7, minute: 0, days: {3}, soundId: 'link.2'));
    alarms.save(const UserAlarm(id: 'sat', hour: 10, minute: 0, days: {6}, soundId: 'link.2'));
    alarms.save(
      const UserAlarm(
        id: 'sum',
        hour: 8,
        minute: 0,
        days: {3},
        soundId: 'link.2',
        style: RingStyle(task: StopTask.sum),
      ),
    );

    final p = RingPayload.decode(_payloadOf(c, 'user.tue').encode());
    expect(p.song, song.link);
    expect(p.link, isNull);
    expect(p.songSeconds, 5);
    expect(p.sound, 'assets/sounds/soft_chime.wav'); // the backup
    expect(p.loudness.backupForSong.fadeInSeconds, greaterThanOrEqualTo(30));
    expect(p.snoozed().song, song.link);
    expect(p.check().song, isNull);

    // Never on Shabbat.
    final sat = _payloadOf(c, 'user.sat');
    expect(sat.song, isNull);
    expect(sat.link, isNull);

    // With a task, it rings and opens the song after.
    final sum = _payloadOf(c, 'user.sum');
    expect(sum.song, isNull);
    expect(sum.link, song.link);

    // Switched to "ring, then open".
    c.read(soundsProvider.notifier).replace(song.copyWith(plays: false));
    final open = _payloadOf(c, 'user.tue');
    expect(open.song, isNull);
    expect(open.link, song.link);
    expect(open.songSeconds, 5);
  });

  test('radio rings live, but a built-in sound on Shabbat', () async {
    final c = await _container();
    const radio = AlarmSound(id: 'radio.1', name: 'Jazz', path: 'https://stream.example.com/jazz.mp3');
    expect(radio.isRadio, isTrue);
    c.read(soundsProvider.notifier).add(radio);
    final alarms = c.read(userAlarmsProvider.notifier);
    // Tuesday is a weekday; Saturday morning is inside Shabbat.
    alarms.save(const UserAlarm(id: 'tue', hour: 7, minute: 0, days: {3}, soundId: 'radio.1'));
    alarms.save(const UserAlarm(id: 'sat', hour: 10, minute: 0, days: {6}, soundId: 'radio.1'));
    expect(_payloadOf(c, 'user.tue').sound, radio.path);
    final sat = _payloadOf(c, 'user.sat');
    expect(sat.shabbatSafe, isTrue);
    expect(sat.sound, startsWith('assets/sounds/'));
  });

  test('a gentle wake-up is planned before the alarm, quieter', () async {
    final c = await _container();
    c
        .read(userAlarmsProvider.notifier)
        .save(
          const UserAlarm(
            id: 'a',
            hour: 7,
            minute: 0,
            days: {3},
            style: RingStyle(gentleMinutes: 15, gentleSound: 'calm.birds'),
          ),
        );
    final plan = c.read(planProvider);
    final real = plan.firstWhere((a) => a.ruleId == 'user.a');
    final soft = plan.firstWhere((a) => a.ruleId == 'gentle.user.a');
    expect(real.at.difference(soft.at), const Duration(minutes: 15));
    final p = c.read(payloadForProvider)(soft);
    expect(p.loudness.volume, 42); // 60% of the default 70%
    expect(p.sound, 'assets/sounds/gentle_birds.ogg');
    expect(p.canSnooze, isFalse);
    // The week list shows only the real alarm.
    expect(c.read(fullPlanProvider).where((a) => a.ruleId.startsWith('gentle.')), isEmpty);
  });

  test('radio search reads stations and skips broken ones', () async {
    final dir = RadioDirectory(
      client: MockClient((req) async {
        expect(req.url.queryParameters['name'], 'jazz');
        return http.Response(
          '[{"name":"Jazz FM","url":"http://x/pls","url_resolved":"https://jazz.example/live",'
          '"country":"France","codec":"MP3","bitrate":128},'
          '{"name":"Broken","url":"ftp://nope","url_resolved":""},'
          '{"name":"Jazz FM again","url_resolved":"https://jazz.example/live"}]',
          200,
        );
      }),
    );
    final r = await dir.search('jazz');
    expect(r.map((s) => s.name), ['Jazz FM']);
    expect(r.single.url, 'https://jazz.example/live');
    expect(r.single.details, 'France · MP3 128 kbps');
  });

  test('Spotify links turn into what Spotify plays', () {
    expect(SpotifyPlay.uriOf('https://open.spotify.com/track/4uLU6hMC?si=x'), 'spotify:track:4uLU6hMC');
    expect(SpotifyPlay.uriOf('https://open.spotify.com/intl-pt/playlist/37i9'), 'spotify:playlist:37i9');
    expect(SpotifyPlay.uriOf('spotify:album:1'), 'spotify:album:1');
    expect(SpotifyPlay.uriOf('https://music.youtube.com/watch?v=abc'), isNull);
    expect(SpotifyPlay.uriOf('https://open.spotify.com/user/me'), isNull);
  });
}
