import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';

/// Scores "Say or type it" against Amazon MASSIVE (CC BY 4.0): real alarm
/// requests, professionally translated, checked against what the English
/// one means. Rebuild the fixture with tool/massive/build_fixture.py.
///
/// The floors only go up: when a change makes a language better, raise
/// its floor so it can't slip back.
const _floors = <String, double>{
  'en': 0.95,
  'pt': 0.94,
  'es': 0.93,
  'fr': 0.86,
  'de': 0.88,
  'it': 0.87,
  'nl': 0.86,
  'pl': 0.89,
  'ru': 0.88,
  'tr': 0.84,
  'ar': 0.85,
  'he': 0.87,
  'hi': 0.85,
  'id': 0.89,
  'ja': 0.93,
  'ko': 0.94,
  'zh': 0.94,
  'zh_Hant': 0.96,
  'vi': 0.8,
};

bool matches(AlarmRequest? r, Map<String, dynamic> e) {
  if (r == null) return false;
  final after = e['after'] as int?;
  if (after != null) return r.after?.inMinutes == after;
  final hour = e['hour'] as int;
  if (r.hour == null || r.minute != e['minute']) return false;
  if (e['halfDayUnsure'] == true) {
    if (r.hour! % 12 != hour % 12) return false;
  } else if (r.hour != hour) {
    return false;
  }
  if (e.containsKey('dayOffset') && r.dayOffset != e['dayOffset']) return false;
  final days = (e['days'] as List?)?.cast<int>().toSet();
  if (days != null && !(r.days.length == days.length && r.days.containsAll(days))) return false;
  final weekday = e['weekday'] as int?;
  if (weekday != null && !(r.onWeekday == weekday || (r.days.length == 1 && r.days.first == weekday))) {
    return false;
  }
  final date = (e['date'] as List?)?.cast<int>();
  if (date != null && (r.month != date[0] || r.dayOfMonth != date[1])) return false;
  return true;
}

void main() {
  final items = (jsonDecode(File('test/fixtures/massive_alarms.json').readAsStringSync())['items'] as List)
      .cast<Map<String, dynamic>>();
  const parser = AlarmParser();

  test('MASSIVE alarm requests, per language', () {
    final lines = <String>[];
    final scores = <String, double>{};
    for (final lang in _floors.keys) {
      var total = 0, ok = 0;
      for (final i in items.where((i) => i['intent'] == 'alarm_set')) {
        final text = (i['text'] as Map)[lang] as String?;
        if (text == null) continue;
        total++;
        final r = parser.parse(text, lang: lang);
        if (matches(r, i['expect'] as Map<String, dynamic>)) {
          ok++;
        } else if (Platform.environment['MASSIVE_FAILS'] == lang) {
          // ignore: avoid_print
          print('✗ $text\n   want ${i['expect']}\n   got  $r');
        }
      }
      scores[lang] = ok / total;
      lines.add('${lang.padRight(8)} ${(100 * ok / total).toStringAsFixed(0).padLeft(3)}%  ($ok/$total)');
    }
    // ignore: avoid_print
    print('MASSIVE alarm_set\n${lines.join('\n')}');
    for (final MapEntry(key: lang, value: floor) in _floors.entries) {
      expect(scores[lang], greaterThanOrEqualTo(floor), reason: lang);
    }
  });
}
