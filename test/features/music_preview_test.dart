import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/app/theme.dart';
import 'package:quando/features/ringing/ui/embedded_music_player.dart';
import 'package:quando/features/sounds/data/radio_stream.dart';
import 'package:quando/features/sounds/domain/sound.dart';
import 'package:quando/features/sounds/ui/music_preview_dialog.dart';
import 'package:quando/features/sounds/ui/sounds_screen.dart';
import 'package:quando/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    useLocale([const Locale('en')]);
  });
  test('radio uses verified HTTPS audio on the same host', () async {
    final client = MockClient((request) async {
      expect(request.method, 'HEAD');
      expect(request.url.toString(), 'https://station.test/live');
      return http.Response('', 200, headers: {'content-type': 'audio/mpeg'});
    });
    expect(await radioPlaybackUrl('http://station.test/live', client: client), 'https://station.test/live');
  });

  test('a web page, failed TLS or an authorization URL cannot become a secure audio source', () async {
    final html = MockClient(
      (_) async => http.Response('<html>', 200, headers: {'content-type': 'text/html'}),
    );
    expect(await radioPlaybackUrl('http://station.test/live', client: html), 'http://station.test/live');
    final broken = MockClient((_) async => throw http.ClientException('TLS failed'));
    expect(await radioPlaybackUrl('http://station.test/live', client: broken), 'http://station.test/live');
    final unused = MockClient((_) async => throw StateError('must not send credentials'));
    expect(
      await radioPlaybackUrl('http://user:password@station.test/live', client: unused),
      'http://user:password@station.test/live',
    );
  });

  testWidgets('Listen opens the official YouTube preview and Stop closes it without scheduling an alarm', (
    tester,
  ) async {
    const record = MethodChannel('com.llfbandit.record/messages');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(record, (_) async => null);
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(record, null));
    SharedPreferences.setMockInitialValues({
      'sounds': jsonEncode([
        {
          'id': 'test.youtube',
          'name': 'My YouTube preview',
          'path': 'assets/sounds/morning_rise.wav',
          'link': 'https://youtu.be/abcdefghijk',
          'plays': true,
        },
      ]),
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(prefs)],
        child: MaterialApp(theme: buildTheme(), home: const SoundsScreen()),
      ),
    );
    final title = find.text('My YouTube preview');
    await tester.scrollUntilVisible(title, 400);
    await tester.ensureVisible(title);
    await tester.pumpAndSettle();
    final row = find.ancestor(of: title, matching: find.byType(ListTile));
    await tester.tap(find.descendant(of: row, matching: find.byIcon(Icons.play_circle_outline)));
    await tester.pumpAndSettle();
    expect(find.byType(MusicPreviewDialog), findsOneWidget);
    expect(tester.widget<EmbeddedMusicPlayer>(find.byType(EmbeddedMusicPlayer)).alarmId, isNull);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text(l10n.stop));
    await tester.pumpAndSettle();
    expect(find.byType(MusicPreviewDialog), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('an expired preview removes its own route beneath a newer alarm card', (tester) async {
    SharedPreferences.setMockInitialValues({
      'alarmOptions': jsonEncode({'ringSeconds': 1}),
    });
    final prefs = await SharedPreferences.getInstance();
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [prefsProvider.overrideWithValue(prefs)],
        child: MaterialApp(
          navigatorKey: navigator,
          theme: buildTheme(),
          home: const Scaffold(body: Text('Home')),
        ),
      ),
    );
    navigator.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => const MusicPreviewDialog(
          sound: AlarmSound(
            id: 'test',
            name: 'Preview',
            path: 'assets/sounds/morning_rise.wav',
            link: 'https://youtu.be/abcdefghijk',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    navigator.currentState!.push(
      MaterialPageRoute<void>(builder: (_) => const Scaffold(body: Text('New alarm card'))),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('New alarm card'), findsOneWidget);
    navigator.currentState!.pop();
    await tester.pumpAndSettle();
    expect(find.byType(MusicPreviewDialog), findsNothing);
    expect(find.text('Home'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
