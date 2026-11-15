# Quando beta dashboard

Private page for the beta: signups, feedback, crashes and the five launch numbers. Process: `beta-program/follow-up-process.md` (project files).
No tester data is in this repo. It lives in Cloudflare D1.

- `/admin/` the dashboard. Needs a Cloudflare Access login, and the functions also check the Access token (fail closed).
- `POST /api/signup` `{email, platform: android|iphone|ipad|mac}` for the quando.day/beta form.
- `POST /api/feedback` `{kind: bug|idea|love|survey, body, platform?, version?, contact?}`. Survey body is `very|somewhat|not`.
- `POST /api/event` `{install_id, type: install|first_alarm|open|crash, platform?, version?, detail?}`, opt-in, anonymous.

## Setup (once)
1. `npx wrangler d1 create quando-beta`, put the id in `wrangler.toml`, then `npx wrangler d1 execute quando-beta --remote --file schema.sql`.
2. Cloudflare Pages: new project `quando-beta` from this repo, root `beta`, no build command, output `public`. Bind D1 as `DB`. Domain `beta.quando.day`.
3. Zero Trust > Access > Applications: self-hosted, `beta.quando.day/admin*`, policy: only your email. Copy the Audience tag.
4. Pages variables: `ACCESS_AUD` (the tag) and `ACCESS_TEAM_DOMAIN` (`<team>.cloudflareaccess.com`).
