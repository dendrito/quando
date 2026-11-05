/// Delivery and media choices for one individual reminder occurrence.
///
/// Kept separate from [AlarmRule] so the same rule can use different media
/// and notification behavior at each offset from its event.
enum PushoverBehavior {
  /// Use the account-wide Pushover preference.
  inherit,

  /// Send a Pushover notification in addition to Quando's local alarm.
  alongside,

  /// Deliver through Pushover only; do not start Quando audio.
  replace,

  /// Do not send a Pushover notification for this reminder.
  disabled,
}

/// Media selected for one reminder. IDs refer to Quando's existing sound
/// catalog for local, radio, Spotify and YouTube sources.
enum ReminderAudioKind {
  inherit,
  local,
  radio,
  spotify,
  youtube,
  elevenLabs,
}

/// The per-reminder audio and notification configuration.
///
/// [audioId] is an existing sound ID, a station URL, or a service content URI.
/// ElevenLabs uses a saved/generated local audio ID after speech is rendered;
/// the API key and voice ID are never stored in this model.
class ReminderDelivery {
  const ReminderDelivery({
    this.audioKind = ReminderAudioKind.inherit,
    this.audioId,
    this.pushoverBehavior = PushoverBehavior.inherit,
    this.pushoverSound,
    this.pushoverPriority,
    this.announcementTemplate,
    this.elevenLabsVoiceId,
    this.cachedSpeechId,
  });

  final ReminderAudioKind audioKind;
  final String? audioId;
  final PushoverBehavior pushoverBehavior;

  /// null means use the connected Pushover account's default sound.
  final String? pushoverSound;

  /// null means use the account-wide priority.
  final int? pushoverPriority;

  /// Optional text template. Supports event placeholders such as
  /// {title}, {time}, {location}, and {countdown}.
  final String? announcementTemplate;

  /// ElevenLabs voice identifier. It is not a downloadable voice model.
  final String? elevenLabsVoiceId;

  /// Local generated audio cache key; generated speech plays offline.
  final String? cachedSpeechId;

  ReminderDelivery copyWith({
    ReminderAudioKind? audioKind,
    String? audioId,
    bool clearAudioId = false,
    PushoverBehavior? pushoverBehavior,
    String? pushoverSound,
    bool clearPushoverSound = false,
    int? pushoverPriority,
    bool clearPushoverPriority = false,
    String? announcementTemplate,
    bool clearAnnouncementTemplate = false,
    String? elevenLabsVoiceId,
    bool clearElevenLabsVoiceId = false,
    String? cachedSpeechId,
    bool clearCachedSpeechId = false,
  }) => ReminderDelivery(
    audioKind: audioKind ?? this.audioKind,
    audioId: clearAudioId ? null : (audioId ?? this.audioId),
    pushoverBehavior: pushoverBehavior ?? this.pushoverBehavior,
    pushoverSound: clearPushoverSound ? null : (pushoverSound ?? this.pushoverSound),
    pushoverPriority: clearPushoverPriority ? null : (pushoverPriority ?? this.pushoverPriority),
    announcementTemplate: clearAnnouncementTemplate
        ? null
        : (announcementTemplate ?? this.announcementTemplate),
    elevenLabsVoiceId: clearElevenLabsVoiceId
        ? null
        : (elevenLabsVoiceId ?? this.elevenLabsVoiceId),
    cachedSpeechId: clearCachedSpeechId ? null : (cachedSpeechId ?? this.cachedSpeechId),
  );

  Map<String, dynamic> toJson() => {
    'audioKind': audioKind.name,
    if (audioId != null) 'audioId': audioId,
    'pushoverBehavior': pushoverBehavior.name,
    if (pushoverSound != null) 'pushoverSound': pushoverSound,
    if (pushoverPriority != null) 'pushoverPriority': pushoverPriority,
    if (announcementTemplate != null) 'announcementTemplate': announcementTemplate,
    if (elevenLabsVoiceId != null) 'elevenLabsVoiceId': elevenLabsVoiceId,
    if (cachedSpeechId != null) 'cachedSpeechId': cachedSpeechId,
  };

  factory ReminderDelivery.fromJson(Map<String, dynamic> json) => ReminderDelivery(
    audioKind: ReminderAudioKind.values.firstWhere(
      (v) => v.name == json['audioKind'],
      orElse: () => ReminderAudioKind.inherit,
    ),
    audioId: json['audioId'] as String?,
    pushoverBehavior: PushoverBehavior.values.firstWhere(
      (v) => v.name == json['pushoverBehavior'],
      orElse: () => PushoverBehavior.inherit,
    ),
    pushoverSound: json['pushoverSound'] as String?,
    pushoverPriority: (json['pushoverPriority'] as num?)?.toInt(),
    announcementTemplate: json['announcementTemplate'] as String?,
    elevenLabsVoiceId: json['elevenLabsVoiceId'] as String?,
    cachedSpeechId: json['cachedSpeechId'] as String?,
  );
}
