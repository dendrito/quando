import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../sync/sync_config.dart';

/// "Help improve voice alarms": when the person turns it on, the sentence
/// they said or typed, what Quando? understood and what they did with it
/// are sent anonymously, so a future on-device model can learn from real
/// phrasing. Off until they turn it on; no account, device or location id
/// goes with it. Rules: firestore.rules, collection `voice_samples`
/// (create only; nothing can read it back from a phone).
class VoiceLogNotifier extends Notifier<bool> {
  static const _key = 'voice.log.on';

  @override
  bool build() => ref.read(prefsProvider).getBool(_key) ?? false;

  void set(bool on) {
    ref.read(prefsProvider).setBool(_key, on);
    state = on;
  }
}

final voiceLogProvider = NotifierProvider<VoiceLogNotifier, bool>(VoiceLogNotifier.new);

/// Where samples go. Tests swap it for one that keeps them in memory.
abstract interface class VoiceLogSink {
  Future<void> send(Map<String, Object?> sample);
}

class FirestoreVoiceLog implements VoiceLogSink {
  @override
  Future<void> send(Map<String, Object?> sample) async {
    try {
      if (Firebase.apps.isEmpty) await Firebase.initializeApp(options: SyncConfig.options);
      await FirebaseFirestore.instance.collection('voice_samples').add({
        ...sample,
        'at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Never gets in the way of setting an alarm.
      debugPrint('voice log not sent: $e');
    }
  }
}

final voiceLogSinkProvider = Provider<VoiceLogSink>((ref) => FirestoreVoiceLog());

/// What may be sent: null when it shouldn't go (too long, or it looks like
/// it holds an email address or a phone number).
Map<String, Object?>? voiceSample({
  required String sentence,
  required String lang,
  required String understood,
  required String outcome,
}) {
  final s = sentence.trim();
  if (s.isEmpty || s.length > 200) return null;
  if (s.contains('@') || RegExp(r'\d[\d\s().-]{7,}\d').hasMatch(s)) return null;
  return {'sentence': s, 'lang': lang, 'understood': understood, 'outcome': outcome};
}
