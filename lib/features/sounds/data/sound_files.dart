import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Where recordings and imported files live: `<documents>/sounds/`.
class SoundFiles {
  static Future<Directory> _docs() => getApplicationDocumentsDirectory();

  /// A new relative path like `sounds/rec_123.m4a`.
  static String newRelative(String prefix, String extension) =>
      'sounds/${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension';

  static Future<String> absolute(String relative) async =>
      '${(await _docs()).path}/$relative';

  static Future<void> ensureFolder() async =>
      Directory('${(await _docs()).path}/sounds').create(recursive: true);

  /// Copies a picked file into the app, so it still works if the original moves.
  static Future<String> import(String sourcePath) async {
    await ensureFolder();
    final ext = sourcePath.contains('.')
        ? sourcePath.split('.').last.toLowerCase()
        : 'mp3';
    final rel = newRelative('file', ext);
    await File(sourcePath).copy(await absolute(rel));
    return rel;
  }

  static Future<void> delete(String relative) async {
    try {
      await File(await absolute(relative)).delete();
    } catch (_) {}
  }
}
