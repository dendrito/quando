/// Per-reminder overrides. Credentials stay in device integration settings.
/// Null values inherit existing rule/global choices, preserving old rules.
class ReminderDelivery {
  const ReminderDelivery({
    this.soundId,
    this.localAudio = true,
    this.pushoverDevices,
    this.useDefaultSound = false,
    this.pushoverEnabled,
    this.pushoverSound,
  });

  static const inherit = ReminderDelivery();

  /// Reference to an existing local, recording, radio or music sound entry.
  final String? soundId;
  final bool localAudio;

  /// Null inherits the connected account; an empty set targets all devices.
  final Set<String>? pushoverDevices;

  ReminderDelivery copyWith({
    String? soundId,
    bool clearSound = false,
    bool? useDefaultSound,
    bool? localAudio,
    bool? pushoverEnabled,
    String? pushoverSound,
    bool clearPushoverSound = false,
    Set<String>? pushoverDevices,
  }) => ReminderDelivery(
    soundId: clearSound ? null : (soundId ?? this.soundId),
    useDefaultSound: useDefaultSound ?? this.useDefaultSound,
    localAudio: localAudio ?? this.localAudio,
    pushoverEnabled: pushoverEnabled ?? this.pushoverEnabled,
    pushoverSound: clearPushoverSound ? null : (pushoverSound ?? this.pushoverSound),
    pushoverDevices: pushoverDevices ?? this.pushoverDevices,
  );

  /// Explicitly use the app default instead of this rule's chosen sound.
  final bool useDefaultSound;
  final bool? pushoverEnabled;
  final String? pushoverSound;

  String? resolveSound(String? ruleSound) => useDefaultSound ? null : (soundId ?? ruleSound);

  Map<String, dynamic> toJson() => {
    if (soundId != null) 'soundId': soundId,
    if (!localAudio) 'localAudio': false,
    if (pushoverDevices != null) 'pushoverDevices': pushoverDevices!.toList()..sort(),
    if (useDefaultSound) 'useDefaultSound': true,
    if (pushoverEnabled != null) 'pushoverEnabled': pushoverEnabled,
    if (pushoverSound != null) 'pushoverSound': pushoverSound,
  };

  factory ReminderDelivery.fromJson(Map<String, dynamic> j) => ReminderDelivery(
    soundId: j['soundId'] as String?,
    localAudio: j['localAudio'] as bool? ?? true,
    pushoverDevices: j['pushoverDevices'] == null
        ? null
        : {for (final d in j['pushoverDevices'] as List) d as String},
    useDefaultSound: j['useDefaultSound'] as bool? ?? false,
    pushoverEnabled: j['pushoverEnabled'] as bool?,
    pushoverSound: j['pushoverSound'] as String?,
  );

  /// JSON object keys are signed minute offsets: negative before, zero at,
  /// positive after. This uses the same precision as existing stored rules.
  static Map<String, dynamic> encode(Map<int, ReminderDelivery> choices) => {
    for (final e in choices.entries) '${e.key}': e.value.toJson(),
  };

  static Map<int, ReminderDelivery> decode(Object? raw) {
    if (raw is! Map) return const {};
    return {
      for (final e in raw.entries)
        if (int.tryParse('${e.key}') case final int offset)
          if (e.value is Map<String, dynamic>) offset: ReminderDelivery.fromJson(e.value),
    };
  }
}
