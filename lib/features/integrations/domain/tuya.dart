enum TuyaRegion {
  usWest('Western America', 'openapi.tuyaus.com'),
  usEast('Eastern America', 'openapi-ueaz.tuyaus.com'),
  euCentral('Central Europe', 'openapi.tuyaeu.com'),
  euWest('Western Europe', 'openapi-weaz.tuyaeu.com'),
  india('India', 'openapi.tuyain.com'),
  china('China', 'openapi.tuyacn.com'),
  singapore('Singapore', 'openapi-sg.iotbing.com');

  const TuyaRegion(this.label, this.host);
  final String label;
  final String host;
}

class TuyaSettings {
  const TuyaSettings({
    this.clientId = '',
    this.secret = '',
    this.uid = '',
    this.region = TuyaRegion.usWest,
    this.relayUrl = defaultRelayUrl,
  });

  /// Address of Quando's Tuya relay, set at build time with
  /// `--dart-define=QUANDO_TUYA_RELAY=https://...`. Empty when no relay is set up.
  static const defaultRelayUrl = String.fromEnvironment('QUANDO_TUYA_RELAY');

  final String clientId;
  final String secret;
  final String uid;
  final TuyaRegion region;

  /// When set, scenes are listed and run through the relay with the user's Quando
  /// sign-in; no Tuya keys are needed in the app. Otherwise the user's own project is used.
  final String relayUrl;
  bool get viaRelay => relayUrl.trim().isNotEmpty;
  bool get ready => viaRelay || clientId.isNotEmpty && secret.isNotEmpty && uid.isNotEmpty;
  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'secret': secret,
    'uid': uid,
    'region': region.name,
    if (relayUrl != defaultRelayUrl) 'relayUrl': relayUrl,
  };
  factory TuyaSettings.fromJson(Map<String, dynamic> j) => TuyaSettings(
    clientId: j['clientId'] as String? ?? '',
    secret: j['secret'] as String? ?? '',
    uid: j['uid'] as String? ?? '',
    region: TuyaRegion.values.firstWhere((r) => r.name == j['region'], orElse: () => TuyaRegion.usWest),
    relayUrl: j['relayUrl'] as String? ?? defaultRelayUrl,
  );
}

/// A scene reference contains no credentials and may follow an alarm in sync.
class TuyaScene {
  const TuyaScene({required this.homeId, required this.id, required this.name});
  final String homeId;
  final String id;
  final String name;
  String get key => '$homeId/$id';
  Map<String, dynamic> toJson() => {'homeId': homeId, 'id': id, 'name': name};
  factory TuyaScene.fromJson(Map<String, dynamic> j) =>
      TuyaScene(homeId: j['homeId'] as String, id: j['id'] as String, name: j['name'] as String);
}
