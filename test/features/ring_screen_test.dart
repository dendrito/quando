import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/service/alarm_storage.dart';
import 'package:alarm/src/generated/platform_bindings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  late GlobalKey<NavigatorState> navigator;
  late AlarmRegistrar registrar;
  final hostCalls = <String>[];

  setUp(() async {
    useLocale([const Locale('en')]);
    SharedPreferences.setMockInitialValues({});
    await AlarmStorage.init();
    navigator = GlobalKey<NavigatorState>();
    registrar = AlarmRegistrar();
    hostCalls.clear();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (_) async => 1,
    );
    for (final method in ['stopAlarm', 'setAlarm', 'getPendingAlarmEvents']) {
      final channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.alarm.AlarmApi.$method',
        AlarmApi.pigeonChannelCodec,
      );
      binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (message) async {
        hostCalls.add(method);
        return method == 'getPendingAlarmEvents' ? [<Object?>[]] : [null];
      });
      addTearDown(() => binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null));
    }
  });

  tearDown(() async {
    await registrar.dispose();
    Alarm.resetForTesting();
    AlarmStorage.resetForTesting();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('flutter_tts'), null);
  });

  Future<void> home(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [registrarProvider.overrideWithValue(registrar)],
        child: MaterialApp(
          navigatorKey: navigator,
          theme: buildTheme(),
          home: const Scaffold(body: Text('Alarm home')),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<AlarmSettings> ring(WidgetTester tester, int id, RingPayload payload) async {
    final alarm = AlarmRegistrar.settingsFor(id, DateTime.now(), payload);
    Alarm.alarmRang(alarm);
    navigator.currentState!.push(MaterialPageRoute<void>(builder: (_) => RingScreen(alarm: alarm)));
    await tester.pumpAndSettle();
    return alarm;
  }

  const gentle = RingPayload(
    title: 'Gentle Havdalah',
    body: '20 min to go',
    ringSeconds: 1185,
    spoken: false,
    gentle: true,
    shabbatSafe: true,
  );
  const mainAlarm = RingPayload(title: 'Main alarm', body: '', ringSeconds: 60, spoken: false);

  Future<void> press(WidgetTester tester, String label) async {
    await tester.runAsync(() async {
      await tester.tap(find.text(label));
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pumpAndSettle();
  }

  testWidgets('Stop dismisses a gentle Shabbat alarm with one tap', (tester) async {
    await home(tester);
    await ring(tester, 1, gentle);
    await press(tester, 'Stop');
    expect(hostCalls, contains('stopAlarm'));
    expect(Alarm.ringing.value.alarms, isEmpty);
    expect(find.byType(RingScreen), findsNothing);
    expect(find.text('Alarm home'), findsOneWidget);
    expect(Alarm.ringing.value.alarms, isEmpty);
    expect(hostCalls.where((c) => c == 'stopAlarm'), hasLength(1));
  });

  testWidgets('a stopped underlying alarm removes its own card, leaving the current alarm usable', (
    tester,
  ) async {
    await home(tester);
    await ring(tester, 1, gentle);
    await ring(tester, 2, mainAlarm);
    await tester.runAsync(() => Alarm.stop(1));
    await tester.pumpAndSettle();
    expect(find.text('Main alarm'), findsOneWidget);
    expect(find.text('Gentle Havdalah'), findsNothing);
    await press(tester, 'Stop');
    expect(find.byType(RingScreen), findsNothing);
    expect(find.text('Alarm home'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Stop keeps the wake-up check card until I am up is confirmed', (tester) async {
    await home(tester);
    await ring(
      tester,
      1,
      const RingPayload(title: 'Wake', body: '', ringSeconds: 60, spoken: false, wakeCheck: true),
    );
    await press(tester, 'Stop');
    expect(find.byType(RingScreen), findsOneWidget);
    expect(find.text(l10n.imUp), findsOneWidget);
    await press(tester, l10n.imUp);
    expect(find.byType(RingScreen), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Snooze closes its card and retains the scheduled follow-up', (tester) async {
    await home(tester);
    await ring(
      tester,
      1,
      const RingPayload(title: 'Wake', body: '', ringSeconds: 60, spoken: false, maxSnoozes: 1),
    );
    await press(tester, l10n.snoozeMinLeft(5, 1));
    expect(find.byType(RingScreen), findsNothing);
    final alarms = await tester.runAsync(Alarm.getAlarms);
    expect(alarms, hasLength(1));
    expect(RingPayload.decode(alarms!.single.payload).snoozeCount, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('two quick Stop taps request only one stop', (tester) async {
    final pending = _PendingStopRegistrar();
    registrar = pending;
    await home(tester);
    await ring(tester, 1, gentle);
    await tester.tap(find.text('Stop'));
    await tester.tap(find.text('Stop'));
    expect(pending.calls, 1);
    pending.result.complete(null);
    await tester.pumpAndSettle();
    expect(find.byType(RingScreen), findsNothing);
  });
}

class _PendingStopRegistrar extends AlarmRegistrar {
  final result = Completer<int?>();
  var calls = 0;

  @override
  Future<int?> stop(AlarmSettings ringing) {
    calls++;
    return result.future;
  }
}
