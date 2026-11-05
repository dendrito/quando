import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/sync/sync_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The shared copy, as Firestore would keep it: each push merges in.
class FakeServer {
  final items = <String, SyncItem>{};
  final _out = StreamController<Map<String, SyncItem>>.broadcast();

  SyncRemote remote() => _Remote(this);

  Future<void> push(Map<String, SyncItem> changed) async {
    items.addAll(changed);
    _out.add(Map.of(items));
  }
}

class _Remote implements SyncRemote {
  _Remote(this.server);
  final FakeServer server;

  @override
  Future<void> push(Map<String, SyncItem> items) => server.push(items);

  @override
  Stream<Map<String, SyncItem>> watch() async* {
    yield Map.of(server.items);
    yield* server._out.stream;
  }
}

void main() {
  late FakeServer server;
  var clock = DateTime.utc(2026, 11, 5, 9);
  DateTime now() => clock = clock.add(const Duration(seconds: 1));

  // Each device keeps its own settings store. SharedPreferences is a single
  // instance in tests, so a device here is a plain map we swap in and out.
  Future<(SyncEngine, SharedPreferences)> device(String id, Map<String, Object> saved) async {
    SharedPreferences.setMockInitialValues(saved);
    final p = await SharedPreferences.getInstance();
    await p.reload();
    return (SyncEngine(p, server.remote(), device: id, now: now), p);
  }

  setUp(() => server = FakeServer());

  test('the first device sends up what it has, and a new one takes it in', () async {
    final (a, pa) = await device('a', {
      'userAlarms': '[1]',
      'quoteSources': ['songs'],
      'sounds': 'mine',
    });
    await a.apply(server.items);
    expect(server.items.keys, containsAll(['userAlarms', 'quoteSources']));
    expect(server.items.containsKey('sounds'), isFalse, reason: 'recorded sounds stay on their device');
    expect(pa.getString('userAlarms'), '[1]');

    final (b, pb) = await device('b', {'userAlarms': '[]'});
    var reloaded = false;
    final b2 = SyncEngine(pb, server.remote(), device: 'b', now: now, onApplied: () => reloaded = true);
    await b2.apply(server.items);
    expect(pb.getString('userAlarms'), '[1]');
    expect(pb.getStringList('quoteSources'), ['songs']);
    expect(reloaded, isTrue);
    expect(b, isNotNull);
  });

  test('a change goes up, comes down on the other device, and removals too', () async {
    final (a, pa) = await device('a', {'lock': '{"shabbat":false}', 'zone.fixed': 'Asia/Jerusalem'});
    await a.apply(server.items);

    await pa.setString('lock', '{"shabbat":true}');
    await pa.remove('zone.fixed');
    await a.pushLocal();
    expect(server.items['lock']!.s, contains('true'));
    expect(server.items['zone.fixed']!.s, isNull);

    final (b, pb) = await device('b', {'lock': '{"shabbat":false}', 'zone.fixed': 'Asia/Jerusalem'});
    // b has never synced, so the shared copy wins.
    await b.apply(server.items);
    expect(pb.getString('lock'), '{"shabbat":true}');
    expect(pb.containsKey('zone.fixed'), isFalse);
  });

  test('a newer change here isn\'t overwritten by an older one from the server', () async {
    final (a, pa) = await device('a', {'havdalah': 'geonim'});
    await a.apply(server.items);
    final old = server.items['havdalah']!;
    await pa.setString('havdalah', 'rabbeinuTam');
    // The server echoes the old value before this change goes up.
    await a.apply({'havdalah': SyncItem(old.t + 1, 'b', old.s)});
    expect(pa.getString('havdalah'), 'rabbeinuTam');
    await a.pushLocal();
    expect(server.items['havdalah']!.s, contains('rabbeinuTam'));
  });

  test('nothing goes up before the shared copy has been heard', () async {
    final (a, pa) = await device('a', {'language': 'pt'});
    await a.pushLocal();
    expect(server.items, isEmpty);
    expect(pa.getString('language'), 'pt');
  });

  test('values keep their kind on the way through', () async {
    final (a, pa) = await device('a', {'place.inIsrael': true, 'place.candleMinutes': 40});
    await a.apply(server.items);
    final (b, pb) = await device('b', {});
    await b.apply(server.items);
    expect(pb.getBool('place.inIsrael'), isTrue);
    expect(pb.getInt('place.candleMinutes'), 40);
    expect(pa, isNotNull);
  });
}
