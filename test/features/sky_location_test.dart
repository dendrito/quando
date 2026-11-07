import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/home/domain/moon.dart';
import 'package:quando/features/home/domain/moon_phases.dart';
import 'package:quando/features/home/domain/moon_backdrop.dart';
import 'package:quando/features/home/domain/sky.dart';
import 'package:quando/features/home/domain/zone_places.dart';
import 'package:quando/features/home/ui/day_arc.dart';
import 'package:quando/features/home/ui/sky_panel.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/features/shabbat/ui/city_picker.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await (FontLoader(
      'Bricolage',
    )..addFont(rootBundle.load('assets/fonts/BricolageGrotesque-Regular.ttf'))).load();
    await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  final now = DateTime.utc(2026, 11, 7, 10, 45);
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });

  test('sky follows timezone reference or Shabbat city without changing either setting', () async {
    SharedPreferences.setMockInitialValues({'place.name': 'Jerusalem'});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        deviceZoneProvider.overrideWithValue('America/Detroit'),
      ],
    );
    addTearDown(c.dispose);
    expect(c.read(skyPlaceProvider)?.name, 'Detroit');
    expect(c.read(placeProvider).name, 'Jerusalem');
    final sun = SkyDay.of(c.read(skyPlaceProvider)!, now);
    expect(hhmm(inZone(sun.sunrise!, 'America/Detroit')), '07:13');
    await c.read(homeDisplayProvider.notifier).set(c.read(homeDisplayProvider).copyWith(skyUseShabbat: true));
    expect(c.read(skyPlaceProvider)?.name, 'Jerusalem');
    expect(c.read(homeZoneProvider), 'America/Detroit');
    c.invalidate(homeDisplayProvider);
    expect(c.read(homeDisplayProvider).skyUseShabbat, isTrue);
    await c
        .read(homeDisplayProvider.notifier)
        .set(c.read(homeDisplayProvider).copyWith(skyUseShabbat: false));
    c
        .read(skyLocationProvider.notifier)
        .set(const Place(name: 'My area', latitude: 42.4, longitude: -83, timeZone: 'America/Detroit'));
    expect(c.read(skyPlaceProvider)?.name, 'My area');
    expect(syncedKeys, isNot(contains('sky.place.local')));
    expect(c.read(placeProvider).name, 'Jerusalem');
    c.read(timeZonesProvider.notifier).setFixed('America/Sao_Paulo');
    expect(c.read(skyPlaceProvider)?.name, 'My area'); // A clock change does not relocate the user.
    await prefs.remove('sky.place.local');
    c.invalidate(skyLocationProvider);
    expect(c.read(skyPlaceProvider)?.name, 'São Paulo');
    c.read(timeZonesProvider.notifier).setFixed('Etc/GMT+3');
    expect(c.read(skyPlaceProvider), isNull); // An offset is not a location.
    expect(ZonePlaces.forZone('Europe/London')?.latitude, closeTo(51.5, .1));
  });

  test('next new/full moons match independent USNO November and December 2026 data', () {
    // https://aa.usno.navy.mil/calculated/moon/phases?date=2026-11-01&format=p&nump=8
    final dates = [
      (DateTime.utc(2026, 11, 7), DateTime.utc(2026, 11, 9, 7, 2), DateTime.utc(2026, 11, 24, 14, 53)),
      (DateTime.utc(2026, 11, 25), DateTime.utc(2026, 12, 9, 0, 52), DateTime.utc(2026, 12, 24, 1, 28)),
    ];
    for (final (from, newMoon, fullMoon) in dates) {
      final phases = MoonPhases.nextAfter(from);
      expect(phases.newMoon.difference(newMoon).inSeconds.abs(), lessThan(90));
      expect(phases.fullMoon.difference(fullMoon).inSeconds.abs(), lessThan(90));
      expect(phases.newMoon.isUtc && phases.fullMoon.isUtc, isTrue);
      final after = MoonPhases.nextAfter(phases.newMoon.add(const Duration(seconds: 1)));
      expect(after.newMoon.isAfter(phases.newMoon.add(const Duration(days: 29))), isTrue);
    }
    expect(MoonIllumination.at(now).phaseIndex, 7); // 3% waning is not new moon.
  });

  test('lunar arc stays chronological across midnight and polar/DST dates', () {
    for (final place in [
      Places.saoPaulo,
      Places.london,
      Places.newYork,
      const Place(name: 'Tromso', latitude: 69.65, longitude: 18.96, timeZone: 'Europe/Oslo'),
    ]) {
      for (final at in [
        now,
        DateTime.utc(2026, 3, 29),
        DateTime.utc(2026, 10, 25, 23),
        DateTime.utc(2026, 6, 21),
      ]) {
        final track = MoonTrack.of(place, at);
        if (track.rise != null && track.set != null) {
          expect(track.set!.isAfter(track.rise!), isTrue);
          if (track.above) expect(track.progress, inInclusiveRange(-.01, 1.01));
        }
      }
    }
  });

  test('moon background is purple at night and changes across sunset and sunrise', () {
    MoonTrack track(DateTime from, DateTime to) => MoonTrack(now: from, above: true, rise: from, set: to);
    final night = MoonBackdrop.forTrack(
      Places.saoPaulo,
      track(DateTime.utc(2026, 11, 7, 23), DateTime.utc(2026, 11, 8, 6)),
    );
    expect(night.toSet(), {SkyColors.night});
    final sunset = MoonBackdrop.forTrack(
      Places.saoPaulo,
      track(DateTime.utc(2026, 11, 7, 20), DateTime.utc(2026, 11, 7, 23)),
    );
    expect(sunset.first, SkyColors.day);
    expect(sunset.last, SkyColors.night);
    expect(sunset.toSet().length, greaterThan(2));
    final dawn = MoonBackdrop.forTrack(
      Places.saoPaulo,
      track(DateTime.utc(2026, 11, 7, 7), DateTime.utc(2026, 11, 7, 10)),
    );
    expect(dawn.first, SkyColors.night);
    expect(dawn.last, SkyColors.day);
  });

  test('Moon colors use the Sun tab sunrise and sunset boundaries in each city', () {
    for (final place in [Places.saoPaulo, Places.jerusalem, Places.newYork]) {
      final sun = SkyDay.of(place, now);
      final rise = sun.sunrise!, set = sun.sunset!;
      expect(MoonBackdrop.colorAt(place, rise.subtract(const Duration(seconds: 1))), SkyColors.night);
      for (final at in [
        rise.add(const Duration(seconds: 1)),
        now,
        set.subtract(const Duration(seconds: 1)),
      ]) {
        expect(
          MoonBackdrop.colorAt(place, at),
          SkyDay.of(place, at).isDay ? SkyDay.of(place, at).color : SkyColors.night,
        );
      }
      expect(MoonBackdrop.colorAt(place, set.add(const Duration(seconds: 1))), SkyColors.night);
    }
  });

  test('foreground location uses one fresh fix and cancels native updates', () async {
    final fake = _LocationPlatform();
    final lookup = LocationLookup(platform: fake, macOS: true);
    final request = lookup.current();
    await Future<void>.delayed(Duration.zero);
    fake.positions.add(_position(DateTime.now().subtract(const Duration(days: 1))));
    fake.positions.add(_position(DateTime.now()));
    final result = await request;
    expect(result.latitude, -23.55);
    expect(fake.cancelled, isTrue);
    expect(fake.requested, 1);
    expect(fake.settings?.timeLimit, isNull); // Outer timeout cancels the subscription.
    await fake.positions.close();
  });

  test('Mac fix timeout cancels updates and reports timeout, not denial', () async {
    final fake = _LocationPlatform();
    final request = LocationLookup(
      platform: fake,
      macOS: true,
      timeout: const Duration(milliseconds: 5),
    ).current();
    await expectLater(
      request,
      throwsA(isA<LocationFailure>().having((e) => e.problem, 'reason', LocationProblem.timeout)),
    );
    expect(fake.cancelled, isTrue);
    await fake.positions.close();
  });

  test('denied permission does not start location updates', () async {
    final fake = _LocationPlatform()..permission = LocationPermission.deniedForever;
    await expectLater(
      LocationLookup(platform: fake).current(),
      throwsA(isA<LocationFailure>().having((e) => e.problem, 'reason', LocationProblem.denied)),
    );
    expect(fake.requested, 0);
    unawaited(fake.positions.close());
  });

  testWidgets('explicit sky GPS coordinates keep a fixed clock zone and Shabbat city unchanged', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'place.name': 'Jerusalem', 'zone.fixed': 'America/Detroit'});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        deviceZoneProvider.overrideWithValue('America/Sao_Paulo'),
        locationLookupProvider.overrideWithValue(_FixedLookup()),
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
              body: TextButton(
                onPressed: () =>
                    Navigator.of(context)
                        .push<void>(MaterialPageRoute(builder: (_) => const CityPicker(forSky: true))),
                child: const Text('Choose'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Choose'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.useMyLocation));
    await tester.pumpAndSettle();
    expect(find.text(l10n.locationReview), findsOneWidget);
    expect(find.text('America/Sao_Paulo'), findsOneWidget);
    await tester.tap(find.text(l10n.save));
    await tester.pumpAndSettle();
    expect(c.read(skyPlaceProvider)?.latitude, -23.55);
    expect(c.read(skyPlaceProvider)?.timeZone, 'America/Sao_Paulo');
    expect(c.read(placeProvider).name, 'Jerusalem');
    expect(c.read(homeZoneProvider), 'America/Detroit');
    expect(syncedKeys, isNot(contains('sky.place.local')));
  });

  for (final width in [390.0, 1100.0]) {
    testWidgets('Sun/Moon tabs and daylight panel fit at $width and keep source toggle working', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({
        'place.name': 'São Paulo',
        'home.display': '{"moon":true,"night":true}',
      });
      final prefs = await SharedPreferences.getInstance();
      final c = ProviderContainer(
        overrides: [
          prefsProvider.overrideWithValue(prefs),
          deviceZoneProvider.overrideWithValue('America/Detroit'),
        ],
      );
      addTearDown(c.dispose);
      final key = GlobalKey();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MaterialApp(
            theme: buildTheme(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: RepaintBoundary(
                  key: key,
                  child: Consumer(
                    builder: (context, ref, _) {
                      final sky = SkyDay.of(ref.watch(skyPlaceProvider)!, now);
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: ColoredBox(
                          key: const ValueKey('test-current-sky'),
                          color: sky.color,
                          child: SkyPanel(sky: sky),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DayArc), findsOneWidget);
      expect(tester.widget<DayArc>(find.byType(DayArc)).sky.isDay, isFalse); // Detroit before sunrise.
      await tester.tap(find.text(l10n.skyMoon));
      await tester.pumpAndSettle();
      expect(find.byType(MoonArc), findsOneWidget);
      expect(find.textContaining(l10n.moonNextNew), findsOneWidget);
      expect(find.textContaining('Detroit'), findsOneWidget);
      await tester.tap(find.text(l10n.skyShabbat));
      await tester.pumpAndSettle();
      expect(find.textContaining('São Paulo'), findsOneWidget);
      expect(c.read(homeZoneProvider), 'America/Detroit');
      final phaseRect = tester.getRect(find.byType(MoonDisc));
      final datesRect = tester.getRect(find.byKey(const ValueKey('moon-upcoming-dates')));
      if (width >= 700) {
        expect(datesRect.left, greaterThan(phaseRect.right));
        expect(datesRect.top, closeTo(phaseRect.top, 1));
        expect(tester.getSize(find.byKey(const ValueKey('moon-daylight-background'))).height, lessThan(300));
      } else {
        expect(datesRect.top, greaterThan(phaseRect.bottom));
      }
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('/private/tmp/quando-sky-$width.png').writeAsBytes(bytes!.buffer.asUint8List());
      });
      await tester.tap(find.text(l10n.skySun));
      await tester.pumpAndSettle();
      final sunArc = tester.widget<DayArc>(find.byType(DayArc));
      expect(sunArc.sky.isDay, isTrue); // São Paulo: visible Sun, not an empty night marker.
      expect(sunArc.sky.progress, inExclusiveRange(0, 1));
      expect(tester.widget<ColoredBox>(find.byKey(const ValueKey('test-current-sky'))).color, SkyColors.day);
      expect(find.textContaining(l10n.moonNextNew), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('/private/tmp/quando-sun-restored-$width.png').writeAsBytes(bytes!.buffer.asUint8List());
      });
    });
  }
}

Position _position(DateTime at) => Position(
  latitude: -23.55,
  longitude: -46.63,
  timestamp: at,
  accuracy: 50,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

class _LocationPlatform extends GeolocatorPlatform {
  _LocationPlatform() {
    positions = StreamController<Position>(onCancel: () => cancelled = true);
  }
  late final StreamController<Position> positions;
  var cancelled = false, requested = 0;
  LocationSettings? settings;
  var permission = LocationPermission.always;
  @override
  Future<bool> isLocationServiceEnabled() async => true;
  @override
  Future<LocationPermission> checkPermission() async => permission;
  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    requested++;
    settings = locationSettings;
    return positions.stream;
  }
}

class _FixedLookup extends LocationLookup {
  @override
  Future<({double latitude, double longitude})> current() async => (latitude: -23.55, longitude: -46.63);
}
