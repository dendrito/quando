import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/integrations/data/pushover_credentials_sync.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/sync/key_vault.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Remote implements SyncRemote {
  final items = <String, SyncItem>{};
  int revision = 0;

  @override
  Stream<Map<String, SyncItem>> watch() => Stream.value(Map.of(items));

  @override
  Future<Map<String, SyncItem>> push(Map<String, SyncItem> changed) async {
    revision++;
    final committed = {for (final e in changed.entries) e.key: SyncItem(revision, e.value.d, e.value.s)};
    items.addAll(committed);
    return committed;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const original = IntegrationSettings(
    pushoverUser: 'test-user',
    pushoverToken: 'test-token',
    pushoverOn: true,
    pushoverSound: 'cosmic',
    pushoverPriority: 2,
    pushoverDevices: {'ipad'},
    webhooks: [Webhook(id: 'private', kind: WebhookKind.other, url: 'https://example.test/private')],
    pauseOnShabbat: false,
  );

  // The same sync passphrase key on every test device, for the 'owner' account.
  Map<String, Object> vault([String uid = 'owner']) => {
    'vault.key': base64Encode(List.filled(32, 7)),
    'vault.salt': base64Encode(List.filled(16, 3)),
    'vault.owner': uid,
    'keys.protection': 'passphrase',
  };

  Future<SharedPreferences> store(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues({...vault(), ...values});
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs;
  }

  Future<Map<String, dynamic>> opened(SharedPreferences p) async =>
      jsonDecode((await KeyVault.read(p, PushoverCredentialsSync.key))!) as Map<String, dynamic>;

  IntegrationSettings local(SharedPreferences p) =>
      IntegrationSettings.fromJson(jsonDecode(p.getString('integrations')!) as Map<String, dynamic>);

  test('existing credentials join only the authorized account, without unrelated settings', () async {
    final p = await store({'integrations': jsonEncode(original.toJson())});
    await PushoverCredentialsSync.activate(p, 'owner');
    expect(KeyVault.isEnvelope(p.getString(PushoverCredentialsSync.key)), isTrue);
    expect(p.getString(PushoverCredentialsSync.key), isNot(contains('test-token')));
    expect(await opened(p), {'uid': 'owner', 'user': 'test-user', 'token': 'test-token'});
    expect(local(p).toJson(), original.toJson());
    expect(syncedKeys, contains(PushoverCredentialsSync.key));
    expect(syncedKeys, isNot(contains('integrations')));
    expect(syncedKeys, isNot(contains(PushoverCredentialsSync.ownerKey)));
    expect(syncedKeys, isNot(contains('pushover.local.owner')));
  });

  test('another device receives keys and retains its own delivery choices', () async {
    final remote = _Remote();
    final a = await store({'integrations': jsonEncode(original.toJson()), 'sync.on': true});
    await PushoverCredentialsSync.activate(a, 'owner');
    final sender = SyncEngine(a, remote, device: 'ipad');
    await sender.apply(remote.items);
    expect(remote.items.keys, unorderedEquals([PushoverCredentialsSync.key, KeyVault.levelPref]));

    const receiverSettings = IntegrationSettings(
      pushoverSound: 'siren',
      pushoverDevices: {'mac'},
      pushoverPriority: 1,
    );
    final b = await store({'integrations': jsonEncode(receiverSettings.toJson()), 'sync.on': true});
    await PushoverCredentialsSync.activate(b, 'owner');
    final receiver = SyncEngine(
      b,
      remote,
      device: 'mac',
      onApplied: () => PushoverCredentialsSync.applyReceived(b),
    );
    await receiver.apply(remote.items);
    expect(
      local(b).toJson(),
      receiverSettings.copyWith(pushoverUser: 'test-user', pushoverToken: 'test-token').toJson(),
    );

    final changed = original.copyWith(pushoverToken: 'replacement-token');
    expect(await PushoverCredentialsSync.publish(a, changed), isTrue);
    await sender.pushLocal();
    await receiver.apply(remote.items);
    expect(local(b).pushoverToken, 'replacement-token');
    expect(local(b).pushoverDevices, {'mac'});
    expect(local(b).pushoverOn, isFalse);
  });

  test('a plain-text pair from an older build is taken in, then locked', () async {
    final p = await store({'integrations': jsonEncode(original.toJson()), 'sync.on': true});
    await PushoverCredentialsSync.activate(p, 'owner');
    final remote = _Remote();
    remote.items[PushoverCredentialsSync.key] = SyncItem(
      5,
      'other',
      jsonEncode({
        'v': jsonEncode({'uid': 'owner', 'user': 'current-user', 'token': 'current-token'}),
      }),
    );
    final engine = SyncEngine(
      p,
      remote,
      device: 'new',
      onApplied: () => PushoverCredentialsSync.applyReceived(p),
    );
    await engine.apply(remote.items);
    expect(local(p).pushoverToken, 'current-token');
    expect(remote.items[PushoverCredentialsSync.key]!.d, 'other');
    expect(KeyVault.isEnvelope(p.getString(PushoverCredentialsSync.key)), isTrue);
    await engine.pushLocal();
    final uploaded = remote.items[PushoverCredentialsSync.key]!.s!;
    expect(uploaded, isNot(contains('current-token')));
    expect((await opened(p))['token'], 'current-token');
  });

  test('account switching never seeds the previous account keys into the new account', () async {
    final p = await store({
      'integrations': jsonEncode(original.toJson()),
      'sync.on': true,
      ...vault('first'),
    });
    await PushoverCredentialsSync.activate(p, 'first');
    await PushoverCredentialsSync.activate(p, 'second');
    expect(p.getString(PushoverCredentialsSync.key), isNull);
    expect(local(p).pushoverUser, isEmpty);
    expect(local(p).pushoverToken, isEmpty);
    expect(local(p).webhooks.single.url, original.webhooks.single.url);
    expect(await PushoverCredentialsSync.publish(p, local(p)), isFalse);
    await PushoverCredentialsSync.activate(p, 'first');
    expect(local(p).pushoverToken, 'test-token');
    expect((await opened(p))['uid'], 'first');
  });

  test('foreign, incomplete and malformed received pairs cannot replace local keys', () async {
    final p = await store({'integrations': jsonEncode(original.toJson()), 'sync.on': true});
    await PushoverCredentialsSync.activate(p, 'owner');
    for (final value in [
      '{',
      '[]',
      jsonEncode({'uid': 'another', 'user': 'foreign', 'token': 'foreign'}),
      jsonEncode({'uid': 'owner', 'user': ' ', 'token': 'partial'}),
      jsonEncode({'uid': 'owner', 'user': 12, 'token': 'partial'}),
    ]) {
      await p.setString(PushoverCredentialsSync.key, value);
      await PushoverCredentialsSync.applyReceived(p);
      expect(local(p).toJson(), original.toJson());
    }
  });

  test('publishing requires active matching account and both keys', () async {
    final p = await store({'integrations': jsonEncode(original.toJson())});
    expect(await PushoverCredentialsSync.publish(p, original), isFalse);
    await PushoverCredentialsSync.activate(p, 'owner');
    expect(await PushoverCredentialsSync.publish(p, original), isFalse);
    await p.setBool('sync.on', true);
    expect(await PushoverCredentialsSync.publish(p, original.copyWith(pushoverToken: ' ')), isFalse);
    expect(await PushoverCredentialsSync.publish(p, original), isTrue);
    await p.setString(PushoverCredentialsSync.accountKey, 'another');
    expect(await PushoverCredentialsSync.publish(p, original), isFalse);
  });
}
