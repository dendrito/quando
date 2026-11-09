# Quando Roadmap

Milestones are ordered by dependency. Basic alarms must remain independent of network services and paid providers.

## M0 — Repository and architecture audit

**Status: audit and code review substantially complete; production sign-off remains gated.**

- [x] Audit the current app, open pull requests, platform setup, and CI workflow.
- [x] Document provider boundaries and the rule that local alarms cannot depend on network services.
- [x] Fix the sync engine's premature local acknowledgement of failed uploads.
- [x] Serialize sync operations and use Firestore transaction revisions instead of device wall clocks.
- [x] Add fail-closed Firestore rules and document the owner-only deployment procedure.
- [x] Exclude the full integrations preference from cloud sync because it contains Pushover credentials and potentially secret webhook URLs.
- [ ] Confirm the owner Firebase Auth UID, replace the rules placeholder, deploy the rules, and verify the deployed policy.
- [ ] Get green CI for the revised sync branch.
- [ ] Reconcile PR #5 with the updated sync/Google OAuth base after PR #4 is reviewed.
- [ ] Move Pushover credentials and webhook URLs from ordinary SharedPreferences into platform secure storage before production release.

- Audit the app, open pull requests, platform behavior, and tests.
- Confirm provider boundaries and document limitations.
- Resolve integration conflicts before new feature work.

## M1 — Reliable alarm foundation
- Make scheduling, stable IDs, duplicate prevention, recurrence, and replanning dependable.
- Handle app resume, reboot, time-zone/DST changes, permissions, and platform restrictions.
- Make ring-duration enforcement robust when the app process is terminated.
- Keep local alarms independent of authentication, sync, calendar APIs, and internet access.
- Test on physical Android and iOS devices.

## M2 — Calendar integrations
- Support native phone calendars on Android and iOS.
- Support direct Google Calendar OAuth independently of phone-calendar sync.
- Persist event cache and define stale-data behavior.
- Deduplicate using stable source/account/calendar/event identifiers, not display names alone.
- Handle recurring, changed, and cancelled events.
- Keep alarms working when a calendar provider is unavailable.

## M3 — Sound and notification integrations
- Preserve built-in sounds and local audio uploads/recordings.
- Support per-reminder source selection rather than one global sound for an event.
- Integrate Pushover as an optional notification provider, with account connection, sound discovery, and per-reminder sound selection.
- Support Spotify selection/playback or official-app handoff within platform/API restrictions.
- Support YouTube discovery and official-app handoff; do not extract streams or bypass restrictions.
- Add radio stations and imported audio as selectable sources, with clear online/offline behavior.
- Distinguish notification delivery (Pushover) from audio playback (Quando/local, Spotify, YouTube, radio).

## M4 — Unified event-to-reminder experience
- Select an event, define multiple lead times, and configure an independent action/audio source for each reminder.
- Allow optional spoken event titles, countdowns, and user-authored announcement text.
- Provide a consistent editor and preview across calendar events and custom alarms.
- Preserve local fallback behavior when remote providers are unavailable.

## M5 — Release readiness
- Complete Android/iOS permission, background execution, alarm, calendar, audio, and OAuth testing on real devices.
- Resolve reliability, accessibility, localization, privacy, security, and performance issues.
- Document provider limitations, onboarding, troubleshooting, and recovery paths.
- Validate backup/sync without making cloud availability a condition for ringing.
- Prepare release builds, store materials, support processes, and monitoring.

## M6 — Premium Voice Experience (deferred)
**Planned for later; explicitly out of scope for the initial release.**
- Keep device text-to-speech and imported audio available without an ElevenLabs account or subscription.
- Validate demand, willingness to pay, provider terms, and unit economics before implementation.
- Offer optional ElevenLabs generation through a trusted backend; never require ordinary users to paste an API key.
- Allow voice selection and custom spoken text per reminder, with preview and explicit consent.
- Generate speech ahead of alarm time, cache it locally, and play it offline.
- Introduce a bounded premium character allowance only if measured costs and conversion support it.
- Optionally support advanced bring-your-own-key users without exposing credentials in the app.
- Enforce quotas, rate limits, spend caps, privacy/deletion controls, and voice-consent requirements.
- Preserve device TTS and imported recordings as fallbacks.

Detailed commercial model, cost assumptions, packaging, safeguards, and acceptance criteria: [ElevenLabs Voice Business Plan](ELEVENLABS_VOICE_BUSINESS_PLAN.md).

## Cross-cutting architecture principles
- Keep AlarmScheduler independent from calendar, music, notification, sync, and speech providers.
- Isolate integrations behind provider interfaces; keep credentials out of domain models.
- Treat remote audio generation and streaming as optional; prefetch/cache whenever possible.
- Do not promise unsupported background playback or bypass third-party restrictions.
- Test failure modes, not only happy paths.
