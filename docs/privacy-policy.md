# Quando and Matai privacy policy

_Development policy updated 6 November 2026. Contact and cloud deletion procedures must be finalized before public release._

Quando is an alarm and reminder app. Matai is its Jewish edition; Quando Mine is a private edition. Local alarms work without an account. The current apps contain no advertising or analytics SDK and do not sell user data.

## Local information

Alarms, preferences, recorded/imported sounds and cached schedules are stored on your device. Calendar access reads events to create reminders. Scanning a stop code uses the camera locally without saving a picture. Recording uses the microphone while recording. Optional foreground location finds a local city; there is no background location tracking. The precise local location entry is excluded from configuration sync.

## Optional account sync

If enabled, Google sign-in identifies your Firebase account. Configuration selected by the app's sync allowlist, including alarms, settings, selected catalog city, home display and learning preferences, is stored in Google Firebase Firestore and received by your signed-in devices. Recorded/imported audio files and calendar event caches are not uploaded by configuration sync. Jewish preferences can reveal religious interests.

Account-bound connection sharing can include Pushover keys, Tuya credentials, Spotify library refresh credentials and webhook URLs. Google/YouTube native sessions and Spotify App Remote sessions are not copied. New received home automation hooks remain disabled until enabled on that device. The current development implementation uses local preferences and private cloud records; it does not provide end-to-end encryption. Public release requires secure-storage migration and verification of deployed account-isolation rules. Do not describe private records as a guarantee against service-operator access.

## Optional external services

- Pushover receives your keys and alarm title/message for requested notifications and tests. A title may contain calendar-event information.
- Webhooks, including Home Assistant, Node-RED, Zapier and IFTTT, receive alarm-event details at the address you configure. URLs may contain credentials.
- Tuya receives signed account requests to list homes/scenes and run the scene you select. Scene names/identifiers are saved for selection and can accompany synchronized alarm settings. Smart-home execution is enabled separately on each device.
- Spotify receives its sign-in/library/playback requests. Google/YouTube receives sign-in and read-only playlist/liked-video requests. Song links open in their owning app. Provider and OS restrictions still apply.
- Radio Browser receives station searches/filters; your chosen station receives the stream request.
- MET Norway receives coordinates rounded to two decimal places when you opt into weather and view that page while the app is active. Forecasts are cached locally. Network services also receive ordinary request metadata such as IP address and app identification.
- Hebcal receives date ranges and the Israel/diaspora setting for selected daily learning schedules. It does not receive coordinates, credentials or a user account from this feature. Schedules are cached locally. Opening a reading link contacts that source directly. Daf Yomi alone can be calculated offline.

Each provider has its own privacy policy. Google's API information is used only for the requested library/calendar experience, consistent with the [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy), including Limited Use. Playlist contents are not uploaded by configuration sync or used for advertising.

## Disconnecting and deletion

Disable an optional feature to stop future requests from it; a request already in progress may finish. Disconnect connections in the app and revoke provider permissions at [Google account permissions](https://myaccount.google.com/permissions) or [Spotify apps](https://www.spotify.com/account/apps/). Signing out stops account sync on that device; it does not delete cloud records or revoke every external credential. Uninstalling does not delete cloud records, other devices' copies, provider accounts or credentials. Device backups may retain local data according to OS settings. A verified cloud-data deletion procedure and retention period remain required before public release.

## Children and contact

The app is not directed at children. Before public release, replace this development contact requirement with the verified operator name and support contact in the store listing and this policy. Publish future changes with a new date.
