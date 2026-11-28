import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/alarms/data/alarm_registrar.dart';
import 'package:quando/features/ringing/ring_payload.dart';
import 'package:quando/features/rules/domain/alarm_priority.dart';
import 'package:quando/features/rules/domain/reminder_delivery.dart';
import 'package:quando/features/settings/domain/alarm_options.dart';

RingPayload _p({bool safe = false}) =>
    RingPayload.forAlarm(title: 't', body: 'b', options: const AlarmOptions(), shabbatSafe: safe);

void main() {
  test('priority survives storage and defaults to loud', () {
    expect(const AlarmOptions().priority, AlarmPriority.loud);
    final o = AlarmOptions.fromJson(const AlarmOptions(priority: AlarmPriority.normal).toJson());
    expect(o.priority, AlarmPriority.normal);
    expect(ReminderDelivery.fromJson({}).priority, isNull);
    final d = const ReminderDelivery(priority: AlarmPriority.quiet);
    expect(ReminderDelivery.fromJson(d.toJson()).priority, AlarmPriority.quiet);
    expect(d.copyWith(inheritPriority: true).priority, isNull);
    final p = RingPayload.decode(_p().withPriority(AlarmPriority.normal).encode());
    expect(p.priority, AlarmPriority.normal);
    expect(RingPayload.decode(_p().encode()).priority, AlarmPriority.loud);
  });

  test('critical rings until stopped, except inside Shabbat', () {
    final c = _p().withPriority(AlarmPriority.critical);
    expect(c.loop, isTrue);
    expect(c.ringSeconds, AlarmPriority.criticalSeconds);
    expect(c.autoSnoozeMinutes, 0);
    final s = _p(safe: true).withPriority(AlarmPriority.critical);
    expect(s.priority, AlarmPriority.loud);
    expect(s.ringSeconds, 60);
  });

  test('normal plays sound without the full screen', () {
    final at = DateTime(2030);
    final loud = AlarmRegistrar.settingsFor(1, at, _p().withPriority(AlarmPriority.loud));
    final normal = AlarmRegistrar.settingsFor(1, at, _p().withPriority(AlarmPriority.normal));
    expect(loud.androidFullScreenIntent, isTrue);
    expect(normal.androidFullScreenIntent, isFalse);
    expect(normal.vibrate, isFalse);
  });
}
