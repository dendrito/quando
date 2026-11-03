import '../../events/domain/event.dart';
import 'alarm_rule.dart';

const _candles = {EventKind.holyDayStart};

/// Ready-made rules the user can switch on with one tap.
class Presets {
  static const countdown = AlarmRule(
    id: 'preset.countdown',
    name: 'Countdown to candle lighting',
    appliesTo: _candles,
    before: [
      Duration(hours: 2),
      Duration(hours: 1),
      Duration(minutes: 30),
      Duration(minutes: 15),
      Duration(minutes: 5),
    ],
  );

  static const hourly = AlarmRule(
    id: 'preset.hourly',
    name: 'Every hour, from 6 hours before',
    appliesTo: _candles,
    series: [OffsetSeries(direction: Direction.before, every: Duration(hours: 1), span: Duration(hours: 6))],
  );

  static const dailyWeek = AlarmRule(
    id: 'preset.dailyWeek',
    name: 'Once a day, for a week before',
    appliesTo: _candles,
    series: [OffsetSeries(direction: Direction.before, every: Duration(days: 1), span: Duration(days: 7))],
    enabled: false,
  );

  static const secondNight = AlarmRule(
    id: 'preset.secondNight',
    name: 'Second-night candles',
    appliesTo: {EventKind.secondNightCandles},
    atEvent: true,
  );

  static const havdalah = AlarmRule(
    id: 'preset.havdalah',
    name: 'Havdalah',
    appliesTo: {EventKind.holyDayEnd},
    atEvent: true,
    after: [Duration(minutes: 15)],
  );

  static const fridayReminder = AlarmRule(
    id: 'preset.fridayReminder',
    name: 'Reminder 3 hours before: charge your phone',
    appliesTo: _candles,
    before: [Duration(hours: 3)],
    label: 'Charge your phone and set any alarms for tomorrow',
  );

  static const sunrise = AlarmRule(
    id: 'preset.sunrise',
    name: 'Sunrise',
    appliesTo: {EventKind.sunrise},
    atEvent: true,
    enabled: false,
  );

  static const sunset = AlarmRule(
    id: 'preset.sunset',
    name: 'Sunset, and 15 minutes before',
    appliesTo: {EventKind.sunset},
    atEvent: true,
    before: [Duration(minutes: 15)],
    enabled: false,
  );

  static const all = [countdown, hourly, dailyWeek, fridayReminder, secondNight, havdalah, sunrise, sunset];
}
