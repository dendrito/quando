import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../ringing/ring_payload.dart';
import '../domain/integrations.dart';

import 'package:quando/l10n/l10n.dart';

/// Sends alarm happenings to Pushover and webhooks. Failures are quiet:
/// an integration must never get in the way of the alarm.
class IntegrationSender {
  IntegrationSender(this._settings, {http.Client? client})
    : _client = client ?? http.Client();

  final IntegrationSettings Function() _settings;
  final http.Client _client;

  static final pushoverUrl = Uri.parse(
    'https://api.pushover.net/1/messages.json',
  );

  Future<void> send(AlarmHappening what, RingPayload p, {DateTime? at}) async {
    final s = _settings();
    if (p.isLock || p.isCheck && what != AlarmHappening.ring) return;
    if (s.pauseOnShabbat && p.shabbatSafe) return;
    final when = (at ?? DateTime.now()).toUtc();
    await Future.wait([
      if (s.pushoverReady && what == AlarmHappening.ring) _pushover(s, p),
      for (final w in s.webhooks)
        if (w.enabled && w.events.contains(what.key))
          _webhook(w, what, p, when),
    ]);
  }

  Future<String?> testPushover(IntegrationSettings s) => _pushover(
    s,
    RingPayload(
      title: l10n.appTest,
      body: l10n.pushoverConnected,
      ringSeconds: 1,
    ),
  );

  Future<String?> testWebhook(Webhook w) => _webhook(
    w,
    AlarmHappening.ring,
    RingPayload(
      title: l10n.appTest,
      body: l10n.webhookConnected,
      ringSeconds: 1,
    ),
    DateTime.now().toUtc(),
  );

  /// Returns null on success, else a short reason.
  Future<String?> _pushover(IntegrationSettings s, RingPayload p) async {
    try {
      final r = await _client
          .post(pushoverUrl, body: pushoverFields(s, p))
          .timeout(const Duration(seconds: 15));
      return r.statusCode == 200
          ? null
          : l10n.pushoverSaid(r.statusCode, _short(r.body));
    } catch (e) {
      return l10n.couldNotReachPushover('$e');
    }
  }

  static Map<String, String> pushoverFields(
    IntegrationSettings s,
    RingPayload p,
  ) => {
    'token': s.pushoverToken.trim(),
    'user': s.pushoverUser.trim(),
    'title': p.title,
    'message': p.body.isEmpty ? l10n.alarm : p.body,
    'priority': '${s.pushoverPriority}',
    if (s.pushoverPriority == 2) ...{'retry': '30', 'expire': '600'},
    if (s.pushoverSound != null) 'sound': s.pushoverSound!,
    if (s.pushoverDevices.isNotEmpty)
      'device': (s.pushoverDevices.toList()..sort()).join(','),
  };

  /// Sound names → labels, built-in plus any you uploaded. Throws with a
  /// short reason on failure.
  Future<Map<String, String>> pushoverSounds(String token) async {
    final r = await _client
        .get(
          Uri.parse(
            'https://api.pushover.net/1/sounds.json?token=${Uri.encodeQueryComponent(token.trim())}',
          ),
        )
        .timeout(const Duration(seconds: 15));
    final j = jsonDecode(r.body) as Map<String, dynamic>;
    if (r.statusCode != 200) throw Exception(_reason(j, r.statusCode));
    return (j['sounds'] as Map<String, dynamic>).map(
      (k, v) => MapEntry(k, v as String),
    );
  }

  /// Your Pushover device names.
  Future<List<String>> pushoverDevices(String token, String user) async {
    final r = await _client
        .post(
          Uri.parse('https://api.pushover.net/1/users/validate.json'),
          body: {'token': token.trim(), 'user': user.trim()},
        )
        .timeout(const Duration(seconds: 15));
    final j = jsonDecode(r.body) as Map<String, dynamic>;
    if (r.statusCode != 200) throw Exception(_reason(j, r.statusCode));
    return [for (final d in (j['devices'] as List? ?? const [])) d as String];
  }

  static String _reason(Map<String, dynamic> j, int code) =>
      (j['errors'] as List?)?.join(', ') ?? 'Pushover said $code';

  Future<String?> _webhook(
    Webhook w,
    AlarmHappening what,
    RingPayload p,
    DateTime when,
  ) async {
    try {
      final r = await _client
          .post(
            Uri.parse(w.url.trim()),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payloadJson(what, p, when)),
          )
          .timeout(const Duration(seconds: 15));
      return r.statusCode >= 200 && r.statusCode < 300
          ? null
          : l10n.itAnswered(r.statusCode);
    } catch (e) {
      return l10n.couldNotReachIt('$e');
    }
  }

  /// What Zapier, IFTTT or any webhook receives.
  static Map<String, dynamic> payloadJson(
    AlarmHappening what,
    RingPayload p,
    DateTime when,
  ) => {
    'app': 'Quando',
    'event': what.key,
    'title': p.title,
    'body': p.body,
    'time': when.toIso8601String(),
    'shabbat': p.shabbatSafe,
    'snoozes': p.snoozeCount,
  };

  static String _short(String s) =>
      s.length > 120 ? '${s.substring(0, 120)}…' : s;
}
