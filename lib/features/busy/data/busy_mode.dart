import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../events/domain/event.dart';
import '../domain/busy.dart';

/// Hands Busy mode to Android, which runs it without Flutter: Do Not
/// Disturb at the start and end of each busy stretch (BusyReceiver), and
/// answers to messages while busy (QuandoListener).
class BusyMode {
  BusyMode(this._prefs);

  final SharedPreferences _prefs;
  static const _channel = MethodChannel('quando/busy');

  static const settingsKey = 'busy.settings';
  static const windowsKey = 'busy.windows';
  static const dndKey = 'busy.dnd';
  static const repliesKey = 'busy.replies';
  static const textKey = 'busy.replyText';
  static const appsKey = 'busy.apps';
  static const groupsKey = 'busy.groups';
  static const holyKey = 'busy.holy';

  /// Writes what Android needs and asks it to act now.
  Future<void> publish({
    required BusySettings settings,
    required List<BusyWindow> windows,
    required String replyText,
    required List<HolyPeriod> holy,
  }) async {
    await _prefs.setString(windowsKey, jsonEncode([for (final w in windows) w.toWire()]));
    await _prefs.setBool(dndKey, settings.dnd);
    await _prefs.setBool(repliesKey, settings.replies);
    await _prefs.setString(textKey, replyText);
    await _prefs.setString(appsKey, jsonEncode(settings.apps.toList()..sort()));
    await _prefs.setBool(groupsKey, settings.groups);
    await _prefs.setString(
      holyKey,
      jsonEncode([
        if (!settings.repliesOnShabbat)
          for (final p in holy) [p.start.millisecondsSinceEpoch, p.end.millisecondsSinceEpoch],
      ]),
    );
    await _call('refresh');
  }

  /// Allowed to turn Do Not Disturb on and off.
  static Future<bool> dndAllowed() async => await _call('policyAllowed') ?? false;

  static Future<void> openDndSettings() => _call('openPolicySettings');

  static Future<bool?> _call(String method) async {
    try {
      return await _channel.invokeMethod<bool>(method);
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}
