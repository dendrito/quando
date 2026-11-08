import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/integrations/data/pushover_credentials_sync.dart';
import 'package:quando/features/integrations/data/service_connections_sync.dart';
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
  const setup = IntegrationSettings(
    pushoverOn: true,
    pushoverUser: 'secret-user',
    pushoverToken: 'secret-token',
    webhooks: [Webhook(id: 'hook', kind: WebhookKind.other, url: 'https://example.test/secret-hook')],
  );

  Future<SharedPreferences> device(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    final p = await SharedPreferences.getInstance();
    await p.reload();
    return p;
  }

  IntegrationSettings local(SharedPreferences p) =>
      IntegrationSettings.fromJson(jsonDecode(p.getString('integrations')!) as Map<String, dynamic>);

  Future<void> signIn(SharedPreferences p, String uid) async {
    await PushoverCredentialsSync.activate(p, uid);
    await ServiceConnectionsSync.activate(p, uid);
  }

  Future<void> share(SharedPreferences p) async {
    await PushoverCredentialsSync.publish(p, local(p));
    await ServiceConnectionsSync.publish(p);
  }

  Future<void> received(SharedPreferences p) async {
    await PushoverCredentialsSync.applyReceived(p);
    await ServiceConnectionsSync.applyReceived(p);
  }

  Future<void> lockWith(SharedPreferences p, String passphrase) async {
    await p.setString(KeyVault.levelPref, KeyProtection.passphrase.name);
    await KeyVault.setPassphrase(p, passphrase);
  }

  test('standard is the default: keys sync with the sign-in alone', () async {
    final remote = _Remote();
    final a = await device({'integrations': jsonEncode(setup.toJson()), 'sync.on': true});
    expect(KeyVault.level(a), KeyProtection.standard);
    await signIn(a, 'owner');
    await SyncEngine(a, remote, device: 'a').apply(remote.items);
    expect(await PushoverCredentialsSync.publish(a, setup), isTrue);
    final b = await device({
      'integrations': jsonEncode(const IntegrationSettings().toJson()),
      'sync.on': true,
    });
    await signIn(b, 'owner');
    await SyncEngine(b, remote, device: 'b', onApplied: () => received(b)).apply(remote.items);
    expect(local(b).pushoverToken, 'secret-token');
    expect(local(b).webhooks.single.url, 'https://example.test/secret-hook');
  });

  test('this device only keeps keys off the account and deletes the cloud copy', () async {
    final remote = _Remote();
    final p = await device({'integrations': jsonEncode(setup.toJson()), 'sync.on': true});
    await signIn(p, 'owner');
    final engine = SyncEngine(p, remote, device: 'a');
    await engine.apply(remote.items);
    expect(remote.items[PushoverCredentialsSync.key]!.s, isNotNull);
    await p.setString(KeyVault.levelPref, KeyProtection.deviceOnly.name);
    await share(p);
    await engine.pushLocal();
    expect(remote.items[PushoverCredentialsSync.key]!.s, isNull);
    expect(remote.items[ServiceConnectionsSync.key]!.s, isNull);
    expect(remote.items[KeyVault.levelPref]!.s, contains('deviceOnly'));
    expect(await PushoverCredentialsSync.publish(p, setup), isFalse);
    expect(local(p).pushoverToken, 'secret-token');
  });

  test('with the passphrase level, a locked device takes plain text out of the account', () async {
    final remote = _Remote();
    final old = jsonEncode({'uid': 'owner', 'user': 'secret-user', 'token': 'secret-token'});
    remote.items[PushoverCredentialsSync.key] = SyncItem(3, 'old', jsonEncode({'v': old}));
    final p = await device({
      'integrations': jsonEncode(const IntegrationSettings().toJson()),
      'sync.on': true,
      'keys.protection': 'passphrase',
    });
    await signIn(p, 'owner');
    final engine = SyncEngine(p, remote, device: 'new', onApplied: () => received(p));
    await engine.apply(remote.items);
    expect(local(p).pushoverToken, 'secret-token');
    await engine.pushLocal();
    expect(remote.items[PushoverCredentialsSync.key]!.s, isNull);
  });

  test('a passphrase locks the keys; another device opens them only with it', () async {
    final remote = _Remote();
    final a = await device({
      'integrations': jsonEncode(setup.toJson()),
      'spotify.refresh': 'secret-refresh',
      'sync.on': true,
    });
    await signIn(a, 'owner');
    await lockWith(a, 'correct horse');
    await share(a);
    final sender = SyncEngine(a, remote, device: 'a');
    await sender.apply(remote.items);
    final uploaded = remote.items.values.map((i) => i.s ?? '').join();
    for (final secret in ['secret-user', 'secret-token', 'secret-refresh', 'secret-hook']) {
      expect(uploaded, isNot(contains(secret)));
    }

    final b = await device({
      'integrations': jsonEncode(const IntegrationSettings().toJson()),
      'sync.on': true,
    });
    await signIn(b, 'owner');
    final receiver = SyncEngine(b, remote, device: 'b', onApplied: () => received(b));
    await receiver.apply(remote.items);
    expect(KeyVault.waiting(b), isTrue);
    expect(local(b).pushoverToken, isEmpty);

    // A locked device leaves the boxes alone, even when it publishes.
    await share(b);
    await receiver.pushLocal();
    expect(remote.items[PushoverCredentialsSync.key]!.d, 'a');

    expect(await KeyVault.unlock(b, 'wrong horse'), isFalse);
    expect(KeyVault.unlocked(b), isFalse);
    expect(await KeyVault.unlock(b, 'correct horse'), isTrue);
    await received(b);
    expect(KeyVault.waiting(b), isFalse);
    expect(local(b).pushoverToken, 'secret-token');
    expect(local(b).webhooks.single.url, 'https://example.test/secret-hook');
    expect(b.getString('spotify.refresh'), 'secret-refresh');
  });

  test('starting over on one device asks the others for the new passphrase', () async {
    final remote = _Remote();
    final a = await device({'integrations': jsonEncode(setup.toJson()), 'sync.on': true});
    await signIn(a, 'owner');
    await lockWith(a, 'first passphrase');
    await share(a);
    final engineA = SyncEngine(a, remote, device: 'a', onApplied: () => received(a));
    await engineA.apply(remote.items);

    final b = await device({'integrations': jsonEncode(setup.toJson()), 'sync.on': true});
    await signIn(b, 'owner');
    final engineB = SyncEngine(b, remote, device: 'b');
    await engineB.apply(remote.items);
    expect(KeyVault.waiting(b), isTrue);
    // B forgot the passphrase: it starts over with its own keys.
    await lockWith(b, 'second passphrase');
    await KeyVault.clearBoxes(b);
    await share(b);
    await engineB.pushLocal();
    expect(KeyVault.waiting(b), isFalse);

    await engineA.apply(remote.items);
    expect(KeyVault.waiting(a), isTrue);
    // A doesn't overwrite B's new boxes with the old passphrase.
    await share(a);
    await engineA.pushLocal();
    expect(remote.items[PushoverCredentialsSync.key]!.d, 'b');
    expect(await KeyVault.unlock(a, 'second passphrase'), isTrue);
    expect(KeyVault.waiting(a), isFalse);
  });

  test("a box for one account can't be opened as another's", () async {
    final p = await device({'integrations': jsonEncode(setup.toJson()), 'sync.on': true});
    await signIn(p, 'owner');
    await lockWith(p, 'correct horse');
    await share(p);
    final box = jsonDecode(p.getString(PushoverCredentialsSync.key)!) as Map<String, dynamic>;
    box['uid'] = 'someone-else';
    expect(await KeyVault.open(p, jsonEncode(box)), isNull);
    box
      ..['uid'] = 'owner'
      ..['name'] = 'services';
    expect(await KeyVault.open(p, jsonEncode(box)), isNull);
  });
}
