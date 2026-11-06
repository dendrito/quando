import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:quando/app/edition.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/home/ui/home_screen.dart';
import 'package:quando/features/rules/domain/alarm_rule.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';
import 'package:quando/features/settings/domain/alarm_options.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/features/shabbat/domain/preparation.dart';
import 'package:quando/features/shabbat/ui/city_picker.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class FakeLocationLookup extends LocationLookup {
  bool fail = false;
  @override
  Future<({double latitude, double longitude})> current() async {
    if (fail) throw StateError('Permission denied');
    return (latitude: -23.55, longitude: -46.63);
  }
}

void main() {
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });
  tearDown(() => useLocale([const Locale('en')]));
  final now = DateTime.utc(2026, 11, 3, 12);
  AnchorEvent event(String id, EventKind kind, DateTime at) =>
      AnchorEvent(id: id, kind: kind, title: id, at: at, source: 'test');
  final candles = event('candles', EventKind.holyDayStart, DateTime.utc(2026, 11, 6, 14));
  final havdalah = event('havdalah', EventKind.holyDayEnd, DateTime.utc(2026, 11, 7, 15));
  const rule = AlarmRule(
    id: 'r',
    name: 'R',
    appliesTo: {EventKind.holyDayStart, EventKind.holyDayEnd, EventKind.calendar},
    before: [Duration(hours: 1)],
    atEvent: true,
  );

  Future<SharedPreferences> saved() async {
    SharedPreferences.setMockInitialValues({});
    return SharedPreferences.getInstance();
  }

  test('preparation switch cancels only reminders before a holy-day start', () {
    final ordinary = event('meeting', EventKind.calendar, DateTime.utc(2026, 11, 5, 12));
    final plan = const Scheduler().plan(
      now: now,
      events: [candles, havdalah, ordinary],
      rules: [rule],
      allowReminder: const Preparation(enabled: false).allows,
    );
    expect(plan.where((a) => a.eventId == 'candles').map((a) => a.offset), [Duration.zero]);
    expect(plan.where((a) => a.eventId == 'havdalah'), hasLength(2));
    expect(plan.where((a) => a.eventId == 'meeting'), hasLength(2));
  });

  test('skip this week leaves next week and saved offsets intact', () {
    final settings = Preparation.fromJson(
      jsonDecode(jsonEncode(Preparation(skipUntil: DateTime.utc(2026, 11, 7, 18)).toJson())),
    );
    final next = event('next', EventKind.holyDayStart, DateTime.utc(2026, 11, 13, 14));
    final plan = const Scheduler(horizon: Duration(days: 14))
        .plan(now: now, events: [candles, next], rules: [rule], allowReminder: settings.allows);
    expect(plan.where((a) => a.eventId == 'candles' && a.offset.isNegative), isEmpty);
    expect(plan.where((a) => a.eventId == 'next' && a.offset.isNegative), hasLength(1));
    expect(rule.offsets(), [const Duration(hours: -1), Duration.zero]);
  });

  test('disabled offset and per-offset seconds survive persistence and scheduling', () {
    final edited = rule.copyWith(
      deliveries: {
        -60: const ReminderDelivery(enabled: false, ringSeconds: 3),
        0: const ReminderDelivery(ringSeconds: 5),
      },
    );
    final restored = rule.withCustom(jsonDecode(jsonEncode(edited.customJson())));
    final plan = const Scheduler().plan(now: now, events: [candles], rules: [restored]);
    expect(plan, hasLength(1));
    expect(plan.single.offset, Duration.zero);
    expect(plan.single.ringDuration, const Duration(seconds: 5));
    expect(plan.single.ringDurationOverride, isTrue);
    expect(ReminderDelivery.fromJson({}).enabled, isTrue);
  });

  test('legacy ring defaults remain global; explicit group and offset durations reach payloads', () async {
    final prefs = await saved();
    await prefs.setString('alarmOptions', jsonEncode(const AlarmOptions(ringSeconds: 12).toJson()));
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    ScheduledAlarm planned(AlarmRule r) =>
        const Scheduler().plan(now: now, events: [candles], rules: [r]).first;
    expect(c.read(payloadForProvider)(planned(rule)).ringSeconds, 12);
    final changed = rule.copyWith(ringDuration: const Duration(seconds: 3));
    final restored = rule.withCustom(jsonDecode(jsonEncode(changed.customJson())));
    expect(c.read(payloadForProvider)(planned(restored)).ringSeconds, 3);
    final withOffset = rule.copyWith(deliveries: {-60: const ReminderDelivery(ringSeconds: 5)});
    expect(c.read(payloadForProvider)(planned(withOffset)).ringSeconds, 5);
  });

  test('master and skip settings persist without rewriting individual rules', () async {
    final prefs = await saved();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    final before = c.read(rulesProvider).map((r) => r.enabled).toList();
    c.read(preparationProvider.notifier).setEnabled(false);
    c.read(preparationProvider.notifier).skipUntil(havdalah.at);
    c.invalidate(preparationProvider);
    expect(c.read(preparationProvider).enabled, isFalse);
    expect(c.read(preparationProvider).skipUntil, havdalah.at);
    expect(c.read(rulesProvider).map((r) => r.enabled), before);
    expect(syncedKeys, contains('shabbat.preparation'));
  });

  test('48 city coordinates and IANA zones are valid; GPS place is restored only locally', () async {
    expect(Places.all, hasLength(48));
    expect(Places.all.map((p) => p.name).toSet(), hasLength(48));
    for (final p in Places.all) {
      expect(p.latitude, inInclusiveRange(-90, 90));
      expect(p.longitude, inInclusiveRange(-180, 180));
      expect(tz.getLocation(p.timeZone).name, p.timeZone);
    }
    final prefs = await saved();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    const custom = Place(
      name: 'Current location',
      latitude: -23.55,
      longitude: -46.63,
      timeZone: 'America/Sao_Paulo',
    );
    c.read(placeProvider.notifier).setLocal(custom);
    c.invalidate(placeProvider);
    expect(c.read(placeProvider).latitude, custom.latitude);
    expect(c.read(placeProvider).timeZone, custom.timeZone);
    expect(syncedKeys, isNot(contains('place.local')));
    c.read(placeProvider.notifier).set(Places.london);
    c.invalidate(placeProvider);
    expect(c.read(placeProvider).name, 'London');
    expect(prefs.containsKey('place.local'), isFalse);
  });

  testWidgets('expanded city search accepts unaccented names', (tester) async {
    final prefs = await saved();
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(theme: buildTheme(), home: const CityPicker()),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Sao Paulo');
    await tester.pumpAndSettle();
    expect(find.text('São Paulo'), findsOneWidget);
    // Do not pop a root route; persistence is covered above and in the real navigator flow.
    expect(find.text(l10n.useMyLocation), findsOneWidget);
  });

  testWidgets('location confirmation saves locally; denial keeps manual city selection available', (
    tester,
  ) async {
    final prefs = await saved();
    final lookup = FakeLocationLookup();
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        deviceZoneProvider.overrideWithValue('America/Sao_Paulo'),
        locationLookupProvider.overrideWithValue(lookup),
      ],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(onPressed: () => pickShabbatPlace(context), child: const Text('Open picker')),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open picker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.useMyLocation));
    await tester.pumpAndSettle();
    expect(find.text(l10n.locationReview), findsOneWidget);
    expect(find.text('America/Sao_Paulo'), findsWidgets);
    await tester.tap(find.text(l10n.save));
    await tester.pumpAndSettle();
    expect(c.read(placeProvider).latitude, -23.55);
    expect(c.read(placeProvider).inIsrael, isFalse);
    expect(prefs.getString('place.local'), isNotNull);
    expect(find.text('Open picker'), findsOneWidget);
    lookup.fail = true;
    await tester.tap(find.text('Open picker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.useMyLocation));
    await tester.pumpAndSettle();
    expect(find.text(l10n.locationUnavailable), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'London');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'London'));
    await tester.pumpAndSettle();
    expect(c.read(placeProvider).name, 'London');
    expect(prefs.containsKey('place.local'), isFalse);
  });

  testWidgets('edition home preserves Quando and exposes Matai tabs and original audio flow', (tester) async {
    tester.view.physicalSize = const Size(780, 1500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final icons = FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    final font = FontLoader('Bricolage')
      ..addFont(rootBundle.load('assets/fonts/BricolageGrotesque-Regular.ttf'));
    await font.load();
    final prefs = await saved();
    final key = GlobalKey();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => RepaintBoundary(key: key, child: const HomeScreen()),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(prefs), clockProvider.overrideWithValue(() => now)],
        child: MaterialApp.router(theme: buildTheme(), routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(l10n.allAlarms), kodesh ? findsOneWidget : findsNothing);
    if (kodesh) {
      expect(find.text(l10n.preparationReminders), findsOneWidget);
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('/private/tmp/matai-combined-home.png').writeAsBytes(bytes!.buffer.asUint8List());
      });
      await tester.tap(find.text(l10n.allAlarms));
      await tester.pumpAndSettle();
      expect(find.text(l10n.yourAlarmsHeading), findsOneWidget);
      expect(find.text(l10n.preparationReminders), findsNothing);
    }
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
