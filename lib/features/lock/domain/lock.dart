import '../../events/domain/event.dart';
import '../../events/domain/event_query.dart';
import 'shabbat_calendar.dart';

import 'package:quando/l10n/l10n.dart';

/// What a lock screen looks like: calm and generic, or Shabbat candles.
/// Shabbat only ever shows when the lock comes from Shabbat times or a
/// Shabbat calendar the user picked.
enum LockLook { calm, shabbat }

/// "Lock during my exams" or "lock from Leave office to Back home": a lock
/// read off the user's own calendars.
class CalendarLock {
  const CalendarLock({
    required this.id,
    required this.startQuery,
    this.endQuery = '',
    this.name = '',
    this.calendarIds = const {},
    this.enabled = true,
  });

  final String id;

  /// Events to lock at, as an EventQuery ("exam", "focus OR deep work").
  final String startQuery;

  /// Empty: lock for the length of each matching event. Otherwise lock
  /// from each [startQuery] event until the next event matching this.
  final String endQuery;

  final String name;

  /// Only events from these calendars. Empty = every calendar you picked.
  final Set<String> calendarIds;

  final bool enabled;

  bool get between => endQuery.trim().isNotEmpty;

  /// The longest a "between" lock waits for its end event.
  static const maxBetween = Duration(days: 3);

  CalendarLock copyWith({
    String? startQuery,
    String? endQuery,
    String? name,
    Set<String>? calendarIds,
    bool? enabled,
  }) => CalendarLock(
    id: id,
    startQuery: startQuery ?? this.startQuery,
    endQuery: endQuery ?? this.endQuery,
    name: name ?? this.name,
    calendarIds: calendarIds ?? this.calendarIds,
    enabled: enabled ?? this.enabled,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'start': startQuery,
    'end': endQuery,
    'name': name,
    'calendarIds': calendarIds.toList(),
    'enabled': enabled,
  };

  factory CalendarLock.fromJson(Map<String, dynamic> j) => CalendarLock(
    id: j['id'] as String,
    startQuery: j['start'] as String? ?? '',
    endQuery: j['end'] as String? ?? '',
    name: j['name'] as String? ?? '',
    calendarIds: {for (final c in (j['calendarIds'] as List? ?? const [])) c as String},
    enabled: j['enabled'] as bool? ?? true,
  );
}

/// When lock mode is on, and what is allowed.
class LockSettings {
  const LockSettings({
    this.shabbat = false,
    this.calendarLocks = const [],
    this.pin = true,
    this.openAtStart = true,
    this.manualUntil,
  });

  /// Lock for every Shabbat and festival, from Quando?'s own times.
  final bool shabbat;

  /// Locks read off the user's calendars.
  final List<CalendarLock> calendarLocks;

  /// Pin Quando to the screen while locked (Android screen pinning).
  final bool pin;

  /// Open Quando on its own when a lock starts, so it can lock.
  final bool openAtStart;

  /// "Lock now for 2 hours".
  final DateTime? manualUntil;

  LockSettings copyWith({
    bool? shabbat,
    List<CalendarLock>? calendarLocks,
    bool? pin,
    bool? openAtStart,
    DateTime? manualUntil,
    bool clearManual = false,
  }) => LockSettings(
    shabbat: shabbat ?? this.shabbat,
    calendarLocks: calendarLocks ?? this.calendarLocks,
    pin: pin ?? this.pin,
    openAtStart: openAtStart ?? this.openAtStart,
    manualUntil: clearManual ? null : (manualUntil ?? this.manualUntil),
  );

  /// Adds or replaces [lock] (same id).
  LockSettings withLock(CalendarLock lock) {
    final i = calendarLocks.indexWhere((l) => l.id == lock.id);
    final next = [...calendarLocks];
    i < 0 ? next.add(lock) : next[i] = lock;
    return copyWith(calendarLocks: next);
  }

  LockSettings withoutLock(String id) => copyWith(
    calendarLocks: [
      for (final l in calendarLocks)
        if (l.id != id) l,
    ],
  );

  Map<String, dynamic> toJson() => {
    'shabbat': shabbat,
    'calendarLocks': [for (final l in calendarLocks) l.toJson()],
    'pin': pin,
    'openAtStart': openAtStart,
    'manualUntil': manualUntil?.toIso8601String(),
  };

  factory LockSettings.fromJson(Map<String, dynamic> j) {
    final locks = [
      for (final l in (j['calendarLocks'] as List? ?? const []).cast<Map<String, dynamic>>())
        CalendarLock.fromJson(l),
    ];
    // Older versions had one "during events named..." word.
    final legacy = (j['calendarKeyword'] as String? ?? '').trim();
    if (legacy.isNotEmpty && j['calendarLocks'] == null) {
      locks.add(CalendarLock(id: 'keyword', startQuery: legacy));
    }
    return LockSettings(
      shabbat: j['shabbat'] as bool? ?? false,
      calendarLocks: locks,
      pin: j['pin'] as bool? ?? true,
      openAtStart: j['openAtStart'] as bool? ?? true,
      manualUntil: j['manualUntil'] == null ? null : DateTime.parse(j['manualUntil'] as String).toUtc(),
    );
  }
}

/// One stretch of time Quando is locked.
class LockPeriod {
  const LockPeriod({
    required this.id,
    required this.start,
    required this.end,
    required this.reason,
    this.look = LockLook.calm,
    Set<String>? ids,
  }) : ids = ids ?? const {};

  /// Candles and "Shabbat shalom", or the calm generic screen.
  final LockLook look;

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
  Set<String> shabbatCalendars = const {},
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
          look: LockLook.shabbat,
        ),
      );
    }
  }
  for (final lock in settings.calendarLocks) {
    if (!lock.enabled) continue;
    out.addAll(calendarLockPeriods(lock, calendarEvents, shabbatCalendars: shabbatCalendars));
  }
  final until = settings.manualUntil;
  if (until != null && until.isAfter(now)) {
    out.add(
      LockPeriod(
        id: 'manual.${until.millisecondsSinceEpoch}',
        start: now.subtract(const Duration(seconds: 1)),
        end: until,
        reason: l10n.locked,
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
          look: last.look == LockLook.shabbat || p.look == LockLook.shabbat
              ? LockLook.shabbat
              : LockLook.calm,
          ids: {...last.allIds, ...p.allIds},
        ),
      );
    } else {
      merged.add(p);
    }
  }
  return merged;
}

/// The stretches one calendar lock covers: each matching event, or from
/// each start event to the next end event (within [CalendarLock.maxBetween]).
/// They look like Shabbat only when they come from a Shabbat calendar or
/// start at candle lighting.
List<LockPeriod> calendarLockPeriods(
  CalendarLock lock,
  List<AnchorEvent> events, {
  Set<String> shabbatCalendars = const {},
}) {
  final startQ = EventQuery.parse(lock.startQuery.trim());
  if (startQ.isEmpty) return const [];
  bool fromCalendar(AnchorEvent e) => lock.calendarIds.isEmpty || lock.calendarIds.contains(e.source);
  final starts = [
    for (final e in events)
      if (e.kind == EventKind.calendar && fromCalendar(e) && startQ.matches(e.title)) e,
  ]..sort((a, b) => a.at.compareTo(b.at));
  if (starts.isEmpty) return const [];

  final out = <LockPeriod>[];
  if (!lock.between) {
    final ends = {
      for (final e in events)
        if (e.kind == EventKind.calendarEnd) e.id.replaceFirst('calend.', ''): e.at,
    };
    for (final e in starts) {
      final end = ends[e.id.replaceFirst('cal.', '')];
      if (end == null || !end.isAfter(e.at)) continue;
      out.add(_period(lock, e, end, shabbatCalendars));
    }
    return out;
  }

  final endQ = EventQuery.parse(lock.endQuery.trim());
  final endEvents = [
    for (final e in events)
      if (e.kind == EventKind.calendar && fromCalendar(e) && endQ.matches(e.title)) e,
  ]..sort((a, b) => a.at.compareTo(b.at));
  for (final s in starts) {
    final end = endEvents
        .where((e) => e.at.isAfter(s.at) && !e.at.isAfter(s.at.add(CalendarLock.maxBetween)))
        .firstOrNull;
    if (end == null) continue;
    out.add(_period(lock, s, end.at, shabbatCalendars));
  }
  return out;
}

LockPeriod _period(CalendarLock lock, AnchorEvent start, DateTime end, Set<String> shabbatCalendars) {
  final shabbat = shabbatCalendars.contains(start.source) || isCandleLightingTitle(start.title);
  return LockPeriod(
    id: 'cl.${lock.id}.${start.id}',
    start: start.at,
    end: end,
    reason: lock.name.trim().isNotEmpty ? lock.name.trim() : start.title,
    look: shabbat ? LockLook.shabbat : LockLook.calm,
  );
}
