import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/geo/offline_cities.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a fix in Rio names the district and the city', () async {
    expect(await OfflineCities.nearest(-22.916, -43.182), 'Santa Teresa, Rio de Janeiro');
    expect(await OfflineCities.nearest(-22.906, -43.182), 'Rio de Janeiro');
  });

  test('the centre of Niterói is named Niterói, not its larger neighbour', () async {
    expect(await OfflineCities.nearest(-22.883, -43.104), 'Niterói');
  });

  test('Tel Aviv and Jerusalem keep their own names', () async {
    expect(await OfflineCities.nearest(32.0853, 34.7818), 'Tel Aviv');
    expect(await OfflineCities.nearest(31.7683, 35.2137), 'Jerusalem');
  });

  test('nothing within range gives no name', () async {
    expect(await OfflineCities.nearest(-30.0, -30.0), isNull);
  });
}
