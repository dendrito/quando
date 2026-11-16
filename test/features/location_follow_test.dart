import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/features/shabbat/ui/city_picker.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A phone in Rio de Janeiro (Santa Teresa), counting how often it is asked.
class _RioLookup extends LocationLookup {
  int calls = 0;
  @override
  Future<({double latitude, double longitude})> current() async {
    calls++;
    await Future<void>.delayed(const Duration(milliseconds: 5));
    return (latitude: -22.916, longitude: -43.182);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    ensureTimeZones();
    useLocale([const Locale('en')]);
  });

  Future<(ProviderContainer, _RioLookup, SharedPreferences)> phone(Map<String, Object> prefs) async {
    SharedPreferences.setMockInitialValues(prefs);
    final p = await SharedPreferences.getInstance();
    final lookup = _RioLookup();
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(p),
        deviceZoneProvider.overrideWithValue('America/Sao_Paulo'),
        locationLookupProvider.overrideWithValue(lookup),
      ],
    );
    addTearDown(c.dispose);
    return (c, lookup, p);
  }

  test('one fix names Rio offline for Shabbat, sky and weather, not the zone city', () async {
    final (c, lookup, _) = await phone({});
    expect(c.read(skyPlaceProvider)?.name, 'São Paulo'); // Before any fix: the zone's city.
    await Future.wait([
      c.read(placeProvider.notifier).refreshPrecise(),
      c.read(weatherLocationProvider.notifier).refreshPrecise(),
      c.read(hereProvider.notifier).refresh(),
    ]);
    expect(lookup.calls, 1);
    expect(c.read(placeProvider).name, contains('Rio de Janeiro'));
    expect(c.read(placeProvider).candleLightingMinutes, 18);
    expect(c.read(skyPlaceProvider)?.name, contains('Rio de Janeiro'));
    expect(c.read(weatherPlaceProvider)?.name, contains('Rio de Janeiro'));
    expect(syncedKeys, isNot(contains(HereNotifier.key)));
  });

  test('a city picked by hand stays, for Shabbat and for the sky', () async {
    final (c, _, _) = await phone({});
    c.read(placeProvider.notifier).set(Places.all.firstWhere((p) => p.name == 'Jerusalem'));
    c.read(skyLocationProvider.notifier).set(Places.london);
    await c.read(placeProvider.notifier).refreshPrecise();
    await c.read(hereProvider.notifier).refresh();
    expect(c.read(placeProvider).name, 'Jerusalem');
    expect(c.read(skyPlaceProvider)?.name, 'London');
    c.read(skyLocationProvider.notifier).clear();
    expect(c.read(skyPlaceProvider)?.name, contains('Rio de Janeiro'));
  });

  test('a place saved as "Current location" gets its city name on the next fix', () async {
    final saved = const Place(
      name: 'Current location',
      latitude: -22.915,
      longitude: -43.18,
      timeZone: 'America/Sao_Paulo',
      inIsrael: true,
      candleLightingMinutes: 22,
    );
    final (c, _, _) = await phone({
      'place.local':
          '{"name":"${saved.name}","latitude":-22.915,'
          '"longitude":-43.18,"timeZone":"America/Sao_Paulo","inIsrael":true,"candleMinutes":22}',
    });
    await c.read(placeProvider.notifier).refreshPrecise();
    final p = c.read(placeProvider);
    expect(p.name, contains('Rio de Janeiro'));
    expect(p.inIsrael, isTrue); // Same spot: the person's settings stay.
    expect(p.candleLightingMinutes, 22);
  });

  test('sunrise alarms follow the sky place, not a Shabbat city chosen elsewhere', () async {
    final (c, _, _) = await phone({});
    c.read(placeProvider.notifier).set(Places.all.firstWhere((p) => p.name == 'Jerusalem'));
    await c.read(hereProvider.notifier).refresh();
    expect(c.read(sunPlaceProvider).name, contains('Rio de Janeiro'));
    expect(c.read(placeProvider).name, 'Jerusalem');
  });
}
