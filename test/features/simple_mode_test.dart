import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:quando/features/alarms/ui/edit_alarm_screen.dart';
import 'package:quando/features/home/ui/settings_screen.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/settings/domain/ui_level.dart';
import 'package:quando/features/settings/ui/first_run_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });

  Future<SharedPreferences> prefsWith(Map<String, Object> values, {bool start = false}) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();
    if (start) UiLevelStore.init(prefs);
    return prefs;
  }

  group('the level and the first-run question', () {
    test('only a brand-new install is asked; everyone else stays on Everything', () async {
      final fresh = await prefsWith({}, start: true);
      expect(UiLevelStore.pending(fresh), isTrue);
      expect(UiLevelStore.read(fresh), UiLevel.everything);

      final existing = await prefsWith({'userAlarms': '[]'}, start: true);
      expect(UiLevelStore.pending(existing), isFalse);
      expect(UiLevelStore.read(existing), UiLevel.everything);

      // Starting again never changes the verdict.
      final again = await prefsWith({'ui.ask': true, 'ui.level': 'simple', 'x': 1});
      UiLevelStore.init(again);
      expect(UiLevelStore.pending(again), isFalse);
      expect(UiLevelStore.read(again), UiLevel.simple);
    });

    testWidgets('the question has Simple ticked, and Continue saves the choice', (tester) async {
      final prefs = await prefsWith({}, start: true);
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp(
            theme: buildTheme(),
            home: const FirstRunGate(child: Text('Home')),
          ),
        ),
      );
      expect(find.text(l10n.firstRunTitle), findsOneWidget);
      expect(find.text(l10n.firstRunSimpleHint), findsOneWidget);
      expect(find.text(l10n.firstRunEverythingHint), findsOneWidget);
      expect(find.text('Home'), findsNothing);
      final ticked = find.descendant(
        of: find.byKey(const Key('first-simple')),
        matching: find.byIcon(Icons.radio_button_checked),
      );
      expect(ticked, findsOneWidget);

      await tester.tap(find.byKey(const Key('firstRunContinue')));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
      expect(c.read(uiLevelProvider), UiLevel.simple);
      expect(prefs.getString('ui.level'), 'simple');
      expect(c.read(firstRunProvider), isFalse);
    });

    testWidgets('choosing Everything is saved too, and an existing install is never asked', (tester) async {
      final prefs = await prefsWith({}, start: true);
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp(
            theme: buildTheme(),
            home: const FirstRunGate(child: Text('Home')),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('first-everything')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('firstRunContinue')));
      await tester.pumpAndSettle();
      expect(c.read(uiLevelProvider), UiLevel.everything);

      final old = await prefsWith({'alarmOptions': '{}'}, start: true);
      final c2 = ProviderContainer(overrides: [prefsProvider.overrideWithValue(old)]);
      addTearDown(c2.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c2,
          child: MaterialApp(
            theme: buildTheme(),
            home: const FirstRunGate(child: Text('Home')),
          ),
        ),
      );
      expect(find.text(l10n.firstRunTitle), findsNothing);
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('Settings', () {
    Future<ProviderContainer> settings(WidgetTester tester, SharedPreferences prefs) async {
      tester.view.physicalSize = const Size(1080, 3000);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp(theme: buildTheme(), home: const SettingsScreen()),
        ),
      );
      await tester.pumpAndSettle();
      return c;
    }

    List<String> folds() => [
      l10n.groupAlarms,
      l10n.groupCalendarShabbat,
      l10n.settingsPlacesTime,
      l10n.groupLookQuotes,
      l10n.groupConnectionsSync,
    ];

    testWidgets('Everything: Quick setups folded, five folded groups with their row counts', (tester) async {
      final prefs = await prefsWith({});
      await settings(tester, prefs);
      expect(find.text(l10n.uiSimple), findsOneWidget);
      expect(find.text(l10n.uiEverything), findsOneWidget);
      expect(find.text(l10n.quickSetups), findsOneWidget);
      expect(find.text(l10n.qsSummary(3, 0)), findsOneWidget);
      for (final f in folds()) {
        expect(find.text(f), findsOneWidget, reason: f);
      }
      // Folded: the rows are not on screen until a group is opened.
      expect(find.text(l10n.testAlarmIn1), findsNothing);
      await tester.tap(find.text(l10n.groupAlarms));
      await tester.pumpAndSettle();
      expect(find.text(l10n.sayItOutLoud), findsOneWidget);
      expect(find.text(l10n.recordOrAddSounds), findsOneWidget);
    });

    testWidgets('switching to Simple and back hides and restores the groups, alarms untouched', (
      tester,
    ) async {
      final alarm = UserAlarm(id: 'a1', hour: 7, minute: 0, label: 'Work', days: const {1, 2, 3, 4, 5});
      final saved = jsonEncode([alarm.toJson()]);
      final prefs = await prefsWith({'userAlarms': saved, 'alarmOptions': '{"ringSeconds":120}'});
      final c = await settings(tester, prefs);

      await tester.tap(find.byKey(const Key('level-simple')));
      await tester.pumpAndSettle();
      expect(c.read(uiLevelProvider), UiLevel.simple);
      for (final f in folds()) {
        expect(find.text(f), findsNothing, reason: f);
      }
      expect(find.text(l10n.quickSetups.toUpperCase()), findsOneWidget);
      expect(find.text(l10n.qsMorningTitle), findsOneWidget);
      expect(find.text(l10n.everyAlarm.toUpperCase()), findsOneWidget);
      expect(find.text(l10n.sound), findsOneWidget);
      expect(find.text(l10n.wakeUpCheck), findsOneWidget);
      expect(find.text(l10n.language), findsNothing);

      await tester.tap(find.byKey(const Key('level-everything')));
      await tester.pumpAndSettle();
      expect(c.read(uiLevelProvider), UiLevel.everything);
      for (final f in folds()) {
        expect(find.text(f), findsOneWidget, reason: f);
      }
      // Nothing was deleted or changed on the way.
      expect(prefs.getString('userAlarms'), saved);
      expect(jsonDecode(prefs.getString('alarmOptions')!)['ringSeconds'], 120);
    });
  });

  group('Home', () {
    Future<(ProviderContainer, GoRouter)> home(
      WidgetTester tester,
      SharedPreferences prefs, {
      double scale = 1,
    }) async {
      tester.view.physicalSize = const Size(1800, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final c = ProviderContainer(
        overrides: [
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 8, 18, 30)),
          prefsProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MediaQuery(
            data: MediaQueryData(
              size: const Size(600, 800),
              disableAnimations: true,
              textScaler: TextScaler.linear(scale),
            ),
            child: const QuandoApp(),
          ),
        ),
      );
      final router = GoRouter.of(tester.element(find.byType(Scaffold).first));
      addTearDown(() => router.go('/'));
      router.go('/');
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      return (c, router);
    }

    testWidgets('Simple hides the header buttons, sky tabs and extras; Everything shows them with words', (
      tester,
    ) async {
      final prefs = await prefsWith({
        'home.display.allOn': true,
        'ui.level': 'simple',
        'userAlarms': jsonEncode([
          UserAlarm(id: 'a1', hour: 7, minute: 0, label: 'Work', days: const {1, 2, 3, 4, 5}).toJson(),
        ]),
      });
      final (c, router) = await home(tester, prefs);
      expect(find.textContaining('Work'), findsWidgets);
      expect(find.text(l10n.when), findsOneWidget);
      expect(find.byTooltip(l10n.settings), findsOneWidget);
      for (final word in [l10n.timersTitle, l10n.calendars, l10n.lockMode]) {
        expect(find.text(word), findsNothing, reason: word);
      }
      expect(find.byTooltip(l10n.homePlaceTitle), findsNothing);
      expect(find.byTooltip(l10n.homeDisplay), findsNothing);
      expect(find.text(l10n.thisWeekHeading), findsNothing);

      c.read(uiLevelProvider.notifier).set(UiLevel.everything);
      await tester.pump(const Duration(milliseconds: 300));
      for (final word in [l10n.timersTitle, l10n.calendars, l10n.lockMode, l10n.settings]) {
        expect(find.text(word), findsWidgets, reason: word);
      }
      expect(find.byKey(const Key('headerPills')), findsOneWidget);
      expect(find.text(l10n.thisWeekHeading), findsOneWidget);
      expect(find.textContaining('Work'), findsWidgets);

      // Pills open their screens.
      await tester.tap(find.byKey(Key('pill-${l10n.calendars}')));
      await tester.pumpAndSettle();
      expect(find.text(l10n.calendars), findsWidgets);
      router.go('/');
      await tester.pumpAndSettle();
    });

    testWidgets('when the words do not fit, the icons stay with the word under each', (tester) async {
      final prefs = await prefsWith({'home.display.allOn': true});
      await home(tester, prefs, scale: 2);
      expect(find.byKey(const Key('headerStacked')), findsOneWidget);
      for (final word in [l10n.timersTitle, l10n.calendars, l10n.lockMode, l10n.settings]) {
        expect(find.text(word), findsWidgets, reason: word);
      }
    });
  });

  group('Edit alarm', () {
    Future<ProviderContainer> edit(WidgetTester tester, SharedPreferences prefs, {String id = 'new'}) async {
      tester.view.physicalSize = const Size(1080, 4000);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (_, _) => const Text('home')),
          GoRoute(
            path: '/edit',
            builder: (_, _) => EditAlarmScreen(id: id),
          ),
          GoRoute(path: '/sounds', builder: (_, _) => const Text('sounds')),
        ],
      );
      addTearDown(router.dispose);
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
      addTearDown(c.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp.router(theme: buildTheme(), routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      unawaited(router.push('/edit'));
      await tester.pumpAndSettle();
      return c;
    }

    testWidgets('Simple shows time, label, Repeat, the line, three rows and Save only', (tester) async {
      final prefs = await prefsWith({'ui.level': 'simple'});
      await edit(tester, prefs);
      expect(find.text(l10n.wakeMeWith.toUpperCase()), findsOneWidget);
      expect(find.text(l10n.ringOrMusic), findsOneWidget);
      expect(find.text(l10n.ringsForRow), findsOneWidget);
      expect(find.text(l10n.gentleWakeUp), findsOneWidget);
      expect(find.text(l10n.phoneAlarmSound), findsOneWidget);
      expect(find.text(RingSecondsText.of(60)), findsOneWidget);
      expect(find.text(l10n.off), findsOneWidget);
      expect(find.byKey(const Key('iWill')), findsOneWidget);
      for (final fold in [l10n.foldVolume, l10n.foldSnoozeStop, l10n.foldExtras]) {
        expect(find.text(fold), findsNothing, reason: fold);
      }
      expect(find.byIcon(Icons.public), findsNothing);
      expect(find.text(l10n.saveCaps), findsOneWidget);
    });

    testWidgets('Everything adds three folds with the rest of today\'s options', (tester) async {
      final prefs = await prefsWith({});
      await edit(tester, prefs);
      for (final fold in [l10n.foldVolume, l10n.foldSnoozeStop, l10n.foldExtras]) {
        expect(find.text(fold), findsOneWidget, reason: fold);
      }
      await tester.tap(find.text(l10n.foldSnoozeStop));
      await tester.pumpAndSettle();
      expect(find.text(l10n.wakeUpCheck), findsOneWidget);
      await tester.tap(find.text(l10n.foldExtras));
      await tester.pumpAndSettle();
      expect(find.text(l10n.group), findsOneWidget);
      expect(find.text(l10n.busyAfterRing), findsOneWidget);
    });

    testWidgets('Rings for: the menu sets this alarm; "Use for new alarms" sets the default only', (
      tester,
    ) async {
      final existing = UserAlarm(id: 'old', hour: 6, minute: 30, label: 'Old', days: const {1});
      final prefs = await prefsWith({
        'ui.level': 'simple',
        'userAlarms': jsonEncode([existing.toJson()]),
        'alarmOptions': '{"ringSeconds":60}',
      });
      final c = await edit(tester, prefs);

      await tester.tap(find.byKey(const Key('wakeRing')));
      await tester.pumpAndSettle();
      for (final s in [30, 60, 180, 300, 600]) {
        expect(find.text(RingSecondsText.of(s)), findsWidgets, reason: '$s');
      }
      await tester.tap(find.text(RingSecondsText.of(300)).last);
      await tester.pumpAndSettle();
      // Not for new alarms yet.
      expect(c.read(alarmOptionsProvider).ringSeconds, 60);

      await tester.tap(find.byKey(const Key('useForNew')));
      await tester.pumpAndSettle();
      expect(c.read(alarmOptionsProvider).ringSeconds, 300);
      await tester.tap(find.text(l10n.done));
      await tester.pumpAndSettle();
      expect(find.text(RingSecondsText.of(300)), findsOneWidget);

      // The alarm that followed the old default keeps what it had.
      expect(c.read(userAlarmsProvider).single.ringSeconds, 60);

      await tester.tap(find.text(l10n.saveCaps));
      await tester.pumpAndSettle();
      final saved = c.read(userAlarmsProvider);
      expect(saved.length, 2);
      expect(saved.firstWhere((a) => a.id != 'old').ringSeconds, 300);
      expect(saved.firstWhere((a) => a.id == 'old').ringSeconds, 60);
    });

    testWidgets('Gentle wake: Off, 5, 10, 20 min; the default starts new alarms with it', (tester) async {
      final prefs = await prefsWith({'ui.level': 'simple'});
      final c = await edit(tester, prefs);
      await tester.tap(find.byKey(const Key('wakeGentle')));
      await tester.pumpAndSettle();
      expect(find.text(l10n.off), findsWidgets);
      for (final m in [5, 10, 20]) {
        expect(find.text(l10n.gentleBeforeValue(m)), findsOneWidget, reason: '$m');
      }
      await tester.tap(find.text(l10n.gentleBeforeValue(10)));
      await tester.pumpAndSettle();
      expect(c.read(alarmOptionsProvider).gentleMinutes, 0);
      await tester.tap(find.byKey(const Key('useForNew')));
      await tester.pumpAndSettle();
      expect(c.read(alarmOptionsProvider).gentleMinutes, 10);
      await tester.tap(find.text(l10n.done));
      await tester.pumpAndSettle();
      expect(find.text(l10n.gentleBeforeValue(10)), findsOneWidget);
    });

    testWidgets('a new alarm starts with the default gentle wake', (tester) async {
      final prefs = await prefsWith({'ui.level': 'simple', 'alarmOptions': '{"gentleMinutes":5}'});
      await edit(tester, prefs);
      expect(find.text(l10n.gentleBeforeValue(5)), findsOneWidget);
    });

    testWidgets('Ring or music: Phone alarm, and three lists; the default sound follows the switch', (
      tester,
    ) async {
      final existing = UserAlarm(id: 'old', hour: 6, minute: 30, label: 'Old', days: const {1});
      final prefs = await prefsWith({
        'ui.level': 'simple',
        'userAlarms': jsonEncode([existing.toJson()]),
        'sounds': jsonEncode([
          {'id': 'rec.1', 'name': 'My voice', 'path': 'sounds/rec1.m4a'},
        ]),
      });
      final c = await edit(tester, prefs);
      await tester.tap(find.byKey(const Key('wakeSound')));
      await tester.pumpAndSettle();
      for (final t in [l10n.phoneAlarmSound, l10n.quandoSounds, l10n.aSongApps, l10n.myRecording]) {
        expect(find.text(t), findsWidgets, reason: t);
      }
      await tester.tap(find.byKey(const Key('useForNew')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.myRecording));
      await tester.pumpAndSettle();
      await tester.tap(find.text('My voice'));
      await tester.pumpAndSettle();
      expect(c.read(alarmOptionsProvider).soundId, 'rec.1');
      // The old alarm followed the phone sound; it still does.
      expect(c.read(userAlarmsProvider).single.delivery.soundId, '__phone__');
      await tester.tap(find.text(l10n.done));
      await tester.pumpAndSettle();
      expect(find.text('My voice'), findsOneWidget);
    });

    testWidgets('the "I will" line is saved with the alarm', (tester) async {
      final prefs = await prefsWith({'ui.level': 'simple'});
      final c = await edit(tester, prefs);
      await tester.enterText(find.byKey(const Key('iWill')), '  Shower, then the 8:10 bus.  ');
      await tester.tap(find.text(l10n.saveCaps));
      await tester.pumpAndSettle();
      final a = c.read(userAlarmsProvider).single;
      expect(a.iWill, 'Shower, then the 8:10 bus.');
      expect(UserAlarm.fromJson(a.toJson()).iWill, 'Shower, then the 8:10 bus.');
    });
  });

  group('"When this rings, I will…"', () {
    test('travels with the alarm into the payload, and is read aloud after the label', () async {
      final a = UserAlarm(id: 'x', hour: 7, minute: 0, label: 'Work', iWill: 'Shower first', days: const {1});
      final planned = a.plan(
        now: DateTime.utc(2026, 11, 8, 3),
        horizon: const Duration(days: 8),
        zone: 'UTC',
        defaultRing: const Duration(minutes: 1),
      );
      expect(planned, isNotEmpty);
      expect(planned.every((p) => p.iWill == 'Shower first'), isTrue);
      final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(await prefsWith({}))]);
      addTearDown(c.dispose);
      final p = c.read(payloadForProvider)(planned.first);
      expect(p.iWill, 'Shower first');
      expect(RingPayload.decode(p.encode()).iWill, 'Shower first');
      expect(p.spokenText, 'Work. Shower first.');
      // Without a line the details are spoken as before.
      final plain = UserAlarm(id: 'y', hour: 7, minute: 0, label: 'Work', days: const {1});
      final q = c.read(payloadForProvider)(
        plain
            .plan(
              now: DateTime.utc(2026, 11, 8, 3),
              horizon: const Duration(days: 8),
              zone: 'UTC',
              defaultRing: const Duration(minutes: 1),
            )
            .first,
      );
      expect(q.iWill, isEmpty);
      expect(q.spokenText, contains(q.body));
    });

    test('gentle lead-ups and "are you up?" checks show their own text, not the line', () {
      const p = RingPayload(title: 'Work', body: 'Mon', ringSeconds: 60, iWill: 'Shower first');
      expect(p.gentleLeadUp(10, null).iWill, isEmpty);
      expect(p.check().iWill, isEmpty);
      expect(p.snoozed().iWill, 'Shower first');
    });

    test('old payloads and alarms without the line still read', () {
      expect(RingPayload.decode('{"title":"A","body":"B"}').iWill, isEmpty);
      expect(UserAlarm.fromJson({'id': 'z', 'hour': 7, 'minute': 0}).iWill, isEmpty);
      expect(
        ScheduledAlarm(
          id: 1,
          at: _epoch,
          title: 't',
          body: 'b',
          ringDuration: Duration.zero,
          ruleId: 'r',
          eventId: 'e',
          offset: Duration.zero,
        ).iWill,
        isEmpty,
      );
    });
  });
}

final _epoch = DateTime.utc(2026);

/// "30 s", "1 min", "5 min": how the Rings for menu words a length.
class RingSecondsText {
  static String of(int s) => s < 60 ? l10n.secondsShort(s) : l10n.minutesShort(s ~/ 60);
}
