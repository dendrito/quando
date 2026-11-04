import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
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
        .save(const UserAlarm(id: 'a', hour: 7, minute: 0, days: {3}, style: RingStyle(gentleMinutes: 15)));
    final plan = c.read(planProvider);
    final real = plan.firstWhere((a) => a.ruleId == 'user.a');
    final soft = plan.firstWhere((a) => a.ruleId == 'gentle.user.a');
    expect(real.at.difference(soft.at), const Duration(minutes: 15));
    final p = c.read(payloadForProvider)(soft);
    expect(p.loudness.volume, 35);
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
}
