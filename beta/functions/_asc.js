// Dormant until ASC_KEY_ID, ASC_ISSUER_ID, ASC_PRIVATE_KEY (.p8 text) and ASC_GROUP_ID are set as Pages secrets.
// Then "Add" on an iPhone, iPad or Mac tester also invites them to that TestFlight group.
const b64 = (b) => btoa(String.fromCharCode(...new Uint8Array(b))).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
const enc = (o) => b64(new TextEncoder().encode(JSON.stringify(o)));

export const ascReady = (env) => !!(env.ASC_KEY_ID && env.ASC_ISSUER_ID && env.ASC_PRIVATE_KEY && env.ASC_GROUP_ID);

async function token(env) {
  const der = Uint8Array.from(atob(env.ASC_PRIVATE_KEY.replace(/-----[^-]+-----|\s/g, "")), (c) => c.charCodeAt(0));
  const key = await crypto.subtle.importKey("pkcs8", der, { name: "ECDSA", namedCurve: "P-256" }, false, ["sign"]);
  const head = enc({ alg: "ES256", kid: env.ASC_KEY_ID, typ: "JWT" });
  const body = enc({ iss: env.ASC_ISSUER_ID, exp: Math.floor(Date.now() / 1000) + 600, aud: "appstoreconnect-v1" });
  const sig = await crypto.subtle.sign({ name: "ECDSA", hash: "SHA-256" }, key, new TextEncoder().encode(head + "." + body));
  return head + "." + body + "." + b64(sig);
}

// Returns true when Apple accepted the invite (a tester that already exists counts as done).
export async function inviteToTestFlight(env, email) {
  const r = await fetch("https://api.appstoreconnect.apple.com/v1/betaTesters", {
    method: "POST",
    headers: { authorization: "Bearer " + (await token(env)), "content-type": "application/json" },
    body: JSON.stringify({
      data: {
        type: "betaTesters",
        attributes: { email },
        relationships: { betaGroups: { data: [{ type: "betaGroups", id: env.ASC_GROUP_ID }] } },
      },
    }),
  });
  return r.ok || r.status === 409;
}
