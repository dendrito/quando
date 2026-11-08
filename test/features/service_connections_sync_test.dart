import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/features/integrations/data/pushover_credentials_sync.dart';
import 'package:quando/features/integrations/data/service_connections_sync.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/integrations/domain/tuya.dart';
import 'package:quando/features/ringing/data/spotify.dart';
import 'package:quando/features/sync/key_vault.dart';
import 'package:quando/features/sounds/data/spotify_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const setup = IntegrationSettings(
    pushoverOn: true,
    pushoverUser: 'u',
    pushoverToken: 'p',
    tuya: TuyaSettings(clientId: 'tuya-client', secret: 'tuya-secret', uid: 'tuya-user'),
    webhooks: [
      Webhook(
        id: 'home',
        kind: WebhookKind.homeAssistant,
        url: 'http://homeassistant.local:8123/api/webhook/private',
      ),
    ],
  );
  Map<String, Object> vault([String uid = 'owner']) => {
    'vault.key': base64Encode(List.filled(32, 7)),
    'vault.salt': base64Encode(List.filled(16, 3)),
    'vault.owner': uid,
    'keys.protection': 'passphrase',
  };

  Future<SharedPreferences> device(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues({...vault(), ...values});
    final p = await SharedPreferences.getInstance();
    await p.reload();
    return p;
  }

  IntegrationSettings local(SharedPreferences p) =>
      IntegrationSettings.fromJson(jsonDecode(p.getString('integrations')!) as Map<String, dynamic>);
  Future<Map<String, dynamic>> shared(SharedPreferences p) async =>
      jsonDecode((await KeyVault.read(p, ServiceConnectionsSync.key))!) as Map<String, dynamic>;

  test('portable keys follow the account while new devices keep automations disabled', () async {
    final a = await device({
      'integrations': jsonEncode(setup.toJson()),
      'spotify.refresh': 'spotify-original',
      'sync.on': true,
    });
    await PushoverCredentialsSync.activate(a, 'owner');
    await ServiceConnectionsSync.activate(a, 'owner');
    final encoded = a.getString(ServiceConnectionsSync.key)!;
    expect((await shared(a))['uid'], 'owner');
    expect((await shared(a)).keys, unorderedEquals(['uid', 'tuya', 'spotify', 'webhooks']));
    final b = await device({
      'sync.on': true,
      'integrations': jsonEncode(const IntegrationSettings(pushoverSound: 'siren').toJson()),
    });
    await PushoverCredentialsSync.activate(b, 'owner');
    await ServiceConnectionsSync.activate(b, 'owner');
    await b.setString(ServiceConnectionsSync.key, encoded);
    await ServiceConnectionsSync.applyReceived(b);
    expect(b.getString('spotify.refresh'), 'spotify-original');
    expect(b.getBool('spotify.library'), isTrue);
    expect(local(b).tuya.secret, 'tuya-secret');
    expect(local(b).pushoverSound, 'siren');
    expect(local(b).webhooks.single.enabled, isFalse);
    expect(local(b).webhooks.single.url, setup.webhooks.single.url);
  });

  test('switching accounts isolates all portable connections and restores only their owner cache', () async {
    final p = await device({
      'integrations': jsonEncode(setup.toJson()),
      'spotify.refresh': 'spotify-owner',
      'sync.on': true,
    });
    await PushoverCredentialsSync.activate(p, 'first');
    await ServiceConnectionsSync.activate(p, 'first');
    await PushoverCredentialsSync.activate(p, 'second');
    await ServiceConnectionsSync.activate(p, 'second');
    expect(p.getString('spotify.refresh'), isNull);
    expect(local(p).tuya.ready, isFalse);
    expect(local(p).webhooks, isEmpty);
    expect(p.getString(ServiceConnectionsSync.key), isNull);
    await PushoverCredentialsSync.activate(p, 'first');
    await ServiceConnectionsSync.activate(p, 'first');
    expect(p.getString('spotify.refresh'), 'spotify-owner');
    expect(local(p).tuya.secret, 'tuya-secret');
    expect(local(p).webhooks.single.enabled, isFalse);
  });

  test('foreign-owner snapshots and other Spotify client tokens are not applied', () async {
    final p = await device({
      'integrations': jsonEncode(setup.toJson()),
      'spotify.refresh': 'keep',
      'sync.on': true,
    });
    await PushoverCredentialsSync.activate(p, 'owner');
    await ServiceConnectionsSync.activate(p, 'owner');
    await p.setString(
      ServiceConnectionsSync.key,
      jsonEncode({
        'uid': 'foreign',
        'spotify': {'client': SpotifyPlay.clientId, 'refresh': 'foreign'},
        'webhooks': [],
      }),
    );
    await ServiceConnectionsSync.applyReceived(p);
    expect(p.getString('spotify.refresh'), 'keep');
    expect(local(p).webhooks, hasLength(1));
    await p.setString(
      ServiceConnectionsSync.key,
      jsonEncode({
        'uid': 'owner',
        'spotify': {'client': 'other-client', 'refresh': 'foreign'},
      }),
    );
    await ServiceConnectionsSync.applyReceived(p);
    expect(p.getString('spotify.refresh'), 'keep');
    await p.setString(
      ServiceConnectionsSync.key,
      jsonEncode({
        'uid': 'foreign',
        'spotify': {'refresh': 'foreign'},
      }),
    );
    await ServiceConnectionsSync.activate(p, 'owner');
    expect((await shared(p))['uid'], 'owner');
  });

  test('Spotify can refresh a received credential and publishes token rotation', () async {
    final p = await device({
      'integrations': jsonEncode(setup.toJson()),
      'spotify.refresh': 'received-refresh',
      'sync.on': true,
    });
    await PushoverCredentialsSync.activate(p, 'owner');
    await ServiceConnectionsSync.activate(p, 'owner');
    final result = await SpotifyAccount.token(
      p,
      prompt: false,
      client: MockClient((r) async {
        expect(r.url.host, 'accounts.spotify.com');
        expect(r.bodyFields['refresh_token'], 'received-refresh');
        return http.Response(
          '{"access_token":"access-new","refresh_token":"rotated-refresh","expires_in":3600}',
          200,
        );
      }),
    );
    expect(result, 'access-new');
    expect(((await shared(p))['spotify'] as Map)['refresh'], 'rotated-refresh');
    await SpotifyAccount.signOut(p);
    expect((await shared(p)).containsKey('spotify'), isFalse);
  });

  test(
    'temporary Spotify failures retain the shared credential; revoked grants require reconnection',
    () async {
      final p = await device({
        'integrations': jsonEncode(setup.toJson()),
        'spotify.refresh': 'retry-refresh',
        'sync.on': true,
      });
      await PushoverCredentialsSync.activate(p, 'owner');
      await ServiceConnectionsSync.activate(p, 'owner');
      await expectLater(
        SpotifyAccount.token(p, prompt: false, client: MockClient((_) async => http.Response('{}', 503))),
        throwsA(isA<SpotifyAuthException>()),
      );
      expect(p.getString('spotify.refresh'), 'retry-refresh');
      expect(
        await SpotifyAccount.token(
          p,
          prompt: false,
          client: MockClient((_) async => http.Response('{"error":"invalid_grant"}', 400)),
        ),
        isNull,
      );
      expect(p.getString('spotify.refresh'), isNull);
      expect((await shared(p)).containsKey('spotify'), isFalse);
    },
  );
}
