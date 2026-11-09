part 'city_catalog.dart';

/// A place to calculate Shabbat and festival times for.
class Place {
  const Place({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    this.inIsrael = false,
    this.candleLightingMinutes = 18,
  });

  final String name;
  final double latitude;
  final double longitude;

  /// IANA zone, e.g. `Asia/Jerusalem`. Used to show local times.
  final String timeZone;

  /// One festival day in Israel, two outside.
  final bool inIsrael;

  /// Minutes before sunset. 18 is the common custom; some cities differ.
  final int candleLightingMinutes;

  Map<String, dynamic> toJson() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'timeZone': timeZone,
    'inIsrael': inIsrael,
    'candleMinutes': candleLightingMinutes,
  };

  factory Place.fromJson(Map<String, dynamic> j) => Place(
    name: j['name'] as String,
    latitude: (j['latitude'] as num).toDouble(),
    longitude: (j['longitude'] as num).toDouble(),
    timeZone: j['timeZone'] as String,
    inIsrael: j['inIsrael'] as bool? ?? false,
    candleLightingMinutes: j['candleMinutes'] as int? ?? 18,
  );

  Place copyWith({bool? inIsrael, int? candleLightingMinutes}) => Place(
    name: name,
    latitude: latitude,
    longitude: longitude,
    timeZone: timeZone,
    inIsrael: inIsrael ?? this.inIsrael,
    candleLightingMinutes: candleLightingMinutes ?? this.candleLightingMinutes,
  );
}

/// Starter list of cities. Local customs for candle lighting follow common
/// practice and can be changed by the user.
class Places {
  static const jerusalem = Place(
    name: 'Jerusalem',
    latitude: 31.778,
    longitude: 35.2354,
    timeZone: 'Asia/Jerusalem',
    inIsrael: true,
    candleLightingMinutes: 40,
  );
  static const telAviv = Place(
    name: 'Tel Aviv',
    latitude: 32.0853,
    longitude: 34.7818,
    timeZone: 'Asia/Jerusalem',
    inIsrael: true,
  );
  static const haifa = Place(
    name: 'Haifa',
    latitude: 32.794,
    longitude: 34.9896,
    timeZone: 'Asia/Jerusalem',
    inIsrael: true,
    candleLightingMinutes: 30,
  );
  static const saoPaulo = Place(
    name: 'São Paulo',
    latitude: -23.5505,
    longitude: -46.6333,
    timeZone: 'America/Sao_Paulo',
  );
  static const newYork = Place(name: 'New York', latitude: 40.7128, longitude: -74.006, timeZone: 'America/New_York');
  static const london = Place(name: 'London', latitude: 51.5074, longitude: -0.1278, timeZone: 'Europe/London');
  static const losAngeles = Place(
    name: 'Los Angeles',
    latitude: 34.0522,
    longitude: -118.2437,
    timeZone: 'America/Los_Angeles',
  );

  static const all = [jerusalem, telAviv, haifa, saoPaulo, newYork, london, losAngeles, ...extraPlaces];
}
