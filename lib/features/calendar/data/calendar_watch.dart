import 'dart:async';

import 'package:flutter/services.dart';

/// Tells Quando? when the calendar changes, so calendar alarms follow it as
/// it happens while the app is open:
///
/// * the phone says so at once (Android watches its calendar store, iPhone
///   and iPad listen for EventKit changes); a burst of edits counts once;
/// * Google Calendar read online has no such signal, so it is read again
///   every [every] while the app is in front.
///
/// With the app closed, Android's background check (a later update) and
/// opening the app pick changes up.
class CalendarWatch {
  CalendarWatch({
    required this.onChange,
    this.pause = const Duration(seconds: 2),
    this.every = const Duration(minutes: 2),
    MethodChannel? channel,
  }) : _channel = channel ?? const MethodChannel('quando/calendar_watch');

  final Future<void> Function() onChange;

  /// Waits this long after a change before reading, so ten edits read once.
  final Duration pause;

  /// How often to read again with no signal.
  final Duration every;

  final MethodChannel _channel;
  Timer? _soon;
  Timer? _poll;
  bool _running = false;

  /// Starts listening (the app came to the front).
  Future<void> start() async {
    if (_running) return;
    _running = true;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'changed') changed();
      // Android's background check found a change while Quando? sat in
      // the back: read now, even though the watch is paused.
      if (call.method == 'refresh') await onChange();
    });
    _poll = Timer.periodic(every, (_) => changed());
    try {
      await _channel.invokeMethod<void>('start');
    } on PlatformException {
      // No phone signal: the timer still reads again.
    } on MissingPluginException {
      // Desktop or tests: the timer still reads again.
    }
  }

  /// Stops listening (the app went to the back).
  Future<void> stop() async {
    if (!_running) return;
    _running = false;
    _soon?.cancel();
    _poll?.cancel();
    try {
      await _channel.invokeMethod<void>('stop');
    } on PlatformException {
      // Nothing to stop.
    } on MissingPluginException {
      // Nothing to stop.
    }
  }

  /// Something changed: read again after a short pause.
  void changed() {
    if (!_running) return;
    _soon?.cancel();
    _soon = Timer(pause, () => onChange());
  }
}
