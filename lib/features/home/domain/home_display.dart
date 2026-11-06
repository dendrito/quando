class HomeDisplay {
  const HomeDisplay({
    this.night = false,
    this.moon = false,
    this.weather = false,
    this.parasha = false,
    this.courses = const {},
  });
  final bool night, moon, weather, parasha;
  final Set<String> courses;
  static const courseIds = {'daf', 'rambam1', 'rambam3', 'mitzvot', 'mishnah', 'nach'};
  HomeDisplay copyWith({bool? night, bool? moon, bool? weather, bool? parasha, Set<String>? courses}) =>
      HomeDisplay(
        night: night ?? this.night,
        moon: moon ?? this.moon,
        weather: weather ?? this.weather,
        parasha: parasha ?? this.parasha,
        courses: courses ?? this.courses,
      );
  Map<String, dynamic> toJson() => {
    'night': night,
    'moon': moon,
    'weather': weather,
    'parasha': parasha,
    'courses': courses.toList()..sort(),
  };
  factory HomeDisplay.fromJson(Map<String, dynamic> j, {bool parashaDefault = false}) => HomeDisplay(
    night: j['night'] as bool? ?? false,
    moon: j['moon'] as bool? ?? false,
    weather: j['weather'] as bool? ?? false,
    parasha: j['parasha'] as bool? ?? parashaDefault,
    courses: {
      for (final x in j['courses'] as List? ?? [])
        if (courseIds.contains(x)) x as String,
    },
  );
}
