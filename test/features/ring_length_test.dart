import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/util/format.dart';
import 'package:quando/features/alarms/ui/ring_length_picker.dart';

void main() {
  test('ring lengths read in seconds too', () {
    expect(formatSpan(const Duration(seconds: 1)), '1 second');
    expect(formatSpan(const Duration(seconds: 3)), '3 seconds');
    expect(formatSpan(const Duration(seconds: 90)), '1 minute 30 seconds');
  });

  testWidgets('picker goes down to 1 second and no lower', (tester) async {
    var value = 3;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => RingLengthPicker(
              seconds: value,
              onChanged: (s) => setState(() => value = s),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.remove)); // disabled at 1
    await tester.pump();
    expect(value, 1);
    expect(find.text('1 second'), findsOneWidget);
    await tester.tap(find.text('5 s'));
    await tester.pump();
    expect(value, 5);
  });

  testWidgets('holding + speeds up', (tester) async {
    var value = 10;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => RingLengthPicker(
              seconds: value,
              onChanged: (s) => setState(() => value = s),
            ),
          ),
        ),
      ),
    );
    final gesture = await tester.startGesture(
      tester.getCenter(find.byIcon(Icons.add)),
    );
    await tester.pump(const Duration(milliseconds: 450));
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 120));
    }
    await gesture.up();
    await tester.pump();
    // 10 steps of 1 s, 12 of 5 s, then 30 s steps: well past a minute.
    expect(value, greaterThan(100));
    final held = value;
    await tester.pump(const Duration(seconds: 1));
    expect(value, held); // stops when released
  });
}
