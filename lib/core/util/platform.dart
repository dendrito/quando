import 'package:flutter/foundation.dart';

/// Android lets Quando do more than iOS: read the volume buttons, open
/// other apps, play and pause other apps' music, pin the screen.
bool get isAndroid =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
