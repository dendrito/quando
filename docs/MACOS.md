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
set `QUANDO_MAC_TEAM` to its existing team. Manual signing also needs
`QUANDO_MAC_SIGNING_IDENTITY` set to an existing signing identity.
The script neither installs nor publishes the result. These builds are not
notarized public releases.

Google's Mac SDK requires its keychain-sharing group. The runner retains the
edition's own default group and adds the Google SDK group. Team-signed local
builds use the team's App ID prefix; `QUANDO_MAC_APP_IDENTIFIER_PREFIX` can
override it for an account whose prefix differs from its team ID. Real Google
sign-in and device sync still require acceptance testing; signing metadata alone
does not prove authentication or cross-device behavior.

The keychain entitlement requires a macOS provisioning profile. Set
`QUANDO_MAC_PROVISIONING_PROFILE` to an existing compatible profile, or set
`QUANDO_MAC_AUTOMATIC_SIGNING=true` to let Xcode obtain a development profile
using the account already signed in to Xcode. This does not enroll in a paid
program or publish the app. An iOS profile does not provision the native Mac app.
Automatic signing defaults to the `Apple Development` identity type; do not
override it with a certificate fingerprint, which Xcode treats as manual signing.

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
- The gentle recordings have matching AAC `.m4a` copies because the system
  decoder does not accept their `.ogg` originals. Mac preview and alarm playback
  use these copies, preserving saved sound IDs/paths and all original credits.
  Regenerate them with `tool/prepare_mac_sounds.sh` when changing the recordings.
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
