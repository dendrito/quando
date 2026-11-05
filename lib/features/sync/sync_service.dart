import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/providers.dart';

import 'package:quando/l10n/l10n.dart';

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
  Future<Map<String, SyncItem>> push(Map<String, SyncItem> items) =>
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(_doc);
        final data = snapshot.data() ?? <String, dynamic>{};
        final raw = (data['items'] as Map?) ?? const {};
        final merged = <String, dynamic>{for (final entry in raw.entries) '${entry.key}': entry.value};

        // Use a server-serialized revision rather than client wall-clock time.
        // Seed from existing item timestamps to migrate older sync documents.
        var revision = (data['revision'] as num?)?.toInt() ?? 0;
        for (final value in raw.values) {
          final item = SyncItem.fromJson(value);
          if (item != null && item.t > revision) revision = item.t;
        }
        revision++;

        final committed = <String, SyncItem>{};
        for (final entry in items.entries) {
          final item = SyncItem(revision, entry.value.d, entry.value.s);
          committed[entry.key] = item;
          merged[entry.key.replaceAll('.', '~')] = item.toJson();
        }
        transaction.set(_doc, {
          'items': merged,
          'revision': revision,
          'updated': FieldValue.serverTimestamp(),
        });
        return committed;
      });
}

enum SyncPhase {
  off,
  working,
  on,
  notAllowed,
  failed,

  /// Signed in with email, waiting for the link in the confirmation email.
  verify,
}

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

  /// Signs in with an email and password, or makes a new account when
  /// [create] is set. Returns what went wrong, in words, or null.
  Future<String?> signInWithEmail(String email, String password, {bool create = false}) async {
    if (!available) return l10n.syncNotSetUp;
    try {
      await _firebase();
      final auth = FirebaseAuth.instance;
      final cred = create
          ? await auth.createUserWithEmailAndPassword(email: email.trim(), password: password)
          : await auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      final user = cred.user!;
      if (!user.emailVerified) {
        if (create) await user.sendEmailVerification();
        state = state.copyWith(phase: SyncPhase.verify, email: user.email);
        return null;
      }
      state = state.copyWith(phase: SyncPhase.working);
      await _start(user);
      return null;
    } on FirebaseAuthException catch (e) {
      return emailError(e.code);
    } catch (e) {
      debugPrint('Quando? sync: $e');
      return l10n.syncFailed;
    }
  }

  /// After tapping the link in the confirmation email.
  Future<bool> confirmEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    await user.reload();
    final fresh = FirebaseAuth.instance.currentUser!;
    if (!fresh.emailVerified) return false;
    await fresh.getIdToken(true); // the server reads "verified" from a fresh token
    state = state.copyWith(phase: SyncPhase.working);
    await _start(fresh);
    return true;
  }

  Future<void> resendConfirmation() async => FirebaseAuth.instance.currentUser?.sendEmailVerification();

  /// Emails a link to choose a new password. Returns what went wrong, or null.
  Future<String?> resetPassword(String email) async {
    try {
      await _firebase();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return emailError(e.code);
    }
  }

  static String emailError(String code) => switch (code) {
    'invalid-email' => l10n.emailInvalid,
    'user-not-found' || 'wrong-password' || 'invalid-credential' => l10n.emailWrong,
    'email-already-in-use' => l10n.emailInUse,
    'weak-password' => l10n.passwordWeak,
    'operation-not-allowed' => l10n.emailNotSwitchedOn,
    'too-many-requests' => l10n.tooManyTries,
    _ => l10n.syncFailed,
  };

  Future<void> _start(User user) async {
    final prefs = ref.read(prefsProvider);
    // The server's rules turn away anyone it doesn't let sync (e.g. an unconfirmed email).
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
    for (final k in ['sync.last', 'sync.stamps', 'sync.origins', 'sync.email', 'sync.name', 'sync.photo']) {
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
