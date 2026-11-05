import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';

void main() {
  test('ReminderDelivery round-trips per-reminder audio and Pushover choices', () {
    const delivery = ReminderDelivery(
      audioKind: ReminderAudioKind.elevenLabs,
      audioId: 'speech.cache.meeting-15m',
      pushoverBehavior: PushoverBehavior.alongside,
      pushoverSound: 'cosmic',
      pushoverPriority: 1,
      announcementTemplate: '{title} starts in {countdown}.',
      elevenLabsVoiceId: 'voice-123',
      cachedSpeechId: 'speech-cache-123',
    );

    final restored = ReminderDelivery.fromJson(delivery.toJson());

    expect(restored.audioKind, ReminderAudioKind.elevenLabs);
    expect(restored.audioId, 'speech.cache.meeting-15m');
    expect(restored.pushoverBehavior, PushoverBehavior.alongside);
    expect(restored.pushoverSound, 'cosmic');
    expect(restored.pushoverPriority, 1);
    expect(restored.announcementTemplate, '{title} starts in {countdown}.');
    expect(restored.elevenLabsVoiceId, 'voice-123');
    expect(restored.cachedSpeechId, 'speech-cache-123');
  });

  test('unknown persisted enum values fall back safely for older/future data', () {
    final restored = ReminderDelivery.fromJson({
      'audioKind': 'futureSource',
      'pushoverBehavior': 'futureBehavior',
    });

    expect(restored.audioKind, ReminderAudioKind.inherit);
    expect(restored.pushoverBehavior, PushoverBehavior.inherit);
  });

  test('copyWith can explicitly clear optional values', () {
    const original = ReminderDelivery(
      audioId: 'local.track',
      pushoverSound: 'cosmic',
      announcementTemplate: 'Starts soon',
      elevenLabsVoiceId: 'voice-123',
      cachedSpeechId: 'cache-123',
      pushoverPriority: 2,
    );

    final cleared = original.copyWith(
      clearAudioId: true,
      clearPushoverSound: true,
      clearAnnouncementTemplate: true,
      clearElevenLabsVoiceId: true,
      clearCachedSpeechId: true,
      clearPushoverPriority: true,
    );

    expect(cleared.audioId, isNull);
    expect(cleared.pushoverSound, isNull);
    expect(cleared.announcementTemplate, isNull);
    expect(cleared.elevenLabsVoiceId, isNull);
    expect(cleared.cachedSpeechId, isNull);
    expect(cleared.pushoverPriority, isNull);
  });
}
