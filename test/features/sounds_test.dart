import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/ringing/ring_payload.dart';
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
}
