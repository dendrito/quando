import 'package:flutter/services.dart';

/// Talks to Android for sharing: the share card out to Instagram Stories,
/// WhatsApp and the share sheet, and song links shared in to Quando?.
class ShareChannel {
  static const _channel = MethodChannel('quando/share');

  /// Facebook App ID for Instagram Stories (`--dart-define=FACEBOOK_APP_ID=...`).
  /// Instagram asks for one; without it, sharing still opens Instagram.
  static const facebookAppId = String.fromEnvironment('FACEBOOK_APP_ID');

  static const whatsapp = 'com.whatsapp';
  static const whatsappBusiness = 'com.whatsapp.w4b';
  static const instagram = 'com.instagram.android';

  static Future<bool> story(String path) => _bool('story', {'path': path, 'appId': facebookAppId});

  /// [package] null = the phone's share sheet.
  static Future<bool> send(String path, {String? text, String? package}) =>
      _bool('send', {'path': path, 'text': text, 'package': package});

  static Future<bool> installed(String package) => _bool('installed', {'package': package});

  /// A link shared to Quando? while it was closed, once.
  static Future<String?> sharedText() async {
    try {
      return await _channel.invokeMethod<String>('sharedText');
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  /// Links shared to Quando? while it is open.
  static void onShared(void Function(String text) handler) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'shared' && call.arguments is String) handler(call.arguments as String);
    });
  }

  static Future<bool> _bool(String method, Map<String, Object?> args) async {
    try {
      return await _channel.invokeMethod<bool>(method, args) ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}

/// The first song link in shared text ("Listen to X on Spotify: https://…").
/// null when there is none from a music service Quando? knows.
String? songLinkIn(String text) {
  for (final m in RegExp(r'(https?://|spotify:)\S+').allMatches(text)) {
    final link = m[0]!.replaceAll(RegExp(r'[)\].,;!?]+$'), '');
    final l = link.toLowerCase();
    const hosts = [
      'spotify.com',
      'spotify:',
      'spotify.link',
      'youtube.com',
      'youtu.be',
      'music.apple.com',
      'soundcloud.com',
      'on.soundcloud.com',
      'deezer.com',
      'deezer.page.link',
      'tidal.com',
    ];
    if (hosts.any(l.contains)) return link;
  }
  return null;
}
