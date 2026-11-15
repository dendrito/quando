import { json } from "../../_lib.js";
const DAY = 86400;
export async function onRequestGet({ env }) {
  const q = async (sql, ...a) => (await env.DB.prepare(sql).bind(...a).all()).results;
  const n = Math.floor(Date.now() / 1000);
  const [signups, feedback, installs, act, ret, sess, crashes, surv] = await Promise.all([
    q("SELECT id, email, platform, added, created_at FROM signups ORDER BY created_at DESC LIMIT 500"),
    q("SELECT id, kind, body, severity, status, platform, version, contact, created_at FROM feedback WHERE kind != 'survey' ORDER BY created_at DESC LIMIT 300"),
    q("SELECT install_id, MIN(created_at) t FROM events WHERE type='install' GROUP BY install_id"),
    q("SELECT COUNT(DISTINCT install_id) c FROM events WHERE type='first_alarm'"),
    q(`SELECT COUNT(DISTINCT e.install_id) c FROM events e JOIN (SELECT install_id, MIN(created_at) t FROM events WHERE type='install' GROUP BY install_id) i
       ON i.install_id = e.install_id WHERE e.type='open' AND e.created_at >= i.t + 6*86400 AND i.t <= ?`, n - 7 * DAY),
    q("SELECT COUNT(*) c FROM events WHERE type='open'"),
    q("SELECT detail, version, platform, COUNT(*) c, COUNT(DISTINCT install_id) u, MAX(created_at) last FROM events WHERE type='crash' GROUP BY detail, version, platform ORDER BY last DESC LIMIT 50"),
    q("SELECT body, COUNT(*) c FROM feedback WHERE kind='survey' GROUP BY body"),
  ]);
  const inst = installs.length, old = installs.filter((i) => i.t <= n - 7 * DAY).length;
  const crashTotal = crashes.reduce((s, c) => s + c.c, 0), sessions = sess[0].c;
  const sv = Object.fromEntries(surv.map((s) => [s.body, s.c])), svT = surv.reduce((s, x) => s + x.c, 0);
  const pct = (a, b) => (b ? Math.round((a / b) * 1000) / 10 : null);
  return json({
    signups, feedback, crashes,
    integrations: { testflight: !!(env.ASC_KEY_ID && env.ASC_ISSUER_ID && env.ASC_PRIVATE_KEY && env.ASC_GROUP_ID) },
    platforms: signups.reduce((m, s) => ((m[s.platform] = (m[s.platform] || 0) + 1), m), {}),
    perDay: (await q("SELECT date(created_at,'unixepoch') d, COUNT(*) c FROM signups GROUP BY d ORDER BY d")),
    metrics: {
      installed: pct(inst, signups.length),
      activated: pct(act[0].c, inst),
      retained: pct(ret[0].c, old),
      crashFree: sessions ? Math.round((1 - crashTotal / sessions) * 1000) / 10 : null,
      veryDisappointed: pct(sv.very || 0, svT),
      openSev1: feedback.filter((f) => f.kind === "bug" && f.severity === 1 && !["done", "wont"].includes(f.status)).length,
      newFeedback: feedback.filter((f) => f.status === "new").length,
    },
  });
}
