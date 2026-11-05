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
files, native calendar selections, and Spotify/YouTube sign-ins are not
synced. Do not add API keys, OAuth refresh tokens, or other credentials to
the synchronized settings list.

## Revision ordering

Firestore writes run in a transaction. Each successful transaction assigns
one monotonically increasing revision to the changed settings in that batch.
The revision is stored on each item and at document level. Existing item
timestamps are used only to seed the revision counter during migration from
the earlier client-timestamp format. This makes the server's accepted write
order authoritative rather than relying on device clocks.
