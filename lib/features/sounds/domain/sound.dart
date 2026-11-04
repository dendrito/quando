/// A sound an alarm can ring with.
class AlarmSound {
  const AlarmSound({
    required this.id,
    required this.name,
    required this.path,
    this.builtIn = false,
    this.link,
    this.plays = false,
    this.playSeconds = 0,
  });

  final String id;
  final String name;

  /// `assets/sounds/x.wav` for built-in sounds, otherwise relative to the
  /// app's documents folder (what the alarm plugin expects), e.g.
  /// `sounds/abc.m4a`.
  final String path;
  final bool builtIn;

  /// A song or playlist in another app, e.g. a Spotify or SoundCloud link.
  /// The alarm rings with [path] (a built-in sound), then opens this when
  /// you stop it.
  final String? link;

  bool get isLink => link != null;

  /// The song itself is the alarm: its app opens and plays it when the
  /// alarm goes off, and [path] rings only if it stays silent. Otherwise
  /// [path] rings and Stop opens the song.
  final bool plays;

  /// Quando pauses the song after this long. 0 = it plays until you stop it.
  final int playSeconds;

  static const playLengths = [0, 5, 15, 30, 60, 300, 900];

  /// "Until you stop it", "5 s", "1 min"…
  static String playLength(int s) => s == 0 ? 'Until you stop it' : (s < 60 ? '$s s' : '${s ~/ 60} min');

  /// An online radio station: [path] is the stream's address. If it can't
  /// connect, the phone's alarm sound rings instead.
  bool get isRadio => path.startsWith('http://') || path.startsWith('https://');

  /// "Spotify", "SoundCloud", "YouTube"… for a link sound.
  String? get linkApp {
    final l = link?.toLowerCase();
    if (l == null) return null;
    for (final (k, v) in const [
      ('spotify', 'Spotify'),
      ('soundcloud', 'SoundCloud'),
      ('music.youtube', 'YouTube Music'),
      ('youtu', 'YouTube'),
      ('music.apple', 'Apple Music'),
      ('music.amazon', 'Amazon Music'),
      ('amazon.', 'Amazon Music'),
      ('amzn', 'Amazon Music'),
      ('deezer', 'Deezer'),
      ('tidal', 'Tidal'),
      ('pandora', 'Pandora'),
      ('bandcamp', 'Bandcamp'),
    ]) {
      if (l.contains(k)) return v;
    }
    return Uri.tryParse(link!)?.host.replaceFirst('www.', '');
  }

  AlarmSound rename(String name) => copyWith(name: name);

  AlarmSound copyWith({String? name, String? path, bool? plays, int? playSeconds}) => AlarmSound(
    id: id,
    name: name ?? this.name,
    path: path ?? this.path,
    builtIn: builtIn,
    link: link,
    plays: plays ?? this.plays,
    playSeconds: playSeconds ?? this.playSeconds,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'path': path,
    'link': ?link,
    if (plays) 'plays': true,
    if (playSeconds > 0) 'playSeconds': playSeconds,
  };

  factory AlarmSound.fromJson(Map<String, dynamic> j) => AlarmSound(
    id: j['id'] as String,
    name: j['name'] as String,
    path: j['path'] as String,
    link: j['link'] as String?,
    plays: j['plays'] as bool? ?? false,
    playSeconds: (j['playSeconds'] as num?)?.toInt() ?? 0,
  );

  static const builtIns = [
    AlarmSound(id: 'builtin.chime', name: 'Soft chime', path: 'assets/sounds/soft_chime.wav', builtIn: true),
    AlarmSound(
      id: 'builtin.rise',
      name: 'Morning rise',
      path: 'assets/sounds/morning_rise.wav',
      builtIn: true,
    ),
    AlarmSound(
      id: 'builtin.beep',
      name: 'Classic beep',
      path: 'assets/sounds/classic_beep.wav',
      builtIn: true,
    ),
  ];

  /// Soft, looping lead-up sounds for the gentle wake-up only; they are not
  /// alarm sounds. Made for Quando by tool/gen_gentle_sounds.py.
  static const calm = [
    AlarmSound(
      id: 'calm.city',
      name: 'Quiet city morning',
      path: 'assets/sounds/gentle_city.ogg',
      builtIn: true,
    ),
    AlarmSound(
      id: 'calm.birds',
      name: 'Birds at dawn',
      path: 'assets/sounds/gentle_birds.ogg',
      builtIn: true,
    ),
    AlarmSound(
      id: 'calm.waves',
      name: 'Waves on the shore',
      path: 'assets/sounds/gentle_waves.ogg',
      builtIn: true,
    ),
    AlarmSound(id: 'calm.rain', name: 'Soft rain', path: 'assets/sounds/gentle_rain.ogg', builtIn: true),
    AlarmSound(
      id: 'calm.stream',
      name: 'Forest stream',
      path: 'assets/sounds/gentle_stream.ogg',
      builtIn: true,
    ),
    AlarmSound(id: 'calm.wind', name: 'Gentle wind', path: 'assets/sounds/gentle_wind.ogg', builtIn: true),
    AlarmSound(id: 'calm.fire', name: 'Crackling fire', path: 'assets/sounds/gentle_fire.ogg', builtIn: true),
    AlarmSound(id: 'calm.night', name: 'Summer night', path: 'assets/sounds/gentle_night.ogg', builtIn: true),
  ];

  /// Who recorded the calm sounds, as their licences ask.
  static const calmCredits = [
    ('Quiet city morning', 'gezortenplotz, freesound.org', 'CC BY'),
    ('Birds at dawn', 'kvgarlic, freesound.org', 'CC0'),
    ('Waves on the shore', 'Luftrum, freesound.org', 'CC BY'),
    ('Soft rain', 'alex36917, freesound.org', 'CC BY'),
    ('Forest stream', 'gluckose, freesound.org', 'CC0'),
    ('Gentle wind', 'felix.blume, freesound.org', 'CC0'),
    ('Crackling fire', 'ezwa, soundbible.com', 'Public domain'),
    ('Summer night', 'Lisa Redfern, soundbible.com', 'Public domain'),
  ];
}
