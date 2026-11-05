import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/features/integrations/data/sender.dart';
import 'package:quando/features/integrations/domain/integrations.dart';
import 'package:quando/features/ringing/ring_payload.dart';

const _alarm = RingPayload(
  title: 'Candle lighting · Shabbat',
  body: '15 minutes before',
  ringSeconds: 60,
);

(IntegrationSender, List<http.Request>) _sender(IntegrationSettings s) {
  final sent = <http.Request>[];
  final client = MockClient((r) async {
    sent.add(r);
    return http.Response('{"status":1}', 200);
  });
  return (IntegrationSender(() => s, client: client), sent);
}

void main() {
  test('Pushover gets the alarm when it rings, not when it stops', () async {
    final (sender, sent) = _sender(
      const IntegrationSettings(
        pushoverOn: true,
        pushoverUser: 'u123',
        pushoverToken: 'a456',
        pushoverPriority: 2,
        pushoverSound: 'my_shofar',
        pushoverDevices: {'pixel', 'ipad'},
      ),
    );
    await sender.send(AlarmHappening.ring, _alarm);
    await sender.send(AlarmHappening.stopped, _alarm);
    expect(sent, hasLength(1));
    expect(sent.single.url, IntegrationSender.pushoverUrl);
    expect(sent.single.bodyFields, {
      'token': 'a456',
      'user': 'u123',
      'title': 'Candle lighting · Shabbat',
      'message': '15 minutes before',
      'priority': '2',
      'retry': '30',
      'expire': '600',
      'sound': 'my_shofar',
      'device': 'ipad,pixel',
    });
  });

  test('Pushover needs both keys', () async {
    final (sender, sent) = _sender(
      const IntegrationSettings(pushoverOn: true, pushoverUser: 'u'),
    );
    await sender.send(AlarmHappening.ring, _alarm);
    expect(sent, isEmpty);
  });

  test('webhooks get JSON for the events they asked for', () async {
    final (sender, sent) = _sender(
      IntegrationSettings(
        webhooks: [
          const Webhook(
            id: 'z',
            kind: WebhookKind.zapier,
            url: 'https://hooks.zapier.com/x',
            events: {'stopped'},
          ),
          Webhook(
            id: 'i',
            kind: WebhookKind.ifttt,
            url: Webhook.iftttUrl('wake up', 'KEY'),
            events: const {'ring'},
          ),
        ],
      ),
    );
    await sender.send(
      AlarmHappening.ring,
      _alarm,
      at: DateTime.utc(2026, 11, 6, 13, 50),
    );
    expect(
      sent.single.url.toString(),
      'https://maker.ifttt.com/trigger/wake%20up/json/with/key/KEY',
    );
    final body = jsonDecode(sent.single.body) as Map<String, dynamic>;
    expect(body['event'], 'ring');
    expect(body['title'], 'Candle lighting · Shabbat');
    expect(body['time'], '2026-11-06T13:50:00.000Z');
    await sender.send(AlarmHappening.stopped, _alarm);
    expect(sent.last.url.host, 'hooks.zapier.com');
  });

  test('paused on Shabbat, and lock chimes never send', () async {
    final (sender, sent) = _sender(
      const IntegrationSettings(
        pushoverOn: true,
        pushoverUser: 'u',
        pushoverToken: 't',
        webhooks: [
          Webhook(
            id: 'w',
            kind: WebhookKind.other,
            url: 'https://example.com/h',
          ),
        ],
      ),
    );
    await sender.send(
      AlarmHappening.ring,
      const RingPayload(
        title: 'Sunrise',
        body: 'Now',
        ringSeconds: 60,
        shabbatSafe: true,
      ),
    );
    await sender.send(
      AlarmHappening.ring,
      const RingPayload(title: 'Lock', body: '', ringSeconds: 1, isLock: true),
    );
    expect(sent, isEmpty);
  });

  test('a failing service never throws', () async {
    final sender = IntegrationSender(
      () => const IntegrationSettings(
        pushoverOn: true,
        pushoverUser: 'u',
        pushoverToken: 't',
      ),
      client: MockClient((_) async => throw Exception('offline')),
    );
    await sender.send(AlarmHappening.ring, _alarm);
    expect(
      await sender.testPushover(
        const IntegrationSettings(pushoverUser: 'u', pushoverToken: 't'),
      ),
      contains('Could not reach'),
    );
  });

  test('settings round-trip', () {
    const s = IntegrationSettings(
      pushoverOn: true,
      pushoverUser: 'u',
      pushoverToken: 't',
      webhooks: [
        Webhook(
          id: 'w',
          kind: WebhookKind.ifttt,
          url: 'https://maker.ifttt.com/trigger/x/json/with/key/k',
        ),
      ],
    );
    final back = IntegrationSettings.fromJson(
      jsonDecode(jsonEncode(s.toJson())) as Map<String, dynamic>,
    );
    expect(back.pushoverReady, isTrue);
    expect(back.webhooks.single.title, 'IFTTT · x');
  });

  test('loads Pushover sounds (custom ones included) and devices', () async {
    final sender = IntegrationSender(
      () => const IntegrationSettings(),
      client: MockClient((r) async {
        if (r.url.path.endsWith('sounds.json')) {
          return http.Response(
            '{"sounds":{"pushover":"Pushover (default)","my_shofar":"My shofar"},"status":1}',
            200,
          );
        }
        return http.Response('{"status":1,"devices":["pixel","ipad"]}', 200);
      }),
    );
    expect(
      await sender.pushoverSounds('t'),
      containsPair('my_shofar', 'My shofar'),
    );
    expect(await sender.pushoverDevices('t', 'u'), ['pixel', 'ipad']);
  });

  test('old settings with high priority still load', () {
    expect(
      IntegrationSettings.fromJson({'pushoverHigh': true}).pushoverPriority,
      1,
    );
  });
}
