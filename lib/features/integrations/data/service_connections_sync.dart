import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../ringing/data/spotify.dart';
import '../../sync/key_vault.dart';
import '../domain/integrations.dart';
import '../domain/tuya.dart';
import 'pushover_credentials_sync.dart';

/// Portable service credentials, separate from per-device execution choices.
/// They travel locked with the sync passphrase (see [KeyVault]).
/// Google/YouTube SDK sessions and OS calendar permissions are not exportable.
class ServiceConnectionsSync {
  static const key = 'services.connections';
  static const _ownerKey = 'services.connections.owner';

  static Map<String, dynamic> _read(String? raw) {
    try {
      return jsonDecode(raw ?? '{}') as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static IntegrationSettings _settings(SharedPreferences p) {
    try {
      return IntegrationSettings.fromJson(_read(p.getString('integrations')));
    } catch (_) {
      return const IntegrationSettings();
    }
  }

  static Map<String, dynamic> _portable(SharedPreferences p, String uid) => {
    'uid': uid,
    if (_settings(p).tuya.ready) 'tuya': _settings(p).tuya.toJson(),
    if (p.getString('spotify.refresh') case final String refresh when refresh.isNotEmpty)
      'spotify': {'client': SpotifyPlay.clientId, 'refresh': refresh},
    'webhooks': [
      for (final w in _settings(p).webhooks) {'id': w.id, 'kind': w.kind.name, 'url': w.url},
    ],
  };

  static Future<void> activate(SharedPreferences p, String uid) async {
    final oldOwner = p.getString(_ownerKey);
    if (oldOwner != null && oldOwner != uid) {
      await p.setString('services.local.$oldOwner', jsonEncode(_portable(p, oldOwner)));
      await p.remove('spotify.refresh');
      await p.setBool('spotify.library', false);
      final s = _settings(p);
      await p.setString(
        'integrations',
        jsonEncode(s.copyWith(webhooks: const [], tuya: const TuyaSettings(), smartHomeOn: false).toJson()),
      );
      await p.remove(key);
      final cached = _read(p.getString('services.local.$uid'));
      if (cached['uid'] == uid) await _apply(p, cached);
    }
    final raw = p.getString(key);
    final box = KeyVault.envelope(raw);
    final legacy = box == null && raw != null ? _read(raw) : null;
    if (raw != null && (box?['uid'] ?? legacy?['uid']) != uid) await p.remove(key);
    await p.setString(_ownerKey, uid);
    final portable = _portable(p, uid);
    if (portable.containsKey('spotify') || portable.containsKey('tuya') || (portable['webhooks'] as List).isNotEmpty) {
      await KeyVault.store(p, key, 'services', jsonEncode(portable));
    } else if (legacy != null && legacy['uid'] == uid) {
      // Plain text from an older build: take it in once, then lock or remove it.
      await applyReceived(p);
    } else if (legacy != null) {
      await p.remove(key);
    }
  }

  /// True when the keys are on their way to your other devices, locked.
  /// False when signed out, or when this device has no sync passphrase yet.
  static Future<bool> publish(SharedPreferences p) async {
    final uid = p.getString(PushoverCredentialsSync.accountKey);
    if (p.getBool('sync.on') != true || uid == null || p.getString(_ownerKey) != uid) return false;
    final raw = jsonEncode(_portable(p, uid));
    await p.setString('services.local.$uid', raw);
    await KeyVault.store(p, key, 'services', raw);
    return KeyVault.unlocked(p);
  }

  static Future<void> applyReceived(SharedPreferences p) async {
    final uid = p.getString(PushoverCredentialsSync.accountKey);
    final raw = p.getString(key);
    final plain = await KeyVault.read(p, key);
    final received = _read(plain);
    if (uid == null || received['uid'] != uid || p.getString(_ownerKey) != uid) return;
    await _apply(p, received);
    await p.setString('services.local.$uid', jsonEncode(received));
    if (!KeyVault.isEnvelope(raw)) await KeyVault.store(p, key, 'services', plain);
  }

  static Future<void> _apply(SharedPreferences p, Map<String, dynamic> received) async {
    try {
      final raw = received['tuya'];
      final tuya = raw is Map ? TuyaSettings.fromJson(raw.cast<String, dynamic>()) : const TuyaSettings();
      await p.setString('integrations', jsonEncode(_settings(p).copyWith(tuya: tuya).toJson()));
    } catch (_) {
      /* Malformed remote credentials leave the local setup intact. */
    }
    final spotify = received['spotify'];
    if (spotify is Map && spotify['client'] == SpotifyPlay.clientId && spotify['refresh'] is String) {
      final refresh = spotify['refresh'] as String;
      if (refresh.isNotEmpty) {
        await p.setString('spotify.refresh', refresh);
        await p.setBool('spotify.library', true);
      }
    } else if (!received.containsKey('spotify')) {
      await p.remove('spotify.refresh');
      await p.setBool('spotify.library', false);
    }
    if (received['webhooks'] case final List hooks) {
      final s = _settings(p);
      final local = {for (final w in s.webhooks) w.id: w};
      final valid = <Webhook>[];
      for (final raw in hooks) {
        if (raw is! Map || raw['id'] is! String || raw['url'] is! String) continue;
        final kind = WebhookKind.values.firstWhere((k) => k.name == raw['kind'], orElse: () => WebhookKind.other);
        final url = raw['url'] as String;
        if (!Webhook.acceptsUrl(url, kind)) continue;
        final id = raw['id'] as String;
        valid.add(
          Webhook(
            id: id,
            kind: kind,
            url: url,
            enabled: local[id]?.enabled ?? false,
            events: local[id]?.events ?? const {'ring'},
          ),
        );
      }
      await p.setString('integrations', jsonEncode(s.copyWith(webhooks: valid).toJson()));
    }
  }
}
