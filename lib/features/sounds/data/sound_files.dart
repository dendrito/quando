import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../domain/sound.dart';

/// Where recordings and imported files live: `<documents>/sounds/`.
class SoundFiles {
  static Future<Directory> _docs() => getApplicationDocumentsDirectory();

  /// A new relative path like `sounds/rec_123.m4a`.
  static String newRelative(String prefix, String extension) =>
      'sounds/${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension';

  static Future<String> absolute(String relative) async => '${(await _docs()).path}/$relative';

  static Future<void> ensureFolder() async =>
      Directory('${(await _docs()).path}/sounds').create(recursive: true);

  /// Copies a picked file into the app, so it still works if the original moves.
  static Future<String> import(String sourcePath) async {
    await ensureFolder();
    final ext = sourcePath.contains('.') ? sourcePath.split('.').last.toLowerCase() : 'mp3';
    final rel = newRelative('file', ext);
    await File(sourcePath).copy(await absolute(rel));
    return rel;
  }

  /// The file id in a Google Drive share link, or null for other links.
  static String? driveId(String link) {
    final u = Uri.tryParse(link);
    if (u == null || !(u.host == 'drive.google.com' || u.host == 'docs.google.com')) return null;
    final m = RegExp(r'/d/([\w-]+)').firstMatch(u.path);
    return m?.group(1) ?? u.queryParameters['id'];
  }

  /// Downloads a link-shared Drive file into the app, so playing it never
  /// needs Drive or a Google sign-in. Returns the relative path.
  static Future<String> downloadDrive(String id) async {
    await ensureFolder();
    final res = await http.get(Uri.parse(AlarmSound.driveUrl(id)));
    final type = res.headers['content-type'] ?? '';
    if (res.statusCode != 200 || type.contains('text/html') || res.bodyBytes.isEmpty) {
      throw 'not shared';
    }
    final ext = type.contains('mp4') || type.contains('m4a') || type.contains('aac')
        ? 'm4a'
        : type.contains('ogg')
        ? 'ogg'
        : type.contains('wav')
        ? 'wav'
        : 'mp3';
    final rel = newRelative('drive', ext);
    await File(await absolute(rel)).writeAsBytes(res.bodyBytes);
    return rel;
  }

  static Future<void> delete(String relative) async {
    try {
      await File(await absolute(relative)).delete();
    } catch (_) {}
  }
}
