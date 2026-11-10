# Merging the two Google Cloud projects

Goal: one Google Cloud project, `quando-27c24` (the Firebase project, consent screen already in production), for every platform. The older `quando-513703` is retired only after Android sign-in is confirmed on a real phone. No secrets here; client IDs and package names are public identifiers.

Dates UTC. Newest at the bottom. Also see the shared setup log.

## Code changes
- 2026-11-10: `YouTubeAccount.init()` always passes `SyncConfig.webClientId` (the `quando-27c24` web client) as `serverClientId`. The old constant pointing at `quando-513703` is removed. Android now asks Google for one token that both Firebase sign-in and YouTube/Calendar use. Not part of the Thursday release candidate unless tested on an Android phone first.

## Console changes
- 2026-11-10 16:0x Firebase (quando-27c24) > Project settings: added the existing Android SHA-1 (the one the old `quando-513703` clients use, ending ...D4:1A) to the Android apps `com.dendrito.alarmapp` and `com.dendrito.quando.kodesh`. Firebase accepted it.
- 2026-11-10 16:1x Checked APIs on quando-27c24: YouTube Data API v3 and Google Calendar API are already enabled.
- 2026-11-10 16:1x Tried to create the Android OAuth client for `com.dendrito.alarmapp` in quando-27c24 by hand. Google refused: the package + fingerprint pair is already in use (it is registered in `quando-513703`, and a pair can live in only one project). No Android clients for alarmapp/kodesh were auto-created either, for the same reason.
- Blocker: to move, the Android clients "Quando Android" and "Matai" must first be deleted from `quando-513703` (restorable for 30 days), which breaks Google sign-in on any Android build made before PR #33 until it is updated.

## Still to do
1. In `quando-27c24`: register Android OAuth clients (package + SHA-1, including Play app-signing key) for Quando (`com.dendrito.alarmapp`) and Matai (`com.dendrito.quando.kodesh`). Firebase already lists the Android apps; check their SHA-1s are present.
2. Enable YouTube Data API v3 and Google Calendar API in `quando-27c24`.
3. Test on a real Android phone: Google sign-in, YouTube playlists, calendar picker.
4. Retire `quando-513703` (shut down project, 30-day undelete window).
