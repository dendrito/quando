import '../../shabbat/domain/hebrew_date.dart';

class HomeDisplay {
  const HomeDisplay({
    this.night = true,
    this.moon = true,
    this.moonDetails = true,
    this.weather = true,
    this.parasha = false,
    this.roshHodesh = false,
    this.skyUseShabbat = false,
    this.courses = const {},
    this.hebrewNames = HebrewNames.israeli,
  });
  final bool night, moon, weather, parasha, roshHodesh;

  /// An extra swipe page with the big Moon phase view.
  final bool moonDetails;
  final bool skyUseShabbat;
  final Set<String> courses;

  /// How the parasha and Hebrew months are spelled.
  final HebrewNames hebrewNames;
  static const courseIds = {'daf', 'rambam1', 'rambam3', 'mitzvot', 'mishnah', 'nach'};
  HomeDisplay copyWith({
    bool? night,
    bool? moon,
    bool? moonDetails,
    bool? weather,
    bool? parasha,
    bool? roshHodesh,
    bool? skyUseShabbat,
    Set<String>? courses,
    HebrewNames? hebrewNames,
  }) => HomeDisplay(
    night: night ?? this.night,
    moon: moon ?? this.moon,
    moonDetails: moonDetails ?? this.moonDetails,
    weather: weather ?? this.weather,
    parasha: parasha ?? this.parasha,
    roshHodesh: roshHodesh ?? this.roshHodesh,
    skyUseShabbat: skyUseShabbat ?? this.skyUseShabbat,
    courses: courses ?? this.courses,
    hebrewNames: hebrewNames ?? this.hebrewNames,
  );
  Map<String, dynamic> toJson() => {
    'night': night,
    'moon': moon,
    'moonDetails': moonDetails,
    'weather': weather,
    'parasha': parasha,
    'roshHodesh': roshHodesh,
    'skyUseShabbat': skyUseShabbat,
    'courses': courses.toList()..sort(),
    'hebrewNames': hebrewNames.name,
  };
  factory HomeDisplay.fromJson(Map<String, dynamic> j, {bool parashaDefault = false}) => HomeDisplay(
    night: j['night'] as bool? ?? true,
    moon: j['moon'] as bool? ?? true,
    moonDetails: j['moonDetails'] as bool? ?? true,
    weather: j['weather'] as bool? ?? true,
    parasha: j['parasha'] as bool? ?? parashaDefault,
    roshHodesh: j['roshHodesh'] as bool? ?? false,
    skyUseShabbat: j['skyUseShabbat'] as bool? ?? false,
    courses: {
      for (final x in j['courses'] as List? ?? [])
        if (courseIds.contains(x)) x as String,
    },
    hebrewNames: HebrewNames.from(j['hebrewNames']),
  );
}
