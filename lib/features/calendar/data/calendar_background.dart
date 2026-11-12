import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';

/// Android, with Quando? closed: the phone wakes Quando? a few seconds after
/// any calendar changes (and every 15 minutes, for Google Calendar read
/// online). This reads the calendar again and sets the phone's alarms to
/// match, then tells Android it is done.
class CalendarBackground {
  static const channel = MethodChannel('quando/calendar_job');

  /// Ask Android to wake Quando? for calendar changes from now on.
  static Future<void> schedule() async {
    try {
      await const MethodChannel('quando/calendar_watch').invokeMethod<void>('background');
    } on PlatformException {
      // Older phone or no permission: changes are picked up on opening.
    } on MissingPluginException {
      // Not Android.
    }
  }

  /// One background run in [container]. Returns whether alarms were set.
  /// Leaves the alarms alone unless every calendar was read in full: an
  /// event missing from a failed read must not lose its alarm.
  static Future<bool> run(ProviderContainer container) async {
    final calendar = container.read(calendarProvider.notifier);
    await calendar.refresh();
    final state = container.read(calendarProvider);
    if (!state.loaded || !state.access || state.error != null || state.googleError != null) return false;
    await container
        .read(registrarProvider)
        .sync(container.read(planProvider), container.read(payloadForProvider));
    return true;
  }

  static Future<void> done(bool ok) async {
    try {
      await channel.invokeMethod<void>('done', ok);
    } catch (_) {
      // The job times out by itself.
    }
  }
}
