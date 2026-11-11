import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/home/data/weather_repository.dart';
import 'package:quando/features/weather_alarms/domain/weather_alarms.dart';

void main() {
  final now = DateTime.utc(2026, 11, 12, 6);
  WeatherHour hour(int h, String symbol) =>
      WeatherHour(at: DateTime.utc(2026, 11, 12, h), celsius: 12, symbol: symbol);

  // Dry until 10:00, rain from 10:00 to 12:00, dry again.
  final forecast = [
    for (var h = 5; h < 10; h++) hour(h, 'cloudy'),
    hour(10, 'rain'),
    hour(11, 'heavyrain'),
    hour(12, 'cloudy'),
    hour(13, 'cloudy'),
  ];
  const planner = WeatherPlanner();

  test('warns before the rain starts, at each reminder', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        enabled: true,
        tied: false,
        reminders: [
          WeatherReminder(lead: Duration(hours: 2)),
          WeatherReminder(lead: Duration(minutes: 30), loud: false),
        ],
      ),
      hours: forecast,
      now: now,
    );
    expect(alerts.map((a) => a.at), [DateTime.utc(2026, 11, 12, 8), DateTime.utc(2026, 11, 12, 9, 30)]);
    expect(alerts.map((a) => a.loud), [true, false]);
    expect(alerts.every((a) => a.kind == WeatherKind.rain), isTrue);
  });

  test('already raining is not a new spell, and reminders in the past are dropped', () {
    final raining = planner.plan(
      settings: const WeatherAlarmSettings(enabled: true, tied: false),
      hours: forecast,
      now: DateTime.utc(2026, 11, 12, 10, 30),
    );
    expect(raining, isEmpty);
    final late = planner.plan(
      settings: const WeatherAlarmSettings(
        enabled: true,
        tied: false,
        reminders: [
          WeatherReminder(lead: Duration(hours: 6)),
          WeatherReminder(lead: Duration(hours: 1)),
        ],
      ),
      hours: forecast,
      now: now,
    );
    // 6 h before 10:00 is 04:00, already gone.
    expect(late.map((a) => a.lead), [const Duration(hours: 1)]);
  });

  test('only the chosen kinds count', () {
    final snowOnly = planner.plan(
      settings: const WeatherAlarmSettings(enabled: true, kinds: {WeatherKind.snow}),
      hours: forecast,
      now: now,
    );
    expect(snowOnly, isEmpty);
  });

  test('tied to an alarm or event that falls in the rain', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        enabled: true,
        anytime: false,
        reminders: [WeatherReminder(lead: Duration(minutes: 20))],
      ),
      hours: forecast,
      now: now,
      anchors: [
        WeatherAnchor(id: 'work', at: DateTime.utc(2026, 11, 12, 11, 30), title: 'Leave for work'),
        WeatherAnchor(id: 'dry', at: DateTime.utc(2026, 11, 12, 7), title: 'Run'),
      ],
    );
    expect(alerts, hasLength(1));
    expect(alerts.single.anchorTitle, 'Leave for work');
    expect(alerts.single.at, DateTime.utc(2026, 11, 12, 11, 10));
  });

  test('thunder beats rain when both are near an event', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(enabled: true, anytime: false),
      hours: [hour(9, 'rain'), hour(10, 'rainandthunder'), hour(11, 'cloudy')],
      now: now,
      anchors: [WeatherAnchor(id: 'e', at: DateTime.utc(2026, 11, 12, 10), title: 'Meeting')],
    );
    expect(alerts.map((a) => a.kind).toSet(), {WeatherKind.thunder});
  });

  test('off means nothing, and settings and alerts survive JSON', () {
    expect(planner.plan(settings: const WeatherAlarmSettings(), hours: forecast, now: now), isEmpty);
    final s = WeatherAlarmSettings.fromJson(
      const WeatherAlarmSettings(
        enabled: true,
        kinds: {WeatherKind.snow},
        reminders: [WeatherReminder(lead: Duration(minutes: 45), loud: false)],
      ).toJson(),
    );
    expect(s.kinds, {WeatherKind.snow});
    expect(s.reminders.single.lead, const Duration(minutes: 45));
    expect(s.reminders.single.loud, isFalse);
    final a = planner
        .plan(settings: const WeatherAlarmSettings(enabled: true, tied: false), hours: forecast, now: now)
        .first;
    expect(WeatherAlert.fromJson(a.toJson())!.key, a.key);
  });
}
