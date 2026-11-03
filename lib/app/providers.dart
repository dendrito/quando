import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/scheduler/scheduler.dart';
import '../features/alarms/data/alarm_registrar.dart';
import '../features/events/domain/event.dart';
import '../features/events/domain/sun_times.dart';
import '../features/ringing/ring_payload.dart';
import '../features/rules/domain/alarm_rule.dart';
import '../features/rules/domain/presets.dart';
import '../features/settings/domain/alarm_options.dart';
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
final eventsProvider = Provider<List<AnchorEvent>>((ref) {
  final now = ref.watch(clockProvider)();
  final rules = ref.watch(rulesProvider);
  final window = scheduler.eventWindow(now, rules);
  final events = ref.watch(jewishTimesProvider).events(window.from, window.to);
  final wantsSun = rules.any(
    (r) => r.enabled && r.appliesTo.any((k) => k == EventKind.sunrise || k == EventKind.sunset),
  );
  if (wantsSun) {
    events.addAll(SunTimes(place: ref.watch(placeProvider)).events(window.from, window.to));
    events.sort((a, b) => a.at.compareTo(b.at));
  }
  return events;
});

final planProvider = Provider<List<ScheduledAlarm>>((ref) {
  return scheduler.plan(
    now: ref.watch(clockProvider)(),
    events: ref.watch(eventsProvider),
    rules: ref.watch(rulesProvider),
  );
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
  return (a) => RingPayload.forAlarm(
    title: a.title,
    body: a.body,
    options: options,
    shabbatSafe: periods.any((p) => p.contains(a.at)),
  );
});

final registrarProvider = Provider<AlarmRegistrar>((ref) {
  final r = AlarmRegistrar();
  ref.onDispose(r.dispose);
  return r;
});
