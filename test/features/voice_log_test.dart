import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/data/voice_log.dart';

void main() {
  test('a sample holds only the sentence, language, reading and outcome', () {
    final s = voiceSample(sentence: ' wake me at 7 ', lang: 'en', understood: 'at 7:00', outcome: 'saved');
    expect(s, {'sentence': 'wake me at 7', 'lang': 'en', 'understood': 'at 7:00', 'outcome': 'saved'});
  });

  test('nothing is sent for empty, long or personal-looking sentences', () {
    String? send(String t) =>
        voiceSample(sentence: t, lang: 'en', understood: '', outcome: 'cancelled')?['sentence'] as String?;
    expect(send('   '), isNull);
    expect(send('x' * 201), isNull);
    expect(send('remind me to email ana@example.com'), isNull);
    expect(send('call 555 123 4567 at 6'), isNull);
    expect(send('remind me at 7 to call grandma'), isNotNull);
  });

  test('the question is asked once, and never in the Jewish editions', () {
    expect(voiceLogMayAsk(false, false, jewishEdition: false), isTrue);
    expect(voiceLogMayAsk(true, false, jewishEdition: false), isFalse);
    expect(voiceLogMayAsk(false, true, jewishEdition: false), isFalse);
    expect(voiceLogMayAsk(false, false, jewishEdition: true), isFalse);
  });
}
