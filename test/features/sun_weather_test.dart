import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/home/data/home_information_providers.dart';
import 'package:quando/features/home/data/weather_repository.dart';
import 'package:quando/features/home/domain/sky.dart';
import 'package:quando/features/home/domain/sky_weather.dart';
import 'package:quando/features/home/ui/day_arc.dart';
import 'package:quando/features/home/ui/sky_panel.dart';
import 'package:quando/features/home/ui/weather_overlay.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Sunday 8 Nov 2026 in São Paulo: showers in the afternoon, clearing at night.
WeatherReport sampleReport({String afternoon = 'rain'}) {
  final hours = <WeatherHour>[];
  for (var h = 0; h < 36; h++) {
    final at = DateTime.utc(2026, 11, 8, 9 + h); // 06:00 local onwards.
    final local = (6 + h) % 24;
    final symbol = local >= 14 && local < 19 && h < 24
        ? afternoon
        : local >= 19 || local < 6
        ? 'clearsky_night'
        : h >= 24
        ? 'cloudy'
        : 'partlycloudy_day';
    hours.add(
      WeatherHour(at: at, celsius: 18.0 + (local > 6 && local < 18 ? (local - 6) * .7 : 1), symbol: symbol),
    );
  }
  return WeatherReport(
    hours: hours,
    fetched: DateTime.utc(2026, 11, 8, 18),
    expires: DateTime.utc(2026, 11, 8, 20),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await (FontLoader(
      'Bricolage',
    )..addFont(rootBundle.load('assets/fonts/BricolageGrotesque-Regular.ttf'))).load();
    await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });

  final afternoon = DateTime.utc(2026, 11, 8, 18, 30); // 15:30 in São Paulo.

  test('card colour follows the weather by day and the clock at dawn, dusk and night', () {
    final day = SkyDay.of(Places.saoPaulo, afternoon);
    expect(skyWeatherGradient(day, WeatherKind.rain), SkyWeatherColors.rain);
    expect(skyWeatherGradient(day, WeatherKind.clear), SkyWeatherColors.clear);
    expect(skyWeatherGradient(day, null), SkyWeatherColors.clear);
    final night = SkyDay.of(Places.saoPaulo, DateTime.utc(2026, 11, 9, 2));
    expect(skyWeatherGradient(night, WeatherKind.clear), SkyWeatherColors.night);
    // Right at sunset a clear sky glows warmer than a rainy one.
    final dusk = SkyDay.of(Places.saoPaulo, day.sunset!);
    final clearDusk = skyWeatherGradient(dusk, WeatherKind.clear).$1;
    final rainDusk = skyWeatherGradient(dusk, WeatherKind.rain).$1;
    double warmth(Color c) => c.r - c.b;
    expect(warmth(clearDusk), greaterThan(warmth(rainDusk)));
  });

  test('forecast stops sit in daylight, away from the Sun, with time and temperature', () {
    final sky = SkyDay.of(Places.saoPaulo, afternoon);
    final stops = arcWeather(sky, sampleReport(), 'America/Sao_Paulo');
    expect(stops, isNotEmpty);
    expect(stops.length, lessThanOrEqualTo(3));
    for (final s in stops) {
      expect(s.t, inInclusiveRange(0, 1));
      expect((s.t - sky.progress!).abs(), greaterThanOrEqualTo(.08));
      expect(s.label, matches(RegExp(r'^\d\d:00 · \d+°$')));
    }
    expect(spellEnds(sampleReport(), afternoon, WeatherKind.rain), DateTime.utc(2026, 11, 8, 22));
  });

  for (final (name, symbol) in [('rain', 'rain'), ('clear', 'clearsky_day')]) {
    testWidgets('Sun card carries the weather on its arc ($name)', (tester) async {
      tester.view.physicalSize = const Size(390, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({
        'place.name': 'São Paulo',
        'home.display.allOn': true,
        'home.display': '{"moon":true,"weather":true,"skyUseShabbat":true}',
      });
      final prefs = await SharedPreferences.getInstance();
      final report = sampleReport(afternoon: symbol);
      final c = ProviderContainer(
        overrides: [
          prefsProvider.overrideWithValue(prefs),
          weatherReportProvider.overrideWith((ref, key) async => report),
        ],
      );
      addTearDown(c.dispose);
      final key = GlobalKey();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp(
            theme: buildTheme(),
            // Reduced motion: the falling weather is drawn still so the test can settle.
            builder: (context, child) =>
                MediaQuery(data: MediaQuery.of(context).copyWith(disableAnimations: true), child: child!),
            home: Scaffold(
              backgroundColor: SkyColors.night,
              body: SingleChildScrollView(
                child: RepaintBoundary(
                  key: key,
                  child: Consumer(
                    builder: (context, ref, _) => ColoredBox(
                      color: SkyColors.night,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SkyPanel(sky: SkyDay.of(ref.watch(skyPlaceProvider)!, afternoon)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('sun-weather-card')), findsOneWidget);
      final arc = tester.widget<DayArc>(find.byType(DayArc));
      expect(arc.weather, isNotEmpty);
      expect(arc.nowLabel, 'Now 15:30');
      final card = tester.widget<Container>(find.byKey(const ValueKey('sun-weather-card')));
      final colors = ((card.decoration! as BoxDecoration).gradient! as LinearGradient).colors;
      // The sky runs sunrise to sunset: warm at the edges, and the forecast
      // weather's own colour through the afternoon.
      expect(colors.length, greaterThan(2));
      expect(colors, contains(name == 'rain' ? SkyWeatherColors.rain.$1 : SkyWeatherColors.clear.$1));
      expect(find.byType(WeatherOverlay), name == 'rain' ? findsOneWidget : findsNothing);
      expect(find.textContaining(l10n.weatherTonight.toUpperCase()), findsOneWidget);
      if (name == 'rain') expect(find.textContaining(l10n.weatherUntilAbout('19:00')), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage(
          pixelRatio: 2,
        );
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('${Directory.systemTemp.path}/quando-sun-weather-$name.png')
            .writeAsBytes(bytes!.buffer.asUint8List());
      });
    });
  }

  testWidgets('weather overlay draws rain, snow, fog and lightning without errors', (tester) async {
    final kinds = <WeatherKind?>[
      null,
      WeatherKind.rain,
      WeatherKind.rain,
      WeatherKind.thunder,
      WeatherKind.thunder,
      WeatherKind.snow,
      WeatherKind.fog,
      WeatherKind.clear,
    ];
    expect(WeatherOverlay.needed(kinds), isTrue);
    expect(WeatherOverlay.needed(const [null, WeatherKind.clear, WeatherKind.clouds]), isFalse);
    await tester.pumpWidget(
      MaterialApp(
        home: Stack(children: [WeatherOverlay(kinds: kinds)]),
      ),
    );
    // Run through a whole cycle so every flash and drop is painted.
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 250));
    }
    expect(tester.takeException(), isNull);
  });
}
