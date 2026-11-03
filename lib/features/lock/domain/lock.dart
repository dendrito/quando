import '../../events/domain/event.dart';

/// When lock mode is on, and what is allowed.
class LockSettings {
  const LockSettings({
    this.shabbat = false,
    this.calendarKeyword = '',
    this.pin = true,
    this.openAtStart = true,
    this.manualUntil,
  });

  /// Lock for every Shabbat and festival.
  final bool shabbat;

  /// Lock during calendar events with this word in the title. Empty = off.
  final String calendarKeyword;

  /// Pin Quando to the screen while locked (Android screen pinning).
  final bool pin;

  /// Open Quando on its own when a lock starts, so it can lock.
  final bool openAtStart;

  /// "Lock now for 2 hours".
  final DateTime? manualUntil;

  LockSettings copyWith({
    bool? shabbat,
    String? calendarKeyword,
    bool? pin,
    bool? openAtStart,
    DateTime? manualUntil,
    bool clearManual = false,
  }) => LockSettings(
    shabbat: shabbat ?? this.shabbat,
    calendarKeyword: calendarKeyword ?? this.calendarKeyword,
    pin: pin ?? this.pin,
    openAtStart: openAtStart ?? this.openAtStart,
    manualUntil: clearManual ? null : (manualUntil ?? this.manualUntil),
  );

  Map<String, dynamic> toJson() => {
    'shabbat': shabbat,
    'calendarKeyword': calendarKeyword,
    'pin': pin,
    'openAtStart': openAtStart,
    'manualUntil': manualUntil?.toIso8601String(),
  };

  factory LockSettings.fromJson(Map<String, dynamic> j) => LockSettings(
    shabbat: j['shabbat'] as bool? ?? false,
    calendarKeyword: j['calendarKeyword'] as String? ?? '',
    pin: j['pin'] as bool? ?? true,
    openAtStart: j['openAtStart'] as bool? ?? true,
    manualUntil: j['manualUntil'] == null ? null : DateTime.parse(j['manualUntil'] as String).toUtc(),
  );
}

/// One stretch of time Quando is locked.
class LockPeriod {
  const LockPeriod({
    required this.id,
    required this.start,
    required this.end,
    required this.reason,
    Set<String>? ids,
  }) : ids = ids ?? const {};

  final String id;

  /// Every lock merged into this one, for "unlock".
  final Set<String> ids;
  Set<String> get allIds => {id, ...ids};
  final DateTime start;
  final DateTime end;

  /// "Shabbat", "Rosh Hashanah", "Exam", "Locked for 2 hours".
  final String reason;

  bool contains(DateTime t) => !t.isBefore(start) && t.isBefore(end);
}

/// Every lock between [from] and [to], earliest first, overlapping ones
/// merged so the lock never flickers off between two of them.
List<LockPeriod> lockPeriods({
  required LockSettings settings,
  required List<HolyPeriod> holy,
  required List<AnchorEvent> calendarEvents,
  required DateTime now,
  Set<String> dismissed = const {},
}) {
  final out = <LockPeriod>[];
  if (settings.shabbat) {
    for (final p in holy) {
      out.add(
        LockPeriod(
          id: 'holy.${p.start.millisecondsSinceEpoch}',
          start: p.start,
          end: p.end,
          reason: p.names.join(' · '),
        ),
      );
    }
  }
  final kw = settings.calendarKeyword.trim().toLowerCase();
  if (kw.isNotEmpty) {
    final ends = {
      for (final e in calendarEvents)
        if (e.kind == EventKind.calendarEnd) e.id.replaceFirst('calend.', ''): e.at,
    };
    for (final e in calendarEvents) {
      if (e.kind != EventKind.calendar || !e.title.toLowerCase().contains(kw)) continue;
      final end = ends[e.id.replaceFirst('cal.', '')];
      if (end == null || !end.isAfter(e.at)) continue;
      out.add(LockPeriod(id: e.id, start: e.at, end: end, reason: e.title));
    }
  }
  final until = settings.manualUntil;
  if (until != null && until.isAfter(now)) {
    out.add(
      LockPeriod(
        id: 'manual.${until.millisecondsSinceEpoch}',
        start: now.subtract(const Duration(seconds: 1)),
        end: until,
        reason: 'Locked',
      ),
    );
  }
  out.removeWhere((p) => dismissed.contains(p.id) || !p.end.isAfter(now));
  out.sort((a, b) => a.start.compareTo(b.start));

  // Merge overlaps.
  final merged = <LockPeriod>[];
  for (final p in out) {
    if (merged.isNotEmpty && !p.start.isAfter(merged.last.end)) {
      final last = merged.removeLast();
      merged.add(
        LockPeriod(
          id: last.id,
          start: last.start,
          end: p.end.isAfter(last.end) ? p.end : last.end,
          reason: last.reason == p.reason ? last.reason : '${last.reason} · ${p.reason}',
          ids: {...last.allIds, ...p.allIds},
        ),
      );
    } else {
      merged.add(p);
    }
  }
  return merged;
}
