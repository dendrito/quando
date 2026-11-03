import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/scheduler/scheduler.dart';
import '../features/alarms/data/alarm_registrar.dart';
import '../features/events/domain/event.dart';
import '../features/rules/domain/alarm_rule.dart';
import '../features/rules/domain/presets.dart';
import '../features/shabbat/domain/jewish_times.dart';
import '../features/shabbat/domain/place.dart';

/// The current time. Overridden in tests.
final clockProvider = Provider<DateTime Function()>(
  (ref) =>
      () => DateTime.now().toUtc(),
);

class PlaceNotifier extends Notifier<Place> {
  @override
  Place build() => Places.jerusalem;

  void set(Place place) => state = place;
  void setInIsrael(bool value) => state = state.copyWith(inIsrael: value);
  void setCandleMinutes(int minutes) => state = state.copyWith(candleLightingMinutes: minutes);
}

final placeProvider = NotifierProvider<PlaceNotifier, Place>(PlaceNotifier.new);

class HavdalahNotifier extends Notifier<HavdalahOpinion> {
  @override
  HavdalahOpinion build() => HavdalahOpinion.geonim;

  void set(HavdalahOpinion value) => state = value;
}

final havdalahProvider = NotifierProvider<HavdalahNotifier, HavdalahOpinion>(HavdalahNotifier.new);

class RulesNotifier extends Notifier<List<AlarmRule>> {
  @override
  List<AlarmRule> build() => Presets.all;

  void toggle(String id, bool enabled) =>
      state = [for (final r in state) r.id == id ? r.copyWith(enabled: enabled) : r];

  void setRingDuration(Duration d) => state = [for (final r in state) r.copyWith(ringDuration: d)];
}

final rulesProvider = NotifierProvider<RulesNotifier, List<AlarmRule>>(RulesNotifier.new);

const scheduler = Scheduler();

final jewishTimesProvider = Provider<JewishTimes>(
  (ref) => JewishTimes(place: ref.watch(placeProvider), havdalah: ref.watch(havdalahProvider)),
);

/// Events wide enough to plan every rule's alarms for the next 7 days.
final eventsProvider = Provider<List<AnchorEvent>>((ref) {
  final now = ref.watch(clockProvider)();
  final window = scheduler.eventWindow(now, ref.watch(rulesProvider));
  return ref.watch(jewishTimesProvider).events(window.from, window.to);
});

final planProvider = Provider<List<ScheduledAlarm>>((ref) {
  return scheduler.plan(
    now: ref.watch(clockProvider)(),
    events: ref.watch(eventsProvider),
    rules: ref.watch(rulesProvider),
  );
});

/// The Shabbat or festival period that is on now or comes next.
final nextPeriodProvider = Provider<HolyPeriod?>((ref) {
  final now = ref.watch(clockProvider)();
  final periods = ref.watch(jewishTimesProvider).periods(now, now.add(const Duration(days: 60)));
  return periods.isEmpty ? null : periods.first;
});

final registrarProvider = Provider<AlarmRegistrar>((ref) {
  final r = AlarmRegistrar();
  ref.onDispose(r.dispose);
  return r;
});
