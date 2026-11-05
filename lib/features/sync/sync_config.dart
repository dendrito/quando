import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../app/edition.dart';

/// The Firebase project that keeps your settings in step across devices.
///
/// These values aren't secrets: they only name the project. What protects
/// your data are the project's security rules, which let in one account.
/// Until they're filled in, sync stays hidden and the app works on its own.
class SyncConfig {
  static const projectId = '';
  static const apiKeyAndroid = '';
  static const apiKeyIos = '';
  static const senderId = '';

  /// One app id per edition and platform, as Firebase lists them.
  static const appIdAndroid = '';
  static const appIdAndroidMatai = '';
  static const appIdIos = '';
  static const appIdIosMatai = '';

  /// The iOS sign-in client from GoogleService-Info.plist (CLIENT_ID).
  static const iosClientId = '';
  static const iosClientIdMatai = '';

  static bool get _android => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool get _apple =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS);

  static String get _appId =>
      _android ? (kodesh ? appIdAndroidMatai : appIdAndroid) : (kodesh ? appIdIosMatai : appIdIos);

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
