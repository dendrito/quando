import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

import '../../sync/sync_config.dart';
import '../domain/tuya.dart';
import 'tuya_client.dart';

/// The Quando Tuya relay (workers/tuya-relay): a small free server that holds the Tuya
/// project keys. The app sends only the user's Quando sign-in token, never any key, and
/// the Smart Life password goes to the relay once, over HTTPS, and is not kept.
class TuyaRelay {
  TuyaRelay({http.Client? client, Future<String?> Function()? idToken})
    : _client = client ?? http.Client(),
      _idToken = idToken ?? firebaseIdToken;
  final http.Client _client;
  final Future<String?> Function() _idToken;

  /// The signed-in Quando account's token, or null when nobody is signed in.
  static Future<String?> firebaseIdToken() async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp(options: SyncConfig.options);
    return FirebaseAuth.instance.currentUser?.getIdToken();
  }

  Future<Map<String, dynamic>> _post(String base, String path, [Map<String, dynamic>? body]) async {
    final token = await _idToken();
    if (token == null) throw const TuyaException('signin');
    final uri = Uri.parse(base.endsWith('/') ? '${base}v1$path' : '$base/v1$path');
    if (uri.scheme != 'https') throw const TuyaException('setup');
    final response = await _client
        .post(
          uri,
          headers: {'authorization': 'Bearer $token', 'content-type': 'application/json'},
          body: jsonEncode(body ?? const {}),
        )
        .timeout(const Duration(seconds: 20));
    Map<String, dynamic> result;
    try {
      result = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw const TuyaException('response');
    }
    if (response.statusCode != 200) {
      // Tuya's own numeric code when there is one, else the relay's short reason.
      throw TuyaException('${result['code'] ?? result['error'] ?? response.statusCode}');
    }
    return result;
  }

  Future<bool> linked(String base) async => (await _post(base, '/status'))['linked'] == true;

  Future<void> login(
    String base, {
    required String countryCode,
    required String username,
    required String password,
  }) => _post(base, '/login', {
    'countryCode': countryCode.trim(),
    'username': username.trim(),
    'password': password,
  });

  Future<void> logout(String base) => _post(base, '/logout');

  Future<List<TuyaScene>> scenes(String base) async {
    final list = (await _post(base, '/scenes'))['scenes'];
    if (list is! List) throw const TuyaException('response');
    return [for (final s in list) TuyaScene.fromJson((s as Map).cast<String, dynamic>())];
  }

  Future<void> runScene(String base, TuyaScene scene) async {
    final r = await _post(base, '/run', {'homeId': scene.homeId, 'sceneId': scene.id});
    if (r['ok'] != true) throw const TuyaException('not_executed');
  }
}
