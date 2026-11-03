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
            builder: (context, setState) =>
                RingLengthPicker(seconds: value, onChanged: (s) => setState(() => value = s)),
          ),
        ),
      ),
    );
    await tester.tap(find.byTooltip('1 second less'));
    await tester.pump();
    await tester.tap(find.byTooltip('1 second less'));
    await tester.pump();
    await tester.tap(find.byTooltip('1 second less')); // disabled at 1
    await tester.pump();
    expect(value, 1);
    expect(find.text('1 second'), findsOneWidget);
    await tester.tap(find.text('5 s'));
    await tester.pump();
    expect(value, 5);
  });
}
