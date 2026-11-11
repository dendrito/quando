import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/providers.dart';

/// What "Say or type it" learned on this phone, and nowhere else:
///
/// - phrases the person taught it: "gym time" → "6:00";
/// - which half of the day they mean by a bare hour: "at 7" → evening.
class Learned {
  const Learned({this.phrases = const {}, this.halfDay = const {}});

  /// A phrase, as typed (lower case), and the time it stands for, "6:00".
  final Map<String, String> phrases;

  /// An hour (1-11) and whether it meant the evening.
  final Map<int, bool> halfDay;

  /// [input] with taught phrases swapped for their times, so the parser
  /// reads "gym time tomorrow" as "6:00 tomorrow".
  String apply(String input) {
    var s = input;
    final keys = phrases.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    for (final k in keys) {
      s = s.replaceAll(
        RegExp('(?<![\\p{L}\\d])${RegExp.escape(k)}(?![\\p{L}\\d])', unicode: true, caseSensitive: false),
        phrases[k]!,
      );
    }
    return s;
  }

  Map<String, dynamic> toJson() => {
    'phrases': phrases,
    'halfDay': {for (final MapEntry(:key, :value) in halfDay.entries) '$key': value},
  };

  factory Learned.fromJson(Map<String, dynamic> j) => Learned(
    phrases: {for (final MapEntry(:key, :value) in (j['phrases'] as Map? ?? {}).entries) '$key': '$value'},
    halfDay: {
      for (final MapEntry(:key, :value) in (j['halfDay'] as Map? ?? {}).entries)
        int.parse('$key'): value == true,
    },
  );
}

class LearnedNotifier extends Notifier<Learned> {
  SharedPreferences get _prefs => ref.read(prefsProvider);

  @override
  Learned build() {
    try {
      final raw = _prefs.getString('assistant.learned');
      return raw == null ? const Learned() : Learned.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const Learned();
    }
  }

  /// "gym time" now means [hour]:[minute].
  void teach(String phrase, int hour, int minute) {
    final p = phrase.trim().toLowerCase();
    if (p.isEmpty) return;
    _set(
      Learned(
        phrases: {...state.phrases, p: '$hour:${minute.toString().padLeft(2, '0')}'},
        halfDay: state.halfDay,
      ),
    );
  }

  void forget(String phrase) =>
      _set(Learned(phrases: {...state.phrases}..remove(phrase), halfDay: state.halfDay));

  /// A bare [hour] (1-11) meant the evening, or the morning.
  void halfDay(int hour, {required bool evening}) {
    if (hour < 1 || hour > 11) return;
    _set(Learned(phrases: state.phrases, halfDay: {...state.halfDay, hour: evening}));
  }

  void _set(Learned l) {
    state = l;
    _prefs.setString('assistant.learned', jsonEncode(l.toJson()));
  }
}

final learnedProvider = NotifierProvider<LearnedNotifier, Learned>(LearnedNotifier.new);
