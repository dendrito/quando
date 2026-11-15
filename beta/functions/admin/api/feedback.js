import { json } from "../../_lib.js";
const STATUS = ["new", "now", "next", "later", "wont", "done"];
// POST {id, status?, severity?, kind?}  triage a feedback item
export async function onRequestPost({ request, env }) {
  const b = await request.json().catch(() => ({}));
  const id = Number(b.id);
  if (!id) return json({ ok: false }, 400);
  if (b.status && STATUS.includes(b.status)) await env.DB.prepare("UPDATE feedback SET status=? WHERE id=?").bind(b.status, id).run();
  if ([1, 2, 3].includes(b.severity)) await env.DB.prepare("UPDATE feedback SET severity=? WHERE id=?").bind(b.severity, id).run();
  if (["bug", "idea", "love"].includes(b.kind)) await env.DB.prepare("UPDATE feedback SET kind=? WHERE id=?").bind(b.kind, id).run();
  return json({ ok: true });
}
