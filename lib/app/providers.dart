import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/scheduler/scheduler.dart';
import '../core/util/format.dart';
import '../features/alarms/data/alarm_registrar.dart';
import '../features/alarms/domain/user_alarm.dart';
import '../features/calendar/data/calendar_reader.dart';
import '../features/calendar/domain/calendar_rule.dart';
import '../features/events/domain/event.dart';
import '../features/events/domain/sun_times.dart';
import '../features/lock/domain/lock.dart';
import '../features/ringing/ring_payload.dart';
import '../features/rules/domain/alarm_rule.dart';
import '../features/rules/domain/presets.dart';
import '../features/settings/domain/alarm_options.dart';
import '../features/sounds/domain/sound.dart';
import '../features/shabbat/domain/jewish_times.dart';
import '../features/shabbat/domain/place.dart';

/// The current time. Overridden in tests.
final clockProvider = Provider<DateTime Function()>(
  (ref) =>
      () => DateTime.now().toUtc(),
);

/// Settings storage. Loaded in main() and overridden there, so reads are
/// synchronous everywhere else.
final prefsProvider = Provider<SharedPreferences>(
  (ref) => throw StateError('prefsProvider must be overridden in main()'),
);

class PlaceNotifier extends Notifier<Place> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  Place build() {
    final name = _prefs.getString('place.name');
    final base = Places.all.firstWhere((p) => p.name == name, orElse: () => Places.jerusalem);
    return base.copyWith(
      inIsrael: _prefs.getBool('place.inIsrael'),
      candleLightingMinutes: _prefs.getInt('place.candleMinutes'),
    );
  }

  void set(Place place) {
    state = place;
    _prefs
      ..setString('place.name', place.name)
      ..remove('place.inIsrael')
      ..remove('place.candleMinutes');
  }

  void setInIsrael(bool value) {
    state = state.copyWith(inIsrael: value);
    _prefs.setBool('place.inIsrael', value);
  }

  void setCandleMinutes(int minutes) {
    state = state.copyWith(candleLightingMinutes: minutes);
    _prefs.setInt('place.candleMinutes', minutes);
  }
}

final placeProvider = NotifierProvider<PlaceNotifier, Place>(PlaceNotifier.new);

class HavdalahNotifier extends Notifier<HavdalahOpinion> {
  @override
  HavdalahOpinion build() {
    final name = ref.read(prefsProvider).getString('havdalah');
    return HavdalahOpinion.values.firstWhere((h) => h.name == name, orElse: () => HavdalahOpinion.geonim);
  }

  void set(HavdalahOpinion value) {
    state = value;
    ref.read(prefsProvider).setString('havdalah', value.name);
  }
}

final havdalahProvider = NotifierProvider<HavdalahNotifier, HavdalahOpinion>(HavdalahNotifier.new);

class RulesNotifier extends Notifier<List<AlarmRule>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  List<AlarmRule> build() {
    final saved = _decode(_prefs.getString('rules.enabled'));
    return [for (final r in Presets.all) saved.containsKey(r.id) ? r.copyWith(enabled: saved[r.id]) : r];
  }

  void toggle(String id, bool enabled) {
    state = [for (final r in state) r.id == id ? r.copyWith(enabled: enabled) : r];
    _prefs.setString('rules.enabled', jsonEncode({for (final r in state) r.id: r.enabled}));
  }

  static Map<String, bool> _decode(String? raw) {
    try {
      return (jsonDecode(raw ?? '{}') as Map<String, dynamic>).map((k, v) => MapEntry(k, v as bool));
    } catch (_) {
      return {};
    }
  }
}

final rulesProvider = NotifierProvider<RulesNotifier, List<AlarmRule>>(RulesNotifier.new);

class AlarmOptionsNotifier extends Notifier<AlarmOptions> {
  @override
  AlarmOptions build() {
    try {
      final raw = ref.read(prefsProvider).getString('alarmOptions');
      return raw == null
          ? const AlarmOptions()
          : AlarmOptions.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const AlarmOptions();
    }
  }

  void update(AlarmOptions Function(AlarmOptions) change) {
    state = change(state);
    ref.read(prefsProvider).setString('alarmOptions', jsonEncode(state.toJson()));
  }
}

final alarmOptionsProvider = NotifierProvider<AlarmOptionsNotifier, AlarmOptions>(AlarmOptionsNotifier.new);

const scheduler = Scheduler();

final jewishTimesProvider = Provider<JewishTimes>(
  (ref) => JewishTimes(place: ref.watch(placeProvider), havdalah: ref.watch(havdalahProvider)),
);

/// Events wide enough to plan every rule's alarms for the next 7 days.
// ---- Calendars ----

final calendarReaderProvider = Provider<CalendarReader>((ref) => DeviceCalendarReader());

class CalendarRulesNotifier extends Notifier<List<CalendarRule>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  List<CalendarRule> build() {
    try {
      final raw = _prefs.getString('calendarRules');
      if (raw == null) return const [];
      return [for (final j in jsonDecode(raw) as List) CalendarRule.fromJson(j as Map<String, dynamic>)];
    } catch (_) {
      return const [];
    }
  }

  void save(CalendarRule rule) {
    final i = state.indexWhere((r) => r.id == rule.id);
    _set(i < 0 ? [...state, rule] : [for (final r in state) r.id == rule.id ? rule : r]);
  }

  void toggle(String id, bool enabled) =>
      _set([for (final r in state) r.id == id ? r.copyWith(enabled: enabled) : r]);

  void delete(String id) => _set([
    for (final r in state)
      if (r.id != id) r,
  ]);

  void _set(List<CalendarRule> rules) {
    state = rules;
    _prefs.setString('calendarRules', jsonEncode([for (final r in rules) r.toJson()]));
  }
}

final calendarRulesProvider = NotifierProvider<CalendarRulesNotifier, List<CalendarRule>>(
  CalendarRulesNotifier.new,
);

/// What we know about the phone's calendars.
class CalendarState {
  const CalendarState({
    this.access = false,
    this.loaded = false,
    this.calendars = const [],
    this.selected = const {},
    this.events = const [],
    this.error,
  });

  final bool access;
  final bool loaded;
  final List<PhoneCalendar> calendars;

  /// Calendars whose events can ring alarms.
  final Set<String> selected;

  /// Start and end events from the selected calendars.
  final List<AnchorEvent> events;
  final String? error;
}

class CalendarNotifier extends Notifier<CalendarState> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  CalendarState build() => const CalendarState();

  /// null = never chosen: every calendar is used.
  Set<String>? get _savedSelection => _prefs.getStringList('calendars.selected')?.toSet();

  Future<void> connect() async {
    final reader = ref.read(calendarReaderProvider);
    try {
      if (!await reader.requestAccess()) {
        state = const CalendarState(loaded: true, error: 'Calendar access was not allowed.');
        return;
      }
    } catch (e) {
      state = CalendarState(loaded: true, error: '$e');
      return;
    }
    await refresh();
  }

  /// Reads calendars and events again. Quietly does nothing without access.
  Future<void> refresh() async {
    final reader = ref.read(calendarReaderProvider);
    try {
      if (!await reader.hasAccess()) {
        state = const CalendarState(loaded: true);
        return;
      }
      final calendars = await reader.calendars();
      final selected = _savedSelection ?? {for (final c in calendars) c.id};
      final now = ref.read(clockProvider)();
      final rules = [for (final r in ref.read(calendarRulesProvider)) ...r.toAlarmRules()];
      final window = scheduler.eventWindow(now, rules);
      final to = window.to.isAfter(now.add(const Duration(days: 62)))
          ? now.add(const Duration(days: 62))
          : window.to;
      final events = await reader.events(window.from.subtract(const Duration(days: 1)), to, selected);
      state = CalendarState(
        access: true,
        loaded: true,
        calendars: calendars,
        selected: selected,
        events: events,
      );
    } catch (e) {
      state = CalendarState(loaded: true, access: state.access, calendars: state.calendars, error: '$e');
    }
  }

  Future<void> select(String id, bool on) async {
    final s = {...state.selected};
    on ? s.add(id) : s.remove(id);
    await _prefs.setStringList('calendars.selected', s.toList());
    await refresh();
  }
}

final calendarProvider = NotifierProvider<CalendarNotifier, CalendarState>(CalendarNotifier.new);

/// Presets plus the user's calendar rules.
final allRulesProvider = Provider<List<AlarmRule>>(
  (ref) => [
    ...ref.watch(rulesProvider),
    for (final r in ref.watch(calendarRulesProvider)) ...r.toAlarmRules(),
  ],
);

final eventsProvider = Provider<List<AnchorEvent>>((ref) {
  final now = ref.watch(clockProvider)();
  final rules = ref.watch(rulesProvider);
  final window = scheduler.eventWindow(now, rules);
  final events = ref.watch(jewishTimesProvider).events(window.from, window.to)
    ..addAll(ref.watch(calendarProvider.select((c) => c.events)));
  final wantsSun = rules.any(
    (r) => r.enabled && r.appliesTo.any((k) => k == EventKind.sunrise || k == EventKind.sunset),
  );
  if (wantsSun) {
    events.addAll(SunTimes(place: ref.watch(placeProvider)).events(window.from, window.to));
  }
  return events..sort((a, b) => a.at.compareTo(b.at));
});

class UserAlarmsNotifier extends Notifier<List<UserAlarm>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  List<UserAlarm> build() {
    try {
      final raw = _prefs.getString('userAlarms');
      if (raw == null) return const [];
      return [for (final j in jsonDecode(raw) as List) UserAlarm.fromJson(j as Map<String, dynamic>)]
        ..sort(_byTime);
    } catch (_) {
      return const [];
    }
  }

  static int _byTime(UserAlarm a, UserAlarm b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute);

  /// Adds or replaces [alarm]. A one-off alarm is pinned to its next time.
  void save(UserAlarm alarm) {
    final fixed = alarm.repeats
        ? alarm
        : alarm.copyWith(
            onceAt: UserAlarm.nextAt(
              alarm.hour,
              alarm.minute,
              ref.read(clockProvider)(),
              ref.read(placeProvider).timeZone,
            ),
          );
    _set([
      for (final a in state)
        if (a.id != alarm.id) a,
      fixed,
    ]);
  }

  void toggle(String id, bool enabled) {
    final a = state.firstWhere((a) => a.id == id);
    if (enabled && !a.repeats) {
      save(a.copyWith(enabled: true));
    } else {
      _set([for (final x in state) x.id == id ? x.copyWith(enabled: enabled) : x]);
    }
  }

  void delete(String id) => _set([
    for (final a in state)
      if (a.id != id) a,
  ]);

  void _set(List<UserAlarm> alarms) {
    state = alarms..sort(_byTime);
    _prefs.setString('userAlarms', jsonEncode([for (final a in state) a.toJson()]));
  }
}

final userAlarmsProvider = NotifierProvider<UserAlarmsNotifier, List<UserAlarm>>(UserAlarmsNotifier.new);

// ---- Sounds ----

/// Built-in sounds plus the user's recordings and files.
class SoundsNotifier extends Notifier<List<AlarmSound>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  List<AlarmSound> build() {
    try {
      final raw = _prefs.getString('sounds');
      final mine = raw == null
          ? const <AlarmSound>[]
          : [for (final j in jsonDecode(raw) as List) AlarmSound.fromJson(j as Map<String, dynamic>)];
      return [...AlarmSound.builtIns, ...mine];
    } catch (_) {
      return AlarmSound.builtIns;
    }
  }

  void add(AlarmSound s) => _set([...state, s]);

  void rename(String id, String name) => _set([for (final s in state) s.id == id ? s.rename(name) : s]);

  void delete(String id) {
    _set([
      for (final s in state)
        if (s.id != id) s,
    ]);
    // Anything that used it goes back to the default.
    final o = ref.read(alarmOptionsProvider);
    if (o.soundId == id) ref.read(alarmOptionsProvider.notifier).update((x) => x.copyWith(phoneSound: true));
  }

  void _set(List<AlarmSound> all) {
    state = all;
    _prefs.setString(
      'sounds',
      jsonEncode([
        for (final s in all)
          if (!s.builtIn) s.toJson(),
      ]),
    );
  }
}

final soundsProvider = NotifierProvider<SoundsNotifier, List<AlarmSound>>(SoundsNotifier.new);

/// "Phone alarm sound" for null, otherwise the sound's name.
String soundName(List<AlarmSound> sounds, String? id) => id == null
    ? 'Phone alarm sound'
    : (sounds.where((s) => s.id == id).firstOrNull?.name ?? 'Phone alarm sound');

// ---- Lock mode ----

class LockSettingsNotifier extends Notifier<LockSettings> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  LockSettings build() {
    try {
      final raw = _prefs.getString('lock');
      return raw == null
          ? const LockSettings()
          : LockSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const LockSettings();
    }
  }

  void update(LockSettings Function(LockSettings) change) {
    state = change(state);
    _prefs.setString('lock', jsonEncode(state.toJson()));
  }

  void lockFor(Duration d) => update((s) => s.copyWith(manualUntil: DateTime.now().toUtc().add(d)));
}

final lockSettingsProvider = NotifierProvider<LockSettingsNotifier, LockSettings>(LockSettingsNotifier.new);

/// Locks the user ended early with "hold to unlock".
class DismissedLocksNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => (ref.read(prefsProvider).getStringList('lock.dismissed') ?? const []).toSet();

  void dismiss(LockPeriod p) {
    // Keep the list short: only the latest few matter.
    final next = {...state, ...p.allIds}.toList();
    state = next.skip(next.length > 50 ? next.length - 50 : 0).toSet();
    ref.read(prefsProvider).setStringList('lock.dismissed', state.toList());
    if (p.allIds.any((id) => id.startsWith('manual.'))) {
      ref.read(lockSettingsProvider.notifier).update((s) => s.copyWith(clearManual: true));
    }
  }
}

final dismissedLocksProvider = NotifierProvider<DismissedLocksNotifier, Set<String>>(
  DismissedLocksNotifier.new,
);

/// Upcoming and current locks.
final lockPeriodsProvider = Provider<List<LockPeriod>>(
  (ref) => lockPeriods(
    settings: ref.watch(lockSettingsProvider),
    holy: ref.watch(periodsProvider),
    calendarEvents: ref.watch(calendarProvider.select((c) => c.events)),
    now: ref.watch(clockProvider)(),
    dismissed: ref.watch(dismissedLocksProvider),
  ),
);

/// A 1-second, silent-ish alarm when each lock starts: it opens Quando,
/// which then locks (and pins itself).
final lockStartAlarmsProvider = Provider<List<ScheduledAlarm>>((ref) {
  final settings = ref.watch(lockSettingsProvider);
  if (!settings.openAtStart) return const [];
  final now = ref.watch(clockProvider)();
  final end = now.add(scheduler.horizon);
  return [
    for (final p in ref.watch(lockPeriodsProvider))
      if (p.start.isAfter(now) && !p.start.isAfter(end))
        ScheduledAlarm(
          id: stableId('lock|${p.id}'),
          at: p.start,
          title: 'Lock mode',
          body: p.reason,
          ringDuration: const Duration(seconds: 1),
          ruleId: 'lock',
          eventId: p.id,
          offset: Duration.zero,
        ),
  ];
});

final planProvider = Provider<List<ScheduledAlarm>>((ref) {
  final now = ref.watch(clockProvider)();
  final zone = ref.watch(placeProvider).timeZone;
  final ring = Duration(seconds: ref.watch(alarmOptionsProvider).ringSeconds);
  return [
    ...scheduler.plan(now: now, events: ref.watch(eventsProvider), rules: ref.watch(allRulesProvider)),
    for (final a in ref.watch(userAlarmsProvider))
      ...a.plan(now: now, horizon: scheduler.horizon, zone: zone, defaultRing: ring),
    ...ref.watch(lockStartAlarmsProvider),
  ]..sort((a, b) => a.at.compareTo(b.at));
});

/// Shabbat and festival periods over the planning horizon.
final periodsProvider = Provider<List<HolyPeriod>>((ref) {
  final now = ref.watch(clockProvider)();
  return ref.watch(jewishTimesProvider).periods(now, now.add(const Duration(days: 60)));
});

/// The Shabbat or festival period that is on now or comes next.
final nextPeriodProvider = Provider<HolyPeriod?>((ref) {
  final periods = ref.watch(periodsProvider);
  return periods.isEmpty ? null : periods.first;
});

/// How each planned alarm behaves when it rings. Alarms inside Shabbat or a
/// festival never ask to be touched.
final payloadForProvider = Provider<RingPayload Function(ScheduledAlarm)>((ref) {
  final options = ref.watch(alarmOptionsProvider);
  final periods = ref.watch(periodsProvider);
  final sounds = {for (final s in ref.watch(soundsProvider)) s.id: s.path};
  return (a) => _withSound(_payload(a, options, periods), sounds[a.soundId ?? options.soundId]);
});

RingPayload _withSound(RingPayload p, String? path) => p.isLock ? p : p.withSound(path);

RingPayload _payload(ScheduledAlarm a, AlarmOptions options, List<HolyPeriod> periods) {
  final p = RingPayload.forAlarm(
    title: a.title,
    body: a.body,
    options: options,
    shabbatSafe: periods.any((p) => p.contains(a.at)),
  );
  if (a.ruleId == 'lock') {
    return RingPayload(title: a.title, body: a.body, ringSeconds: 1, spoken: false, isLock: true);
  }
  // A user alarm can have its own ring length.
  return a.ruleId.startsWith('user.') ? p.withRingSeconds(a.ringDuration.inSeconds) : p;
}

final registrarProvider = Provider<AlarmRegistrar>((ref) {
  final r = AlarmRegistrar();
  ref.onDispose(r.dispose);
  return r;
});
