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
    this.pushoverPriority = 0,
    this.pushoverSound,
    this.pushoverDevices = const {},
    this.webhooks = const [],
    this.pauseOnShabbat = true,
  });

  /// Your Pushover user key (pushover.net, top of the page after sign-in).
  final String pushoverUser;

  /// An application token you create at pushover.net/apps/build.
  final String pushoverToken;
  final bool pushoverOn;

  /// 0 normal, 1 high (through quiet hours), 2 emergency (Pushover keeps
  /// ringing every 30 s until you acknowledge it, up to 10 minutes).
  final int pushoverPriority;

  /// A Pushover sound name: built-in (e.g. `cosmic`) or one you uploaded to
  /// pushover.net. null = your Pushover default.
  final String? pushoverSound;

  /// Pushover device names to send to. Empty = all, this phone included.
  final Set<String> pushoverDevices;
  final List<Webhook> webhooks;

  /// Send nothing for alarms inside Shabbat and festivals.
  final bool pauseOnShabbat;

  bool get pushoverReady => pushoverOn && pushoverUser.trim().isNotEmpty && pushoverToken.trim().isNotEmpty;

  IntegrationSettings copyWith({
    String? pushoverUser,
    String? pushoverToken,
    bool? pushoverOn,
    int? pushoverPriority,
    String? pushoverSound,
    bool defaultPushoverSound = false,
    Set<String>? pushoverDevices,
    List<Webhook>? webhooks,
    bool? pauseOnShabbat,
  }) => IntegrationSettings(
    pushoverUser: pushoverUser ?? this.pushoverUser,
    pushoverToken: pushoverToken ?? this.pushoverToken,
    pushoverOn: pushoverOn ?? this.pushoverOn,
    pushoverPriority: pushoverPriority ?? this.pushoverPriority,
    pushoverSound: defaultPushoverSound ? null : (pushoverSound ?? this.pushoverSound),
    pushoverDevices: pushoverDevices ?? this.pushoverDevices,
    webhooks: webhooks ?? this.webhooks,
    pauseOnShabbat: pauseOnShabbat ?? this.pauseOnShabbat,
  );

  Map<String, dynamic> toJson() => {
    'pushoverUser': pushoverUser,
    'pushoverToken': pushoverToken,
    'pushoverOn': pushoverOn,
    'pushoverPriority': pushoverPriority,
    'pushoverSound': pushoverSound,
    'pushoverDevices': pushoverDevices.toList(),
    'webhooks': [for (final w in webhooks) w.toJson()],
    'pauseOnShabbat': pauseOnShabbat,
  };

  factory IntegrationSettings.fromJson(Map<String, dynamic> j) => IntegrationSettings(
    pushoverUser: j['pushoverUser'] as String? ?? '',
    pushoverToken: j['pushoverToken'] as String? ?? '',
    pushoverOn: j['pushoverOn'] as bool? ?? false,
    pushoverPriority:
        (j['pushoverPriority'] as num?)?.toInt() ?? ((j['pushoverHigh'] as bool? ?? false) ? 1 : 0),
    pushoverSound: j['pushoverSound'] as String?,
    pushoverDevices: {for (final d in (j['pushoverDevices'] as List? ?? const [])) d as String},
    webhooks: [
      for (final w in (j['webhooks'] as List? ?? const [])) Webhook.fromJson(w as Map<String, dynamic>),
    ],
    pauseOnShabbat: j['pauseOnShabbat'] as bool? ?? true,
  );
}
