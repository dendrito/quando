import { json, cors, preflight, clip, now, body } from "../_lib.js";
export const onRequestOptions = ({ request }) => preflight(request);
export async function onRequestPost({ request, env }) {
  try {
    const b = await body(request);
    const id = clip(b.install_id, 64);
    if (!id || !["install", "first_alarm", "open", "crash", "missed"].includes(b.type)) return json({ ok: false }, 400);
    await env.DB.prepare("INSERT INTO events (install_id, type, platform, version, detail, created_at) VALUES (?,?,?,?,?,?)")
      .bind(id, b.type, clip(b.platform, 30), clip(b.version, 30), clip(b.detail, 300), now()).run();
    return json({ ok: true });
  } catch { return json({ ok: false }, 400); }
}
