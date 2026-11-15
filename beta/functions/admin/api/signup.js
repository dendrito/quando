import { json } from "../../_lib.js";
// POST {id, added}  mark a tester as added to the Google Group / TestFlight
export async function onRequestPost({ request, env }) {
  const b = await request.json().catch(() => ({}));
  if (!Number(b.id)) return json({ ok: false }, 400);
  await env.DB.prepare("UPDATE signups SET added=? WHERE id=?").bind(b.added ? 1 : 0, Number(b.id)).run();
  return json({ ok: true });
}
