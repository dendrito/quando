import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/scheduler/scheduler.dart';

/// Feeds the Android home-screen widget (QuandoWidget): the alarms coming
/// up, today's sunrise and sunset, and its words in your language. The
/// widget reads them on its own, so it keeps working while the app is
/// closed.
class HomeWidget {
  HomeWidget(this._prefs);

  final SharedPreferences _prefs;
  static const _channel = MethodChannel('quando/busy');

  static const alarmsKey = 'widget.alarms';
  static const sunriseKey = 'widget.sunrise';
  static const sunsetKey = 'widget.sunset';
  static const labelKey = 'widget.label';
  static const noneKey = 'widget.none';

  Future<void> publish({
    required List<ScheduledAlarm> plan,
    required DateTime? sunrise,
    required DateTime? sunset,
    required String label,
    required String none,
  }) async {
    final ringing = [
      for (final a in plan)
        // Lock starts and gentle lead-ups aren't alarms you wait for.
        if (a.ruleId != 'lock' && !a.ruleId.startsWith('gentle.')) a,
    ];
    await _prefs.setString(
      alarmsKey,
      jsonEncode([
        for (final a in ringing.take(20)) [a.at.millisecondsSinceEpoch, a.title],
      ]),
    );
    await _prefs.setInt(sunriseKey, sunrise?.millisecondsSinceEpoch ?? 0);
    await _prefs.setInt(sunsetKey, sunset?.millisecondsSinceEpoch ?? 0);
    await _prefs.setString(labelKey, label);
    await _prefs.setString(noneKey, none);
    try {
      await _channel.invokeMethod<bool>('widget');
    } on PlatformException {
      // No widget to redraw.
    } on MissingPluginException {
      // Not Android.
    }
  }
}
