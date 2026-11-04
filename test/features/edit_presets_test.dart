import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/rules/domain/presets.dart';

import '../shabbat_on.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  ProviderContainer make() {
    final c = ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 3, 12)),
        prefsProvider.overrideWithValue(prefs),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({...shabbatOn});
    prefs = await SharedPreferences.getInstance();
  });

  List<Duration> countdownTimes(ProviderContainer c) =>
      c.read(rulesProvider).firstWhere((r) => r.id == Presets.countdown.id).offsets();

  test('a preset\'s times can be changed, are kept, and can be reset', () {
    final c = make();
    final id = Presets.countdown.id;
    c
        .read(rulesProvider.notifier)
        .edit(
          id,
          (r) => r.withOffsets([
            ...r.offsets().where((d) => d != const Duration(minutes: -30)),
            const Duration(minutes: -45),
          ]),
        );
    final changed = countdownTimes(c);
    expect(changed, contains(const Duration(minutes: -45)));
    expect(changed, isNot(contains(const Duration(minutes: -30))));

    final again = make();
    expect(countdownTimes(again), changed);
    expect(again.read(rulesProvider.notifier).isCustom(id), isTrue);
    final planned = again.read(planProvider).where((a) => a.ruleId == id).map((a) => a.offset).toSet();
    expect(planned, contains(const Duration(minutes: -45)));
    expect(planned, isNot(contains(const Duration(minutes: -30))));

    again.read(rulesProvider.notifier).reset(id);
    expect(countdownTimes(again), Presets.countdown.offsets());
    expect(countdownTimes(make()), Presets.countdown.offsets());
  });

  test('a series preset becomes plain times when edited', () {
    final c = make();
    final id = Presets.hourly.id;
    c
        .read(rulesProvider.notifier)
        .edit(id, (r) => r.withOffsets(r.offsets().where((d) => d != const Duration(hours: -6))));
    final r = c.read(rulesProvider).firstWhere((r) => r.id == id);
    expect(r.series, isEmpty);
    expect(r.offsets(), [for (var h = 5; h >= 1; h--) Duration(hours: -h)]);
  });

  test('skipping one alarm leaves the rest, and can be undone', () {
    final c = make();
    final first = c.read(planProvider).first;
    final count = c.read(planProvider).length;
    c.read(skippedProvider.notifier).skip(first.id, true);
    expect(c.read(planProvider).length, count - 1);
    expect(c.read(fullPlanProvider).length, count);
    expect(make().read(planProvider).any((a) => a.id == first.id), isFalse);
    c.read(skippedProvider.notifier).skip(first.id, false);
    expect(c.read(planProvider).length, count);
  });

  test('a deleted preset is off and hidden until brought back', () {
    final c = make();
    final id = Presets.countdown.id;
    c.read(rulesProvider.notifier).hide(id);
    expect(c.read(rulesProvider.notifier).hidden, {id});
    expect(c.read(planProvider).any((a) => a.ruleId == id), isFalse);
    expect(make().read(rulesProvider.notifier).hidden, {id});
    c.read(rulesProvider.notifier).restore(id);
    expect(c.read(rulesProvider.notifier).hidden, isEmpty);
    expect(c.read(planProvider).any((a) => a.ruleId == id), isTrue);
  });
}
