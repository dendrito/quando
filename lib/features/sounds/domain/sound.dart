/// A sound an alarm can ring with.
class AlarmSound {
  const AlarmSound({required this.id, required this.name, required this.path, this.builtIn = false});

  final String id;
  final String name;

  /// `assets/sounds/x.wav` for built-in sounds, otherwise relative to the
  /// app's documents folder (what the alarm plugin expects), e.g.
  /// `sounds/abc.m4a`.
  final String path;
  final bool builtIn;

  AlarmSound rename(String name) => AlarmSound(id: id, name: name, path: path, builtIn: builtIn);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'path': path};

  factory AlarmSound.fromJson(Map<String, dynamic> j) =>
      AlarmSound(id: j['id'] as String, name: j['name'] as String, path: j['path'] as String);

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
