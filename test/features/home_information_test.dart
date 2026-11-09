import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/edition.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/home/data/home_information_providers.dart';
import 'package:quando/features/home/data/learning_repository.dart';
import 'package:quando/features/home/data/weather_repository.dart';
import 'package:quando/features/home/domain/home_display.dart';
import 'package:quando/features/home/domain/moon.dart';
import 'package:quando/features/home/ui/home_display_controls.dart';
import 'package:quando/features/home/ui/weather_motion.dart';
import 'package:quando/features/home/ui/weather_panel.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  final now = DateTime.utc(2026, 11, 6, 15);
  String forecast() => jsonEncode({
    'properties': {
      'timeseries': [
        for (var i = 0; i < 4; i++)
          {
            'time': now.add(Duration(hours: i)).toIso8601String(),
            'data': {
              'instant': {
                'details': {'air_temperature': 24 - i},
              },
              'next_1_hours': {
                'summary': {'symbol_code': i == 1 ? 'rainandthunder' : 'clearsky_day'},
              },
            },
          },
      ],
    },
  });
  setUp(() async {
    ensureTimeZones();
    useLocale([const Locale('en')]);
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  test('lunar calculations match published SunCalc 1.9.0 reference vectors', () {
    final at = DateTime.utc(2013, 3, 5);
    expect(MoonDay.altitude(at, 50.5, 30.5), closeTo(0.014551482243892251, 1e-10));
    final light = MoonIllumination.at(at);
    expect(light.fraction, closeTo(0.4848068202456373, 1e-10));
    expect(light.phase, closeTo(0.7548368838538762, 1e-10));
    final day = MoonDay.of(
      const Place(name: 'Vector', latitude: 50.5, longitude: 30.5, timeZone: 'UTC'),
      DateTime.utc(2013, 3, 4),
    );
    expect(day.rise!.difference(DateTime.utc(2013, 3, 4, 23, 54, 29)).inSeconds.abs(), lessThan(2));
    expect(day.set!.difference(DateTime.utc(2013, 3, 4, 7, 47, 58)).inSeconds.abs(), lessThan(2));
  });

  test('moon events stay inside selected civil date across DST and polar locations', () {
    for (final place in [
      Places.london,
      Places.newYork,
      Places.saoPaulo,
      const Place(name: 'Tromso', latitude: 69.65, longitude: 18.96, timeZone: 'Europe/Oslo'),
    ]) {
      for (final date in [
        DateTime.utc(2026, 3, 29, 12),
        DateTime.utc(2026, 10, 25, 12),
        DateTime.utc(2026, 6, 21, 12),
      ]) {
        final local = inZone(date, place.timeZone), day = MoonDay.of(place, date);
        for (final at in [day.rise, day.set].whereType<DateTime>()) {
          final event = inZone(at, place.timeZone);
          expect((event.year, event.month, event.day), (local.year, local.month, local.day));
        }
        expect(day.alwaysUp && day.alwaysDown, isFalse);
      }
    }
  });

  test('weather rounds coordinates, honors expiry, and revalidates with 304', () async {
    var clock = now, calls = 0;
    final repo = WeatherRepository(
      prefs,
      now: () => clock,
      random: Random(0),
      client: MockClient((r) async {
        calls++;
        expect(r.url.queryParameters, {'lat': '-23.55', 'lon': '-46.63'});
        expect(r.headers['User-Agent'], contains('https://github.com/dendrito'));
        if (calls == 1) {
          return http.Response(
            forecast(),
            200,
            headers: {
              'expires': 'Fri, 06 Nov 2026 16:00:00 GMT',
              'last-modified': 'Fri, 06 Nov 2026 14:00:00 GMT',
            },
          );
        }
        expect(r.headers['If-Modified-Since'], 'Fri, 06 Nov 2026 14:00:00 GMT');
        return http.Response('', 304, headers: {'expires': 'Fri, 06 Nov 2026 18:00:00 GMT'});
      }),
    );
    addTearDown(repo.close);
    final first = await repo.load(Places.saoPaulo);
    expect(first.hours[1].kind, WeatherKind.thunder);
    expect(first.current(now)?.celsius, 24);
    await repo.load(Places.saoPaulo);
    expect(calls, 1);
    clock = DateTime.utc(2026, 11, 6, 17);
    final second = await repo.load(Places.saoPaulo);
    expect(calls, 2);
    expect(second.hours, hasLength(4));
    expect(second.expires.isAfter(DateTime.utc(2026, 11, 6, 18)), isTrue);
  });

  test('offline and 429 use bounded cached data and respect retry backoff', () async {
    var clock = now, calls = 0;
    final repo = WeatherRepository(
      prefs,
      now: () => clock,
      client: MockClient((r) async {
        calls++;
        return calls == 1
            ? http.Response(forecast(), 200)
            : http.Response('', 429, headers: {'retry-after': '3600'});
      }),
    );
    addTearDown(repo.close);
    await repo.load(Places.saoPaulo);
    clock = now.add(const Duration(hours: 2));
    expect((await repo.load(Places.saoPaulo)).stale, isTrue);
    clock = clock.add(const Duration(minutes: 30));
    expect((await repo.load(Places.saoPaulo)).stale, isTrue);
    expect(calls, 2);
    clock = now.add(const Duration(days: 2));
    await expectLater(repo.load(Places.saoPaulo), throwsStateError);
  });

  test('learning sends date only, caches month and rejects unsafe links', () async {
    var calls = 0;
    final repo = LearningRepository(
      prefs,
      client: MockClient((r) async {
        calls++;
        expect(r.url.queryParameters['start'], '2026-11-01');
        expect(r.url.queryParameters['end'], '2026-11-30');
        expect(r.url.queryParameters['nyomi'], 'on');
        expect(r.url.queryParameters.containsKey('latitude'), isFalse);
        return http.Response(
          jsonEncode({
            'items': [
              {
                'category': 'dailyRambam1',
                'date': '2026-11-06',
                'title': 'Forbidden Intercourse 18',
                'link': 'https://www.chabad.org/library/article.asp?aid=1',
              },
              {
                'category': 'nachyomi',
                'date': '2026-11-06',
                'title': 'Nach',
                'link': 'https://evil.example/redirect',
              },
            ],
          }),
          200,
        );
      }),
    );
    addTearDown(repo.close);
    final first = await repo.month(now, inIsrael: false);
    expect(first.map((x) => x.course), ['rambam1', 'nach']);
    expect(first.first.link?.host, 'www.chabad.org');
    expect(first.last.link, isNull);
    final restored = await repo.month(now.add(const Duration(days: 1)), inIsrael: false);
    expect(restored.first.date, '2026-11-06');
    expect(calls, 1);
  });

  test('home preferences survive reload and preserve edition defaults', () async {
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    expect(c.read(homeDisplayProvider).parasha, jewishHome);
    expect(c.read(homeDisplayProvider).weather, isTrue);
    await c
        .read(homeDisplayProvider.notifier)
        .set(
          const HomeDisplay(
            night: true,
            moon: true,
            weather: true,
            parasha: true,
            roshHodesh: true,
            courses: {'daf', 'rambam1'},
          ),
        );
    c.invalidate(homeDisplayProvider);
    expect(c.read(homeDisplayProvider).courses, {'daf', 'rambam1'});
    expect(c.read(homeDisplayProvider).night, isTrue);
    expect(c.read(homeDisplayProvider).roshHodesh, isTrue);
    expect(syncedKeys, contains('home.display'));
    expect(syncedKeys.any((k) => k.startsWith('weather.cache')), isFalse);
  });

  testWidgets('Home display exposes and persists the Rosh Hodesh switch', (tester) async {
    final c = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: buildTheme(),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => showHomeDisplayControls(context),
                child: const Text('Display'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Display'));
    await tester.pumpAndSettle();
    final setting = find.widgetWithText(SwitchListTile, l10n.roshHodeshHeading);
    await tester.ensureVisible(setting);
    await tester.tap(setting);
    await tester.pumpAndSettle();
    expect(c.read(homeDisplayProvider).roshHodesh, isTrue);
    c.invalidate(homeDisplayProvider);
    expect(c.read(homeDisplayProvider).roshHodesh, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('inactive weather makes no network request; foreground shows upcoming thunder', (tester) async {
    var calls = 0;
    final repo = WeatherRepository(
      prefs,
      now: () => now,
      client: MockClient((r) async {
        calls++;
        return http.Response(forecast(), 200);
      }),
    );
    addTearDown(repo.close);
    final c = ProviderContainer(
      overrides: [prefsProvider.overrideWithValue(prefs), weatherRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(c.dispose);
    Widget app(bool active, {bool visible = true}) => UncontrolledProviderScope(
      container: c,
      child: MaterialApp(
        theme: buildTheme(),
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: TickerMode(
            enabled: visible,
            child: Scaffold(
              body: WeatherPanel(now: now, active: active),
            ),
          ),
        ),
      ),
    );
    await tester.pumpWidget(app(false));
    await tester.pumpAndSettle();
    expect(calls, 0);
    await tester.pumpWidget(app(true, visible: false));
    await tester.pumpAndSettle();
    expect(calls, 0);
    await tester.pumpWidget(app(true));
    await tester.pumpAndSettle();
    expect(calls, 1);
    expect(find.text('24°C'), findsOneWidget);
    expect(find.textContaining(l10n.weatherThunderExpected), findsOneWidget);
    expect(tester.takeException(), isNull);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    expect(find.byType(WeatherMotion), findsNothing);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(calls, 1);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('home toggles expose study only for Matai and Mine', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(prefs)],
        child: MaterialApp(
          theme: buildTheme(),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(onPressed: () => showHomeDisplayControls(context), child: const Text('Open')),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.skyDayNight), findsOneWidget);
    expect(find.text(l10n.courseDaf), jewishHome ? findsOneWidget : findsNothing);
    await tester.tap(find.widgetWithText(SwitchListTile, l10n.skyMoonDisplay));
    await tester.pumpAndSettle();
    expect(jsonDecode(prefs.getString('home.display')!)['moon'], isFalse);
  });

  testWidgets('weather art respects Reduce Motion and renders all conditions', (tester) async {
    tester.view.physicalSize = const Size(700, 300);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final font = FontLoader('Bricolage')
      ..addFont(rootBundle.load('assets/fonts/BricolageGrotesque-Regular.ttf'));
    await font.load();
    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: buildTheme(),
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: RepaintBoundary(
              key: key,
              child: Row(
                children: [
                  for (final kind in WeatherKind.values)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WeatherMotion(kind: kind),
                        Text(kind.name),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.hasRunningAnimations, isFalse);
    expect(tester.takeException(), isNull);
    await tester.runAsync(() async {
      final img = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
      final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
      await File('${Directory.systemTemp.path}/quando-weather-art.png')
          .writeAsBytes(bytes!.buffer.asUint8List());
    });
  });
}
