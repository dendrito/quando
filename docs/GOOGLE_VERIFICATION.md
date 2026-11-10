# quando.day: Cloudflare and Google setup

The website lives in `site/` (home, privacy, terms). These are the clicks only the account owner can do. Do them in this order.

## A. Cloudflare (about 10 minutes)

1. **Publish the site.** Cloudflare dashboard → Workers & Pages → Create → Pages → Connect to Git → pick `dendrito/quando`. Branch `main`, framework none, build command empty, **build output directory `site`**. Save and deploy. (Merge the website pull request first, or the folder does not exist on `main`.)
2. **Attach the domain.** Open the new Pages project → Custom domains → Set up a custom domain → `quando.day`. Because the domain is already on Cloudflare, it adds the DNS record for you. Also add `www.quando.day` if you like.
3. **Make the support address work.** Domain `quando.day` → Email → Email Routing → Get started → create `support@quando.day` that forwards to your own mailbox, and confirm the verification email. The pages tell people to write to this address, and Google wants a reachable contact.
4. Check `https://quando.day`, `/privacy` and `/terms` open in a private window.

## B. Prove you own the domain to Google

5. Go to https://search.google.com/search-console → Add property → **Domain** → `quando.day`.
6. It shows a TXT record. In Cloudflare: DNS → Records → Add → type TXT, name `@`, content the text Google gave → Save. Back in Search Console press Verify (can take a few minutes).
7. Use the **same Google account** that owns the Google Cloud project "Quando". Google only accepts domains verified by a project Owner or Editor.

## C. Google Cloud: consent screen ("Google Auth Platform")

Project "Quando": https://console.cloud.google.com/auth

8. **Branding.** App name `Quando?`, user support email `support@quando.day`, upload the app logo (120x120 px), App home page `https://quando.day`, Privacy policy `https://quando.day/privacy/`, Terms `https://quando.day/terms/`, Authorized domain `quando.day`, developer contact email. Save.
9. **Audience.** User type External. While status is *Testing*, only listed test users (max 100) can sign in and tokens expire after 7 days. That is fine until launch. Press **Publish app** when you submit for verification.
10. **Data Access → Add or remove scopes.** Add:
    - `openid`, `.../auth/userinfo.email`, `.../auth/userinfo.profile` (basic, no review)
    - `https://www.googleapis.com/auth/calendar.readonly` (sensitive)
    - `https://www.googleapis.com/auth/youtube.readonly` (sensitive)
    These are exactly the scopes the app requests. Do not add more than the app uses; Google rejects extras.
11. Make sure **Google Calendar API** and **YouTube Data API v3** are enabled (APIs & Services → Library).
12. **Firebase project `quando-27c24`:** if Google sign-in runs on this project's OAuth client, repeat steps 8 to 10 in that project too (Cloud console project picker, same id). Then in Firebase console → Authentication → Settings → Authorized domains, add `quando.day`.

## D. Submit for verification

13. Google Auth Platform → **Verification Center** → Prepare for verification. Brand verification is quick once steps 5 to 8 are done. Scope verification (calendar, YouTube) takes days to a few weeks.
14. For each sensitive scope Google asks "why do you need it". Paste:
    - Calendar: "Quando is an alarm clock. The user picks one of their Google calendars and Quando reads its events (read-only) so the user can create alarms before, at or after an event and see the next event. Events are read on the device, not stored on our servers, and never modified."
    - YouTube: "Quando lets the user pick a YouTube playlist or liked videos as their alarm sound. It reads the user's playlists and liked videos (read-only) to show a list in the app. Nothing is stored on our servers or used for ads."
15. **Demo video** (unlisted YouTube link, English): show the app, press Sign in with Google, show the consent screen with the browser address bar and the client ID visible, then show where each scope is used in the app (calendar picker making an alarm, YouTube playlist picker). Claude can write a shot list when you are ready to record.
16. Answer questions from Google's reviewers by email promptly; most delays come from missing replies.

## E. Elsewhere

- Play Console → App content → Privacy policy: `https://quando.day/privacy/`.
- Matai? gets its own domain, site and publisher later; nothing Jewish-specific is on quando.day.

## Hosting note

quando.day is served by Cloudflare Pages from `site/`. The project board stays on GitHub Pages at `https://dendrito.github.io/quando/`. Do **not** set a custom domain in GitHub's Pages settings, or the board would redirect to quando.day.
