import { isAdmin } from "../_lib.js";
// Everything under /admin needs a valid Cloudflare Access token, even if the Access app is misconfigured.
export async function onRequest(ctx) {
  if (!(await isAdmin(ctx.request, ctx.env))) return new Response("Not allowed", { status: 403 });
  return ctx.next();
}
