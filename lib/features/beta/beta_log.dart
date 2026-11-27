import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/edition.dart';

/// Beta follow-up, opt-in. When a tester turns "Share how I use" on, Quando?
/// sends a few anonymous events (installed, first alarm, opened, crashed) to
/// the private beta dashboard: beta/ in this repo. A random id made on the
/// phone ties them together; no email, name, alarm, place or sentence goes
/// with them. Feedback and the day-7 question are sent only when the person
/// taps Send or answers.
class BetaLog {
  /// Turn off to hide the Beta rows in Settings (public release).
  static const showInSettings = true;
  static const base = 'https://beta.quando.day';
  static const _on = 'beta.share.on';
  static const _id = 'beta.install.id';
  static const _at = 'beta.install.at';
  static const _firstAlarm = 'beta.first.alarm';
  static const _survey = 'beta.survey.done';

  static SharedPreferences? _p;
  static BetaSink sink = HttpBetaSink();
  static DateTime? _lastOpen;
  static int _crashes = 0;

  static void init(SharedPreferences prefs) => _p = prefs;

  static bool get on => _p?.getBool(_on) ?? false;

  static Future<void> setOn(bool value) async {
    final p = _p;
    if (p == null) return;
    await p.setBool(_on, value);
    if (value && p.getInt(_at) == null) {
      await p.setInt(_at, DateTime.now().millisecondsSinceEpoch);
      event('install');
    }
  }

  static String get platform => switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    TargetPlatform.macOS => 'mac',
    _ => 'other',
  };

  static String _installId() {
    final p = _p!;
    var id = p.getString(_id);
    if (id == null) {
      final r = Random.secure();
      id = List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
      unawaited(p.setString(_id, id));
    }
    return id;
  }

  static void event(String type, {String detail = ''}) {
    if (!on) return;
    unawaited(
      sink.post('/api/event', {
        'install_id': _installId(),
        'type': type,
        'platform': platform,
        'version': appVersion,
        'detail': detail,
      }),
    );
  }

  /// The app is in front: one "open" per half hour counts as a session.
  static void opened([DateTime? now]) {
    final t = now ?? DateTime.now();
    final last = _lastOpen;
    if (last != null && t.difference(last) < const Duration(minutes: 30)) return;
    _lastOpen = t;
    event('open');
  }

  static void alarmSaved() {
    final p = _p;
    if (p == null || !on || (p.getBool(_firstAlarm) ?? false)) return;
    unawaited(p.setBool(_firstAlarm, true));
    event('first_alarm');
  }

  static void crash(Object error, StackTrace? stack) {
    if (!on || ++_crashes > 5) return; // a loop of errors must not flood
    event('crash', detail: crashDetail(error, stack));
  }

  /// Only the kind of error and where in Quando? it happened, never its
  /// message, which could hold a label or a place.
  static String crashDetail(Object error, StackTrace? stack) {
    final where = RegExp(r'package:quando/([^\s:)]+):(\d+)').firstMatch(stack?.toString() ?? '');
    final type = error.runtimeType.toString();
    return where == null ? type : '$type at ${where.group(1)}:${where.group(2)}';
  }

  /// Day 7 after turning sharing on, once: "How would you feel…?"
  static bool surveyDue([DateTime? now]) {
    final p = _p;
    final at = p?.getInt(_at);
    if (p == null || !on || at == null || (p.getBool(_survey) ?? false)) return false;
    return (now ?? DateTime.now()).difference(DateTime.fromMillisecondsSinceEpoch(at)) >=
        const Duration(days: 7);
  }

  static Future<void> answerSurvey(String answer) async {
    await _p?.setBool(_survey, true);
    await sink.post('/api/feedback', {
      'kind': 'survey',
      'body': answer,
      'platform': platform,
      'version': appVersion,
    });
  }

  /// "Do you lose track of time?": often, sometimes or rarely.
  static Future<void> answerTime(String answer, {String contact = ''}) => sink.post('/api/feedback', {
    'kind': 'time',
    'body': answer,
    'platform': platform,
    'version': appVersion,
    if (contact.isNotEmpty) 'contact': contact,
  });

  /// Feedback is the person's own choice, so it does not need the switch.
  static Future<bool> feedback(String kind, String body, {String contact = ''}) =>
      sink.post('/api/feedback', {
        'kind': kind,
        'body': body,
        'platform': platform,
        'version': appVersion,
        if (contact.isNotEmpty) 'contact': contact,
      });
}

abstract interface class BetaSink {
  Future<bool> post(String path, Map<String, Object?> json);
}

class HttpBetaSink implements BetaSink {
  @override
  Future<bool> post(String path, Map<String, Object?> json) async {
    try {
      final r = await http
          .post(
            Uri.parse('${BetaLog.base}$path'),
            headers: {'content-type': 'application/json'},
            body: jsonEncode(json),
          )
          .timeout(const Duration(seconds: 10));
      return r.statusCode == 200;
    } catch (e) {
      debugPrint('beta not sent: $e'); // never gets in the way of the app
      return false;
    }
  }
}
