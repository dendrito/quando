# Native Mac development builds

Quando, Matai and Quando Mine share the existing Flutter screens and data models.
The native macOS runner avoids the iPad-on-Mac launch-constraint failure observed
on this development Mac. The older installed iPad wrappers must be backed up
before replacing them. Never change macOS security settings to make a build run.

## Build

Use the CI-pinned Flutter 3.47.9, Xcode and CocoaPods. With dependencies installed:

```sh
tool/build_macos.sh quando
tool/build_macos.sh kodesh
tool/build_macos.sh mine
```

The script builds for Apple Silicon and writes apps under `build/mac-editions`.
It restores the runner's original edition configuration after each build. Set
`QUANDO_MAC_OUTPUT` to choose another artifact directory. Set
`QUANDO_MAC_DERIVED_DATA` to keep Xcode's cache outside any cloud-synced source
folder; the default is `build/macos`. For local team signing,
set `QUANDO_MAC_SIGNING_IDENTITY` to an existing signing identity and
`QUANDO_MAC_TEAM` to its existing team. Without them, Xcode signs to run locally.
The script neither installs nor publishes the result. These builds are not
notarized public releases.

## Alarm behavior

- Keep the app running and the Mac awake. Closing the window hides it; Quit
  terminates the process. Click its Dock icon to reopen the window.
- Native main-run-loop timers start local audio and report through the existing
  alarm callback API. The shared registrar handles ring length, snooze and
  per-reminder integrations. App Nap is suppressed while alarms are scheduled;
  system sleep is still allowed. This app does not wake a sleeping Mac or
  install a login item/daemon. Saved future alarms are rearmed when relaunched.
- Default and missing-file fallback use the bundled classic beep. Selected
  supported local files and built-in sounds use AVAudioPlayer. Radio uses an
  AVPlayer with the local backup audible when the stream is not playing.
- Per-alarm app volume and fade are supported. macOS output volume/mute still
  apply; the backend does not change system volume or provide vibration.
- External music links can open their applications. Automatic playback and
  pause in those applications are not supported by this Mac bridge, so the
  local alarm backup remains active. Do not claim Spotify/YouTube direct play.

## Other services

Native calendars use a read-only EventKit bridge. Permission is requested only
through the user's calendar-connect action; code exposes no event write API.
The existing sync, Pushover, Tuya, weather, sound import and recording code is
shared. Building or launching does not prove provider authentication, delivery
or hardware control. Tuya consumer-account login remains a separate blocked
provider integration; the personal developer-project mode is retained.

## Verification

Run strict formatting, `flutter analyze`, the full Flutter test suite, and the
edition/home tests with `QUANDO_EDITION=kodesh` and `QUANDO_EDITION=mine`.
`test/features/mac_platform_test.dart` exercises calendar permission/error
propagation, recurring event identity and the native ring callback through
automatic stop. It uses a fake host and does not prove audible native playback.
Validate the installed app by a normal Applications launch and an actual local
alarm, including hiding/reopening the window and relaunching saved settings.
