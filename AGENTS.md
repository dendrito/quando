# Quando

Flutter alarm app, one codebase with three editions chosen by `--dart-define=QUANDO_EDITION=`:
`quando` (Quando?), `kodesh` (Matai?), `mine` (Quando Mine). Targets: native macOS, iOS/iPadOS, Android.

## Build and install

Use the script. Don't run `flutter build` or `xcodebuild` by hand unless debugging a failure.

    tool/ship.sh quando|kodesh|mine|all mac|ipad|all [--no-install]

It prints one line per step. On failure, read the errors it prints first, then only the end of the
log in `build/ship/`. Never paste a whole build log into the conversation.

## Check before saying it's done

    dart format --output=none --set-exit-if-changed lib test
    flutter analyze
    flutter test
    flutter test --dart-define=QUANDO_EDITION=kodesh test/edition_test.dart test/quotes_test.dart

Pipe these through `tail -20`. While iterating, run only the test file you're changing.

## Files not to open

Generated and huge. Blocked for Read in `.Codex/settings.json`; don't `cat` them either.

- `lib/features/quotes/data/quote_bank.dart` (592 KB): built by `tool/quotes/build.py` from `tool/quotes/*.txt`.
- `lib/l10n/app_localizations*.dart` (1.5 MB): generated. Edit `lib/l10n/app_en.arb`, and search the
  other `.arb` files for a key rather than reading them whole.
- `build/`.

## Layout

`lib/app` shell, router, theme, state (Riverpod). `lib/core/scheduler` turns rules and events into
alarms. `lib/features/*` one folder per feature. `macos/` native timers, audio, EventKit.

## Things that are easy to get wrong

- Mac alarms only ring while the app is open and the Mac is awake. Quitting stops them.
- `tool/ios_edition.sh` and `tool/macos_edition.sh` rewrite tracked project files. `tool/ship.sh` and
  `tool/build_macos.sh` restore them; if you call them directly, restore them yourself.
- Don't change entitlements or keychain groups, or weaken OS security settings, without asking.
- Say "not verified" for anything not actually run, especially real alarms, sign-in and music providers.

## Project notes

Long history lives in `~/Downloads/Codex-memory-2026-11-05/quando/` (about 110 KB). Don't load it
at the start of a task. Open `STATUS.md` or `ROADMAP.md` only if the task needs that history.
