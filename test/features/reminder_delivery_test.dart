import 'package:flutter_test/flutter_test.dart';
import 'package:quando/core/scheduler/scheduler.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/alarm_rule.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';

void main() {
  test('scheduler carries independent per-offset delivery into planned alarms', () {
    final now = DateTime.utc(2026, 11, 5, 10);
    final event = AnchorEvent(
      id: 'event-1',
      kind: EventKind.calendar,
      title: 'Meeting',
      at: now.add(const Duration(hours: 2)),
      source: 'google',
    );
    const rule = AlarmRule(
      id: 'r1',
      name: 'Meetings',
      appliesTo: {EventKind.calendar},
      before: [Duration(minutes: 30), Duration(minutes: 5)],
      deliveries: {
        -30: ReminderDelivery(pushoverBehavior: PushoverBehavior.alongside),
        -5: ReminderDelivery(
          audioKind: ReminderAudioKind.radio,
          audioId: 'station',
        ),
      },
    );
    final plan = const Scheduler().plan(now: now, events: [event], rules: [rule]);
    expect(plan, hasLength(2));
    expect(plan[0].offset, const Duration(minutes: -30));
    expect(plan[0].delivery.pushoverBehavior, PushoverBehavior.alongside);
    expect(plan[1].delivery.audioId, 'station');
  });

  test('rule persists different delivery choices at different offsets', () {
    const rule = AlarmRule(
      id: 'meeting',
      name: 'Meeting',
      appliesTo: {EventKind.calendar},
      before: [Duration(minutes: 30), Duration(minutes: 5)],
      deliveries: {
        -30: ReminderDelivery(pushoverBehavior: PushoverBehavior.alongside),
        -5: ReminderDelivery(
          audioKind: ReminderAudioKind.radio,
          audioId: 'station',
        ),
      },
    );
    final restored = rule.withCustom(rule.customJson());
    expect(
      restored.deliveryAt(const Duration(minutes: -30)).pushoverBehavior,
      PushoverBehavior.alongside,
    );
    expect(restored.deliveryAt(const Duration(minutes: -5)).audioId, 'station');
    expect(restored.deliveryAt(Duration.zero).audioKind, ReminderAudioKind.inherit);
    final trimmed = restored.withOffsets([const Duration(minutes: -5)]);
    expect(trimmed.deliveries.keys, [-5]);
  });

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
