import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// One planned alarm that may not have rung.
typedef PlannedRing = ({int id, DateTime at});

/// Remembers which alarms were planned and which actually rang, so the next
/// time the app is opened it can ask about any that seem to have been missed.
///
/// "Rang" is only known when the app saw the alarm ring, so a miss is asked
/// about ("Did 07:00 ring?"), never claimed.
class MissedLog {
  static const _planKey = 'missed.plan';
  static const _rangKey = 'missed.rang';
  static const _doneKey = 'missed.done';

  /// How long after its time an alarm counts as missed, and how far back to look.
  static const grace = Duration(minutes: 5);
  static const lookBack = Duration(hours: 24);

  static SharedPreferences? _p;
  static void init(SharedPreferences prefs) => _p = prefs;

  static String _key(int id, DateTime at) => '$id@${at.toUtc().millisecondsSinceEpoch ~/ 60000}';

  static List<PlannedRing> _readPlan() {
    final raw = _p?.getString(_planKey);
    if (raw == null) return [];
    try {
      return [
        for (final e in jsonDecode(raw) as List)
          (id: e['id'] as int, at: DateTime.fromMillisecondsSinceEpoch(e['at'] as int, isUtc: true)),
      ];
    } catch (_) {
      return [];
    }
  }

  /// Keeps the alarms of the last day that were planned, plus the next two
  /// days of [plan]. Old entries are dropped.
  static void remember(Iterable<PlannedRing> plan, DateTime now) {
    final p = _p;
    if (p == null) return;
    final from = now.subtract(lookBack), to = now.add(const Duration(hours: 48));
    final keep = <String, PlannedRing>{};
    for (final r in _readPlan()) {
      if (r.at.isAfter(from) && !r.at.isAfter(now)) keep[_key(r.id, r.at)] = r;
    }
    for (final r in plan) {
      if (r.at.isAfter(now) && r.at.isBefore(to)) keep[_key(r.id, r.at)] = r;
    }
    p.setString(
      _planKey,
      jsonEncode([
        for (final r in keep.values) {'id': r.id, 'at': r.at.toUtc().millisecondsSinceEpoch},
      ]),
    );
    final live = keep.keys.toSet();
    for (final k in [_rangKey, _doneKey]) {
      p.setStringList(k, (p.getStringList(k) ?? const []).where(live.contains).toList());
    }
  }

  /// The app saw alarm [id], planned for [at], ring.
  static void rang(int id, DateTime at) => _add(_rangKey, _key(id, at));

  /// The person answered about this alarm; never ask again.
  static void answered(PlannedRing r) => _add(_doneKey, _key(r.id, r.at));

  static void _add(String list, String key) {
    final p = _p;
    if (p == null) return;
    final l = p.getStringList(list) ?? const [];
    if (!l.contains(key)) p.setStringList(list, [...l, key]);
  }

  /// Alarms whose time passed (by more than [grace], within [lookBack]) that
  /// the app never saw ring and nobody answered about yet. Oldest first.
  static List<PlannedRing> unsure(DateTime now) {
    final p = _p;
    if (p == null) return [];
    final seen = {...?p.getStringList(_rangKey), ...?p.getStringList(_doneKey)};
    return [
      for (final r in _readPlan())
        if (r.at.isBefore(now.subtract(grace)) &&
            r.at.isAfter(now.subtract(lookBack)) &&
            !seen.contains(_key(r.id, r.at)))
          r,
    ]..sort((a, b) => a.at.compareTo(b.at));
  }
}
