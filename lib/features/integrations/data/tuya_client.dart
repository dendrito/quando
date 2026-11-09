import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../domain/tuya.dart';
import 'tuya_relay.dart';

/// Talks to Tuya with the user's own project keys, or through Quando's relay when
/// [TuyaSettings.relayUrl] is set. No Tuya secret is ever bundled in the app.
class TuyaClient {
  TuyaClient({http.Client? client, DateTime Function()? now, TuyaRelay? relay})
    : _client = client ?? http.Client(),
      _now = now ?? DateTime.now,
      relay = relay ?? TuyaRelay(client: client);
  final http.Client _client;

  /// Used when the settings point at Quando's relay instead of the user's own project.
  final TuyaRelay relay;
  final DateTime Function() _now;
  String? _accessToken;
  String? _owner;
  DateTime _expires = DateTime(2000);
  final _authentication = <String, Future<String>>{};

  static Map<String, String> signedHeaders(
    TuyaSettings s,
    String method,
    String path, {
    required String timestamp,
    String body = '',
    String token = '',
    String nonce = '',
    Map<String, String> signatureHeaders = const {},
  }) {
    final digest = sha256.convert(utf8.encode(body));
    final optionalHeaders = signatureHeaders.entries.map((e) => '${e.key}:${e.value}\n').join();
    final canonical = '$method\n$digest\n$optionalHeaders\n$path';
    final signature = Hmac(
      sha256,
      utf8.encode(s.secret),
    ).convert(utf8.encode('${s.clientId}$token$timestamp$nonce$canonical')).toString().toUpperCase();
    return {
      'client_id': s.clientId,
      't': timestamp,
      'sign_method': 'HMAC-SHA256',
      'sign': signature,
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'access_token': token,
      if (nonce.isNotEmpty) 'nonce': nonce,
      if (signatureHeaders.isNotEmpty) 'Signature-Headers': signatureHeaders.keys.join(':'),
      ...signatureHeaders,
    };
  }

  Future<dynamic> _request(TuyaSettings s, String method, String path, {String token = '', String body = ''}) async {
    final request = http.Request(
      method,
      Uri.https(
        s.region.host,
        path.split('?').first,
        path.contains('?') ? Uri.splitQueryString(path.split('?').last) : null,
      ),
    );
    request.followRedirects = false;
    final canonicalPath = request.url.toString().substring(request.url.origin.length);
    request.headers.addAll(
      signedHeaders(s, method, canonicalPath, timestamp: '${_now().millisecondsSinceEpoch}', token: token, body: body),
    );
    if (body.isNotEmpty) request.body = body;
    final response = await http.Response.fromStream(await _client.send(request).timeout(const Duration(seconds: 15)))
        .timeout(const Duration(seconds: 15));
    Map<String, dynamic> result;
    try {
      result = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw const TuyaException('response');
    }
    if (response.statusCode != 200 || result['success'] != true) {
      if (['1010', '1011', '1012', '1400'].contains('${result['code']}')) _accessToken = null;
      // Return the documented error code; never echo provider payloads or keys.
      throw TuyaException('${result['code'] ?? response.statusCode}');
    }
    return result['result'];
  }

  Future<String> _token(TuyaSettings s) async {
    if (!s.ready) throw const TuyaException('setup');
    final owner = sha256.convert(utf8.encode(jsonEncode(s.toJson()))).toString();
    if (_owner == owner && _accessToken != null && _now().isBefore(_expires)) return _accessToken!;
    final pending = _authentication.putIfAbsent(owner, () => _authenticate(s, owner));
    try {
      return await pending;
    } finally {
      if (identical(_authentication[owner], pending)) _authentication.remove(owner);
    }
  }

  Future<String> _authenticate(TuyaSettings s, String owner) async {
    final result = await _request(s, 'GET', '/v1.0/token?grant_type=1');
    if (result is! Map || result['access_token'] is! String) throw const TuyaException('response');
    _owner = owner;
    _accessToken = result['access_token'] as String;
    _expires = _now().add(Duration(seconds: ((result['expire_time'] as num?)?.toInt() ?? 7200) - 60));
    return _accessToken!;
  }

  /// Signs in with the account used in the Smart Life / Tuya Smart app and returns its
  /// Tuya user id. Uses `associated-users/actions/authorized-login`; Tuya documents the
  /// password as an MD5 hex digest (as its own Python SDK sends it). The password is
  /// only sent to Tuya in this call and is never stored or returned.
  ///
  /// The account normally has to be linked to the cloud project first. Tuya doesn't
  /// document the `schema` value for Smart Life accounts, so the usual ones are tried.
  Future<String> login(
    TuyaSettings s, {
    required String username,
    required String password,
    required String countryCode,
    List<String> schemas = const ['smartlife', 'tuyaSmart'],
  }) async {
    if (s.clientId.isEmpty || s.secret.isEmpty) throw const TuyaException('setup');
    TuyaException? last;
    for (final schema in schemas) {
      try {
        final result = await _request(
          s,
          'POST',
          '/v1.0/iot-01/associated-users/actions/authorized-login',
          body: jsonEncode({
            'username': username.trim(),
            'password': md5.convert(utf8.encode(password)).toString(),
            'country_code': countryCode.trim(),
            'schema': schema,
          }),
        );
        if (result is! Map || '${result['uid'] ?? ''}'.isEmpty) throw const TuyaException('response');
        return '${result['uid']}';
      } on TuyaException catch (e) {
        last = e;
        // Any other Tuya error may come from the schema, so try the next one.
        if (e.code == 'response' || e.code == 'setup') rethrow;
      }
    }
    throw last ?? const TuyaException('response');
  }

  Future<List<TuyaScene>> scenes(TuyaSettings s) async {
    if (s.viaRelay) return relay.scenes(s.relayUrl.trim());
    final token = await _token(s);
    final homes = await _request(s, 'GET', '/v1.0/users/${Uri.encodeComponent(s.uid)}/homes', token: token);
    if (homes is! List) throw const TuyaException('response');
    final scenes = <TuyaScene>[];
    for (final home in homes) {
      if (home is! Map || home['home_id'] == null) continue;
      final homeId = '${home['home_id']}';
      final result = await _request(s, 'GET', '/v1.1/homes/${Uri.encodeComponent(homeId)}/scenes', token: token);
      if (result is! List) throw const TuyaException('response');
      for (final scene in result) {
        if (scene is! Map || scene['scene_id'] == null || scene['enabled'] == false || scene['status'] == '2') {
          continue;
        }
        scenes.add(
          TuyaScene(homeId: homeId, id: '${scene['scene_id']}', name: '${scene['name'] ?? scene['scene_id']}'),
        );
      }
    }
    return scenes;
  }

  Future<void> runScene(TuyaSettings s, TuyaScene scene) async {
    if (s.viaRelay) return relay.runScene(s.relayUrl.trim(), scene);
    final token = await _token(s);
    final result = await _request(
      s,
      'POST',
      '/v1.0/homes/${Uri.encodeComponent(scene.homeId)}/scenes/${Uri.encodeComponent(scene.id)}/trigger',
      token: token,
    );
    if (result != true) throw const TuyaException('not_executed');
  }
}

class TuyaException implements Exception {
  const TuyaException(this.code);
  final String code;
  @override
  String toString() => 'Tuya ($code)';
}
