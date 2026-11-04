import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/ringing/ring_style.dart';
import 'package:quando/features/ringing/ui/tasks.dart';

Widget _wrap(Widget w) => MaterialApp(
  theme: buildTheme(),
  home: Scaffold(
    body: Padding(padding: const EdgeInsets.all(16), child: w),
  ),
);

void main() {
  testWidgets('memory game ends when every pair is found', (t) async {
    var done = false;
    await t.pumpWidget(_wrap(MemoryTask(seed: 1, onDone: () => done = true)));
    final state = t.state(find.byType(MemoryTask)) as dynamic;
    final List<IconData> cards = state.cardsForTest;
    final byIcon = <IconData, List<int>>{};
    for (var i = 0; i < cards.length; i++) {
      byIcon.putIfAbsent(cards[i], () => []).add(i);
    }
    final tiles = find.byType(GestureDetector);
    for (final pair in byIcon.values) {
      await t.tap(tiles.at(pair[0]));
      await t.pump();
      await t.tap(tiles.at(pair[1]));
      await t.pump();
    }
    expect(done, isTrue);
  });

  testWidgets('a wrong pair turns back over', (t) async {
    await t.pumpWidget(_wrap(MemoryTask(seed: 1, onDone: () {})));
    final state = t.state(find.byType(MemoryTask)) as dynamic;
    final List<IconData> cards = state.cardsForTest;
    final other = cards.indexWhere((c) => c != cards[0]);
    final tiles = find.byType(GestureDetector);
    await t.tap(tiles.at(0));
    await t.pump();
    await t.tap(tiles.at(other));
    await t.pump();
    expect(find.byIcon(Icons.question_mark), findsNWidgets(10));
    await t.pump(const Duration(seconds: 1));
    expect(find.byIcon(Icons.question_mark), findsNWidgets(12));
  });

  testWidgets('typing the phrase, in any case, stops it', (t) async {
    var done = false;
    await t.pumpWidget(_wrap(PhraseTask(seed: 0, onDone: () => done = true)));
    await t.enterText(find.byType(TextField), 'i AM awake  and the day is mine.');
    await t.tap(find.text('Done'));
    expect(done, isTrue);
  });

  testWidgets('a wrong phrase says so', (t) async {
    var done = false;
    await t.pumpWidget(_wrap(PhraseTask(seed: 0, onDone: () => done = true)));
    await t.enterText(find.byType(TextField), 'I am asleep');
    await t.tap(find.text('Done'));
    await t.pump();
    expect(done, isFalse);
    expect(find.textContaining('Not quite'), findsOneWidget);
  });

  test('scanning without a saved code falls back to a sum', () {
    const base = RingPayload(title: 'Wake', body: 'Alarm', ringSeconds: 60);
    final none = base.withStyle(const RingStyle(task: StopTask.scan));
    expect(none.puzzle, StopTask.none);
    expect(none.mathTask, isTrue);
    final p = RingPayload.decode(
      base.withStyle(const RingStyle(task: StopTask.scan, scanCode: '4006381')).encode(),
    );
    expect(p.puzzle, StopTask.scan);
    expect(p.scanCode, '4006381');
    expect(p.hasTask, isTrue);
    final memory = base.withStyle(const RingStyle(task: StopTask.memory, snoozeTask: StopTask.phrase));
    expect(memory.puzzle, StopTask.memory);
    expect(memory.snoozeTask, StopTask.phrase);
    expect(memory.mathTask, isFalse);
  });
}
