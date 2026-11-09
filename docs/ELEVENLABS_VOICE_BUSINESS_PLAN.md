# ElevenLabs Voice Experience — Business Plan

Status: Deferred to M6; not part of the initial release.

## Executive summary

Quando should eventually offer optional, premium-quality spoken reminders using ElevenLabs. This is an enhancement for users who want custom voices and natural announcements, not a requirement for ordinary alarms. The feature should be considered only after the core alarm, calendar, and per-reminder sound experience is stable.

## Customer value

- Speak an event title, countdown, or custom instruction at a selected reminder time.
- Use a selected supported language and voice.
- Let users choose a voice per reminder or set a default.
- Preview speech before saving.
- Generate audio ahead of time and replay it from local storage, including offline.

## Product packaging

### Free/core
- Device text-to-speech using installed phone voices.
- Built-in sounds and user-imported recordings.
- No ElevenLabs account, API key, or subscription required.

### Quando Premium (proposed)
- ElevenLabs voice catalog and voice selection.
- Custom announcement text and event-aware templates.
- Preview, generation, local caching, and a monthly character allowance.
- Per-reminder voice choice and a usage meter.

### Advanced bring-your-own-key (optional)
- For users who already have ElevenLabs and want to pay the provider directly.
- Never make API-key setup part of ordinary onboarding.
- Never embed keys in the mobile app binary, logs, analytics, or synced settings.

Manual audio import remains available to everyone. Users can generate an audio file themselves and import it without connecting an account. Generated audio files are not the same thing as downloadable voice models; do not promise model export unless ElevenLabs explicitly supports it.

## Recommended business model

Start with a bounded Quando Premium allowance, not unlimited AI speech.

Pricing hypotheses to test:
- Free: device TTS and imported audio; no platform-funded ElevenLabs generation.
- Premium: test an included allowance of 10,000 characters/month.
- Optional prepaid top-ups may be considered later if provider terms and billing support them.
- BYOK remains an advanced opt-in option.

Do not commit to an expensive enterprise plan or promise unlimited generation before real demand and usage distribution are known.

## Cost model

The official ElevenLabs API pricing page currently lists approximate pay-as-you-go rates:
- Flash/Turbo: US$0.05 per 1,000 characters.
- Multilingual v2/v3: US$0.10 per 1,000 characters.

These are planning assumptions, not guaranteed future prices. Recheck rates, model availability, credit accounting, taxes, and commercial terms before M6.

Example usage: 3 announcements/day × 100 characters × 30 days = 9,000 characters/user/month.

| Monthly characters per user | Flash/Turbo | Multilingual |
|---:|---:|---:|
| 3,000 | $0.15 | $0.30 |
| 9,000 | $0.45 | $0.90 |
| 10,000 | $0.50 | $1.00 |
| 20,000 | $1.00 | $2.00 |

At 9,000 characters per user/month:

| Monthly voice users | Flash/Turbo | Multilingual |
|---:|---:|---:|
| 100 | $45 | $90 |
| 500 | $225 | $450 |
| 1,000 | $450 | $900 |
| 5,000 | $2,250 | $4,500 |

Estimates exclude retries, taxes, backend hosting, storage, support, payment processing, app-store fees, and unused subscription capacity. Actual billing depends on the selected model, plan, credit rules, and provider terms. These current rates supersede older rough estimates of $0.04/$0.08 per 1,000 characters.

A 10,000-character allowance therefore represents approximately $0.50 of Flash/Turbo generation or $1.00 of Multilingual generation at the listed rates, before all other costs.

### Cost controls and pricing guardrails

- Monthly per-account character quotas and maximum text length.
- Per-user request throttles and abuse controls.
- Global monthly provider budget, alerts, and emergency kill switch.
- Generate ahead of the alarm, never during alarm playback.
- Cache generated speech and reuse it where privacy and account permissions allow.
- Make the premium price high enough to cover provider usage, hosting, payment fees, support, and a target contribution margin.
- Model median and 95th-percentile usage before deciding the final allowance and price.

## Technical and operational model

Use a trusted backend for platform-funded generation:
1. The app requests speech for a particular reminder.
2. The backend verifies the user's entitlement, quota, text length, and voice authorization.
3. The backend calls ElevenLabs using a server-side secret.
4. Generated audio is stored privately and linked to a generation record.
5. The app downloads and caches it locally.
6. The alarm scheduler plays the cached file offline.

Suggested components:
- SpeechProvider abstraction for device TTS, imported files, and generated speech.
- Backend speech-generation service.
- Entitlement and usage ledger with idempotency to prevent duplicate charges.
- Private audio storage, retention/deletion controls, and cache invalidation.
- Voice selection/catalog integration.

The alarm scheduler must not depend on Firebase, ElevenLabs, or internet access. If generation or download fails, fall back to device TTS or a selected local sound.

## Rights, privacy, and provider dependency

- Require users to have rights and consent for any voice they connect, clone, or upload.
- Do not enable impersonation or cloning of another person without required authorization.
- Review ElevenLabs API terms, commercial-use permissions, voice-cloning rules, data-processing terms, and deletion obligations before launch.
- Clearly explain what reminder text is sent to ElevenLabs.
- Send no calendar/event text until the user explicitly enables speech generation.
- Provide deletion for generated audio and stored voice references.
- Keep provider changes from breaking already-cached alarms.

## Validation and go-to-market

Before implementation:
1. Interview users about spoken reminders and custom voices.
2. Prototype voice preview and per-reminder voice selection.
3. Measure opt-in rates and monthly character consumption.
4. Test willingness to pay for a bounded allowance.
5. Run a small opt-in beta for pronunciation, languages, latency, and voice rights.
6. Launch behind a feature flag with conservative quotas and spending limits.

Success metrics:
- Share of active users enabling spoken reminders.
- Share choosing premium generation over device TTS/imported audio.
- Median and 95th-percentile characters per paying user/month.
- Generation success rate and median latency.
- Cache reuse rate.
- Cost per paying user and contribution margin.
- Paid conversion, retention, and support/complaint rate.
- Successful offline playback of cached speech.

## Risks and mitigations

| Risk | Mitigation |
|---|---|
| Provider costs exceed revenue | Quotas, usage dashboard, spend caps, no unlimited plan |
| API/network failure | Pre-generate, cache locally, fallback to device TTS/local sound |
| Voice misuse | Consent requirements, reporting, deletion path |
| Privacy concerns | Explicit opt-in, minimum text sent, private storage, retention controls |
| Vendor changes | Provider abstraction, price reviews, retain local audio |
| Duplicate generation charges | Idempotency, usage ledger, cache keys |

## M6 scope and acceptance criteria

M6 starts only after M0–M5 are complete and the core reminder experience is stable.

Deliverables:
- Validate demand, provider terms, packaging, and unit economics before coding.
- Backend-mediated ElevenLabs integration with server-side credentials.
- Optional voice selection and consent flow.
- Per-reminder spoken text and voice settings.
- Preview, generation, caching, quota display, and usage controls.
- Offline playback and fallback.
- Billing/entitlement integration only if premium packaging is validated.
- Privacy, security, deletion, and abuse controls.
- Beta metrics and a launch/rollback decision.

Exit criteria:
- No API call is required when an alarm rings.
- Cached speech works offline.
- Every generation is authenticated, authorized, quota-checked, and auditable.
- Provider credentials never ship in the app.
- Server-side usage and spend caps are enforced.
- The price has positive contribution margin under measured high-percentile usage.
- Voice rights, consent, privacy, and provider terms have been reviewed.
- Device TTS and imported audio remain available without subscription.

## References

- [ElevenLabs API pricing](https://join.elevenlabs.io/api/developer-api)
- [ElevenLabs plans and product pricing](https://elevenlabs.io/pricing)

Provider prices and terms change; recheck them before M6 implementation.
