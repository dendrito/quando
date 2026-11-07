import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/service/alarm_storage.dart';
import 'package:alarm/src/alarm_trigger_api_impl.dart';
import 'package:alarm/src/generated/platform_bindings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/util/platform.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/calendar/data/mac_calendar_reader.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    Alarm.resetForTesting();
    AlarmStorage.resetForTesting();
    AlarmTriggerApiImpl.resetForTesting();
  });

  test('Mac enables real alarms; preview platforms remain unsupported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(supportsLocalAlarms, isTrue);
    expect(Alarm.iOS, isFalse);
    expect(StopWay.onThisPhone, isEmpty);
    expect(StopTask.onThisDevice, isNot(contains(StopTask.shake)));
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(supportsLocalAlarms, isFalse);
  });

  test('Mac calendars preserve permission boundaries, recurrence IDs and end labels', () async {
    final calls = <MethodCall>[];
    var granted = false;
    binding.defaultBinaryMessenger.setMockMethodCallHandler(MacCalendarReader.channel, (call) async {
      calls.add(call);
      return switch (call.method) {
        'hasAccess' => granted,
        'requestAccess' => granted = true,
        'calendars' => [
          {'id': 'work', 'name': 'Work', 'account': 'Local'},
        ],
        'events' => [
          {
            'instanceId': 'work:recurring:1',
            'calendarId': 'work',
            'title': 'Meeting',
            'start': 1000,
            'end': 2000,
          },
          {
            'instanceId': 'work:recurring:2',
            'calendarId': 'work',
            'title': 'Meeting',
            'start': 3000,
            'end': 4000,
          },
        ],
        _ => throw StateError('Unexpected ${call.method}'),
      };
    });
    addTearDown(
      () => binding.defaultBinaryMessenger.setMockMethodCallHandler(MacCalendarReader.channel, null),
    );
    final reader = MacCalendarReader();
    expect(await reader.hasAccess(), isFalse);
    expect(calls.map((c) => c.method), ['hasAccess']);
    expect(await reader.requestAccess(), isTrue);
    expect((await reader.calendars()).single.id, 'work');
    final from = DateTime.utc(2026, 11, 6);
    expect(await reader.events(from, from.add(const Duration(days: 1)), {}), isEmpty);
    expect(calls.where((c) => c.method == 'events'), isEmpty);
    final events = await reader.events(from, from.add(const Duration(days: 1)), {'work'});
    expect(events.map((e) => e.id).toSet(), hasLength(4));
    expect(events[1].title, contains('Meeting'));
    expect(events[1].title, isNot('Meeting'));
    expect(events.first.at, DateTime.fromMillisecondsSinceEpoch(1000, isUtc: true));
    expect((calls.last.arguments as Map)['calendarIds'], ['work']);
    binding.defaultBinaryMessenger.setMockMethodCallHandler(MacCalendarReader.channel, (_) async {
      throw PlatformException(code: 'calendar-access');
    });
    await expectLater(reader.calendars(), throwsA(isA<PlatformException>()));
  });

  test('Mac host ring callback reaches registrar and stops at the chosen length', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    SharedPreferences.setMockInitialValues({});
    final pending = <int, AlarmSettingsWire>{};
    var hostRinging = false;
    for (final method in ['setAlarm', 'stopAlarm', 'stopAll', 'getPendingAlarmEvents', 'isRinging']) {
      final channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.alarm.AlarmApi.$method',
        AlarmApi.pigeonChannelCodec,
      );
      binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (message) async {
        final args = message as List<Object?>?;
        switch (method) {
          case 'setAlarm':
            final settings = args!.single! as AlarmSettingsWire;
            pending[settings.id] = settings;
          case 'stopAlarm':
            pending.remove(args!.single! as int);
            hostRinging = false;
          case 'stopAll':
            pending.clear();
            hostRinging = false;
          case 'getPendingAlarmEvents':
            return [<Object?>[]];
          case 'isRinging':
            return [hostRinging];
        }
        return [null];
      });
      addTearDown(() => binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null));
    }
    final registrar = AlarmRegistrar();
    addTearDown(registrar.dispose);
    final happenings = <AlarmHappening>[];
    final stopped = Completer<void>();
    registrar.onHappening = (what, _) {
      happenings.add(what);
      if (what == AlarmHappening.autoStopped) stopped.complete();
    };
    await registrar.set(
      9123,
      DateTime.now().add(const Duration(minutes: 5)),
      const RingPayload(title: 'Mac test', body: '', ringSeconds: 1, spoken: false),
    );
    expect(pending.keys, [9123]);
    hostRinging = true;
    await binding.defaultBinaryMessenger.handlePlatformMessage(
      'dev.flutter.pigeon.alarm.AlarmTriggerApi.alarmRang',
      AlarmTriggerApi.pigeonChannelCodec.encodeMessage([9123]),
      null,
    );
    await Future<void>.delayed(Duration.zero);
    expect(happenings, [AlarmHappening.ring]);
    expect(Alarm.ringing.value.alarms.single.id, 9123);
    await stopped.future.timeout(const Duration(seconds: 3));
    expect(pending, isEmpty);
    expect(Alarm.ringing.value.alarms, isEmpty);
    expect(happenings, contains(AlarmHappening.autoStopped));
    await registrar.dispose();
  });
}
