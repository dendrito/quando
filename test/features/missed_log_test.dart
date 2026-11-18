import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/data/missed_log.dart';
import 'package:quando/features/alarms/ui/missed_ask.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final seven = DateTime.utc(2026, 11, 18, 7);

  setUp(() async {
    ensureTimeZones();
    useLocale([const Locale('en')]);
    SharedPreferences.setMockInitialValues({});
    MissedLog.init(await SharedPreferences.getInstance());
  });

  test('an alarm the app never saw ring is asked about after five minutes', () {
    MissedLog.remember([
      (id: 1, at: seven),
      (id: 2, at: seven.add(const Duration(days: 1))),
    ], seven.subtract(const Duration(hours: 8)));
    expect(MissedLog.unsure(seven.add(const Duration(minutes: 3))), isEmpty);
    final later = seven.add(const Duration(minutes: 10));
    expect(MissedLog.unsure(later).map((r) => r.id), [1]);
  });

  test('an alarm that rang, or was answered, is never asked about', () {
    MissedLog.remember([
      (id: 1, at: seven),
      (id: 3, at: seven.add(const Duration(minutes: 30))),
    ], seven.subtract(const Duration(hours: 1)));
    MissedLog.rang(1, seven);
    final later = seven.add(const Duration(hours: 1));
    expect(MissedLog.unsure(later).map((r) => r.id), [3]);
    MissedLog.answered(MissedLog.unsure(later).first);
    expect(MissedLog.unsure(later), isEmpty);
  });

  test('re-planning keeps the past day and forgets older alarms', () {
    MissedLog.remember([(id: 1, at: seven)], seven.subtract(const Duration(hours: 1)));
    // Next sync after the alarm time: the plan no longer holds it.
    MissedLog.remember([
      (id: 2, at: seven.add(const Duration(days: 1))),
    ], seven.add(const Duration(hours: 2)));
    expect(MissedLog.unsure(seven.add(const Duration(hours: 3))).map((r) => r.id), [1]);
    // A day later the first one is too old to ask about.
    expect(MissedLog.unsure(seven.add(const Duration(hours: 30))).map((r) => r.id), [2]);
  });

  testWidgets('Home asks "Did 07:00 ring?" and an answer clears it', (tester) async {
    final prefs = await SharedPreferences.getInstance();
    MissedLog.remember([(id: 1, at: seven)], seven.subtract(const Duration(hours: 1)));
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        clockProvider.overrideWithValue(() => seven.add(const Duration(hours: 1))),
        homeZoneProvider.overrideWithValue('UTC'),
      ],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: const Scaffold(body: MissedAsk()),
        ),
      ),
    );
    expect(find.text(l10n.missedAsk('07:00')), findsOneWidget);
    await tester.tap(find.byKey(const Key('missedNo')));
    await tester.pump();
    expect(find.byKey(const Key('missedAsk')), findsNothing);
  });
}
