import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../sync/key_vault.dart';
import '../domain/integrations.dart';

/// Only the explicitly requested Pushover key pair travels in account sync,
/// as the account's key protection says (see [KeyVault]). Webhooks, device
/// destinations, priorities and playback settings remain local.
class PushoverCredentialsSync {
  static const key = 'pushover.credentials';
  static const ownerKey = 'pushover.credentials.owner';
  static const accountKey = 'sync.uid';

  static Map<String, dynamic>? _read(String? raw) {
    try {
      return raw == null ? null : jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static IntegrationSettings _local(SharedPreferences prefs) {
    try {
      return IntegrationSettings.fromJson(_read(prefs.getString('integrations')) ?? {});
    } catch (_) {
      return const IntegrationSettings();
    }
  }

  static String _encode(String uid, IntegrationSettings s) =>
      jsonEncode({'uid': uid, 'user': s.pushoverUser.trim(), 'token': s.pushoverToken.trim()});

  static bool _complete(Map<String, dynamic>? pair) =>
      pair?['user'] is String &&
      (pair!['user'] as String).trim().isNotEmpty &&
      pair['token'] is String &&
      (pair['token'] as String).trim().isNotEmpty;

  /// Called only after Firebase authorizes access to users/{uid}.
  static Future<void> activate(SharedPreferences prefs, String uid) async {
    final oldOwner = prefs.getString(ownerKey);
    var settings = _local(prefs);
    if (oldOwner != null && oldOwner != uid) {
      await prefs.setString('pushover.local.$oldOwner', _encode(oldOwner, settings));
      final cached = _read(prefs.getString('pushover.local.$uid'));
      settings = settings.copyWith(
        pushoverUser: _complete(cached) ? cached!['user'] as String : '',
        pushoverToken: _complete(cached) ? cached!['token'] as String : '',
      );
      await prefs.setString('integrations', jsonEncode(settings.toJson()));
      await prefs.remove(key);
      for (final marker in ['sync.last', 'sync.stamps', 'sync.origins']) {
        await prefs.remove(marker);
      }
    }
    final raw = prefs.getString(key);
    final box = KeyVault.envelope(raw);
    final legacy = box == null ? _read(raw) : null;
    if (raw != null && (box?['uid'] ?? legacy?['uid']) != uid) await prefs.remove(key);
    await prefs.setString(accountKey, uid);
    await prefs.setString(ownerKey, uid);
    // A plain-text pair from an older build is taken in once, then stored
    // the way the account's key protection says.
    if (legacy?['uid'] == uid && _complete(legacy) && !_complete(_encodedPair(settings))) {
      await applyReceived(prefs);
      return;
    }
    // Existing setups join the owner's requested credential sharing on sign-in.
    if (settings.pushoverUser.isNotEmpty && settings.pushoverToken.isNotEmpty) {
      await KeyVault.store(prefs, key, 'pushover', _encode(uid, settings));
    } else if (legacy != null && KeyVault.level(prefs) != KeyProtection.standard) {
      await prefs.remove(key);
    }
  }

  static Map<String, dynamic> _encodedPair(IntegrationSettings s) => {
    'user': s.pushoverUser.trim(),
    'token': s.pushoverToken.trim(),
  };

  /// True when the pair is on its way to your other devices. False when
  /// signed out, kept on this device, or waiting for the sync passphrase.
  static Future<bool> publish(SharedPreferences prefs, IntegrationSettings settings) async {
    final uid = prefs.getString(accountKey);
    if (prefs.getBool('sync.on') != true || uid == null || prefs.getString(ownerKey) != uid) return false;
    if (settings.pushoverUser.trim().isEmpty || settings.pushoverToken.trim().isEmpty) return false;
    await prefs.setString('pushover.local.$uid', _encode(uid, settings));
    await KeyVault.store(prefs, key, 'pushover', _encode(uid, settings));
    return KeyVault.sharing(prefs);
  }

  static Future<void> applyReceived(SharedPreferences prefs) async {
    final uid = prefs.getString(accountKey);
    final raw = prefs.getString(key);
    final plain = await KeyVault.read(prefs, key);
    final pair = _read(plain);
    if (uid == null || pair?['uid'] != uid || !_complete(pair)) return;
    final settings = _local(prefs)
        .copyWith(pushoverUser: pair!['user'] as String, pushoverToken: pair['token'] as String);
    await prefs.setString('integrations', jsonEncode(settings.toJson()));
    await prefs.setString(ownerKey, uid);
    await prefs.setString('pushover.local.$uid', jsonEncode(pair));
    if (!KeyVault.isEnvelope(raw)) await KeyVault.store(prefs, key, 'pushover', plain!);
  }
}
