import '../../events/domain/event.dart';
import 'alarm_rule.dart';

import 'package:quando/l10n/l10n.dart';

const _candles = {EventKind.holyDayStart};

/// Ready-made rules the user can switch on with one tap.
class Presets {
  static AlarmRule get countdown => AlarmRule(
    id: 'preset.countdown',
    name: l10n.presetCountdown,
    appliesTo: _candles,
    before: [
      Duration(hours: 2),
      Duration(hours: 1),
      Duration(minutes: 30),
      Duration(minutes: 15),
      Duration(minutes: 5),
    ],
  );

  static AlarmRule get hourly => AlarmRule(
    id: 'preset.hourly',
    name: l10n.presetHourly,
    appliesTo: _candles,
    series: [OffsetSeries(direction: Direction.before, every: Duration(hours: 1), span: Duration(hours: 6))],
  );

  static AlarmRule get dailyWeek => AlarmRule(
    id: 'preset.dailyWeek',
    name: l10n.presetDailyWeek,
    appliesTo: _candles,
    series: [OffsetSeries(direction: Direction.before, every: Duration(days: 1), span: Duration(days: 7))],
    enabled: false,
  );

  static AlarmRule get secondNight => AlarmRule(
    id: 'preset.secondNight',
    name: l10n.presetSecondNight,
    appliesTo: {EventKind.secondNightCandles},
    atEvent: true,
  );

  static AlarmRule get havdalah => AlarmRule(
    id: 'preset.havdalah',
    name: l10n.havdalah,
    appliesTo: {EventKind.holyDayEnd},
    atEvent: true,
    after: [Duration(minutes: 15)],
  );

  static AlarmRule get fridayReminder => AlarmRule(
    id: 'preset.fridayReminder',
    name: l10n.presetFridayReminder,
    appliesTo: _candles,
    before: [Duration(hours: 3)],
    label: l10n.presetFridayReminderLabel,
  );

  static AlarmRule get sunrise => AlarmRule(
    id: 'preset.sunrise',
    name: l10n.sunrise,
    appliesTo: {EventKind.sunrise},
    atEvent: true,
    enabled: false,
  );

  static AlarmRule get sunset => AlarmRule(
    id: 'preset.sunset',
    name: l10n.presetSunset,
    appliesTo: {EventKind.sunset},
    atEvent: true,
    before: [Duration(minutes: 15)],
    enabled: false,
  );

  static List<AlarmRule> get all => [
    countdown,
    hourly,
    dailyWeek,
    fridayReminder,
    secondNight,
    havdalah,
    sunrise,
    sunset,
  ];
}
