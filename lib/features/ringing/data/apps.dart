import 'package:flutter/services.dart';

/// An app on the phone that can be opened after an alarm.
class PhoneApp {
  const PhoneApp({required this.package, required this.label, this.icon});

  final String package;
  final String label;
  final Uint8List? icon;
}

/// "Open after stopping" stores an app as `app:<package>|<name>`; anything
/// else is a link.
class AppLink {
  static const prefix = 'app:';

  static String of(PhoneApp a) => '$prefix${a.package}|${a.label}';

  static bool isApp(String? s) => s != null && s.startsWith(prefix);

  static String package(String s) =>
      s.substring(prefix.length).split('|').first;

  /// The app's name, or the link itself.
  static String label(String s) {
    if (!isApp(s)) return s;
    final parts = s.substring(prefix.length).split('|');
    return parts.length > 1 && parts[1].isNotEmpty ? parts[1] : parts.first;
  }
}

/// Talks to Android: which apps can be opened, and opening one.
class Apps {
  static const _channel = MethodChannel('quando/apps');

  static Future<List<PhoneApp>> list() async {
    try {
      final raw = await _channel.invokeListMethod<Map>('list') ?? const [];
      return [
        for (final m in raw)
          PhoneApp(
            package: m['package'] as String,
            label: m['label'] as String? ?? m['package'] as String,
            icon: m['icon'] as Uint8List?,
          ),
      ];
    } catch (_) {
      return const [];
    }
  }

  static Future<bool> launch(String package) async {
    try {
      return await _channel.invokeMethod<bool>('launch', {
            'package': package,
          }) ??
          false;
    } catch (_) {
      return false;
    }
  }
}
