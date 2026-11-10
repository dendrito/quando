/// A built-in moment an alarm can hang off.
enum TimeAnchor {
  sunrise('sunrise'),
  sunset('sunset'),
  candleLighting('candle*'),
  havdalah('havdalah*');

  const TimeAnchor(this.query);

  /// The search a Shabbat, festival and sun times rule uses to find it.
  final String query;
}

/// What someone asked for, in words or by voice, before it becomes an alarm
/// or a rule. The parser and, later, an on-device AI model both produce this,
/// and the app always shows it for a tap on Save before anything is created.
class AlarmRequest {
  const AlarmRequest({
    this.hour,
    this.minute = 0,
    this.days = const {},
    this.dayOffset,
    this.after,
    this.anchor,
    this.offset = Duration.zero,
    this.label = '',
    this.halfDayUnsure = false,
  });

  /// "At 7" with no am/pm: for a one-off, the next 7 o'clock, morning or
  /// evening, is meant.
  final bool halfDayUnsure;

  /// Wall-clock time, for alarms at a time of day.
  final int? hour;
  final int minute;

  /// Repeats on these weekdays, 1 = Monday ... 7 = Sunday. Empty = once,
  /// or, for an [anchor], every time it comes.
  final Set<int> days;

  /// For a one-off: 0 = today, 1 = tomorrow. null = the next time it comes.
  final int? dayOffset;

  /// "In 20 minutes": rings this long after now.
  final Duration? after;

  /// Rings around sunrise, sunset, candle lighting or havdalah.
  final TimeAnchor? anchor;

  /// From the [anchor]: negative = before, positive = after.
  final Duration offset;

  /// What the alarm is for, e.g. "Take pills". Empty = none.
  final String label;

  bool get isEmpty => hour == null && after == null && anchor == null;

  bool get repeats => days.isNotEmpty;

  AlarmRequest copyWith({String? label}) => AlarmRequest(
    hour: hour,
    minute: minute,
    days: days,
    dayOffset: dayOffset,
    after: after,
    anchor: anchor,
    offset: offset,
    label: label ?? this.label,
    halfDayUnsure: halfDayUnsure,
  );

  @override
  bool operator ==(Object other) =>
      other is AlarmRequest &&
      other.hour == hour &&
      other.minute == minute &&
      other.days.length == days.length &&
      other.days.containsAll(days) &&
      other.dayOffset == dayOffset &&
      other.after == after &&
      other.anchor == anchor &&
      other.offset == offset &&
      other.label == label;

  @override
  int get hashCode => Object.hash(hour, minute, Object.hashAllUnordered(days), dayOffset, after, anchor, offset, label);

  @override
  String toString() =>
      'AlarmRequest(${[if (hour != null) 'at $hour:${minute.toString().padLeft(2, '0')}', if (days.isNotEmpty) 'days ${(days.toList()..sort()).join(',')}', if (dayOffset != null) 'dayOffset $dayOffset', if (after != null) 'in ${after!.inMinutes}m', if (anchor != null) '${anchor!.name} ${offset.inMinutes}m', if (label.isNotEmpty) '"$label"'].join(', ')})';
}
