import 'package:http/http.dart' as http;

/// Prefer a station's verified TLS endpoint without relaxing transport checks.
Future<String> radioPlaybackUrl(String url, {http.Client? client}) async {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.scheme != 'http' || uri.userInfo.isNotEmpty) return url;
  final secure = uri.replace(scheme: 'https');
  final connection = client ?? http.Client();
  try {
    final response = await connection.head(secure).timeout(const Duration(seconds: 4));
    final type = response.headers['content-type']?.toLowerCase() ?? '';
    if (response.statusCode == 200 &&
        (type.startsWith('audio/') || type.contains('mpegurl') || type.contains('application/ogg'))) {
      return secure.toString();
    }
  } catch (_) {
    /* Playback reports a failure if the original source is unavailable. */
  } finally {
    if (client == null) connection.close();
  }
  return url;
}
