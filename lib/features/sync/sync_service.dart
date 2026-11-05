import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/providers.dart';
import '../sounds/data/youtube_library.dart';
import 'sync_config.dart';
import 'sync_engine.dart';

/// Firestore keeps one document per account: users/{uid}, holding each
/// setting under `items`. Dots aren't allowed in its field names, so they
/// travel as `~`.
class FirestoreRemote implements SyncRemote {
  FirestoreRemote(String uid) : _doc = FirebaseFirestore.instance.collection('users').doc(uid);

  final DocumentReference<Map<String, dynamic>> _doc;

  @override
  Stream<Map<String, SyncItem>> watch() => _doc.snapshots().map((s) {
    final raw = (s.data()?['items'] as Map?) ?? const {};
    return {for (final e in raw.entries) '${e.key}'.replaceAll('~', '.'): ?SyncItem.fromJson(e.value)};
  });

  @override
  Future<void> push(Map<String, SyncItem> items) => _doc.set({
    'items': {for (final e in items.entries) e.key.replaceAll('.', '~'): e.value.toJson()},
    'updated': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

enum SyncPhase { off, working, on, notAllowed, failed }

class SyncStatus {
  const SyncStatus({this.revealed = false, this.phase = SyncPhase.off, this.email, this.name, this.photo});

  /// Kept for older builds; the account card now always shows.
  final bool revealed;
  final SyncPhase phase;
  final String? email;

  /// The Google account's name and picture, for the account card.
  final String? name;
  final String? photo;

  SyncStatus copyWith({bool? revealed, SyncPhase? phase, String? email, String? name, String? photo}) =>
      SyncStatus(
        revealed: revealed ?? this.revealed,
        phase: phase ?? this.phase,
        email: email ?? this.email,
        name: name ?? this.name,
        photo: photo ?? this.photo,
      );
}

/// Signs in with Google and keeps settings in step while signed in.
class SyncNotifier extends Notifier<SyncStatus> {
  SyncEngine? _engine;
  static bool _firebaseUp = false;

  @override
  SyncStatus build() {
    ref.onDispose(() => _engine?.stop());
    final prefs = ref.read(prefsProvider);
    final revealed = prefs.getBool('sync.revealed') ?? false;
    if (SyncConfig.ready && (prefs.getBool('sync.on') ?? false)) {
      Future.microtask(_resume);
      return SyncStatus(
        revealed: revealed,
        phase: SyncPhase.working,
        email: prefs.getString('sync.email'),
        name: prefs.getString('sync.name'),
        photo: prefs.getString('sync.photo'),
      );
    }
    return SyncStatus(revealed: revealed);
  }

  bool get available => SyncConfig.ready;

  void reveal() {
    ref.read(prefsProvider).setBool('sync.revealed', true);
    state = state.copyWith(revealed: true);
  }

  static Future<void> _firebase() async {
    if (_firebaseUp) return;
    if (Firebase.apps.isEmpty) await Firebase.initializeApp(options: SyncConfig.options);
    _firebaseUp = true;
  }

  Future<void> _resume() async {
    try {
      await _firebase();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        state = state.copyWith(phase: SyncPhase.off);
        return;
      }
      await _start(user);
    } catch (e) {
      debugPrint('Quando? sync: $e');
      state = state.copyWith(phase: SyncPhase.failed);
    }
  }

  Future<void> signIn() async {
    if (!available) return;
    state = state.copyWith(phase: SyncPhase.working);
    try {
      await _firebase();
      await YouTubeAccount.init();
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      final cred = await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      await _start(cred.user!);
    } on GoogleSignInException catch (e) {
      state = state.copyWith(
        phase: e.code == GoogleSignInExceptionCode.canceled ? SyncPhase.off : SyncPhase.failed,
      );
    } catch (e) {
      debugPrint('Quando? sync: $e');
      state = state.copyWith(phase: SyncPhase.failed);
    }
  }

  Future<void> _start(User user) async {
    final prefs = ref.read(prefsProvider);
    // Only one account may sync: the server's rules turn everyone else away.
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        await FirebaseAuth.instance.signOut();
        await prefs.setBool('sync.on', false);
        state = state.copyWith(phase: SyncPhase.notAllowed, email: user.email);
        return;
      }
    }
    var device = prefs.getString('sync.device');
    if (device == null) {
      device = List.generate(12, (_) => Random.secure().nextInt(36).toRadixString(36)).join();
      await prefs.setString('sync.device', device);
    }
    await _engine?.stop();
    _engine = SyncEngine(prefs, FirestoreRemote(user.uid), device: device, onApplied: _reload)..start();
    await prefs.setBool('sync.on', true);
    if (user.email != null) await prefs.setString('sync.email', user.email!);
    if (user.displayName != null) await prefs.setString('sync.name', user.displayName!);
    if (user.photoURL != null) await prefs.setString('sync.photo', user.photoURL!);
    state = state.copyWith(
      phase: SyncPhase.on,
      email: user.email,
      name: user.displayName,
      photo: user.photoURL,
    );
  }

  Future<void> signOut() async {
    await _engine?.stop();
    _engine = null;
    final prefs = ref.read(prefsProvider);
    await prefs.setBool('sync.on', false);
    for (final k in ['sync.last', 'sync.stamps', 'sync.email', 'sync.name', 'sync.photo']) {
      await prefs.remove(k);
    }
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
    state = SyncStatus(revealed: state.revealed);
  }

  /// Settings arrived from another device: read them again.
  void _reload() {
    for (final p in <ProviderOrFamily>[
      languageProvider,
      quoteSourcesProvider,
      quoteOccasionsProvider,
      timeZonesProvider,
      placeProvider,
      havdalahProvider,
      rulesProvider,
      skippedProvider,
      alarmOptionsProvider,
      calendarRulesProvider,
      userAlarmsProvider,
      lockSettingsProvider,
      dismissedLocksProvider,
      integrationsProvider,
    ]) {
      ref.invalidate(p);
    }
  }
}

final syncProvider = NotifierProvider<SyncNotifier, SyncStatus>(SyncNotifier.new);
