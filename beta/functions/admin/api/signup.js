import { json } from "../../_lib.js";
// POST {id, added} marks a tester as added to the Google Group / TestFlight; {id, delete:true} removes them
export async function onRequestPost({ request, env }) {
  const b = await request.json().catch(() => ({}));
  if (!Number(b.id)) return json({ ok: false }, 400);
  if (b.delete) {
    await env.DB.prepare("DELETE FROM signups WHERE id=?").bind(Number(b.id)).run();
    return json({ ok: true });
  }
  await env.DB.prepare("UPDATE signups SET added=? WHERE id=?").bind(b.added ? 1 : 0, Number(b.id)).run();
  return json({ ok: true });
}
