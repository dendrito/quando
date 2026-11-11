import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/calendar/data/calendar_watch.dart';
import 'package:quando/features/calendar/domain/calendar_sync.dart';
import 'package:quando/features/calendar/ui/calendar_sync_choice.dart';
import 'package:quando/l10n/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => useLocale(const [Locale('en')]));

  testWidgets('three choices with a one-line summary each, and a help sheet', (tester) async {
    var value = CalendarSync.live;
    await tester.pumpWidget(
      MaterialApp(
        theme: buildTheme(),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: CalendarSyncChoice(value: value, onChanged: (v) => setState(() => value = v)),
            ),
          ),
        ),
      ),
    );
    expect(find.text(l10n.syncLive), findsOneWidget);
    expect(find.text(l10n.syncKeepFirstHint), findsOneWidget);
    expect(find.text(l10n.syncSnapshotHint), findsOneWidget);
    await tester.tap(find.text(l10n.syncKeepFirst));
    await tester.pump();
    expect(value, CalendarSync.keepFirst);

    await tester.tap(find.byKey(const Key('syncHelp')));
    await tester.pumpAndSettle();
    expect(find.text(l10n.syncHelpTitle), findsOneWidget);
    expect(find.text(l10n.syncHelpExampleLive), findsOneWidget);
    expect(find.text(l10n.syncHelpWhenTitle), findsOneWidget);
  });

  testWidgets('a burst of calendar changes reads once, after a short pause', (tester) async {
    var reads = 0;
    final watch = CalendarWatch(onChange: () async => reads++);
    unawaited(watch.start());
    for (var i = 0; i < 10; i++) {
      watch.changed();
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(reads, 0);
    await tester.pump(const Duration(seconds: 2));
    expect(reads, 1);
    // With no signal, it reads again every 2 minutes.
    await tester.pump(const Duration(minutes: 2, seconds: 2));
    expect(reads, 2);
    unawaited(watch.stop());
    watch.changed();
    await tester.pump(const Duration(minutes: 5));
    expect(reads, 2);
  });
}
