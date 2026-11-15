import { json } from "../../_lib.js";
// POST {id}  invite a tester to TestFlight through the App Store Connect API.
// Needs Pages secrets: ASC_KEY_ID, ASC_ISSUER_ID, ASC_PRIVATE_KEY (the .p8 text), ASC_GROUP_ID (beta group id).
// Without them it answers 501 and the dashboard keeps the manual "Mark added" flow.
const b64u = (buf) => btoa(String.fromCharCode(...new Uint8Array(buf))).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
const enc = (o) => b64u(new TextEncoder().encode(JSON.stringify(o)));

async function ascToken(env) {
  const pem = env.ASC_PRIVATE_KEY.replace(/\\n/g, "\n").replace(/-----[A-Z ]+-----/g, "").replace(/\s+/g, "");
  const key = await crypto.subtle.importKey("pkcs8", Uint8Array.from(atob(pem), (c) => c.charCodeAt(0)), { name: "ECDSA", namedCurve: "P-256" }, false, ["sign"]);
  const iat = Math.floor(Date.now() / 1000);
  const head = enc({ alg: "ES256", kid: env.ASC_KEY_ID, typ: "JWT" });
  const pay = enc({ iss: env.ASC_ISSUER_ID, iat, exp: iat + 600, aud: "appstoreconnect-v1" });
  const sig = await crypto.subtle.sign({ name: "ECDSA", hash: "SHA-256" }, key, new TextEncoder().encode(head + "." + pay));
  return head + "." + pay + "." + b64u(sig);
}

export async function onRequestPost({ request, env }) {
  if (!(env.ASC_KEY_ID && env.ASC_ISSUER_ID && env.ASC_PRIVATE_KEY && env.ASC_GROUP_ID)) return json({ ok: false, error: "not configured" }, 501);
  const b = await request.json().catch(() => ({}));
  const s = await env.DB.prepare("SELECT id, email, platform FROM signups WHERE id=?").bind(Number(b.id)).first();
  if (!s) return json({ ok: false }, 404);
  if (!["iphone", "ipad", "mac"].includes(s.platform)) return json({ ok: false, error: "not an Apple device" }, 400);
  const r = await fetch("https://api.appstoreconnect.apple.com/v1/betaTesters", {
    method: "POST",
    headers: { authorization: "Bearer " + (await ascToken(env)), "content-type": "application/json" },
    body: JSON.stringify({ data: { type: "betaTesters", attributes: { email: s.email }, relationships: { betaGroups: { data: [{ type: "betaGroups", id: env.ASC_GROUP_ID }] } } } }),
  });
  // 409: already a tester in App Store Connect. Count it as added; adjust the group by hand if needed.
  if (r.ok || r.status === 409) {
    await env.DB.prepare("UPDATE signups SET added=1 WHERE id=?").bind(s.id).run();
    return json({ ok: true, existing: r.status === 409 });
  }
  return json({ ok: false, error: "App Store Connect " + r.status }, 502);
}
