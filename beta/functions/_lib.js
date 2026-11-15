const ORIGINS = ["https://quando.day", "https://www.quando.day"];
export const json = (o, s = 200, extra = {}) =>
  new Response(JSON.stringify(o), { status: s, headers: { "content-type": "application/json", "cache-control": "no-store", ...extra } });
export function cors(req) {
  const o = req.headers.get("origin");
  return o && ORIGINS.includes(o) ? { "access-control-allow-origin": o, vary: "origin", "access-control-allow-headers": "content-type", "access-control-allow-methods": "POST, OPTIONS" } : {};
}
export const preflight = (req) => new Response(null, { status: 204, headers: cors(req) });
export const clip = (v, n) => String(v ?? "").trim().slice(0, n);
export const now = () => Math.floor(Date.now() / 1000);

// Public endpoints take small JSON bodies only.
export async function body(req) {
  const t = await req.text();
  if (t.length > 4000) throw new Error("big");
  return JSON.parse(t || "{}");
}

// Cloudflare Access: the admin routes must carry a valid Access token for this app. Fails closed.
const b64 = (s) => Uint8Array.from(atob(s.replace(/-/g, "+").replace(/_/g, "/")), (c) => c.charCodeAt(0));
let jwks;
export async function isAdmin(req, env) {
  try {
    if (!env.ACCESS_TEAM_DOMAIN || !env.ACCESS_AUD) return false;
    const t = req.headers.get("cf-access-jwt-assertion");
    if (!t) return false;
    const [h, p, s] = t.split(".");
    const head = JSON.parse(new TextDecoder().decode(b64(h)));
    const pay = JSON.parse(new TextDecoder().decode(b64(p)));
    const aud = [].concat(pay.aud || []);
    if (!aud.includes(env.ACCESS_AUD) || pay.iss !== "https://" + env.ACCESS_TEAM_DOMAIN || pay.exp < now()) return false;
    if (!jwks || !jwks.keys.some((k) => k.kid === head.kid))
      jwks = await (await fetch(`https://${env.ACCESS_TEAM_DOMAIN}/cdn-cgi/access/certs`)).json();
    const jwk = jwks.keys.find((k) => k.kid === head.kid);
    if (!jwk) return false;
    const key = await crypto.subtle.importKey("jwk", jwk, { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" }, false, ["verify"]);
    return await crypto.subtle.verify("RSASSA-PKCS1-v1_5", key, b64(s), new TextEncoder().encode(h + "." + p));
  } catch { return false; }
}
