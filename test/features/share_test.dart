import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/share/share_channel.dart';
import 'package:quando/features/share/ui/share_card_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('song links are found in what music apps share', () {
    expect(
      songLinkIn('Listen to Hey Jude on Spotify: https://open.spotify.com/track/abc?si=1'),
      'https://open.spotify.com/track/abc?si=1',
    );
    expect(songLinkIn('https://youtu.be/xyz.'), 'https://youtu.be/xyz');
    expect(
      songLinkIn('(https://music.apple.com/br/album/x/1?i=2)'),
      'https://music.apple.com/br/album/x/1?i=2',
    );
    expect(songLinkIn('https://soundcloud.com/a/b'), 'https://soundcloud.com/a/b');
    expect(songLinkIn('look at https://example.com/page'), isNull);
    expect(songLinkIn('no link here'), isNull);
  });

  testWidgets('the share card shows the quote, your words and the share buttons', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefsProvider.overrideWithValue(prefs),
          clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 12, 9)),
        ],
        child: const MaterialApp(home: ShareCardScreen()),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Instagram Stories'), findsOneWidget);
    expect(find.text('WhatsApp: status or chat'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Good morning, world');
    await tester.pump();
    expect(find.text('Good morning, world'), findsNWidgets(2));
  });
}
