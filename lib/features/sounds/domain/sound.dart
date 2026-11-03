/// A sound an alarm can ring with.
class AlarmSound {
  const AlarmSound({
    required this.id,
    required this.name,
    required this.path,
    this.builtIn = false,
    this.link,
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

  /// "Spotify", "SoundCloud", "YouTube"… for a link sound.
  String? get linkApp {
    final l = link?.toLowerCase();
    if (l == null) return null;
    for (final (k, v) in const [
      ('spotify', 'Spotify'),
      ('soundcloud', 'SoundCloud'),
      ('youtu', 'YouTube'),
      ('music.apple', 'Apple Music'),
      ('deezer', 'Deezer'),
      ('tidal', 'Tidal'),
      ('pandora', 'Pandora'),
      ('bandcamp', 'Bandcamp'),
    ]) {
      if (l.contains(k)) return v;
    }
    return Uri.tryParse(link!)?.host.replaceFirst('www.', '');
  }

  AlarmSound rename(String name) => AlarmSound(id: id, name: name, path: path, builtIn: builtIn, link: link);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'path': path, 'link': ?link};

  factory AlarmSound.fromJson(Map<String, dynamic> j) => AlarmSound(
    id: j['id'] as String,
    name: j['name'] as String,
    path: j['path'] as String,
    link: j['link'] as String?,
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
}
