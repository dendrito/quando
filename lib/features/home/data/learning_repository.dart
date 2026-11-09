import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const learningCategories = {
  'dafyomi': 'daf',
  'dailyRambam1': 'rambam1',
  'dailyRambam3': 'rambam3',
  'seferHaMitzvot': 'mitzvot',
  'mishnayomi': 'mishnah',
  'nachyomi': 'nach',
};

class LearningReading {
  const LearningReading({
    required this.course,
    required this.date,
    required this.title,
    required this.hebrew,
    this.link,
  });
  final String course, date, title, hebrew;
  final Uri? link;
  Map<String, dynamic> toJson() => {
    'course': course,
    'date': date,
    'title': title,
    'hebrew': hebrew,
    'link': link?.toString(),
  };
  factory LearningReading.fromJson(Map<String, dynamic> j) => LearningReading(
    course: j['course'] as String,
    date: j['date'] as String,
    title: j['title'] as String,
    hebrew: j['hebrew'] as String? ?? '',
    link: _safeLink(j['link']),
  );
  static Uri? _safeLink(Object? value) {
    if (value is! String) return null;
    final u = Uri.tryParse(value);
    return u != null &&
            u.scheme == 'https' &&
            u.userInfo.isEmpty &&
            {'www.sefaria.org', 'sefaria.org', 'www.chabad.org', 'www.hebcal.com'}.contains(u.host)
        ? u
        : null;
  }
}

String learningDateKey(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

/// Date-only public schedules; no coordinates or user account are transmitted.
class LearningRepository {
  LearningRepository(this.prefs, {http.Client? client}) : _client = client ?? http.Client();
  final SharedPreferences prefs;
  final http.Client _client;
  final _pending = <String, Future<List<LearningReading>>>{};
  Future<List<LearningReading>> month(DateTime day, {required bool inIsrael}) async {
    final key = 'learning.${day.year}.${day.month}.$inIsrael';
    final saved = prefs.getString(key);
    if (saved != null) {
      try {
        return [
          for (final x in jsonDecode(saved) as List) LearningReading.fromJson((x as Map).cast<String, dynamic>()),
        ];
      } catch (_) {
        /* A corrupt cache can be fetched again. */
      }
    }
    final request = _pending.putIfAbsent(key, () => _fetch(day, inIsrael, key));
    try {
      return await request;
    } finally {
      if (identical(_pending[key], request)) _pending.remove(key);
    }
  }

  Future<List<LearningReading>> _fetch(DateTime day, bool inIsrael, String key) async {
    final start = learningDateKey(DateTime(day.year, day.month, 1)),
        end = learningDateKey(DateTime(day.year, day.month + 1, 0));
    final response = await _client
        .get(
          Uri.https('www.hebcal.com', '/hebcal', {
            'v': '1',
            'cfg': 'json',
            'start': start,
            'end': end,
            'i': inIsrael ? 'on' : 'off',
            'F': 'on',
            'dr1': 'on',
            'dr3': 'on',
            'dsm': 'on',
            'myomi': 'on',
            'nyomi': 'on',
          }),
        )
        .timeout(const Duration(seconds: 12));
    if (response.statusCode != 200) throw StateError('Learning calendar unavailable');
    final raw = jsonDecode(response.body) as Map<String, dynamic>;
    final out = <LearningReading>[];
    for (final item in raw['items'] as List) {
      if (item is! Map || item['date'] is! String || item['title'] is! String) continue;
      final course = learningCategories[item['category']];
      if (course == null) continue;
      out.add(
        LearningReading(
          course: course,
          date: item['date'] as String,
          title: item['title'] as String,
          hebrew: item['hebrew'] as String? ?? '',
          link: LearningReading._safeLink(item['link']),
        ),
      );
    }
    if (out.isEmpty) throw StateError('Learning calendar missing');
    await prefs.setString(key, jsonEncode([for (final reading in out) reading.toJson()]));
    // Keep bounded local data: this month plus the immediately previous month.
    for (final old in prefs.getKeys().where((k) => k.startsWith('learning.') && k != key).toList()) {
      final parts = old.split('.');
      if (parts.length != 4) continue;
      final year = int.tryParse(parts[1]), month = int.tryParse(parts[2]);
      if (year != null && month != null && DateTime(year, month).isBefore(DateTime(day.year, day.month - 1))) {
        await prefs.remove(old);
      }
    }
    return out;
  }

  void close() => _client.close();
}
