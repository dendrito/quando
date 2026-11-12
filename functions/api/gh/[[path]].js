// Board write access without a browser token.
// Cloudflare Access signs you in to board.quando.day; this function checks that sign-in
// and then talks to GitHub with a token kept as a Pages secret (GH_TOKEN).
// Needs env: GH_TOKEN (secret), ACCESS_TEAM (Zero Trust team name), ACCESS_AUD (the Access app's AUD tag).
// Without all three it answers 503 and the board falls back to the paste-a-token dialog.
const REPO = "dendrito/quando";

const b64u = (s) => Uint8Array.from(atob(s.replace(/-/g, "+").replace(/_/g, "/")), (c) => c.charCodeAt(0));
const json = (o, status = 200) => new Response(JSON.stringify(o), { status, headers: { "content-type": "application/json", "cache-control": "no-store" } });

async function accessEmail(request, env) {
  const jwt = request.headers.get("Cf-Access-Jwt-Assertion");
  if (!jwt) return null;
  const [h, p, s] = jwt.split(".");
  if (!s) return null;
  try {
    const dec = new TextDecoder();
    const head = JSON.parse(dec.decode(b64u(h)));
    const pay = JSON.parse(dec.decode(b64u(p)));
    const iss = `https://${env.ACCESS_TEAM}.cloudflareaccess.com`;
    if (head.alg !== "RS256" || pay.iss !== iss) return null;
    if (!(Array.isArray(pay.aud) ? pay.aud : [pay.aud]).includes(env.ACCESS_AUD)) return null;
    if (!pay.exp || pay.exp * 1000 < Date.now()) return null;
    const certs = await (await fetch(`${iss}/cdn-cgi/access/certs`, { cf: { cacheTtl: 3600 } })).json();
    const jwk = (certs.keys || []).find((k) => k.kid === head.kid);
    if (!jwk) return null;
    const key = await crypto.subtle.importKey("jwk", jwk, { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" }, false, ["verify"]);
    const ok = await crypto.subtle.verify("RSASSA-PKCS1-v1_5", key, b64u(s), new TextEncoder().encode(`${h}.${p}`));
    return ok ? pay.email || "signed in" : null;
  } catch (e) {
    return null;
  }
}

// What the board may ask GitHub for: its own card files, and read-only lists for the GitHub tab.
function allowed(method, rest, search) {
  if (rest.includes("..") || rest.includes("//")) return false;
  if (method === "GET") return /^(contents\/dashboard\/|pulls$|issues$|actions\/runs$)/.test(rest);
  if (method === "PUT" || method === "DELETE") return /^contents\/dashboard\/(cards\/[A-Za-z0-9._-]+\.json|board\.json)$/.test(rest);
  return false;
}

export async function onRequest({ request, env, params }) {
  if (!env.GH_TOKEN || !env.ACCESS_TEAM || !env.ACCESS_AUD) return json({ error: "not configured" }, 503);
  const email = await accessEmail(request, env);
  if (!email) return json({ error: "not signed in" }, 401);
  const rest = [].concat(params.path || []).join("/");
  if (rest === "whoami") return json({ ok: true, email });
  const url = new URL(request.url);
  if (!allowed(request.method, rest, url.search)) return json({ error: "not allowed" }, 403);
  const init = {
    method: request.method,
    headers: { Accept: "application/vnd.github+json", Authorization: `Bearer ${env.GH_TOKEN}`, "User-Agent": "quando-board", "Content-Type": "application/json" },
  };
  if (request.method === "PUT" || request.method === "DELETE") init.body = await request.text();
  const r = await fetch(`https://api.github.com/repos/${REPO}/${rest}${url.search}`, init);
  return new Response(r.body, { status: r.status, headers: { "content-type": "application/json", "cache-control": "no-store" } });
}
