import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../ringing/ring_payload.dart';
import '../domain/integrations.dart';

/// Sends alarm happenings to Pushover and webhooks. Failures are quiet:
/// an integration must never get in the way of the alarm.
class IntegrationSender {
  IntegrationSender(this._settings, {http.Client? client}) : _client = client ?? http.Client();

  final IntegrationSettings Function() _settings;
  final http.Client _client;

  static final pushoverUrl = Uri.parse('https://api.pushover.net/1/messages.json');

  Future<void> send(AlarmHappening what, RingPayload p, {DateTime? at}) async {
    final s = _settings();
    if (p.isLock || p.isCheck && what != AlarmHappening.ring) return;
    if (s.pauseOnShabbat && p.shabbatSafe) return;
    final when = (at ?? DateTime.now()).toUtc();
    await Future.wait([
      if (s.pushoverReady && what == AlarmHappening.ring) _pushover(s, p),
      for (final w in s.webhooks)
        if (w.enabled && w.events.contains(what.key)) _webhook(w, what, p, when),
    ]);
  }

  Future<String?> testPushover(IntegrationSettings s) =>
      _pushover(s, const RingPayload(title: 'Quando test', body: 'Pushover is connected', ringSeconds: 1));

  Future<String?> testWebhook(Webhook w) => _webhook(
    w,
    AlarmHappening.ring,
    const RingPayload(title: 'Quando test', body: 'Webhook is connected', ringSeconds: 1),
    DateTime.now().toUtc(),
  );

  /// Returns null on success, else a short reason.
  Future<String?> _pushover(IntegrationSettings s, RingPayload p) async {
    try {
      final r = await _client
          .post(
            pushoverUrl,
            body: {
              'token': s.pushoverToken.trim(),
              'user': s.pushoverUser.trim(),
              'title': p.title,
              'message': p.body.isEmpty ? 'Alarm' : p.body,
              'priority': s.pushoverHigh ? '1' : '0',
            },
          )
          .timeout(const Duration(seconds: 15));
      return r.statusCode == 200 ? null : 'Pushover said ${r.statusCode}: ${_short(r.body)}';
    } catch (e) {
      return 'Could not reach Pushover ($e)';
    }
  }

  Future<String?> _webhook(Webhook w, AlarmHappening what, RingPayload p, DateTime when) async {
    try {
      final r = await _client
          .post(
            Uri.parse(w.url.trim()),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payloadJson(what, p, when)),
          )
          .timeout(const Duration(seconds: 15));
      return r.statusCode >= 200 && r.statusCode < 300 ? null : 'It answered ${r.statusCode}';
    } catch (e) {
      return 'Could not reach it ($e)';
    }
  }

  /// What Zapier, IFTTT or any webhook receives.
  static Map<String, dynamic> payloadJson(AlarmHappening what, RingPayload p, DateTime when) => {
    'app': 'Quando',
    'event': what.key,
    'title': p.title,
    'body': p.body,
    'time': when.toIso8601String(),
    'shabbat': p.shabbatSafe,
    'snoozes': p.snoozeCount,
  };

  static String _short(String s) => s.length > 120 ? '${s.substring(0, 120)}…' : s;
}
