import 'package:alarm/alarm.dart';

/// How loud an alarm rings, and how it fades in at the start and out at the
/// end, when it stops by itself.
class Loudness {
  const Loudness({this.volume, this.fadeInSeconds = 10, this.fadeOutSeconds = 0});

  /// Percent of the phone's alarm volume, 0 to 100. null = leave the phone's
  /// alarm volume as it is.
  final int? volume;

  /// Seconds to rise from silent to full. 0 = full straight away.
  final int fadeInSeconds;

  /// Seconds to sink back to silent before it stops by itself. 0 = no fade.
  final int fadeOutSeconds;

  static const standard = Loudness();

  /// The settings the alarm plugin plays with, for an alarm that rings for
  /// [ringSeconds]. When the fades are longer than the ring, both shrink to
  /// fit, so a short alarm is still heard.
  VolumeSettings toVolumeSettings(int ringSeconds) {
    final v = volume == null ? null : volume!.clamp(0, 100) / 100;
    var fadeIn = fadeInSeconds.clamp(0, 3600).toDouble();
    var fadeOut = fadeOutSeconds.clamp(0, 3600).toDouble();
    final ring = ringSeconds.toDouble();
    if (ring <= 0) fadeOut = 0;
    // Keep at least a fifth of the ring at full volume.
    final room = ring * 0.8;
    if (ring > 0 && fadeIn + fadeOut > room) {
      final k = room / (fadeIn + fadeOut);
      fadeIn *= k;
      fadeOut *= k;
    }
    if (fadeIn < 1) fadeIn = 0;
    if (fadeOut < 1) fadeOut = 0;
    if (fadeIn == 0 && fadeOut == 0) return VolumeSettings.fixed(volume: v);
    Duration at(double s) => Duration(milliseconds: (s * 1000).round());
    return VolumeSettings.staircaseFade(
      volume: v,
      fadeSteps: [
        if (fadeIn > 0) ...[VolumeFadeStep(Duration.zero, 0), VolumeFadeStep(at(fadeIn), 1)],
        if (fadeOut > 0) ...[
          if (fadeIn == 0) VolumeFadeStep(Duration.zero, 1),
          VolumeFadeStep(at(ring - fadeOut), 1),
          VolumeFadeStep(at(ring), 0),
        ],
      ],
    );
  }

  /// "70% · fades in 10 s", "Phone volume · no fade".
  String get summary {
    final parts = [
      volume == null ? 'Phone volume' : '$volume%',
      if (fadeInSeconds > 0) 'fades in ${seconds(fadeInSeconds)}',
      if (fadeOutSeconds > 0) 'fades out ${seconds(fadeOutSeconds)}',
      if (fadeInSeconds == 0 && fadeOutSeconds == 0) 'no fade',
    ];
    return parts.join(' · ');
  }

  static String seconds(int s) =>
      s < 60 ? '$s s' : (s % 60 == 0 ? '${s ~/ 60} min' : '${s ~/ 60} min ${s % 60} s');

  Loudness copyWith({int? volume, bool phoneVolume = false, int? fadeInSeconds, int? fadeOutSeconds}) =>
      Loudness(
        volume: phoneVolume ? null : (volume ?? this.volume),
        fadeInSeconds: fadeInSeconds ?? this.fadeInSeconds,
        fadeOutSeconds: fadeOutSeconds ?? this.fadeOutSeconds,
      );

  Map<String, dynamic> toJson() => {'volume': volume, 'fadeIn': fadeInSeconds, 'fadeOut': fadeOutSeconds};

  static Loudness? fromJson(Object? j) {
    if (j is! Map) return null;
    return Loudness(
      volume: (j['volume'] as num?)?.toInt(),
      fadeInSeconds: (j['fadeIn'] as num?)?.toInt() ?? 10,
      fadeOutSeconds: (j['fadeOut'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Loudness &&
      other.volume == volume &&
      other.fadeInSeconds == fadeInSeconds &&
      other.fadeOutSeconds == fadeOutSeconds;

  @override
  int get hashCode => Object.hash(volume, fadeInSeconds, fadeOutSeconds);
}
