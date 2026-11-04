import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/home/domain/sky.dart';
import 'package:quando/features/shabbat/domain/place.dart';

void main() {
  test('countdown reads like speech', () {
    expect(countdown(const Duration(seconds: 20)), 'now');
    expect(countdown(const Duration(minutes: 12)), 'in 12m');
    expect(countdown(const Duration(hours: 1, minutes: 40)), 'in 1h 40m');
    expect(countdown(const Duration(hours: 3)), 'in 3h');
    expect(countdown(const Duration(days: 2, hours: 5, minutes: 9)), 'in 2d 5h');
  });

  test('the sky follows the sun in Jerusalem', () {
    // 3 Nov 2026: sunrise about 06:00 local (04:00 UTC), sunset about 16:50 (14:50 UTC).
    final noon = SkyDay.of(Places.jerusalem, DateTime.utc(2026, 11, 3, 10));
    expect(noon.isDay, isTrue);
    expect(noon.progress, inInclusiveRange(0.4, 0.7));
    expect(noon.color, SkyColors.day);
    expect(noon.nextSunset, noon.sunset);

    final night = SkyDay.of(Places.jerusalem, DateTime.utc(2026, 11, 3, 20));
    expect(night.isDay, isFalse);
    expect(night.color, SkyColors.night);
    expect(night.nextSunset!.isAfter(DateTime.utc(2026, 11, 4)), isTrue);
  });
}
