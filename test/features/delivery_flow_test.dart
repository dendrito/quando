import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/integrations/data/sender.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_style.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:quando/features/rules/ui/delivery_tile.dart';
import 'package:quando/features/rules/ui/preset_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

const connected = IntegrationSettings(
  pushoverOn: true,
  pushoverUser: 'test-user',
  pushoverToken: 'test-token',
  pushoverSound: 'global',
  pushoverDevices: {'global-phone'},
);
const remote = ReminderDelivery(
  localAudio: false,
  pushoverEnabled: true,
  pushoverSound: 'custom',
  pushoverDevices: {'ipad'},
);
const local = ReminderDelivery(pushoverEnabled: false);
const both = ReminderDelivery(pushoverEnabled: true);

Future<SharedPreferences> prefs({bool ready = true}) async {
  SharedPreferences.setMockInitialValues({
    'integrations': jsonEncode((ready ? connected : const IntegrationSettings()).toJson()),
  });
  return SharedPreferences.getInstance();
}

void main() {
  setUp(() {
    useLocale([const Locale('en')]);
    ensureTimeZones();
  });
  tearDown(() => useLocale([const Locale('en')]));

  test('normal alarms persist delivery, keep IDs, and carry choices into cold-start payloads', () {
    final at = DateTime.utc(2026, 11, 7, 12);
    final original = UserAlarm(id: 'a', hour: 12, minute: 0, onceAt: at, delivery: remote);
    final restored = UserAlarm.fromJson(jsonDecode(jsonEncode(original.toJson())));
    final planned = restored.plan(
      now: at.subtract(const Duration(hours: 1)),
      horizon: const Duration(days: 1),
      zone: 'UTC',
      defaultRing: const Duration(seconds: 3),
    );
    expect(planned.single.delivery.localAudio, isFalse);
    expect(planned.single.delivery.pushoverDevices, {'ipad'});
    final payload = const RingPayload(
      title: 'A',
      body: 'B',
      ringSeconds: 3,
    ).withDelivery(remote).withStyle(RingStyle.none);
    for (final p in [payload, payload.snoozed(), payload.asPreview(), payload.withSound('local.wav')]) {
      final decoded = RingPayload.decode(p.encode());
      expect(decoded.delivery.toJson(), remote.toJson());
    }
    final oldJson = original.toJson()..remove('delivery');
    expect(UserAlarm.fromJson(oldJson).delivery.localAudio, isTrue);
    expect(RingPayload.decode('{"title":"Legacy","ringSeconds":1}').delivery.pushoverEnabled, isNull);
  });

  test('Pushover sender honors local-only and overrides sound/devices per item', () async {
    final requests = <http.Request>[];
    final sender = IntegrationSender(
      () => connected,
      client: MockClient((r) async {
        requests.add(r);
        return http.Response('{"status":1}', 200);
      }),
    );
    const p = RingPayload(title: 'Reminder', body: 'Soon', ringSeconds: 3);
    await sender.send(AlarmHappening.ring, p.withDelivery(local));
    expect(requests, isEmpty);
    await sender.send(AlarmHappening.ring, RingPayload.decode(p.withDelivery(remote).encode()));
    expect(requests.single.bodyFields['sound'], 'custom');
    expect(requests.single.bodyFields['device'], 'ipad');
    await sender.send(AlarmHappening.ring, p.withDelivery(remote.copyWith(pushoverDevices: {})));
    expect(requests.last.bodyFields.containsKey('device'), isFalse);
    await sender.send(AlarmHappening.ring, p.withDelivery(both));
    expect(requests.last.bodyFields['sound'], 'global');
    expect(requests.last.bodyFields['device'], 'global-phone');
    await sender.send(AlarmHappening.stopped, p.withDelivery(remote));
    expect(requests, hasLength(3));
  });

  test('remote-only native registration is silent and avoids radio streams/fullscreen/vibration', () {
    final p = const RingPayload(
      title: 'A',
      body: 'B',
      ringSeconds: 60,
      sound: 'https://example.com/radio',
    ).withDelivery(remote);
    final settings = AlarmRegistrar.settingsFor(42, DateTime.utc(2026, 11, 7), p);
    expect(settings.volumeSettings.volume, 0);
    expect(settings.assetAudioPath, isNull);
    expect(settings.vibrate, isFalse);
    expect(settings.androidFullScreenIntent, isFalse);
    final normal = AlarmRegistrar.settingsFor(42, DateTime.utc(2026, 11, 7), p.withDelivery(both));
    expect(normal.vibrate, isTrue);
    expect(normal.androidFullScreenIntent, isTrue);
    expect(normal.assetAudioPath, 'https://example.com/radio');
  });

  test('disabled or Shabbat-paused Pushover keeps a local fallback; remote lead-ups are absent', () async {
    final saved = await prefs();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(saved)]);
    addTearDown(c.dispose);
    ScheduledAlarm alarm(DateTime at) => ScheduledAlarm(
      id: 1,
      at: at,
      title: 'A',
      body: 'B',
      ringDuration: const Duration(seconds: 3),
      ruleId: 'user.a',
      eventId: 'a',
      offset: Duration.zero,
      delivery: remote,
    );
    final outside = alarm(DateTime.utc(2026, 11, 9, 12));
    expect(c.read(payloadForProvider)(outside).localAudio, isFalse);
    final period = c.read(periodsProvider).first;
    expect(
      c.read(payloadForProvider)(alarm(period.start.add(const Duration(minutes: 1)))).localAudio,
      isTrue,
    );
    c.read(integrationsProvider.notifier).update((s) => s.copyWith(pushoverOn: false));
    expect(c.read(payloadForProvider)(outside).localAudio, isTrue);
    expect(gentleBefore(outside, outside.at.subtract(const Duration(hours: 1))), isNull);
  });

  testWidgets('inline choices keep each reminder independent and load actual account sounds', (tester) async {
    final saved = await prefs();
    final sender = IntegrationSender(
      () => connected,
      client: MockClient(
        (r) async => http.Response(
          r.url.path.endsWith('sounds.json')
              ? '{"sounds":{"custom":"Custom sound"},"status":1}'
              : '{"devices":["ipad"],"status":1}',
          200,
        ),
      ),
    );
    var first = local, second = local;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefsProvider.overrideWithValue(saved),
          integrationSenderProvider.overrideWithValue(sender),
        ],
        child: MaterialApp(
          theme: buildTheme(),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => ListView(
                children: [
                  DeliveryTile(
                    title: '1 hour before',
                    value: first,
                    initiallyExpanded: true,
                    onChanged: (v) => setState(() => first = v),
                  ),
                  DeliveryTile(
                    title: '15 minutes before',
                    value: second,
                    onChanged: (v) => setState(() => second = v),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('delivery-push')).first);
    await tester.pumpAndSettle();
    expect(first.localAudio, isFalse);
    expect(first.pushoverEnabled, isTrue);
    expect(second.pushoverEnabled, isFalse);
    await tester.ensureVisible(find.text('Load from Pushover').first);
    await tester.tap(find.text('Load from Pushover').first);
    await tester.pumpAndSettle();
    expect(find.text('ipad'), findsOneWidget);
    await tester.tap(find.text('ipad'));
    await tester.pumpAndSettle();
    expect(first.pushoverDevices, {'ipad'});
    expect(tester.takeException(), isNull);
  });

  testWidgets('unconnected Pushover cannot be selected and gives a connection action', (tester) async {
    final saved = await prefs(ready: false);
    var changed = false;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(saved)],
        child: MaterialApp(
          theme: buildTheme(),
          home: Scaffold(
            body: DeliveryTile(
              title: 'Reminder',
              value: local,
              initiallyExpanded: true,
              onChanged: (_) => changed = true,
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('delivery-push')));
    await tester.pumpAndSettle();
    expect(changed, isFalse);
    expect(find.text('Connect Pushover'), findsOneWidget);
  });

  testWidgets('preset row choices save immediately and survive reopening', (tester) async {
    final saved = await prefs();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(saved)]);
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: PresetScreen(id: Presets.countdown.id),
        ),
      ),
    );
    await tester.tap(find.text('2 hours before'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('delivery-push')).first);
    await tester.pumpAndSettle();
    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(saved)]);
    addTearDown(again.dispose);
    expect(
      again
          .read(rulesProvider)
          .firstWhere((r) => r.id == Presets.countdown.id)
          .deliveryAt(const Duration(hours: -2))
          .localAudio,
      isFalse,
    );
  });

  testWidgets('phone-size editor renders in English, Portuguese and Hebrew', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final font = FontLoader('Bricolage')
      ..addFont(rootBundle.load('assets/fonts/BricolageGrotesque-Regular.ttf'));
    await font.load();
    final icons = FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    final saved = await prefs();
    for (final lang in ['en', 'pt', 'he']) {
      final locale = useLocale([Locale(lang)]);
      final key = GlobalKey();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [prefsProvider.overrideWithValue(saved)],
          child: MaterialApp(
            theme: buildTheme(),
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: Scaffold(
              body: RepaintBoundary(
                key: key,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    DeliveryTile(
                      key: ValueKey(lang),
                      title: l10n.minutesShort(15),
                      value: both,
                      initiallyExpanded: true,
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      if (lang == 'en') {
        await tester.runAsync(() async {
          final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await File('/private/tmp/quando-delivery-editor.png').writeAsBytes(bytes!.buffer.asUint8List());
        });
      }
    }
  });
}
