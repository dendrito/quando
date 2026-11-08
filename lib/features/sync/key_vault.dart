import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// How the service keys (Pushover, Spotify, Tuya, webhooks) reach your
/// other devices. The choice follows the account to every device.
enum KeyProtection {
  /// Keys sync like your other settings, protected by your sign-in and by
  /// database rules that let only you read your account.
  standard,

  /// Keys are locked with a sync passphrase before they leave a device.
  passphrase,

  /// Keys never leave the device they were typed into.
  deviceOnly,
}

/// Locks the service keys before they travel, when you choose a passphrase.
///
/// You choose a sync passphrase once. Each device turns it into a key and
/// keeps only that key; the passphrase itself is never stored or sent. The
/// shared copy in your account holds just a locked box that only the key
/// opens, so whoever reads the account (Firebase, a leaked backup) sees
/// noise.
class KeyVault {
  /// Synced: which [KeyProtection] the account uses.
  static const levelPref = 'keys.protection';

  static const _keyPref = 'vault.key';
  static const _saltPref = 'vault.salt';
  static const _ownerPref = 'vault.owner';
  static const _accountPref = 'sync.uid';

  /// The synced settings that hold locked boxes.
  static const sealedKeys = ['pushover.credentials', 'services.connections'];

  /// PBKDF2-HMAC-SHA256 rounds. Stored in every box, so it can grow later.
  static const iterations = 310000;
  static const minLength = 8;

  static final _aes = AesGcm.with256bits();

  static String? _uid(SharedPreferences p) => p.getString(_accountPref);

  static KeyProtection level(SharedPreferences p) => KeyProtection.values.firstWhere(
    (l) => l.name == p.getString(levelPref),
    orElse: () => KeyProtection.standard,
  );

  /// Whether this device's keys are on their way to your other devices.
  static bool sharing(SharedPreferences p) => switch (level(p)) {
    KeyProtection.standard => true,
    KeyProtection.passphrase => unlocked(p) && !waiting(p),
    KeyProtection.deviceOnly => false,
  };

  static List<int> _random(int n) {
    final r = Random.secure();
    return List<int>.generate(n, (_) => r.nextInt(256));
  }

  static Future<List<int>> derive(String passphrase, List<int> salt, int rounds) => Isolate.run(() async {
    final key = await Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: rounds,
      bits: 256,
    ).deriveKeyFromPassword(password: passphrase, nonce: salt);
    return key.extractBytes();
  });

  /// A locked box, as the synced setting holds it.
  static Map<String, dynamic>? envelope(String? raw) {
    if (raw == null) return null;
    try {
      final j = jsonDecode(raw);
      return j is Map<String, dynamic> && j['vault'] == 1 ? j : null;
    } catch (_) {
      return null;
    }
  }

  static bool isEnvelope(String? raw) => envelope(raw) != null;

  /// This device holds the key for the signed-in account.
  static bool unlocked(SharedPreferences p) {
    final uid = _uid(p);
    return uid != null && p.getString(_ownerPref) == uid && p.getString(_keyPref) != null;
  }

  static List<Map<String, dynamic>> _boxes(SharedPreferences p) {
    final uid = _uid(p);
    return [
      for (final k in sealedKeys)
        if (envelope(p.getString(k)) case final box? when box['uid'] == uid) box,
    ];
  }

  /// Keys from another device are waiting here, locked: ask for the passphrase.
  static bool waiting(SharedPreferences p) {
    final boxes = _boxes(p);
    if (boxes.isEmpty) return false;
    if (!unlocked(p)) return true;
    final salt = p.getString(_saltPref);
    return boxes.any((b) => b['salt'] != salt);
  }

  /// Starts (or starts over) with a new passphrase on this device. Boxes
  /// made with an older passphrase can no longer be opened here.
  static Future<void> setPassphrase(SharedPreferences p, String passphrase) async {
    final uid = _uid(p);
    if (uid == null) throw StateError('Sign in first.');
    final salt = _random(16);
    final key = await derive(passphrase, salt, iterations);
    await _remember(p, uid, key, salt);
  }

  /// Tries the passphrase on the boxes that arrived. True when it opens them.
  static Future<bool> unlock(SharedPreferences p, String passphrase) async {
    final uid = _uid(p);
    final boxes = _boxes(p);
    if (uid == null || boxes.isEmpty) return false;
    final box = boxes.first;
    final salt = base64Decode(box['salt'] as String);
    final key = await derive(passphrase, salt, (box['iter'] as num).toInt());
    if (await _open(key, box, uid) == null) return false;
    await _remember(p, uid, key, salt);
    return true;
  }

  static Future<void> _remember(SharedPreferences p, String uid, List<int> key, List<int> salt) async {
    await p.setString(_keyPref, base64Encode(key));
    await p.setString(_saltPref, base64Encode(salt));
    await p.setString(_ownerPref, uid);
  }

  /// Clears the boxes on this device so the next publish locks fresh ones.
  static Future<void> clearBoxes(SharedPreferences p) async {
    for (final k in sealedKeys) {
      await p.remove(k);
    }
  }

  /// Forgets the key on this device (on sign-out).
  static Future<void> forget(SharedPreferences p) async {
    for (final k in [_keyPref, _saltPref, _ownerPref]) {
      await p.remove(k);
    }
  }

  static String _aad(String uid, String name) => 'quando-vault:$uid:$name';

  /// Locks [plain] for the signed-in account, or null without a key here.
  static Future<String?> seal(SharedPreferences p, String name, String plain) async {
    if (!unlocked(p)) return null;
    final uid = _uid(p)!;
    final key = base64Decode(p.getString(_keyPref)!);
    final box = await _aes.encrypt(
      utf8.encode(plain),
      secretKey: SecretKey(key),
      aad: utf8.encode(_aad(uid, name)),
    );
    return jsonEncode({
      'vault': 1,
      'uid': uid,
      'name': name,
      'kdf': 'pbkdf2-sha256',
      'iter': iterations,
      'salt': p.getString(_saltPref),
      'nonce': base64Encode(box.nonce),
      'ct': base64Encode(box.cipherText),
      'mac': base64Encode(box.mac.bytes),
    });
  }

  /// Opens a box made for the signed-in account, or null if it can't.
  static Future<String?> open(SharedPreferences p, String raw) async {
    final box = envelope(raw);
    final uid = _uid(p);
    if (box == null || uid == null || !unlocked(p) || box['salt'] != p.getString(_saltPref)) return null;
    return _open(base64Decode(p.getString(_keyPref)!), box, uid);
  }

  static Future<String?> _open(List<int> key, Map<String, dynamic> box, String uid) async {
    try {
      if (box['uid'] != uid) return null;
      final plain = await _aes.decrypt(
        SecretBox(
          base64Decode(box['ct'] as String),
          nonce: base64Decode(box['nonce'] as String),
          mac: Mac(base64Decode(box['mac'] as String)),
        ),
        secretKey: SecretKey(key),
        aad: utf8.encode(_aad(uid, box['name'] as String)),
      );
      return utf8.decode(plain);
    } catch (_) {
      return null;
    }
  }

  /// Writes [plain] to the synced setting [pref] as the account's
  /// [KeyProtection] says: as-is, locked, or not at all (removing any cloud
  /// copy). A box locked by another device is never overwritten here: it
  /// waits for the passphrase. A device without the key never uploads plain
  /// text under the passphrase level.
  static Future<void> store(SharedPreferences p, String pref, String name, String plain) async {
    final current = p.getString(pref);
    final box = envelope(current);
    switch (level(p)) {
      case KeyProtection.deviceOnly:
        if (current != null) await p.remove(pref);
      case KeyProtection.standard:
        if (box == null && current != plain) await p.setString(pref, plain);
      case KeyProtection.passphrase:
        if (box != null) {
          if (await open(p, current!) == plain) return;
          // Locked with another passphrase (a device started over): unlock first.
          if (box['salt'] != p.getString(_saltPref)) return;
        }
        final sealed = await seal(p, name, plain);
        if (sealed != null) {
          await p.setString(pref, sealed);
        } else if (current != null && box == null) {
          await p.remove(pref);
        }
    }
  }

  /// The plain JSON of the synced setting [pref]: opened if locked, as-is
  /// if it came from an older build, null if it can't be opened here.
  static Future<String?> read(SharedPreferences p, String pref) async {
    final raw = p.getString(pref);
    if (raw == null) return null;
    return isEnvelope(raw) ? open(p, raw) : raw;
  }
}
