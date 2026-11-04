# Play Store checklist

What to fill in on the Play Console for Quando. Store texts are in
`fastlane/metadata/android/en-US/`, and the privacy policy is
`docs/privacy-policy.md`.

## Before you start

1. Create a Google Play developer account (one-time US$25 fee, ID check):
   https://play.google.com/console/signup
2. Make the privacy policy reachable at a public web address. Google and
   YouTube verification both ask for that link.
3. Save the upload key in GitHub's secrets so CI signs the store bundle.
   Claude walks you through this when the account is ready.

## App details

- App name: Quando: Alarms & Shabbat
- Default language: English (United States)
- App or game: App. Free.
- Category: Tools. Tags: Alarm clock, Calendar, Religion.
- Package name: com.dendrito.alarmapp

## App content

**Privacy policy:** the public link to `docs/privacy-policy.md`.

**Ads:** No, the app has no ads.

**App access:** All features work without signing in. Spotify and YouTube
need the user's own account, which is optional.

**Content rating questionnaire:** category "Utility, productivity,
communication or other". Answer No to violence, sexuality, language,
controlled substances and gambling. Users can't chat or share content with
each other. Expected rating: Everyone / PEGI 3.

**Target audience:** 18 and over (keeps the app out of the Families
programme, which has extra rules). Not designed for children.

**Data safety:**

- Does the app collect or share user data? Answer **No**. Everything stays
  on the phone, and what is sent (radio searches, Pushover and webhook
  messages, Spotify and Google sign-in) goes only to services the user turns
  on and controls. Google's definition treats data sent at the user's request
  to a service they chose as not "shared".
- Is data encrypted in transit? Yes (HTTPS), except some radio streams that
  only exist over http.
- Can users ask for their data to be deleted? Nothing is held off the phone;
  uninstalling deletes it.

**News app, health, financial, government:** No to all.

## Permission declarations

The Console asks about these when the first bundle is uploaded:

| Permission | Answer |
| --- | --- |
| USE_EXACT_ALARM / SCHEDULE_EXACT_ALARM | Core function: Quando is an alarm clock. Choose "Alarm clock". |
| USE_FULL_SCREEN_INTENT | Core function: shows the ringing alarm over the lock screen. Choose "Alarm clock". |
| FOREGROUND_SERVICE_MEDIA_PLAYBACK | Plays the alarm sound and online radio while ringing. Record a short video of an alarm ringing for the form. |
| REQUEST_IGNORE_BATTERY_OPTIMIZATIONS | Alarms must ring on time even when the phone saves battery; the "Ready to ring" screen asks for it only when the user taps Fix. |
| READ_CALENDAR / WRITE_CALENDAR | Calendar alarms read events to ring around them. Quando never writes events; the calendar plugin needs both. |
| RECORD_AUDIO | Recording your own alarm sound. |
| CAMERA | "Scan a code" to stop an alarm. |

## Store graphics

- App icon 512 × 512 (from the Q-hand logo).
- Feature graphic 1024 × 500.
- At least 2 phone screenshots (Claude makes these from the app).

## Release

Start with **Internal testing**, then **Closed testing**. New personal
developer accounts must run a closed test with at least 12 testers for 14
days before they can publish to everyone.
