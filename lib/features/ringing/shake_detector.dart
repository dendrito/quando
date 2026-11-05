import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

/// Calls [onShake] for each firm shake of the phone.
class ShakeDetector {
  ShakeDetector({
    required this.onShake,
    this.threshold = 14,
    this.gap = const Duration(milliseconds: 250),
  });

  final void Function() onShake;

  /// Acceleration beyond gravity, in m/s², that counts as a shake.
  final double threshold;

  /// Shakes closer together than this count once.
  final Duration gap;

  StreamSubscription<UserAccelerometerEvent>? _sub;
  DateTime _last = DateTime(0);

  void start() {
    try {
      _sub = userAccelerometerEventStream().listen((e) {
        final g = sqrt(e.x * e.x + e.y * e.y + e.z * e.z);
        final now = DateTime.now();
        if (g > threshold && now.difference(_last) > gap) {
          _last = now;
          onShake();
        }
      }, onError: (_) {});
    } catch (_) {
      // No motion sensor: the buttons on screen still work.
    }
  }

  void stop() => _sub?.cancel();
}
