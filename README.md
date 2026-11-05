# Quando

*If not now, when?*

Quando is an event-aware alarm app built around the moments that matter: Shabbat and festivals, calendar events, and the reminders before and after them.

See the [project roadmap](docs/ROADMAP.md) for the dependency-ordered development plan and the [ElevenLabs voice business plan](docs/ELEVENLABS_VOICE_BUSINESS_PLAN.md) for the deferred premium voice concept.

## What is in the app

- **Shabbat and festival times calculated on the phone**, including candle lighting, second-night candles, and havdalah, using [kosher_dart](https://pub.dev/packages/kosher_dart).
- **Local customs**, including candle-lighting offsets and Geonim or Rabbeinu Tam havdalah calculations.
- **Alarm rules and presets**, including countdown reminders, recurring reminders, second-night candles, and havdalah.
- **A seven-day scheduler** that creates concrete alarms with stable identifiers, avoids duplicate registration, and replans as events and settings change.
- **Native Android and iOS alarm integration** through the [alarm](https://pub.dev/packages/alarm) package.
- **Local persistence**, built-in sounds, user recordings, and spoken alarms through device text-to-speech.
- **Phone calendar access** and calendar-based alarm rules.
- **Music and notification integrations**, including Spotify/YouTube discovery and Pushover support, subject to each provider's API, account, and operating-system restrictions.

The app's basic local alarm path must remain usable without Firebase, calendar APIs, or an internet connection. Remote audio providers may require connectivity or an official-app handoff; Quando does not extract protected streams or promise unsupported background playback.

## Project layout

```
lib/
  app/                 app shell, router, theme, state (Riverpod)
  core/
    scheduler/         rules + events → alarms for the next 7 days
    util/              formatting, time zones
  features/            alarms, events, calendars, rules, sounds,
                       integrations, Shabbat, sync, and settings
test/                  unit and widget tests
docs/                  roadmap, setup guides, and product plans
```

## Run locally

Use the Flutter stable version pinned in `.github/workflows/build.yml` (currently 3.47.9).

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter run
```

## Continuous integration

Pull requests run formatting, static analysis, the Flutter test suite, and Android release builds. The workflow also builds the two app editions and uploads installable artifacts. iOS builds run on pushes to `main` and by manual workflow dispatch; they are unsigned until Apple signing is configured.

## Roadmap

Development is organized into milestones so alarm reliability comes before additional integrations:

1. M0 — Repository and architecture audit
2. M1 — Reliable alarm foundation
3. M2 — Calendar integrations
4. M3 — Sound and notification integrations
5. M4 — Unified event-to-reminder experience
6. M5 — Release readiness
7. M6 — Premium Voice Experience (deferred)

See [docs/ROADMAP.md](docs/ROADMAP.md) for acceptance criteria and dependencies.

Times are calculated on the phone. For borderline religious-time cases, check with your rabbi or community calendar.
