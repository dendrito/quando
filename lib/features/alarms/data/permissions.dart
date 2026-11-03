import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Asks once for what alarms need on Android 13+: notifications (so the
/// ringing screen can appear) and exact alarms.
Future<void> ensureAlarmPermissions() async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
  try {
    if (await Permission.notification.isDenied) await Permission.notification.request();
    if (await Permission.scheduleExactAlarm.isDenied) await Permission.scheduleExactAlarm.request();
  } catch (_) {
    // Older Android: nothing to ask.
  }
}
