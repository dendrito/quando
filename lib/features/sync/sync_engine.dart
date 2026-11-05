import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// The settings that follow you from device to device. Things that belong to
/// one device stay on it: recorded sounds (the files live there), which
/// phone calendars to read, and Spotify or YouTube sign-ins.
const syncedKeys = [
  'userAlarms',
  'alarmOptions',
  'rules.enabled',
  'rules.custom',
  'rules.hidden',
  'plan.skipped',
  'calendarRules',
  'lock',
  'lock.dismissed',
  'place.name',
  'place.inIsrael',
  'place.candleMinutes',
  'havdalah',
  'zone.fixed',
  'zone.clocks',
  'quoteSources',
  'quoteOccasions',
  'language',
  'integrations',
];

/// One setting as the server keeps it: when it changed, on which device,
/// and its value (null once it was removed).
class SyncItem {
  const SyncItem(this.t, this.d, this.s);

  final int t;
  final String d;
  final String? s;

  Map<String, Object?> toJson() => {'t': t, 'd': d, 's': s};

  static SyncItem? fromJson(Object? j) {
    if (j is! Map) return null;
    final t = j['t'];
    return t is int ? SyncItem(t, '${j['d'] ?? ''}', j['s'] as String?) : null;
  }
}

/// Where the shared copy lives. Firestore in the app, a fake in tests.
abstract class SyncRemote {
  Stream<Map<String, SyncItem>> watch();
  Future<void> push(Map<String, SyncItem> items);
}

String? encodePref(SharedPreferences p, String key) {
  final v = p.get(key);
  return v == null ? null : jsonEncode({'v': v});
}

Future<void> decodePref(SharedPreferences p, String key, String? s) async {
  if (s == null) {
    await p.remove(key);
    return;
  }
  final v = (jsonDecode(s) as Map)['v'];
  switch (v) {
    case final bool b:
      await p.setBool(key, b);
    case final int i:
      await p.setInt(key, i);
    case final double d:
      await p.setDouble(key, d);
    case final String x:
      await p.setString(key, x);
    case final List l:
      await p.setStringList(key, [for (final e in l) '$e']);
  }
}

/// Keeps this device's settings and the shared copy in step. Failed uploads
/// remain dirty and are retried; remote updates and local pushes are serialized.
class SyncEngine {
  SyncEngine(
    this.prefs,
    this.remote, {
    required this.device,
    this.onApplied,
    DateTime Function()? now,
    this.every = const Duration(seconds: 3),
  }) : _now = now ?? DateTime.now;

  final SharedPreferences prefs;
  final SyncRemote remote;
  final String device;

  /// Called after settings from another device were written here.
  final void Function()? onApplied;
  final DateTime Function() _now;
  final Duration every;

  StreamSubscription<Map<String, SyncItem>>? _sub;
  Timer? _timer;
  bool _heard = false;
  Future<void> _pending = Future<void>.value();

  Map<String, String?> get _last =>
      _readMap('sync.last').map((k, v) => MapEntry(k, v as String?));
  Map<String, int> get _stamps =>
      _readMap('sync.stamps').map((k, v) => MapEntry(k, (v as num).toInt()));
  Map<String, String> get _origins =>
      _readMap('sync.origins').map((k, v) => MapEntry(k, '$v'));

  Map<String, Object?> _readMap(String key) {
    try {
      return (jsonDecode(prefs.getString(key) ?? '{}') as Map).cast<String, Object?>();
    } catch (_) {
      return {};
    }
  }

  Future<void> _save(
    Map<String, String?> last,
    Map<String, int> stamps,
    Map<String, String> origins,
  ) async {
    await prefs.setString('sync.last', jsonEncode(last));
    await prefs.setString('sync.stamps', jsonEncode(stamps));
    await prefs.setString('sync.origins', jsonEncode(origins));
  }

  /// Prevents a timer tick and a Firestore snapshot from mutating sync state
  /// concurrently. A failed operation doesn't poison the queue.
  Future<void> _enqueue(Future<void> Function() operation) {
    final result = _pending.then((_) => operation());
    _pending = result.catchError((Object _) {});
    return result;
  }

  void start() {
    _sub = remote.watch().listen(
      (items) => apply(items),
      onError: (Object error, StackTrace stack) {
        // A later snapshot or timer tick can recover; don't kill local alarms.
      },
    );
    _timer = Timer.periodic(every, (_) => pushLocal());
  }

  Future<void> stop() async {
    _timer?.cancel();
    await _sub?.cancel();
    _sub = null;
    await _pending;
    _heard = false;
  }

  /// Sends whatever changed here since the last successful upload.
  Future<void> pushLocal() => _enqueue(_pushLocal);

  Future<void> _pushLocal() async {
    if (!_heard) return; // Hear the shared copy first, so it isn't overwritten.
    final last = _last, stamps = _stamps, origins = _origins;
    final changed = <String, SyncItem>{};
    final now = _now().millisecondsSinceEpoch;
    final nextLogicalTime = stamps.values.fold<int>(now, (a, b) => a > b ? a : b + 1);
    for (final k in syncedKeys) {
      final cur = encodePref(prefs, k);
      if (cur == last[k]) continue;
      changed[k] = SyncItem(nextLogicalTime, device, cur);
    }
    if (changed.isEmpty) return;

    // Crucially, do not advance local sync markers before the remote confirms
    // the write. If offline or denied, the next timer tick retries these keys.
    try {
      await remote.push(changed);
    } catch (_) {
      return;
    }

    for (final entry in changed.entries) {
      last[entry.key] = entry.value.s;
      stamps[entry.key] = entry.value.t;
      origins[entry.key] = entry.value.d;
    }
    await _save(last, stamps, origins);
  }

  /// Takes in the shared copy: newer settings are written here, and local
  /// settings missing remotely are uploaded after the initial snapshot.
  Future<void> apply(Map<String, SyncItem> items) => _enqueue(() => _apply(items));

  Future<void> _apply(Map<String, SyncItem> items) async {
    final last = _last, stamps = _stamps, origins = _origins;
    var applied = false;
    for (final k in syncedKeys) {
      final item = items[k];
      if (item == null) continue;
      final previousStamp = stamps[k] ?? 0;
      final previousOrigin = origins[k] ?? '';
      final newer = item.t > previousStamp ||
          (item.t == previousStamp && item.d.compareTo(previousOrigin) > 0);
      if (!newer) continue;

      final cur = encodePref(prefs, k);
      // A local edit not yet uploaded wins over an incoming snapshot. Its
      // dirty marker is retained, so _pushLocal will retry it.
      if (_heard && cur != last[k]) continue;
      if (item.s != cur) {
        await decodePref(prefs, k, item.s);
        applied = true;
      }
      last[k] = item.s;
      stamps[k] = item.t;
      origins[k] = item.d;
    }
    _heard = true;
    await _save(last, stamps, origins);

    // Any local values absent from the initial remote snapshot are now dirty.
    // Upload them through the same retry-safe path.
    await _pushLocal();
    if (applied) onApplied?.call();
  }
}
