/// Things that happen to an alarm, which can be sent elsewhere.
enum AlarmHappening {
  ring('ring', 'Rings'),
  stopped('stopped', 'You stop it'),
  snoozed('snoozed', 'You snooze it'),
  autoStopped('auto_stopped', 'It stops by itself');

  const AlarmHappening(this.key, this.label);
  final String key;
  final String label;
}

enum WebhookKind { zapier, ifttt, other }

/// A web address Quando calls with the alarm's details (JSON POST).
class Webhook {
  const Webhook({
    required this.id,
    required this.kind,
    required this.url,
    this.events = const {'ring'},
    this.enabled = true,
  });

  final String id;
  final WebhookKind kind;
  final String url;

  /// [AlarmHappening.key]s that trigger it.
  final Set<String> events;
  final bool enabled;

  String get title => switch (kind) {
    WebhookKind.zapier => 'Zapier',
    WebhookKind.ifttt => 'IFTTT · ${iftttEvent(url) ?? 'event'}',
    WebhookKind.other => Uri.tryParse(url)?.host ?? 'Webhook',
  };

  /// IFTTT's Webhooks service: any JSON goes to the applet.
  static String iftttUrl(String event, String key) =>
      'https://maker.ifttt.com/trigger/${Uri.encodeComponent(event.trim())}/json/with/key/${key.trim()}';

  static String? iftttEvent(String url) => RegExp(r'/trigger/([^/]+)/').firstMatch(url)?.group(1);

  Webhook copyWith({Set<String>? events, bool? enabled}) =>
      Webhook(id: id, kind: kind, url: url, events: events ?? this.events, enabled: enabled ?? this.enabled);

  Map<String, dynamic> toJson() => {
    'id': id,
    'kind': kind.name,
    'url': url,
    'events': events.toList(),
    'enabled': enabled,
  };

  factory Webhook.fromJson(Map<String, dynamic> j) => Webhook(
    id: j['id'] as String,
    kind: WebhookKind.values.firstWhere((k) => k.name == j['kind'], orElse: () => WebhookKind.other),
    url: j['url'] as String,
    events: {
      for (final e in (j['events'] as List? ?? const ['ring'])) e as String,
    },
    enabled: j['enabled'] as bool? ?? true,
  );
}

class IntegrationSettings {
  const IntegrationSettings({
    this.pushoverUser = '',
    this.pushoverToken = '',
    this.pushoverOn = false,
    this.pushoverHigh = false,
    this.webhooks = const [],
    this.pauseOnShabbat = true,
  });

  /// Your Pushover user key (pushover.net, top of the page after sign-in).
  final String pushoverUser;

  /// An application token you create at pushover.net/apps/build.
  final String pushoverToken;
  final bool pushoverOn;

  /// Pushover priority 1: breaks through quiet hours.
  final bool pushoverHigh;
  final List<Webhook> webhooks;

  /// Send nothing for alarms inside Shabbat and festivals.
  final bool pauseOnShabbat;

  bool get pushoverReady => pushoverOn && pushoverUser.trim().isNotEmpty && pushoverToken.trim().isNotEmpty;

  IntegrationSettings copyWith({
    String? pushoverUser,
    String? pushoverToken,
    bool? pushoverOn,
    bool? pushoverHigh,
    List<Webhook>? webhooks,
    bool? pauseOnShabbat,
  }) => IntegrationSettings(
    pushoverUser: pushoverUser ?? this.pushoverUser,
    pushoverToken: pushoverToken ?? this.pushoverToken,
    pushoverOn: pushoverOn ?? this.pushoverOn,
    pushoverHigh: pushoverHigh ?? this.pushoverHigh,
    webhooks: webhooks ?? this.webhooks,
    pauseOnShabbat: pauseOnShabbat ?? this.pauseOnShabbat,
  );

  Map<String, dynamic> toJson() => {
    'pushoverUser': pushoverUser,
    'pushoverToken': pushoverToken,
    'pushoverOn': pushoverOn,
    'pushoverHigh': pushoverHigh,
    'webhooks': [for (final w in webhooks) w.toJson()],
    'pauseOnShabbat': pauseOnShabbat,
  };

  factory IntegrationSettings.fromJson(Map<String, dynamic> j) => IntegrationSettings(
    pushoverUser: j['pushoverUser'] as String? ?? '',
    pushoverToken: j['pushoverToken'] as String? ?? '',
    pushoverOn: j['pushoverOn'] as bool? ?? false,
    pushoverHigh: j['pushoverHigh'] as bool? ?? false,
    webhooks: [
      for (final w in (j['webhooks'] as List? ?? const [])) Webhook.fromJson(w as Map<String, dynamic>),
    ],
    pauseOnShabbat: j['pauseOnShabbat'] as bool? ?? true,
  );
}
