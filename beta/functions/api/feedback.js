import { json, cors, preflight, clip, now, body } from "../_lib.js";
export const onRequestOptions = ({ request }) => preflight(request);
export async function onRequestPost({ request, env }) {
  const h = cors(request);
  try {
    const b = await body(request);
    if (!["bug", "idea", "love", "survey", "time"].includes(b.kind)) return json({ ok: false }, 400, h);
    const text = clip(b.body, 2000);
    if (b.kind === "survey" ? !["very", "somewhat", "not"].includes(text) : b.kind === "time" ? !["often", "sometimes", "rarely"].includes(text) : !text) return json({ ok: false }, 400, h);
    await env.DB.prepare("INSERT INTO feedback (kind, body, platform, version, contact, created_at) VALUES (?,?,?,?,?,?)")
      .bind(b.kind, text, clip(b.platform, 30), clip(b.version, 30), clip(b.contact, 200), now()).run();
    return json({ ok: true }, 200, h);
  } catch { return json({ ok: false }, 400, h); }
}
