/// How hard an alarm or reminder tries to get your attention.
enum AlarmPriority {
  /// A silent notification.
  quiet,

  /// A notification with a sound.
  normal,

  /// A full-screen alarm that rings through Do Not Disturb and other audio.
  loud,

  /// Like [loud], and keeps ringing until you stop it.
  critical;

  static AlarmPriority? parse(Object? name) => AlarmPriority.values.where((p) => p.name == name).firstOrNull;

  /// How long a critical alarm may ring before the phone gives up.
  static const criticalSeconds = 3600;
}
