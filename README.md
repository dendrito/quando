# Quando

*If not now, when?*

An alarm app built around the moments that matter: Shabbat and festivals, calendar events, and the
times before and after them.

See the [project roadmap](docs/ROADMAP.md) and [ElevenLabs voice business plan](docs/ELEVENLABS_VOICE_BUSINESS_PLAN.md) for future milestones and deferred premium features.

## What works today (milestone 1)

- **Shabbat and festival times, calculated on the phone.** Candle lighting, second-night candles and
  havdalah for any city, using [kosher_dart](https://pub.dev/packages/kosher_dart). Two-day festivals
  outside Israel, one day in Israel, and festivals that run into Shabbat are one unbroken period.
- **Local customs.** Candle-lighting minutes per city (18 by default, 40 for Jerusalem, 30 for Haifa),
  and havdalah by the Geonim (8.5°) or Rabbeinu Tam (72 minutes).
- **Alarm rules and presets.** Countdown (2h, 1h, 30m, 15m, 5m before), every hour from 6 hours
  before, once a day for a week before, second-night candles, and havdalah.
- **The scheduler.** Turns rules and events into concrete alarms for the next 7 days, with stable ids
  so re-planning never doubles up, and one ring when two rules ask for the same minute.
- **Real alarms on Android and iOS** through the [alarm](https://pub.dev/packages/alarm) package:
  full-screen on the lock screen, rings on silent, fades in, and stops by itself after its ring
  duration.

## Layout

```
lib/
  app/                 app shell, router, theme, state (Riverpod)
  core/
    scheduler/         rules + events → alarms for the next 7 days
    util/              formatting, time zones
  features/
    alarms/            registering alarms with the phone
    events/            events and Shabbat/festival periods
    rules/             alarm rules and presets
    shabbat/           places and Shabbat/festival times
    home/              home and settings screens
test/                  unit and widget tests
```

## Running it

```sh
flutter pub get
flutter test          # 22 tests
flutter run           # on a connected phone or emulator
```

Every push to `main` runs format, analyze and tests on GitHub, then builds a debug APK you can
download from the run's **Artifacts** section and install on an Android phone.

## Next (milestone 2)

Saving settings on the phone, re-planning daily and after a reboot, a native ring-duration timer that
survives the app being killed, spoken alarms, custom recordings, multiple time zones, and the
create/edit screens for plain alarms and custom rules.

Times are calculated on the phone. For borderline cases, check with your rabbi or community calendar.
