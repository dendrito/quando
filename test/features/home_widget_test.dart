import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

ScheduledAlarm _alarm(String rule, DateTime at, String title) => ScheduledAlarm(
  id: at.millisecondsSinceEpoch ~/ 1000,
  at: at,
  title: title,
  body: '',
  ringDuration: const Duration(minutes: 1),
  ruleId: rule,
  eventId: rule,
  offset: Duration.zero,
);

void main() {
  test('the widget gets the alarms you wait for, the sun and its words', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final rise = DateTime.utc(2026, 11, 12, 8, 30);
    await HomeWidget(prefs).publish(
      plan: [
        _alarm('lock', DateTime.utc(2026, 11, 12, 6), 'Lock mode'),
        _alarm('gentle.user.a', DateTime.utc(2026, 11, 12, 6, 50), 'Wake up'),
        _alarm('user.a', DateTime.utc(2026, 11, 12, 7), 'Wake up'),
      ],
      sunrise: rise,
      sunset: null,
      label: 'NEXT ALARM',
      none: 'No alarms in the next 7 days.',
    );
    expect(jsonDecode(prefs.getString(HomeWidget.alarmsKey)!), [
      [DateTime.utc(2026, 11, 12, 7).millisecondsSinceEpoch, 'Wake up'],
    ]);
    expect(prefs.getInt(HomeWidget.sunriseKey), rise.millisecondsSinceEpoch);
    expect(prefs.getInt(HomeWidget.sunsetKey), 0);
    expect(prefs.getString(HomeWidget.labelKey), 'NEXT ALARM');
  });
}
