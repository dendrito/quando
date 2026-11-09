# Quando Tuya relay (free server)

Lets Quando users link their Smart Life / Tuya Smart account with only their
Smart Life country, email or phone and password. The Tuya Cloud Project keys stay on
a small Cloudflare Worker; the app never contains a Tuya key.

## How it works

1. The user signs in to Quando (Google or email, as for sync). The app sends that
   sign-in token with every request, and the Worker checks it (right project, not
   expired, email verified).
2. The user enters Smart Life country code, email/phone and password. They go to the
   Worker once over HTTPS. The Worker signs in to Tuya with the project keys, keeps
   **only the Tuya user id** (tied to the Quando account) and forgets the password.
3. The app lists the user's scenes and runs the one attached to an alarm through the
   Worker. A scene only runs if its home belongs to that user's own Tuya account.
4. At most 5 sign-in attempts per user per hour.

## Open question: account linking

Tuya's documents say an app account must be linked to the Cloud Project (QR scan in the
Tuya console) before it can be used, and describe no API for linking. Whether the
sign-in call links the account is untested. Until Tuya answers (or a real account test
shows it works), the relay may only work for accounts you linked in the console.
Google/Apple-only Smart Life accounts have no password, so Tuya's password sign-in
doesn't apply to them until they set one (Forgot Password in Smart Life).

## Deploy (once)

Needs a free Cloudflare account and Node.js 20+. Do not paste the keys in chat.

```sh
cd workers/tuya-relay
npm install
npx wrangler login
npx wrangler kv namespace create LINKS      # copy the id into wrangler.toml
npx wrangler secret put TUYA_ACCESS_ID
npx wrangler secret put TUYA_ACCESS_SECRET
# set TUYA_HOST in wrangler.toml to your project's data center, e.g. openapi.tuyaus.com
npx wrangler deploy
```

Wrangler prints the Worker address (`https://quando-tuya-relay.<you>.workers.dev`).
In Quando: Connections > Tuya > Advanced setup > relay address, or build the app with
`--dart-define=QUANDO_TUYA_RELAY=https://...`.

Tests: `cd workers/tuya-relay && npm test`.

## Limits and costs

Cloudflare's free plan (check current numbers) allows about 100,000 Worker requests a
day and a small KV allowance; scene triggers use a handful of requests each. Tuya's
free Trial plan prohibits commercial use and allows 26k API calls a month and 50
devices, so a public launch needs the right Tuya edition. The Tuya account's region must
match the project's data center.

## Message sent to Tuya support (2026-11-09)

See the thread; it asks about linking without the console, Google/Apple sign-in,
same-phone authorization and the edition needed for a free public app.
