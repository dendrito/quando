import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/integrations/data/sender.dart';
import 'package:quando/features/integrations/data/tuya_client.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/integrations/domain/tuya.dart';
import 'package:quando/features/integrations/ui/tuya_connection_card.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';
import 'package:shared_preferences/shared_preferences.dart';

const settings = TuyaSettings(clientId: 'test-client', secret: 'test-secret', uid: 'test-user');
const scene = TuyaScene(homeId: '42', id: 'light', name: 'Bedroom light');

class _FakeTuya extends TuyaClient {
  final runs = <TuyaScene>[];
  @override
  Future<List<TuyaScene>> scenes(TuyaSettings s) async => [scene];
  @override
  Future<void> runScene(TuyaSettings s, TuyaScene scene) async {
    runs.add(scene);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('cloud signatures match Tuya published verification vector', () {
    // Public sample credentials, not a real account:
    // https://developer.tuya.com/en/docs/iot/new-singnature?id=Kbw0q34cs2e5g
    final h = TuyaClient.signedHeaders(
      const TuyaSettings(clientId: '1KAD46OrT9HafiKdsXeg', secret: '4OHBOnWOqaEC1mWXOpVL3yV50s0qGSRC'),
      'GET',
      '/v2.0/apps/schema/users?page_no=1&page_size=50',
      timestamp: '1588925778000',
      token: '3f4eda2bdec17232f67c0b188af3eec1',
      nonce: '5138cc3a9033d69856923fd07b491173',
      signatureHeaders: {'area_id': '29a33e8796834b1efa6', 'call_id': '8afdb70ab2ed11eb85290242ac130003'},
    );
    expect(h['sign'], 'AE4481C692AA80B25F3A7E12C3A5FD9BBF6251539DD78E565A1A72A508A88784');
  });

  test('loading scenes only reads; running a scene sends one command with a cached token', () async {
    final requests = <http.Request>[];
    final client = TuyaClient(
      client: MockClient((r) async {
        requests.add(r);
        final dynamic result = switch (r.url.path) {
          '/v1.0/token' => {'access_token': 'test-access', 'expire_time': 7200},
          '/v1.0/users/test-user/homes' => [
            {'home_id': 42},
          ],
          '/v1.1/homes/42/scenes' => [
            {'scene_id': 'light', 'name': 'Bedroom light'},
            {'scene_id': 'disabled', 'enabled': false},
            {'scene_id': 'expired', 'status': '2'},
          ],
          '/v1.0/homes/42/scenes/light/trigger' => true,
          _ => throw StateError('Unexpected path'),
        };
        expect(r.followRedirects, isFalse);
        return http.Response(jsonEncode({'success': true, 'result': result}), 200);
      }),
    );
    expect((await client.scenes(settings)).single.key, scene.key);
    expect(requests.every((r) => r.method == 'GET'), isTrue);
    expect(requests.first.headers.containsKey('access_token'), isFalse);
    expect(requests[1].headers['access_token'], 'test-access');
    await client.runScene(settings, scene);
    expect(requests.where((r) => r.method == 'POST'), hasLength(1));
    expect(requests.where((r) => r.url.path == '/v1.0/token'), hasLength(1));
    expect(requests.every((r) => r.url.host == TuyaRegion.usWest.host && r.url.scheme == 'https'), isTrue);
  });

  test('account sign-in sends an MD5 password, tries the next schema, and returns only the uid', () async {
    final requests = <http.Request>[];
    final client = TuyaClient(
      client: MockClient((r) async {
        requests.add(r);
        final body = jsonDecode(r.body) as Map<String, dynamic>;
        if (body['schema'] == 'smartlife') {
          return http.Response('{"success":false,"code":2406,"msg":"user does not exist"}', 200);
        }
        return http.Response(
          jsonEncode({
            'success': true,
            'result': {'uid': 'eu123', 'access_token': 'user-token', 'refresh_token': 'r'},
          }),
          200,
        );
      }),
    );
    final uid = await client.login(
      const TuyaSettings(clientId: 'test-client', secret: 'test-secret'),
      username: ' me@example.com ',
      password: 'pa55word',
      countryCode: '55',
    );
    expect(uid, 'eu123');
    expect(requests, hasLength(2));
    final sent = requests.last;
    expect(sent.method, 'POST');
    expect(sent.url.path, '/v1.0/iot-01/associated-users/actions/authorized-login');
    expect(sent.headers.containsKey('access_token'), isFalse);
    expect(sent.headers['sign'], isNotEmpty);
    final body = jsonDecode(sent.body) as Map<String, dynamic>;
    expect(body['username'], 'me@example.com');
    expect(body['country_code'], '55');
    expect(body['schema'], 'tuyaSmart');
    expect(body['password'], 'a17a41337551d6542fd005e18b43afd4');
  });

  test('Tuya errors expose codes without response secrets and no command retry', () async {
    var commands = 0;
    final client = TuyaClient(
      client: MockClient((r) async {
        if (r.url.path == '/v1.0/token') {
          return http.Response('{"success":true,"result":{"access_token":"a"}}', 200);
        }
        commands++;
        return http.Response('{"success":false,"code":1106,"msg":"sensitive diagnostic"}', 200);
      }),
    );
    await expectLater(
      client.runScene(settings, scene),
      throwsA(isA<TuyaException>().having((e) => e.toString(), 'safe error', 'Tuya (1106)')),
    );
    expect(commands, 1);
  });

  test('only an explicitly attached scene runs, and Shabbat pause still applies', () async {
    final requests = <http.Request>[];
    final sender = IntegrationSender(
      () => const IntegrationSettings(tuya: settings, smartHomeOn: true),
      client: MockClient((r) async {
        requests.add(r);
        return http.Response(
          jsonEncode({
            'success': true,
            'result': r.url.path == '/v1.0/token' ? {'access_token': 'a'} : true,
          }),
          200,
        );
      }),
    );
    const plain = RingPayload(title: 'Alarm', body: '', ringSeconds: 1);
    await sender.send(AlarmHappening.ring, plain);
    expect(requests, isEmpty);
    final alarm = plain.withDelivery(const ReminderDelivery(tuyaScene: scene));
    await sender.send(AlarmHappening.stopped, alarm);
    expect(requests, isEmpty);
    await sender.send(
      AlarmHappening.ring,
      const RingPayload(
        title: 'Shabbat',
        body: '',
        ringSeconds: 1,
        shabbatSafe: true,
        delivery: ReminderDelivery(tuyaScene: scene),
      ),
    );
    expect(requests, isEmpty);
    await sender.send(AlarmHappening.ring, alarm);
    expect(requests.where((r) => r.method == 'POST'), hasLength(1));
    final back = ReminderDelivery.fromJson(alarm.delivery.toJson());
    expect(back.tuyaScene!.key, scene.key);
    expect(jsonEncode(back.toJson()), isNot(contains('test-secret')));
    expect(back.copyWith(inheritPushoverDevices: true).tuyaScene!.key, scene.key);
    expect(back.copyWith(clearTuyaScene: true).tuyaScene, isNull);
  });

  test('smart-home URLs allow private HTTP hubs and reject public insecure endpoints', () {
    for (final value in [
      'http://homeassistant.local:8123/api/webhook/test',
      'http://192.168.1.3:1880/alarm',
      'http://10.1.0.2/a',
    ]) {
      expect(Webhook.acceptsUrl(value, WebhookKind.homeAssistant), isTrue);
      expect(Webhook.acceptsUrl(value, WebhookKind.other), isFalse);
    }
    for (final value in [
      'http://example.com/alarm',
      'https://user:password@example.com',
      'file:///private/file',
      'http://192.168.999.1/a',
    ]) {
      expect(Webhook.acceptsUrl(value, WebhookKind.nodeRed), isFalse);
    }
    expect(Webhook.acceptsUrl('https://example.test/hook', WebhookKind.homeAssistant), isTrue);
  });

  test('simultaneous scenes share authentication and receiving credentials never enables actions', () async {
    final gate = Completer<void>();
    var tokens = 0;
    var actions = 0;
    final client = TuyaClient(
      client: MockClient((r) async {
        if (r.url.path == '/v1.0/token') {
          tokens++;
          await gate.future;
          return http.Response('{"success":true,"result":{"access_token":"a"}}', 200);
        }
        actions++;
        return http.Response('{"success":true,"result":true}', 200);
      }),
    );
    final a = client.runScene(settings, scene), b = client.runScene(settings, scene);
    gate.complete();
    await Future.wait([a, b]);
    expect(tokens, 1);
    expect(actions, 2);
    final sender = IntegrationSender(
      () => const IntegrationSettings(tuya: settings),
      client: MockClient((_) async {
        fail('A connection alone must not enable device actions');
      }),
    );
    await sender.send(
      AlarmHappening.ring,
      const RingPayload(
        title: 'Alarm',
        body: '',
        ringSeconds: 1,
        delivery: ReminderDelivery(tuyaScene: scene),
      ),
    );
  });

  testWidgets('Tuya test requires a selected scene and an explicit run confirmation', (tester) async {
    SharedPreferences.setMockInitialValues({
      'integrations': jsonEncode(const IntegrationSettings(tuya: settings).toJson()),
    });
    final p = await SharedPreferences.getInstance();
    final fake = _FakeTuya();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(p), tuyaClientProvider.overrideWithValue(fake)],
        child: MaterialApp(
          theme: buildTheme(),
          home: const Scaffold(body: SingleChildScrollView(child: TuyaConnectionCard())),
        ),
      ),
    );
    await tester.tap(find.text('Tuya · Smart Life'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing); // Developer credentials start under Advanced.
    await tester.ensureVisible(find.text('Load scenes'));
    await tester.tap(find.text('Load scenes'));
    await tester.pumpAndSettle();
    expect(fake.runs, isEmpty);
    await tester.ensureVisible(find.text('Bedroom light'));
    await tester.tap(find.text('Bedroom light'));
    await tester.pumpAndSettle();
    expect(fake.runs, isEmpty);
    await tester.tap(find.widgetWithText(FilledButton, 'Run scene now'));
    await tester.pumpAndSettle();
    expect(fake.runs.single.key, scene.key);
  });
}
