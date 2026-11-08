import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/core/util/local_time.dart';
import 'package:quando/features/alarms/domain/user_alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tue 3 Nov 2026, 12:00 UTC.
final _now = DateTime.utc(2026, 11, 3, 12);

Future<ProviderContainer> _container({String? deviceZone}) async {
  ensureTimeZones();
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => _now),
      prefsProvider.overrideWithValue(prefs),
      deviceZoneProvider.overrideWithValue(deviceZone),
    ],
  );
  addTearDown(c.dispose);
  return c;
}

DateTime _first(ProviderContainer c, String id) =>
    c.read(planProvider).firstWhere((a) => a.ruleId == 'user.$id').at;

void main() {
  test('home zone: picked city, else the phone, else the Shabbat city', () async {
    expect((await _container()).read(homeZoneProvider), 'Asia/Jerusalem');
    final c = await _container(deviceZone: 'America/Sao_Paulo');
    expect(c.read(homeZoneProvider), 'America/Sao_Paulo');
    c.read(timeZonesProvider.notifier).setFixed('Europe/Lisbon');
    expect(c.read(homeZoneProvider), 'Europe/Lisbon');
    c.read(timeZonesProvider.notifier).followPhone();
    expect(c.read(homeZoneProvider), 'America/Sao_Paulo');
  });

  test('a zone synced from another device is dropped; Quando? follows this device', () async {
    ensureTimeZones();
    SharedPreferences.setMockInitialValues({'zone.fixed': 'America/Detroit'});
    final prefs = await SharedPreferences.getInstance();
    final c = ProviderContainer(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        deviceZoneProvider.overrideWithValue('America/Sao_Paulo'),
      ],
    );
    addTearDown(c.dispose);
    expect(c.read(homeZoneProvider), 'America/Sao_Paulo');
    expect(prefs.containsKey('zone.fixed'), isFalse);
  });

  test('everyday alarms follow the phone\'s zone', () async {
    final c = await _container(deviceZone: 'America/Sao_Paulo');
    c.read(userAlarmsProvider.notifier).save(const UserAlarm(id: 'a', hour: 7, minute: 0, days: {3}));
    // Wed 4 Nov 07:00 in São Paulo (UTC-3) = 10:00 UTC.
    expect(_first(c, 'a'), DateTime.utc(2026, 11, 4, 10));
  });

  test('an alarm set in New York time rings at New York\'s 7:00', () async {
    final c = await _container(deviceZone: 'Asia/Jerusalem');
    c
        .read(userAlarmsProvider.notifier)
        .save(const UserAlarm(id: 'ny', hour: 7, minute: 0, days: {3}, zone: 'America/New_York'));
    expect(_first(c, 'ny'), DateTime.utc(2026, 11, 4, 12)); // NY is UTC-5 in November
    final body = c.read(planProvider).firstWhere((a) => a.ruleId == 'user.ny').body;
    expect(body, contains('07:00 New York time'));
  });

  test('world clocks are kept, once each, and survive a restart', () async {
    final c = await _container();
    final n = c.read(timeZonesProvider.notifier);
    n.addClock('Asia/Tokyo');
    n.addClock('Asia/Tokyo');
    n.addClock('America/Los_Angeles');
    n.removeClock('Asia/Tokyo');
    final again = ProviderContainer(overrides: [prefsProvider.overrideWithValue(c.read(prefsProvider))]);
    addTearDown(again.dispose);
    expect(again.read(timeZonesProvider).clocks, ['America/Los_Angeles']);
  });

  test('zone helpers', () {
    ensureTimeZones();
    expect(cityOf('America/Sao_Paulo'), 'Sao Paulo');
    expect(offsetFrom('Asia/Tokyo', 'Asia/Jerusalem', _now), '+7 h');
    expect(offsetFrom('Asia/Kolkata', 'Asia/Jerusalem', _now), '+3:30 h');
    expect(offsetFrom('America/New_York', 'Asia/Jerusalem', _now), '−7 h');
    expect(allZones(), contains('Europe/Lisbon'));
  });
}
