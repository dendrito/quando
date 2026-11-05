import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../app/edition.dart';

/// The Firebase project that keeps your settings in step across devices.
///
/// These values aren't secrets: they only name the project. What protects
/// your data are the project's security rules, which let in one account.
/// Until they're filled in, sync stays hidden and the app works on its own.
class SyncConfig {
  static const projectId = 'quando-27c24';
  static const apiKeyAndroid = 'AIzaSyDPqkWtjkkrm1HAy-felBdA2VTrJ4kyOao';
  static const apiKeyIos = 'AIzaSyADqaIICM-OFNDnKq5ksiuijH6UsYGvv74';
  static const senderId = '216517788382';

  /// One app id per edition and platform, as Firebase lists them.
  static const appIdAndroid = '1:216517788382:android:1379ca100435e0099e384f';
  static const appIdAndroidMatai = '1:216517788382:android:c0d17f9cc4c601139e384f';
  static const appIdIos = '1:216517788382:ios:99aa2bf02a4239099e384f';
  static const appIdIosMatai = '1:216517788382:ios:234bb24b72d1084f9e384f';

  /// The iOS sign-in client from GoogleService-Info.plist (CLIENT_ID).
  static const iosClientId = '216517788382-nv4cmk4sa7boc2ebp7ddd6htdj4f9jku.apps.googleusercontent.com';
  static const iosClientIdMatai = '216517788382-u2m9fn9n6nul6co31svplmktcjlgpgvk.apps.googleusercontent.com';

  static bool get _android => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool get _apple =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS);

  static String get _appId =>
      _android ? (kodesh ? appIdAndroidMatai : appIdAndroid) : (kodesh ? appIdIosMatai : appIdIos);

  /// The Firebase project's own web client. Apple devices ask Google for a
  /// sign-in token meant for it. Android keeps the YouTube project's web
  /// client, which Firebase is told to trust (Authentication → Google →
  /// "Safelist client IDs from external projects").
  static const webClientId = '216517788382-8ko4t17hcqe5na1mnbvk2d3ad6rg032a.apps.googleusercontent.com';

  static String? get iosClient => _apple ? (kodesh ? iosClientIdMatai : iosClientId) : null;

  /// Whether this build knows its Firebase project.
  static bool get ready => projectId.isNotEmpty && _appId.isNotEmpty && (_android || _apple);

  static FirebaseOptions get options => FirebaseOptions(
    apiKey: _android ? apiKeyAndroid : apiKeyIos,
    appId: _appId,
    messagingSenderId: senderId,
    projectId: projectId,
    storageBucket: '$projectId.firebasestorage.app',
    iosClientId: iosClient,
    iosBundleId: _apple ? (kodesh ? 'com.dendrito.quando.kodesh' : 'com.dendrito.quando') : null,
  );
}
