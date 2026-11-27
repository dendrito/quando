import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/edition.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/shabbat/ui/city_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Lookup implements LocationLookup {
  int calls = 0;
  @override
  Future<({double latitude, double longitude})> current() async {
    calls++;
    return (latitude: 51.5, longitude: -0.12);
  }

  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Run with --dart-define=QUANDO_EDITION=kodesh to check Matai?.
  test('Quando? follows the phone, Matai? waits for a tap; "stop" turns it off', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final lookup = _Lookup();
    final c = ProviderContainer(
      overrides: [prefsProvider.overrideWithValue(prefs), locationLookupProvider.overrideWithValue(lookup)],
    );
    addTearDown(c.dispose);
    final here = c.read(hereProvider.notifier);
    expect(here.allowed, !kodesh);
    if (kodesh) {
      await expectLater(here.refresh(), throwsA(isA<LocationFailure>()));
      expect(lookup.calls, 0); // Matai? never asks the phone by itself
      await here.refresh(force: true);
    } else {
      await here.refresh();
    }
    expect(lookup.calls, 1);

    await here.stop();
    expect(c.read(hereProvider), isNull);
    await expectLater(here.refresh(), throwsA(isA<LocationFailure>()));
    expect(lookup.calls, 1); // never asked the phone

    await here.refresh(force: true); // "Use my location"
    expect(here.allowed, isTrue);
    expect(lookup.calls, 2);
  });
}
