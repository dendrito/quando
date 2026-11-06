import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/tuya.dart';

class TuyaSceneCache {
  static String _owner(TuyaSettings s) => sha256.convert(utf8.encode(jsonEncode(s.toJson()))).toString();
  static Future<void> write(SharedPreferences p, TuyaSettings s, List<TuyaScene> scenes) async {
    await p.setString(
      'tuya.scenes',
      jsonEncode({
        'owner': _owner(s),
        'scenes': [for (final x in scenes) x.toJson()],
      }),
    );
  }

  static List<TuyaScene> read(SharedPreferences p, TuyaSettings s) {
    try {
      final j = jsonDecode(p.getString('tuya.scenes') ?? '{}') as Map;
      if (j['owner'] != _owner(s)) return const [];
      return [for (final x in j['scenes'] as List) TuyaScene.fromJson((x as Map).cast<String, dynamic>())];
    } catch (_) {
      return const [];
    }
  }
}
