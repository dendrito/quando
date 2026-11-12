import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../../l10n/l10n.dart';
import '../../ringing/ring_style.dart';
import '../../sounds/domain/loudness.dart';
import '../../home/data/weather_repository.dart';
import '../domain/weather_alarms.dart';

/// Soft reminders are a short, quiet ping; loud ones a full alarm.
const softLoudness = Loudness(volume: 30, fadeInSeconds: 3);

String _hhmm(DateTime utc) {
  final t = utc.toLocal();
  return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

String weatherTitle(WeatherKind kind) => switch (kind) {
  WeatherKind.thunder => l10n.weatherTitleThunder,
  WeatherKind.snow => l10n.weatherTitleSnow,
  WeatherKind.fog => l10n.weatherTitleFog,
  _ => l10n.weatherTitleRain,
};

/// The reminders as alarms the phone can ring, in the language in use.
List<ScheduledAlarm> weatherAlarmsFor(List<WeatherAlert> alerts, DateTime now) => [
  for (final a in alerts)
    if (a.at.isAfter(now))
      ScheduledAlarm(
        id: stableId('weather|${a.key}'),
        at: a.at,
        title: weatherTitle(a.kind),
        body: a.anchorTitle == null
            ? l10n.weatherBodyAny(_hhmm(a.onset))
            : l10n.weatherBodyTied(a.anchorTitle!, _hhmm(a.onset)),
        ringDuration: Duration(seconds: a.loud ? 60 : 15),
        ringDurationOverride: true,
        ruleId: 'weather',
        eventId: a.key,
        offset: -a.lead,
        style: a.loud ? RingStyle.none : const RingStyle(loudness: softLoudness),
      ),
];
