import { json, cors, preflight, clip, now, body } from "../_lib.js";
const PLATFORMS = ["android", "iphone", "ipad", "mac"];
export const onRequestOptions = ({ request }) => preflight(request);
export async function onRequestPost({ request, env }) {
  const h = cors(request);
  try {
    const b = await body(request);
    const email = clip(b.email, 200).toLowerCase();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email) || !PLATFORMS.includes(b.platform)) return json({ ok: false }, 400, h);
    await env.DB.prepare("INSERT OR IGNORE INTO signups (email, platform, created_at) VALUES (?, ?, ?)").bind(email, b.platform, now()).run();
    return json({ ok: true }, 200, h); // same answer for new and repeat signups
  } catch { return json({ ok: false }, 400, h); }
}
