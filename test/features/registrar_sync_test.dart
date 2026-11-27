import 'package:alarm/alarm.dart';
import 'package:alarm/service/alarm_storage.dart';
import 'package:alarm/src/generated/platform_bindings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final calls = <String>[];
  final stopped = <int>[];
  final armed = <int>[];
  final nativeRings = <int>{};

  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    SharedPreferences.setMockInitialValues({});
    await AlarmStorage.init();
    calls.clear();
    stopped.clear();
    armed.clear();
    nativeRings.clear();
    for (final method in ['stopAll', 'stopAlarm', 'setAlarm', 'isRinging', 'getPendingAlarmEvents']) {
      final channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.alarm.AlarmApi.$method',
        AlarmApi.pigeonChannelCodec,
      );
      binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (message) async {
        calls.add(method);
        if (method == 'getPendingAlarmEvents') return [<Object?>[]];
        if (method == 'isRinging') return [nativeRings.contains((message as List).first)];
        if (method == 'stopAlarm') stopped.add((message as List).first as int);
        if (method == 'setAlarm') armed.add(((message as List).first as AlarmSettingsWire).id);
        return method == 'setAlarm' ? [true] : [null];
      });
      addTearDown(() => binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null));
    }
  });

  tearDown(() {
    Alarm.resetForTesting();
    AlarmStorage.resetForTesting();
    debugDefaultTargetPlatformOverride = null;
  });

  test('a replan while an alarm is ringing does not silence it', () async {
    final registrar = AlarmRegistrar();
    await registrar.init();
    const payload = RingPayload(title: 'Wake up', body: '', spoken: false, ringSeconds: 60);
    // Rang a few seconds ago, still ringing: it is saved, and no longer in the plan.
    final ringing = AlarmRegistrar.settingsFor(
      7,
      DateTime.now().subtract(const Duration(seconds: 20)),
      payload,
    );
    await AlarmStorage.saveAlarm(ringing);
    nativeRings.add(7);
    Alarm.alarmRang(ringing);
    await Future<void>.delayed(Duration.zero);

    final next = ScheduledAlarm(
      id: 8,
      at: DateTime.now().add(const Duration(hours: 1)),
      title: 'Later',
      body: '',
      ringDuration: const Duration(minutes: 1),
      ruleId: 'user.x',
      eventId: 'user.x',
      offset: Duration.zero,
    );
    await registrar.sync([next], (_) => payload);

    expect(stopped, isNot(contains(7)));
    expect(armed, contains(8));
    await registrar.dispose();
  });

  test('a replan still removes alarms that are no longer planned', () async {
    final registrar = AlarmRegistrar();
    await registrar.init();
    const payload = RingPayload(title: 'Old', body: '', spoken: false, ringSeconds: 60);
    await AlarmStorage.saveAlarm(
      AlarmRegistrar.settingsFor(9, DateTime.now().add(const Duration(hours: 2)), payload),
    );
    await registrar.sync(const [], (_) => payload);
    expect(stopped, contains(9));
    await registrar.dispose();
  });
}
