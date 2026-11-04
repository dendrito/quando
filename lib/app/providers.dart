import 'dart:convert';

import 'package:flutter/widgets.dart' show Locale;
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
import '../features/integrations/data/sender.dart';
import '../features/integrations/domain/integrations.dart';
import '../features/lock/domain/lock.dart';
import '../features/quotes/data/quote_bank.dart';
import '../features/quotes/domain/quote.dart';
import '../features/ringing/ring_payload.dart';
import '../features/rules/domain/alarm_rule.dart';
import '../features/rules/domain/presets.dart';
import '../features/settings/domain/alarm_options.dart';
import '../features/sounds/domain/sound.dart';
import '../features/shabbat/domain/jewish_times.dart';
import '../features/shabbat/domain/place.dart';

import 'package:quando/l10n/l10n.dart';

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

// ---- Language ----

/// The language chosen in Settings, e.g. `pt` or `zh_Hant`. null = the phone's.
class LanguageNotifier extends Notifier<String?> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  String? build() => _prefs.getString('language');

  void set(String? tag) {
    tag == null ? _prefs.remove('language') : _prefs.setString('language', tag);
    state = tag;
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, String?>(LanguageNotifier.new);

/// The language Quando speaks right now. Anything that builds words
/// (event titles, preset names, alarm bodies) watches it, so all of it
/// is made again in the new language when it changes.
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => currentLocale;

  void changed(Locale l) {
    if (l != state) state = l;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

// ---- Quotes about time ----

/// Which kinds of quotes the home screen shows. Empty = none.
class QuoteSourcesNotifier extends Notifier<Set<QuoteSource>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  Set<QuoteSource> build() {
    final saved = _prefs.getStringList('quoteSources');
    if (saved == null) return QuoteSource.values.toSet();
    return {
      for (final s in QuoteSource.values)
        if (saved.contains(s.name)) s,
    };
  }

  void toggle(QuoteSource s, bool on) {
    state = on ? {...state, s} : ({...state}..remove(s));
    _prefs.setStringList('quoteSources', [for (final x in state) x.name]);
  }
}

final quoteSourcesProvider = NotifierProvider<QuoteSourcesNotifier, Set<QuoteSource>>(
  QuoteSourcesNotifier.new,
);

/// Extra quotes the user opted into: Carnaval, near me. Off by default.
class QuoteOccasionsNotifier extends Notifier<Set<QuoteOccasion>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  Set<QuoteOccasion> build() {
    final saved = _prefs.getStringList('quoteOccasions') ?? const [];
    return {
      for (final o in QuoteOccasion.values)
        if (saved.contains(o.name)) o,
    };
  }

  void toggle(QuoteOccasion o, bool on) {
    state = on ? {...state, o} : ({...state}..remove(o));
    _prefs.setStringList('quoteOccasions', [for (final x in state) x.name]);
  }
}

final quoteOccasionsProvider = NotifierProvider<QuoteOccasionsNotifier, Set<QuoteOccasion>>(
  QuoteOccasionsNotifier.new,
);

/// Where the user is, for "Near me" quotes.
final quotePlacesProvider = Provider<Set<String>>(
  (ref) => placeTags(ref.watch(homeZoneProvider), city: ref.watch(placeProvider).name),
);

/// Every quote for the language in use.
final quotesProvider = Provider<List<Quote>>((ref) {
  final l = ref.watch(localeProvider);
  final key = l.languageCode == 'zh' && l.scriptCode == 'Hant' ? 'zh_Hant' : l.languageCode;
  return quoteBank[key] ?? quoteBank['en']!;
});

// ---- Time zones ----

/// The phone's own zone, e.g. `America/Sao_Paulo`. Read in main(); null in
/// tests and when it can't be read.
final deviceZoneProvider = Provider<String?>((ref) => null);

class TimeZones {
  const TimeZones({this.fixed, this.clocks = const []});

  /// null = follow the phone.
  final String? fixed;

  /// Extra world clocks on the home screen.
  final List<String> clocks;
}

class TimeZonesNotifier extends Notifier<TimeZones> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  TimeZones build() => TimeZones(
    fixed: _prefs.getString('zone.fixed'),
    clocks: _prefs.getStringList('zone.clocks') ?? const [],
  );

  void followPhone() {
    _prefs.remove('zone.fixed');
    state = TimeZones(clocks: state.clocks);
  }

  void setFixed(String zone) {
    _prefs.setString('zone.fixed', zone);
    state = TimeZones(fixed: zone, clocks: state.clocks);
  }

  void addClock(String zone) {
    if (state.clocks.contains(zone)) return;
    _setClocks([...state.clocks, zone]);
  }

  void removeClock(String zone) => _setClocks([
    for (final z in state.clocks)
      if (z != zone) z,
  ]);

  void _setClocks(List<String> clocks) {
    _prefs.setStringList('zone.clocks', clocks);
    state = TimeZones(fixed: state.fixed, clocks: clocks);
  }
}

final timeZonesProvider = NotifierProvider<TimeZonesNotifier, TimeZones>(TimeZonesNotifier.new);

/// The zone Quando shows times in and sets everyday alarms in: the one you
/// picked, else the phone's, else your Shabbat city's.
final homeZoneProvider = Provider<String>(
  (ref) =>
      ref.watch(timeZonesProvider).fixed ??
      ref.watch(deviceZoneProvider) ??
      ref.watch(placeProvider).timeZone,
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
    ref.watch(localeProvider);
    final saved = _decode(_prefs.getString('rules.enabled'));
    final custom = _custom();
    return [
      for (final r in Presets.all.map((p) => p.withCustomFrom(custom)))
        saved.containsKey(r.id) ? r.copyWith(enabled: saved[r.id]) : r,
    ];
  }

  void toggle(String id, bool enabled) {
    state = [for (final r in state) r.id == id ? r.copyWith(enabled: enabled) : r];
    _prefs.setString('rules.enabled', jsonEncode({for (final r in state) r.id: r.enabled}));
  }

  /// Changes a preset's times or sound, and remembers the change.
  void edit(String id, AlarmRule Function(AlarmRule) change) {
    state = [for (final r in state) r.id == id ? change(r) : r];
    final custom = _custom()..[id] = state.firstWhere((r) => r.id == id).customJson();
    _prefs.setString('rules.custom', jsonEncode(custom));
  }

  /// Back to the preset as Quando ships it, keeping it on or off.
  void reset(String id) {
    final custom = _custom()..remove(id);
    _prefs.setString('rules.custom', jsonEncode(custom));
    final preset = Presets.all.firstWhere((p) => p.id == id);
    state = [for (final r in state) r.id == id ? preset.copyWith(enabled: r.enabled) : r];
  }

  /// Presets you deleted: off, and out of the list until restored.
  Set<String> get hidden => (_prefs.getStringList('rules.hidden') ?? const []).toSet();

  void hide(String id) {
    toggle(id, false);
    _prefs.setStringList('rules.hidden', {...hidden, id}.toList());
    ref.notifyListeners();
  }

  void restore(String id) {
    _prefs.setStringList('rules.hidden', [
      for (final h in hidden)
        if (h != id) h,
    ]);
    toggle(id, true);
  }

  /// Whether the user has changed this preset.
  bool isCustom(String id) => _custom().containsKey(id);

  Map<String, dynamic> _custom() {
    try {
      return jsonDecode(_prefs.getString('rules.custom') ?? '{}') as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
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

extension on AlarmRule {
  AlarmRule withCustomFrom(Map<String, dynamic> custom) {
    final j = custom[id];
    return j is Map<String, dynamic> ? withCustom(j) : this;
  }
}

/// Single alarms the user chose to skip, by their stable id.
class SkippedNotifier extends Notifier<Set<int>> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  Set<int> build() => {
    for (final s in _prefs.getStringList('plan.skipped') ?? const <String>[]) ?int.tryParse(s),
  };

  void skip(int id, bool skipped) {
    final next = {...state};
    skipped ? next.add(id) : next.remove(id);
    // Only the newest few hundred matter: the plan reaches a week ahead.
    final kept = next.toList();
    state = kept.length > 400 ? kept.sublist(kept.length - 400).toSet() : next;
    _prefs.setStringList('plan.skipped', [for (final i in state) '$i']);
  }
}

final skippedProvider = NotifierProvider<SkippedNotifier, Set<int>>(SkippedNotifier.new);

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
        state = CalendarState(loaded: true, error: l10n.calendarNotAllowed);
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
  ref.watch(localeProvider);
  final now = ref.watch(clockProvider)();
  final window = scheduler.eventWindow(now, ref.watch(allRulesProvider));
  final events = ref.watch(jewishTimesProvider).events(window.from, window.to)
    ..addAll(ref.watch(calendarProvider.select((c) => c.events)));
  final wantsSun = ref
      .watch(allRulesProvider)
      .any((r) => r.enabled && r.appliesTo.any((k) => k == EventKind.sunrise || k == EventKind.sunset));
  if (wantsSun) {
    events.addAll(SunTimes(place: ref.watch(placeProvider)).events(window.from, window.to));
  }
  return events..sort((a, b) => a.at.compareTo(b.at));
});

/// Everything an event alarm can be set around, for the next 60 days:
/// calendar events (start), Shabbat and festival times, and two weeks of
/// sunrises and sunsets. Feeds the event search.
final searchableEventsProvider = FutureProvider.autoDispose<List<AnchorEvent>>((ref) async {
  ref.watch(localeProvider);
  final now = ref.watch(clockProvider)();
  final to = now.add(const Duration(days: 60));
  final cal = ref.watch(calendarProvider);
  final out = <AnchorEvent>[
    ...ref.watch(jewishTimesProvider).events(now, to),
    ...SunTimes(place: ref.watch(placeProvider)).events(now, now.add(const Duration(days: 14))),
  ];
  if (cal.access && cal.selected.isNotEmpty) {
    try {
      out.addAll(await ref.read(calendarReaderProvider).events(now, to, cal.selected));
    } catch (_) {
      // Calendar unreadable just now: search the rest.
    }
  }
  return out.where((e) => e.at.isAfter(now) && e.kind != EventKind.calendarEnd).toList()
    ..sort((a, b) => a.at.compareTo(b.at));
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
              alarm.zone ?? ref.read(homeZoneProvider),
            ),
          );
    _set([
      for (final a in state)
        if (a.id != alarm.id) a,
      fixed,
    ]);
  }

  /// A copy of alarm [id], right after it in the list. Returns the copy.
  UserAlarm duplicate(String id) {
    final i = state.indexWhere((a) => a.id == id);
    final copy = UserAlarm.fromJson({
      ...state[i].toJson(),
      'id': DateTime.now().microsecondsSinceEpoch.toRadixString(36),
    });
    _set([...state.sublist(0, i + 1), copy, ...state.sublist(i + 1)]);
    return copy;
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

  /// Every group name in use, A to Z.
  List<String> get groups => {
    for (final a in state)
      if (a.group.isNotEmpty) a.group,
  }.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  /// Turns every alarm in [group] on or off at once.
  void toggleGroup(String group, bool enabled) {
    for (final a in [...state]) {
      if (a.group == group && a.enabled != enabled) toggle(a.id, enabled);
    }
  }

  /// Renames a group; an empty name takes its alarms out of any group.
  void renameGroup(String from, String to) =>
      _set([for (final a in state) a.group == from ? a.copyWith(group: to.trim()) : a]);

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
    ref.watch(localeProvider);
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

  void replace(AlarmSound sound) => _set([for (final s in state) s.id == sound.id ? sound : s]);

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
    ? l10n.phoneAlarmSound
    : (sounds.where((s) => s.id == id).firstOrNull?.name ?? l10n.phoneAlarmSound);

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
final lockPeriodsProvider = Provider<List<LockPeriod>>((ref) {
  ref.watch(localeProvider);
  return lockPeriods(
    settings: ref.watch(lockSettingsProvider),
    holy: ref.watch(periodsProvider),
    calendarEvents: ref.watch(calendarProvider.select((c) => c.events)),
    now: ref.watch(clockProvider)(),
    dismissed: ref.watch(dismissedLocksProvider),
  );
});

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
          title: l10n.lockMode,
          body: p.reason,
          ringDuration: const Duration(seconds: 1),
          ruleId: 'lock',
          eventId: p.id,
          offset: Duration.zero,
        ),
  ];
});

/// The alarms that will ring: the full plan minus the ones you skipped.
final planProvider = Provider<List<ScheduledAlarm>>((ref) {
  ref.watch(localeProvider);
  final skipped = ref.watch(skippedProvider);
  final now = ref.watch(clockProvider)();
  return [
    for (final a in ref.watch(fullPlanProvider))
      if (!skipped.contains(a.id)) ...[?gentleBefore(a, now), a],
  ]..sort((a, b) => a.at.compareTo(b.at));
});

/// The soft alarm some minutes before [a], if it asks for one and that
/// moment is still ahead.
ScheduledAlarm? gentleBefore(ScheduledAlarm a, DateTime now) {
  final m = a.style.gentleMinutes;
  if (m <= 0 || a.ruleId == 'lock') return null;
  final at = a.at.subtract(Duration(minutes: m));
  if (!at.isAfter(now)) return null;
  return ScheduledAlarm(
    id: stableId('gentle|${a.id}'),
    at: at,
    title: a.title,
    body: a.body,
    ringDuration: a.ringDuration,
    ruleId: 'gentle.${a.ruleId}',
    eventId: a.eventId,
    offset: a.offset,
    soundId: a.soundId,
    style: a.style,
  );
}

/// Every alarm for the week ahead, skipped ones included.
final fullPlanProvider = Provider<List<ScheduledAlarm>>((ref) {
  ref.watch(localeProvider);
  final now = ref.watch(clockProvider)();
  final zone = ref.watch(homeZoneProvider);
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
  ref.watch(localeProvider);
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
  ref.watch(localeProvider);
  final options = ref.watch(alarmOptionsProvider);
  final periods = ref.watch(periodsProvider);
  final sounds = {for (final s in ref.watch(soundsProvider)) s.id: s.path};
  final links = {for (final s in ref.watch(soundsProvider)) s.id: s};
  return (a) {
    final id = a.soundId ?? options.soundId;
    var p = _payload(a, options, periods);
    // No live radio on Shabbat or a festival: a built-in sound instead.
    final path = sounds[id];
    final radio = path != null && (path.startsWith('http://') || path.startsWith('https://'));
    p = _withSound(p, radio && p.shabbatSafe ? AlarmSound.builtIns[1].path : path);
    // Never open another app on Shabbat or a festival.
    final song = links[id];
    if (!p.isLock && !p.shabbatSafe && song?.link != null) {
      p = p.withSong(song!.link!, plays: song.plays, seconds: song.playSeconds);
    }
    if (p.isLock) return p;
    p = p.withStyle(a.style);
    if (!a.ruleId.startsWith('gentle.')) return options.fadesForAll ? p.withFadesOf(options.loudness) : p;
    final calm =
        (AlarmSound.calm.where((c) => c.id == a.style.gentleSound).firstOrNull ?? AlarmSound.calm.first).path;
    return p.gentleLeadUp(a.style.gentleMinutes, calm);
  };
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
  return a.ruleId.startsWith('user.') || a.ruleId.startsWith('gentle.user.')
      ? p.withRingSeconds(a.ringDuration.inSeconds)
      : p;
}

// ---- Integrations ----

class IntegrationsNotifier extends Notifier<IntegrationSettings> {
  @override
  IntegrationSettings build() {
    try {
      final raw = ref.read(prefsProvider).getString('integrations');
      return raw == null
          ? const IntegrationSettings()
          : IntegrationSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const IntegrationSettings();
    }
  }

  void update(IntegrationSettings Function(IntegrationSettings) change) {
    state = change(state);
    ref.read(prefsProvider).setString('integrations', jsonEncode(state.toJson()));
  }

  void addWebhook(Webhook w) => update((s) => s.copyWith(webhooks: [...s.webhooks, w]));

  void replaceWebhook(Webhook w) =>
      update((s) => s.copyWith(webhooks: [for (final x in s.webhooks) x.id == w.id ? w : x]));

  void removeWebhook(String id) => update(
    (s) => s.copyWith(
      webhooks: [
        for (final x in s.webhooks)
          if (x.id != id) x,
      ],
    ),
  );
}

final integrationsProvider = NotifierProvider<IntegrationsNotifier, IntegrationSettings>(
  IntegrationsNotifier.new,
);

final integrationSenderProvider = Provider<IntegrationSender>(
  (ref) => IntegrationSender(() => ref.read(integrationsProvider)),
);

final registrarProvider = Provider<AlarmRegistrar>((ref) {
  final sender = ref.read(integrationSenderProvider);
  final r = AlarmRegistrar()..onHappening = (what, p) => sender.send(what, p);
  ref.onDispose(r.dispose);
  return r;
});
