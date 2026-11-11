import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/settings/domain/alarm_options.dart';
import 'package:quando/features/settings/domain/quick_setups.dart';
import 'package:quando/features/timers/domain/timers.dart';

void main() {
  test('Morning changes only wake-up check, snooze and spoken', () {
    const before = AlarmOptions(
      wakeCheck: false,
      maxSnoozes: 4,
      snoozeMinutes: 10,
      spoken: false,
      mathTask: true,
    );
    final after = morningApplied(before);
    expect(morningIsOn(before), isFalse);
    expect(morningIsOn(after), isTrue);
    final j = after.toJson(), b = before.toJson();
    final changed = {
      for (final k in j.keys)
        if (jsonEncode(j[k]) != jsonEncode(b[k])) k,
    };
    expect(changed, {'wakeCheck', 'maxSnoozes', 'snoozeMinutes', 'spoken'});
    expect(morningApplied(after).toJson(), after.toJson());
  });

  test('Undo (restoring the old options) gives back every value', () {
    const before = AlarmOptions(maxSnoozes: 3);
    morningApplied(before);
    expect(before.toJson(), const AlarmOptions(maxSnoozes: 3).toJson());
  });

  test('Work in stretches changes only length, say-every, count and marks', () {
    const before = SequenceConfig(calls: [], goText: 'Go', finishText: 'Time', beeps: false);
    final after = stretchApplied(before, '5 left');
    expect(stretchIsOn(before), isFalse);
    expect(stretchIsOn(after), isTrue);
    expect(after.lengthSeconds, 1500);
    expect(after.sayEvery, 300);
    expect(after.finalCount, 10);
    expect(after.marks.single, (atSeconds: 1200, text: '5 left'));
    expect(after.goText, 'Go');
    expect(after.beeps, isFalse);
  });
}
