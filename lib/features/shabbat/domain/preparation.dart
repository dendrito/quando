import '../../events/domain/event.dart';

/// Pauses only reminders before candle lighting; keeps each rule's choices.
class Preparation {
  const Preparation({this.enabled = true, this.skipUntil});
  final bool enabled;
  final DateTime? skipUntil;

  bool allows(AnchorEvent event, Duration offset) =>
      event.kind != EventKind.holyDayStart ||
      !offset.isNegative ||
      (enabled && (skipUntil == null || event.at.isAfter(skipUntil!)));

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    if (skipUntil != null) 'skipUntil': skipUntil!.toUtc().toIso8601String(),
  };

  factory Preparation.fromJson(Map<String, dynamic> j) =>
      Preparation(enabled: j['enabled'] as bool? ?? true, skipUntil: DateTime.tryParse('${j['skipUntil']}'));
}
