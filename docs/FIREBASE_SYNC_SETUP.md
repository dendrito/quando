# Firebase Sync Security Setup

Quando sync stores one document per Firebase Authentication user at
`users/{uid}`. The client-side Firebase configuration in
`lib/features/sync/sync_config.dart` identifies the project; it is not an
authorization boundary. Firestore Security Rules are the authorization
boundary.

## Fail-closed rules

The repository's `firestore.rules` intentionally contains the placeholder
`REPLACE_WITH_OWNER_FIREBASE_AUTH_UID`. With that value unchanged, all
client access is denied. Do not replace it with a broad condition such as
`request.auth != null`.

Before enabling sync:

1. Open Firebase Console → Authentication → Users.
2. Identify the one owner account that is allowed to use this private sync.
3. Copy that account's Firebase Authentication UID (not its email address).
4. Replace the placeholder in `firestore.rules` with that exact UID.
5. Review the rules and confirm that reads and writes are restricted to
   `users/{that-same-uid}` and that the token must have a verified email.
6. Deploy from the repository root using an authorized Firebase CLI session:

   ```sh
   firebase deploy --only firestore:rules --project quando-27c24
   ```

7. In Firebase Console → Firestore Database → Rules, verify that the deployed
   rules match the reviewed repository file. Also test that:
   - the owner can read and write only their own `users/{uid}` document;
   - a different authenticated UID is denied;
   - an unverified account is denied;
   - unauthenticated access is denied;
   - every other collection/document is denied.

Do not enable sync in production until these checks pass. The repository
cannot prove which rules are currently deployed in the Firebase project.

## Data model and privacy

The app writes one document per account. The `items` map contains settings
that are intended to follow the account between devices. Device-local audio
files, native calendar selections, Spotify/YouTube sign-ins, and the entire
`integrations` preference are not synced.

At Leandro's explicit request (6 November 2026), the separate
`pushover.credentials` item shares only the Pushover user key and application
token across Quando? and Matai? devices signed in to the same authorized
account. Existing complete keys join on sign-in; Connections also offers a
sharing button, and a successful Pushover test queues the pair. Receiving keys
does not enable Pushover or change local sound, destination devices, priority,
Shabbat pause settings or webhooks. Account ownership is checked before applying
received keys; switching accounts clears the active pair and restores only that
account's local cache. Clearing local fields does not revoke a previously shared
pair; revoke compromised tokens at Pushover and share the replacement.

The key pair is stored inside the private Firestore account document. This is
not end-to-end encryption. The deployed owner-only access policy still needs
verification; this feature does not deploy or broaden those rules. All other
provider secrets, OAuth refresh tokens and webhook URLs remain excluded from
the synchronized settings list.

The current app stores Pushover credentials and webhook URLs in ordinary
SharedPreferences on each device. Before production release, migrate these
values to platform secure storage and add a migration path. Device-local does
not mean encrypted-at-rest by the app.

## Revision ordering

Firestore writes run in a transaction. Each successful transaction assigns
one monotonically increasing revision to the changed settings in that batch.
The revision is stored on each item and at document level. Existing item
timestamps are used only to seed the revision counter during migration from
the earlier client-timestamp format. This makes the server's accepted write
order authoritative rather than relying on device clocks.
