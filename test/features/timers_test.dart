import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/timers/domain/timers.dart';
import 'package:quando/features/timers/ui/timers_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

String say(int s) => '$s s';

void main() {
  setUp(() => useLocale([const Locale('en')]));

  test('race start: calls, Go and the time every 10 seconds', () {
    final cues = sequenceCues(
      const SequenceConfig(
        calls: [(secondsBefore: 6, text: 'On your marks'), (secondsBefore: 3, text: 'Get set')],
        goText: 'Go!',
        finishText: 'Time!',
        sayEvery: 10,
      ),
      say,
    );
    expect(cues.take(3).map((c) => (c.ms, c.text)), [
      (-6000, 'On your marks'),
      (-3000, 'Get set'),
      (0, 'Go!'),
    ]);
    expect(cues[3].ms, 10000);
    expect(cues[3].text, '10 s');
    expect(cues[4].text, '20 s');
  });

  test('a length adds the end, a final count and the time left; your marks win ties', () {
    final cues = sequenceCues(
      const SequenceConfig(
        calls: [(secondsBefore: 3, text: 'Get set')],
        goText: 'Go',
        finishText: 'Done',
        lengthSeconds: 30,
        sayEvery: 10,
        finalCount: 3,
        marks: [(atSeconds: 15, text: 'Halfway'), (atSeconds: 10, text: 'Ten gone')],
      ),
      say,
    );
    final byMs = {for (final c in cues) c.ms: c};
    expect(byMs[10000]!.text, 'Ten gone'); // your mark beats the regular time
    expect(byMs[15000]!.text, 'Halfway');
    expect(byMs[20000]!.text, '10 s'); // 10 s left
    expect(byMs[27000]!.text, '3');
    expect(byMs[28000]!.text, '2');
    expect(byMs[29000]!.text, '1');
    expect(byMs[30000]!.text, 'Done');
    expect(byMs[30000]!.kind, CueKind.finish);
    // Nothing regular lands inside the final count.
    expect(cues.where((c) => c.kind == CueKind.tick && c.ms > 27000), isEmpty);
  });

  test('the config survives being saved and read back', () {
    const c = SequenceConfig(
      calls: [(secondsBefore: 4, text: 'Ready')],
      goText: 'Go',
      finishText: 'End',
      lengthSeconds: 45,
      sayEvery: 15,
      finalCount: 5,
      marks: [(atSeconds: 20, text: 'Push')],
      speak: false,
    );
    final back = SequenceConfig.decode(c.encode())!;
    expect(back.calls.single, (secondsBefore: 4, text: 'Ready'));
    expect(back.lengthSeconds, 45);
    expect(back.marks.single, (atSeconds: 20, text: 'Push'));
    expect(back.speak, isFalse);
    expect(SequenceConfig.decode('nonsense'), isNull);
  });

  test('runner fires each cue once, in time, and finishes', () {
    var ms = 0;
    final said = <String>[];
    final run = SequenceRunner(now: () => ms, say: say)
      ..onCue = (cue, _) => said.add('${cue.ms}:${cue.text}');
    run.start(
      const SequenceConfig(
        calls: [(secondsBefore: 2, text: 'Set')],
        goText: 'Go',
        finishText: 'End',
        lengthSeconds: 3,
        finalCount: 1,
      ),
    );
    expect(said, ['-2000:Set']);
    for (var t = 0; t <= 6000; t += 100) {
      ms = t;
      run.onBeat();
    }
    expect(said, ['-2000:Set', '0:Go', '2000:1', '3000:End']);
    expect(run.phase, SequencePhase.done);
    run.dispose();
  });

  test('pausing stops the runner clock', () {
    var ms = 0;
    final run = SequenceRunner(now: () => ms, say: say);
    run.start(const SequenceConfig(calls: [], goText: 'Go', finishText: ''));
    ms = 5000;
    expect(run.positionMs, 5000);
    run.pause();
    ms = 9000;
    expect(run.positionMs, 5000);
    run.start(const SequenceConfig(calls: [], goText: 'Go', finishText: ''));
    ms = 10000;
    expect(run.positionMs, 6000);
    run.dispose();
  });

  test('stopwatch times laps and pauses', () {
    var ms = 0;
    final w = StopwatchModel(() => ms);
    w.start();
    ms = 3000;
    w.lap();
    ms = 8000;
    w.lap();
    expect(w.laps, [8000, 3000]);
    expect(w.lapLength(0), 5000);
    expect(w.lapLength(1), 3000);
    w.pause();
    ms = 20000;
    expect(w.elapsedMs, 8000);
    w.reset();
    expect(w.untouched, isTrue);
    expect(w.laps, isEmpty);
    w.dispose();
  });

  test('countdown schedules the phone alarm, finishes and rings once', () {
    var ms = 0;
    final c = CountdownModel(() => ms)..length = const Duration(seconds: 10);
    var finished = 0;
    final scheduled = <DateTime?>[];
    c.onFinish = () => finished++;
    c.onSchedule = scheduled.add;
    c.start();
    expect(scheduled.single, isNotNull);
    ms = 4000;
    expect(c.remaining, const Duration(seconds: 6));
    c.pause();
    expect(scheduled.last, isNull);
    c.start();
    ms = 20000;
    c.onBeat();
    c.onBeat();
    expect(c.remaining, Duration.zero);
    expect(c.finished, isTrue);
    expect(finished, 1);
    c.dispose();
  });

  testWidgets('the timers screen shows big time and the three tabs', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(prefs)],
        child: MaterialApp(theme: buildTheme(), home: const TimersScreen(initialTab: 1)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('05:00'), findsOneWidget); // The timer's default length.
    await tester.tap(find.text(l10n.timerStopwatch));
    await tester.pumpAndSettle();
    expect(find.text('00:00.00'), findsOneWidget);
    await tester.tap(find.text(l10n.timerSequence));
    await tester.pumpAndSettle();
    expect(find.text(l10n.seqReady), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
