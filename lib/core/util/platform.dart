import 'package:flutter/foundation.dart';

/// Android lets Quando do more than iOS: read the volume buttons, open
/// other apps, play and pause other apps' music, pin the screen.
bool get isAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

bool get isMacOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

/// Platforms with an actual local alarm host, rather than a UI-only preview.
bool get supportsLocalAlarms =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS);
