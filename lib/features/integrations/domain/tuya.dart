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
  const TuyaSettings({this.clientId = '', this.secret = '', this.uid = '', this.region = TuyaRegion.usWest});
  final String clientId;
  final String secret;
  final String uid;
  final TuyaRegion region;
  bool get ready => clientId.isNotEmpty && secret.isNotEmpty && uid.isNotEmpty;
  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'secret': secret,
    'uid': uid,
    'region': region.name,
  };
  factory TuyaSettings.fromJson(Map<String, dynamic> j) => TuyaSettings(
    clientId: j['clientId'] as String? ?? '',
    secret: j['secret'] as String? ?? '',
    uid: j['uid'] as String? ?? '',
    region: TuyaRegion.values.firstWhere((r) => r.name == j['region'], orElse: () => TuyaRegion.usWest),
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
