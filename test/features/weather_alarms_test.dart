import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/shabbat/domain/place.dart';
import 'package:quando/features/weather_alarms/data/weather_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  DateTime same(DateTime d) => d;

  test('warns before the rain starts, at each reminder', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        quiet: false,
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
      settings: const WeatherAlarmSettings(quiet: false, enabled: true, tied: false),
      hours: forecast,
      now: DateTime.utc(2026, 11, 12, 10, 30),
    );
    expect(raining, isEmpty);
    final late = planner.plan(
      settings: const WeatherAlarmSettings(
        quiet: false,
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
      settings: const WeatherAlarmSettings(quiet: false, enabled: true, kinds: {WeatherKind.snow}),
      hours: forecast,
      now: now,
    );
    expect(snowOnly, isEmpty);
  });

  test('tied to an alarm or event that falls in the rain', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        quiet: false,
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
      settings: const WeatherAlarmSettings(quiet: false, enabled: true, anytime: false),
      hours: [hour(9, 'rain'), hour(10, 'rainandthunder'), hour(11, 'cloudy')],
      now: now,
      anchors: [WeatherAnchor(id: 'e', at: DateTime.utc(2026, 11, 12, 10), title: 'Meeting')],
    );
    expect(alerts.map((a) => a.kind).toSet(), {WeatherKind.thunder});
  });

  test('off means nothing, and settings and alerts survive JSON', () {
    expect(
      planner.plan(settings: const WeatherAlarmSettings(quiet: false), hours: forecast, now: now),
      isEmpty,
    );
    final s = WeatherAlarmSettings.fromJson(
      const WeatherAlarmSettings(
        quiet: false,
        enabled: true,
        kinds: {WeatherKind.snow},
        reminders: [WeatherReminder(lead: Duration(minutes: 45), loud: false)],
      ).toJson(),
    );
    expect(s.kinds, {WeatherKind.snow});
    expect(s.reminders.single.lead, const Duration(minutes: 45));
    expect(s.reminders.single.loud, isFalse);
    final a = planner
        .plan(
          settings: const WeatherAlarmSettings(quiet: false, enabled: true, tied: false),
          hours: forecast,
          now: now,
        )
        .first;
    expect(WeatherAlert.fromJson(a.toJson())!.key, a.key);
  });

  test('quiet hours hold a night reminder until morning, if the weather is not there yet', () {
    final night = DateTime.utc(2026, 11, 12, 1);
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        enabled: true,
        tied: false,
        reminders: [
          WeatherReminder(lead: Duration(hours: 6)),
          WeatherReminder(lead: Duration(hours: 1)),
        ],
      ),
      hours: [hour(2, 'cloudy'), hour(9, 'rain'), hour(10, 'cloudy')],
      now: night,
      toLocal: same,
    );
    // 03:00 is quiet, so it waits for 07:00; 08:00 is fine as it is.
    expect(alerts.map((a) => a.at), [DateTime.utc(2026, 11, 12, 7), DateTime.utc(2026, 11, 12, 8)]);
  });

  test('a quiet reminder is dropped when the weather arrives before the quiet hours end', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(
        enabled: true,
        tied: false,
        reminders: [WeatherReminder(lead: Duration(hours: 1))],
      ),
      hours: [hour(2, 'cloudy'), hour(6, 'rain'), hour(7, 'cloudy')],
      now: DateTime.utc(2026, 11, 12, 1),
      toLocal: same,
    );
    expect(alerts, isEmpty);
  });

  test('nothing rings inside a blocked period (Shabbat)', () {
    final alerts = planner.plan(
      settings: const WeatherAlarmSettings(enabled: true, tied: false, quiet: false),
      hours: forecast,
      now: now,
      blocked: [(DateTime.utc(2026, 11, 12, 7), DateTime.utc(2026, 11, 12, 9))],
    );
    // The 2 h reminder (08:00) is blocked; the 30 min one (09:30) is not.
    expect(alerts.map((a) => a.at), [DateTime.utc(2026, 11, 12, 9, 30)]);
  });

  test('what the background check needs survives being saved', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await WeatherSnapshot(
      place: Places.jerusalem,
      anchors: [WeatherAnchor(id: 'a', at: DateTime.utc(2026, 11, 12, 8), title: 'Work')],
      blocked: [(DateTime.utc(2026, 11, 13, 15), DateTime.utc(2026, 11, 14, 17))],
      locale: 'zh_Hant',
    ).save(prefs);
    final back = WeatherSnapshot.load(prefs)!;
    expect(back.place.name, 'Jerusalem');
    expect(back.locale, 'zh_Hant');
    expect(back.anchors.single.title, 'Work');
    expect(back.blocked.single.$2, DateTime.utc(2026, 11, 14, 17));
    expect(WeatherSnapshot.load(await _empty()), isNull);
  });
}

Future<SharedPreferences> _empty() async {
  SharedPreferences.setMockInitialValues({});
  return SharedPreferences.getInstance();
}
