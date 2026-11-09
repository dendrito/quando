// Quando Tuya relay: a tiny Cloudflare Worker that keeps the Tuya Cloud Project keys
// off users' phones. The app sends the user's Firebase sign-in token; this Worker
// signs in to Tuya with the user's Smart Life account, remembers only the Tuya user
// id, and lists / runs that user's scenes. Passwords are never stored or logged.

const JWKS_URL = 'https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com';
const SCHEMAS = ['smartlife', 'tuyaSmart'];
const LOGIN_LIMIT = 5; // sign-in attempts per user per hour
const enc = new TextEncoder();

let jwksCache = { keys: null, until: 0 };
let projectToken = { value: null, until: 0 };

const json = (status, body) =>
  new Response(JSON.stringify(body), { status, headers: { 'content-type': 'application/json' } });

class HttpError extends Error {
  constructor(status, error, code) {
    super(error);
    this.status = status;
    this.error = error;
    this.code = code;
  }
}

const b64urlToBytes = (s) => {
  const bin = atob(s.replace(/-/g, '+').replace(/_/g, '/'));
  return Uint8Array.from(bin, (c) => c.charCodeAt(0));
};
const hex = (buf) => [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, '0')).join('');
const sha256Hex = async (text) => hex(await crypto.subtle.digest('SHA-256', enc.encode(text)));

// --- Firebase sign-in token --------------------------------------------------

async function firebaseKeys(fetchFn) {
  if (jwksCache.keys && Date.now() < jwksCache.until) return jwksCache.keys;
  const res = await fetchFn(JWKS_URL);
  if (!res.ok) throw new HttpError(503, 'auth_unavailable');
  const body = await res.json();
  jwksCache = { keys: body.keys, until: Date.now() + 3600_000 };
  return body.keys;
}

/** Returns the Firebase user id of a valid, email-verified sign-in token. */
export async function verifyFirebaseToken(token, env, fetchFn = fetch, nowMs = Date.now()) {
  const parts = (token || '').split('.');
  if (parts.length !== 3) throw new HttpError(401, 'unauthorized');
  let header, payload;
  try {
    header = JSON.parse(new TextDecoder().decode(b64urlToBytes(parts[0])));
    payload = JSON.parse(new TextDecoder().decode(b64urlToBytes(parts[1])));
  } catch {
    throw new HttpError(401, 'unauthorized');
  }
  if (header.alg !== 'RS256' || !header.kid) throw new HttpError(401, 'unauthorized');
  const jwk = (await firebaseKeys(fetchFn)).find((k) => k.kid === header.kid);
  if (!jwk) throw new HttpError(401, 'unauthorized');
  const key = await crypto.subtle.importKey(
    'jwk',
    jwk,
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['verify'],
  );
  const ok = await crypto.subtle.verify(
    'RSASSA-PKCS1-v1_5',
    key,
    b64urlToBytes(parts[2]),
    enc.encode(`${parts[0]}.${parts[1]}`),
  );
  const now = Math.floor(nowMs / 1000);
  const project = env.FIREBASE_PROJECT_ID;
  if (
    !ok ||
    payload.aud !== project ||
    payload.iss !== `https://securetoken.google.com/${project}` ||
    typeof payload.sub !== 'string' ||
    !payload.sub ||
    payload.exp <= now ||
    payload.iat > now + 300 ||
    payload.email_verified !== true
  ) {
    throw new HttpError(401, 'unauthorized');
  }
  return payload.sub;
}

// --- Tuya cloud --------------------------------------------------------------

async function tuyaCall(env, fetchFn, method, path, { token = '', body = '' } = {}) {
  const t = `${Date.now()}`;
  const stringToSign = `${method}\n${await sha256Hex(body)}\n\n${path}`;
  const key = await crypto.subtle.importKey('raw', enc.encode(env.TUYA_ACCESS_SECRET), { name: 'HMAC', hash: 'SHA-256' }, false, [
    'sign',
  ]);
  const sign = hex(
    await crypto.subtle.sign('HMAC', key, enc.encode(`${env.TUYA_ACCESS_ID}${token}${t}${stringToSign}`)),
  ).toUpperCase();
  const headers = {
    client_id: env.TUYA_ACCESS_ID,
    t,
    sign_method: 'HMAC-SHA256',
    sign,
    'content-type': 'application/json',
  };
  if (token) headers.access_token = token;
  let res;
  try {
    res = await fetchFn(`https://${env.TUYA_HOST}${path}`, {
      method,
      headers,
      body: body || undefined,
      redirect: 'manual',
    });
  } catch {
    throw new HttpError(502, 'tuya_unreachable');
  }
  let out;
  try {
    out = await res.json();
  } catch {
    throw new HttpError(502, 'tuya_bad_response');
  }
  if (!res.ok || out.success !== true) {
    if (['1010', '1011', '1012', '1400'].includes(`${out.code}`)) projectToken = { value: null, until: 0 };
    // Only Tuya's documented error code is passed on, never its message text.
    throw new HttpError(502, 'tuya', `${out.code ?? res.status}`);
  }
  return out.result;
}

async function projectAccessToken(env, fetchFn) {
  if (projectToken.value && Date.now() < projectToken.until) return projectToken.value;
  const r = await tuyaCall(env, fetchFn, 'GET', '/v1.0/token?grant_type=1');
  if (!r || typeof r.access_token !== 'string') throw new HttpError(502, 'tuya_bad_response');
  projectToken = { value: r.access_token, until: Date.now() + ((Number(r.expire_time) || 7200) - 60) * 1000 };
  return projectToken.value;
}

// MD5 is required by Tuya's login call (SubtleCrypto has none), so it is implemented here.
export function md5(text) {
  const bytes = enc.encode(text);
  const k = Array.from({ length: 64 }, (_, i) => Math.floor(Math.abs(Math.sin(i + 1)) * 2 ** 32) >>> 0);
  const shifts = [
    [7, 12, 17, 22],
    [5, 9, 14, 20],
    [4, 11, 16, 23],
    [6, 10, 15, 21],
  ];
  const s = Array.from({ length: 64 }, (_, i) => shifts[i >> 4][i % 4]);
  const padded = new Uint8Array((((bytes.length + 8) >> 6) + 1) << 6);
  padded.set(bytes);
  padded[bytes.length] = 0x80;
  const view = new DataView(padded.buffer);
  view.setUint32(padded.length - 8, (bytes.length * 8) >>> 0, true);
  view.setUint32(padded.length - 4, Math.floor((bytes.length * 8) / 2 ** 32), true);
  let [a0, b0, c0, d0] = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476];
  for (let o = 0; o < padded.length; o += 64) {
    const m = Array.from({ length: 16 }, (_, i) => view.getUint32(o + i * 4, true));
    let [a, b, c, d] = [a0, b0, c0, d0];
    for (let i = 0; i < 64; i++) {
      let f, g;
      if (i < 16) [f, g] = [(b & c) | (~b & d), i];
      else if (i < 32) [f, g] = [(d & b) | (~d & c), (5 * i + 1) % 16];
      else if (i < 48) [f, g] = [b ^ c ^ d, (3 * i + 5) % 16];
      else [f, g] = [c ^ (b | ~d), (7 * i) % 16];
      const sum = (a + f + k[i] + m[g]) >>> 0;
      [a, d, c] = [d, c, b];
      b = (b + ((sum << s[i]) | (sum >>> (32 - s[i])))) >>> 0;
    }
    a0 = (a0 + a) >>> 0;
    b0 = (b0 + b) >>> 0;
    c0 = (c0 + c) >>> 0;
    d0 = (d0 + d) >>> 0;
  }
  const out = new DataView(new ArrayBuffer(16));
  [a0, b0, c0, d0].forEach((v, i) => out.setUint32(i * 4, v, true));
  return hex(out.buffer);
}

// --- Routes ------------------------------------------------------------------

async function loginAttemptAllowed(env, user) {
  const key = `attempts:${user}`;
  const used = Number((await env.LINKS.get(key)) || 0);
  if (used >= LOGIN_LIMIT) return false;
  await env.LINKS.put(key, `${used + 1}`, { expirationTtl: 3600 });
  return true;
}

async function login(env, fetchFn, user, req) {
  let b;
  try {
    b = await req.json();
  } catch {
    throw new HttpError(400, 'bad_request');
  }
  const { countryCode, username, password } = b ?? {};
  if ([countryCode, username, password].some((v) => typeof v !== 'string' || !v) || password.length > 128) {
    throw new HttpError(400, 'bad_request');
  }
  if (!(await loginAttemptAllowed(env, user))) throw new HttpError(429, 'too_many_attempts');
  const token = await projectAccessToken(env, fetchFn);
  let last;
  for (const schema of SCHEMAS) {
    try {
      const r = await tuyaCall(env, fetchFn, 'POST', '/v1.0/iot-01/associated-users/actions/authorized-login', {
        token,
        body: JSON.stringify({
          country_code: countryCode.trim(),
          username: username.trim(),
          password: md5(password),
          schema,
        }),
      });
      if (!r || !r.uid) throw new HttpError(502, 'tuya_bad_response');
      await env.LINKS.put(`tuya:${user}`, `${r.uid}`);
      return json(200, { linked: true });
    } catch (e) {
      if (!(e instanceof HttpError) || e.error !== 'tuya') throw e;
      last = e;
    }
  }
  throw last;
}

async function linkedUid(env, user) {
  const uid = await env.LINKS.get(`tuya:${user}`);
  if (!uid) throw new HttpError(409, 'not_linked');
  return uid;
}

async function homesOf(env, fetchFn, uid) {
  const token = await projectAccessToken(env, fetchFn);
  const homes = await tuyaCall(env, fetchFn, 'GET', `/v1.0/users/${encodeURIComponent(uid)}/homes`, { token });
  if (!Array.isArray(homes)) throw new HttpError(502, 'tuya_bad_response');
  return { token, ids: homes.filter((h) => h && h.home_id != null).map((h) => `${h.home_id}`) };
}

async function scenes(env, fetchFn, user) {
  const { token, ids } = await homesOf(env, fetchFn, await linkedUid(env, user));
  const out = [];
  for (const homeId of ids) {
    const list = await tuyaCall(env, fetchFn, 'GET', `/v1.1/homes/${encodeURIComponent(homeId)}/scenes`, { token });
    if (!Array.isArray(list)) throw new HttpError(502, 'tuya_bad_response');
    for (const s of list) {
      if (!s || s.scene_id == null || s.enabled === false || s.status === '2') continue;
      out.push({ homeId, id: `${s.scene_id}`, name: `${s.name ?? s.scene_id}` });
    }
  }
  return json(200, { scenes: out });
}

async function run(env, fetchFn, user, req) {
  let b;
  try {
    b = await req.json();
  } catch {
    throw new HttpError(400, 'bad_request');
  }
  const { homeId, sceneId } = b ?? {};
  if (typeof homeId !== 'string' || typeof sceneId !== 'string' || !homeId || !sceneId) {
    throw new HttpError(400, 'bad_request');
  }
  const { token, ids } = await homesOf(env, fetchFn, await linkedUid(env, user));
  // Only homes that belong to the signed-in user's own Tuya account may run scenes.
  if (!ids.includes(homeId)) throw new HttpError(403, 'forbidden');
  const r = await tuyaCall(
    env,
    fetchFn,
    'POST',
    `/v1.0/homes/${encodeURIComponent(homeId)}/scenes/${encodeURIComponent(sceneId)}/trigger`,
    { token },
  );
  if (r !== true) throw new HttpError(502, 'not_executed');
  return json(200, { ok: true });
}

export async function handle(req, env, fetchFn = fetch) {
  try {
    const url = new URL(req.url);
    const bearer = (req.headers.get('authorization') || '').replace(/^Bearer /i, '');
    const user = await verifyFirebaseToken(bearer, env, fetchFn);
    if (req.method === 'POST' && url.pathname === '/v1/login') return await login(env, fetchFn, user, req);
    if (req.method === 'POST' && url.pathname === '/v1/scenes') return await scenes(env, fetchFn, user);
    if (req.method === 'POST' && url.pathname === '/v1/run') return await run(env, fetchFn, user, req);
    if (req.method === 'POST' && url.pathname === '/v1/status') {
      return json(200, { linked: (await env.LINKS.get(`tuya:${user}`)) != null });
    }
    if (req.method === 'POST' && url.pathname === '/v1/logout') {
      await env.LINKS.delete(`tuya:${user}`);
      return json(200, { linked: false });
    }
    return json(404, { error: 'not_found' });
  } catch (e) {
    if (e instanceof HttpError) return json(e.status, { error: e.error, ...(e.code ? { code: e.code } : {}) });
    return json(500, { error: 'server' });
  }
}

export default { fetch: (req, env) => handle(req, env) };
