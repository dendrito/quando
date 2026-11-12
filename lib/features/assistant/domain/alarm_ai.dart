import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'alarm_request.dart';

/// A second reader for sentences the parser isn't sure about (its
/// confidence is below `AlarmReading.unsure`): an on-device model such as
/// Gemini Nano on Android or Apple's Foundation Models on iOS, or a small
/// model trained on Amazon MASSIVE (see tool/massive/export_training.py).
///
/// It answers with the same [AlarmRequest] the parser does, so the preview
/// and Save work the same, and nothing leaves the phone. None is built in
/// yet: [alarmAiProvider] is null until a platform one is added.
abstract interface class AlarmAi {
  /// null = it couldn't read it either.
  Future<AlarmRequest?> read(String input, {String? lang});
}

final alarmAiProvider = Provider<AlarmAi?>((ref) => null);
