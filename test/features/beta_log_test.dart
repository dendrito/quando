import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quando/features/beta/beta_log.dart';

class _Sink implements BetaSink {
  final sent = <(String, Map<String, Object?>)>[];
  @override
  Future<bool> post(String path, Map<String, Object?> json) async {
    sent.add((path, json));
    return true;
  }
}

void main() {
  late _Sink sink;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    BetaLog.init(await SharedPreferences.getInstance());
    sink = _Sink();
    BetaLog.sink = sink;
  });

  test('nothing is sent until the tester turns sharing on', () async {
    BetaLog.alarmSaved();
    BetaLog.event('open');
    expect(sink.sent, isEmpty);
    await BetaLog.setOn(true);
    expect(sink.sent.map((e) => e.$2['type']), ['install']);
  });

  test('events carry an anonymous id and no personal fields', () async {
    await BetaLog.setOn(true);
    BetaLog.alarmSaved();
    BetaLog.alarmSaved(); // only the first one counts
    expect(sink.sent.map((e) => e.$2['type']), ['install', 'first_alarm']);
    final e = sink.sent.first.$2;
    expect((e['install_id'] as String).length, 32);
    expect(e.keys.toSet(), {'install_id', 'type', 'platform', 'version', 'detail'});
  });

  test('a crash names the error and the Quando? file, never the message', () {
    final d = BetaLog.crashDetail(
      StateError('alarm "Mum 050-123 4567"'),
      StackTrace.fromString('#0 f (package:quando/app/providers.dart:1085:5)'),
    );
    expect(d, 'StateError at app/providers.dart:1085');
    expect(d, isNot(contains('Mum')));
  });

  test('the day-7 question comes once, a week after turning sharing on', () async {
    await BetaLog.setOn(true);
    expect(BetaLog.surveyDue(), isFalse);
    expect(BetaLog.surveyDue(DateTime.now().add(const Duration(days: 8))), isTrue);
    await BetaLog.answerSurvey('very');
    expect(BetaLog.surveyDue(DateTime.now().add(const Duration(days: 8))), isFalse);
    expect(sink.sent.last.$1, '/api/feedback');
  });
}
