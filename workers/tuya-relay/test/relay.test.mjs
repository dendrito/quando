import assert from 'node:assert/strict';
import { generateKeyPairSync, createSign } from 'node:crypto';
import { test } from 'node:test';

import { handle, md5, verifyFirebaseToken } from '../src/index.js';

const env0 = {
  TUYA_ACCESS_ID: 'test-id',
  TUYA_ACCESS_SECRET: 'test-secret',
  TUYA_HOST: 'openapi.test.example',
  FIREBASE_PROJECT_ID: 'demo-project',
};
const { privateKey, publicKey } = generateKeyPairSync('rsa', { modulusLength: 2048 });
const jwk = { ...publicKey.export({ format: 'jwk' }), kid: 'k1' };
const b64u = (v) => Buffer.from(typeof v === 'string' ? v : JSON.stringify(v)).toString('base64url');

function token(over = {}, kid = 'k1') {
  const now = Math.floor(Date.now() / 1000);
  const payload = {
    aud: 'demo-project',
    iss: 'https://securetoken.google.com/demo-project',
    sub: 'user-1',
    iat: now,
    exp: now + 3600,
    email_verified: true,
    ...over,
  };
  const head = b64u({ alg: 'RS256', kid });
  const body = b64u(payload);
  const sig = createSign('RSA-SHA256').update(`${head}.${body}`).sign(privateKey).toString('base64url');
  return `${head}.${body}.${sig}`;
}

function kv() {
  const m = new Map();
  return {
    m,
    get: async (k) => m.get(k) ?? null,
    put: async (k, v) => void m.set(k, v),
    delete: async (k) => void m.delete(k),
  };
}

/** Fake Google key list + fake Tuya cloud. */
function world({ homes = [{ home_id: 42 }], loginUser = 'me@example.com' } = {}) {
  const calls = [];
  const fetchFn = async (url, init = {}) => {
    const u = new URL(url);
    if (u.host === 'www.googleapis.com') return Response.json({ keys: [jwk] });
    calls.push({ path: u.pathname, init });
    const ok = (result) => Response.json({ success: true, result });
    switch (u.pathname) {
      case '/v1.0/token':
        return ok({ access_token: 'proj-token', expire_time: 7200 });
      case '/v1.0/iot-01/associated-users/actions/authorized-login': {
        const b = JSON.parse(init.body);
        if (b.username !== loginUser || b.schema !== 'tuyaSmart') {
          return Response.json({ success: false, code: 2406, msg: 'secret detail' });
        }
        return ok({ uid: 'tuya-uid', access_token: 'user-token' });
      }
      case '/v1.0/users/tuya-uid/homes':
        return ok(homes);
      case '/v1.1/homes/42/scenes':
        return ok([{ scene_id: 's1', name: 'Wake lights' }, { scene_id: 'off', enabled: false }]);
      case '/v1.0/homes/42/scenes/s1/trigger':
        return ok(true);
      default:
        throw new Error(`unexpected ${u.pathname}`);
    }
  };
  return { fetchFn, calls };
}

const req = (path, body, tok = token()) =>
  new Request(`https://relay.test${path}`, {
    method: 'POST',
    headers: { authorization: `Bearer ${tok}`, 'content-type': 'application/json' },
    body: body === undefined ? undefined : JSON.stringify(body),
  });

test('md5 matches the standard digest', () => {
  assert.equal(md5('pa55word'), 'a17a41337551d6542fd005e18b43afd4');
  assert.equal(md5(''), 'd41d8cd98f00b204e9800998ecf8427e');
});

test('only a valid, verified Firebase token for this project is accepted', async () => {
  const w = world();
  assert.equal(await verifyFirebaseToken(token(), env0, w.fetchFn), 'user-1');
  for (const bad of [
    token({ aud: 'other' }),
    token({ iss: 'https://securetoken.google.com/other' }),
    token({ exp: 1 }),
    token({ email_verified: false }),
    token({}, 'unknown-kid'),
    token().slice(0, -4) + 'AAAA',
    'not-a-token',
    '',
  ]) {
    await assert.rejects(() => verifyFirebaseToken(bad, env0, w.fetchFn), { status: 401 });
  }
  const res = await handle(req('/v1/scenes', {}, 'nope'), { ...env0, LINKS: kv() }, w.fetchFn);
  assert.equal(res.status, 401);
});

test('login stores only the Tuya uid, sends an MD5 password and signs with the project secret', async () => {
  const LINKS = kv();
  const w = world();
  const res = await handle(
    req('/v1/login', { countryCode: '55', username: 'me@example.com', password: 'pa55word' }),
    { ...env0, LINKS },
    w.fetchFn,
  );
  assert.equal(res.status, 200);
  assert.deepEqual(await res.json(), { linked: true });
  assert.equal(LINKS.m.get('tuya:user-1'), 'tuya-uid');
  assert.ok(![...LINKS.m.values()].some((v) => `${v}`.includes('pa55word')));
  const sent = w.calls.find((c) => c.path.endsWith('authorized-login'));
  assert.equal(JSON.parse(sent.init.body).password, md5('pa55word'));
  assert.equal(sent.init.headers.client_id, 'test-id');
  assert.match(sent.init.headers.sign, /^[0-9A-F]{64}$/);
  assert.equal(sent.init.headers.access_token, 'proj-token');
});

test('a Tuya login error passes on only the code, and sign-in attempts are limited', async () => {
  const LINKS = kv();
  const w = world();
  const bad = () =>
    handle(req('/v1/login', { countryCode: '55', username: 'x@example.com', password: 'nope' }), { ...env0, LINKS }, w.fetchFn);
  const first = await bad();
  assert.equal(first.status, 502);
  assert.deepEqual(await first.json(), { error: 'tuya', code: '2406' });
  for (let i = 0; i < 4; i++) await bad();
  assert.equal((await bad()).status, 429);
});

test('scenes need a linked account; run only works inside the user\'s own homes', async () => {
  const LINKS = kv();
  const env = { ...env0, LINKS };
  const w = world();
  assert.equal((await handle(req('/v1/scenes', {}), env, w.fetchFn)).status, 409);

  LINKS.m.set('tuya:user-1', 'tuya-uid');
  const list = await (await handle(req('/v1/scenes', {}), env, w.fetchFn)).json();
  assert.deepEqual(list.scenes, [{ homeId: '42', id: 's1', name: 'Wake lights' }]);

  const before = w.calls.length;
  const other = await handle(req('/v1/run', { homeId: '999', sceneId: 's1' }), env, w.fetchFn);
  assert.equal(other.status, 403);
  assert.ok(!w.calls.slice(before).some((c) => c.path.endsWith('/trigger')));

  const ok = await handle(req('/v1/run', { homeId: '42', sceneId: 's1' }), env, w.fetchFn);
  assert.equal(ok.status, 200);
  assert.equal(w.calls.filter((c) => c.path.endsWith('/trigger')).length, 1);
});

test('status and logout manage the saved link', async () => {
  const LINKS = kv();
  const env = { ...env0, LINKS };
  const w = world();
  assert.deepEqual(await (await handle(req('/v1/status', {}), env, w.fetchFn)).json(), { linked: false });
  LINKS.m.set('tuya:user-1', 'tuya-uid');
  assert.deepEqual(await (await handle(req('/v1/status', {}), env, w.fetchFn)).json(), { linked: true });
  await handle(req('/v1/logout', {}), env, w.fetchFn);
  assert.equal(LINKS.m.has('tuya:user-1'), false);
});
