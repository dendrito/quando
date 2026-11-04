import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quando/l10n/l10n.dart';

import '../../../app/edition.dart';

/// One station from the free Radio Browser directory (radio-browser.info).
class RadioStation {
  const RadioStation({
    required this.name,
    required this.url,
    this.country = '',
    this.countryCode = '',
    this.tags = '',
    this.codec = '',
    this.bitrate = 0,
  });

  final String name;

  /// The stream itself, not a playlist file.
  final String url;
  final String country;

  /// ISO code, such as "IL".
  final String countryCode;

  /// Radio Browser's comma-separated genre tags.
  final String tags;
  final String codec;
  final int bitrate;

  /// "France · MP3 128 kbps".
  String get details => [
    if (country.isNotEmpty) country,
    if (codec.isNotEmpty) bitrate > 0 ? '$codec $bitrate kbps' : codec,
  ].join(' · ');

  static RadioStation? fromJson(Map<String, dynamic> j) {
    final url = ((j['url_resolved'] as String?)?.trim().isNotEmpty ?? false)
        ? (j['url_resolved'] as String).trim()
        : (j['url'] as String? ?? '').trim();
    final name = (j['name'] as String? ?? '').trim();
    if (name.isEmpty || !isStreamUrl(url)) return null;
    return RadioStation(
      name: name,
      url: url,
      country: (j['country'] as String? ?? '').trim(),
      countryCode: (j['countrycode'] as String? ?? '').trim().toUpperCase(),
      tags: (j['tags'] as String? ?? '').trim(),
      codec: (j['codec'] as String? ?? '').trim(),
      bitrate: (j['bitrate'] as num?)?.toInt() ?? 0,
    );
  }
}

bool isStreamUrl(String url) {
  final u = Uri.tryParse(url);
  return u != null && (u.scheme == 'http' || u.scheme == 'https') && u.host.isNotEmpty;
}

/// Searches Radio Browser by station name. Tries a few of its mirrors.
class RadioDirectory {
  RadioDirectory({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _mirrors = [
    'de1.api.radio-browser.info',
    'fi1.api.radio-browser.info',
    'at1.api.radio-browser.info',
  ];

  /// Stations by [name], [tag] (a genre such as "jazz") and [countryCode]
  /// ("US"), most listened first. Any of them may be left out.
  Future<List<RadioStation>> search(String name, {String? tag, String? countryCode}) async {
    final q = name.trim();
    if (q.isEmpty && (tag ?? '').isEmpty && (countryCode ?? '').isEmpty) return const [];
    Object? lastError;
    for (final host in _mirrors) {
      try {
        final uri = Uri.https(host, '/json/stations/search', {
          if (q.isNotEmpty) 'name': q,
          if ((tag ?? '').isNotEmpty) 'tag': tag,
          if ((countryCode ?? '').isNotEmpty) 'countrycode': countryCode,
          'limit': kodesh ? '300' : '60',
          'hidebroken': 'true',
          'order': 'clickcount',
          'reverse': 'true',
        });
        final r = await _client
            .get(uri, headers: {'User-Agent': 'Quando/0.1'})
            .timeout(const Duration(seconds: 8));
        if (r.statusCode != 200) continue;
        final list = jsonDecode(r.body) as List;
        final seen = <String>{};
        return [
          for (final j in list)
            if (RadioStation.fromJson(j as Map<String, dynamic>) case final s?
                when (!kodesh || isJewishStation(s)) && seen.add(s.url))
              s,
        ].take(60).toList();
      } catch (e) {
        lastError = e;
      }
    }
    throw lastError ?? Exception(l10n.radioUnreachable);
  }
}

/// Israeli or Jewish: the only stations Quando? Shabbat offers.
bool isJewishStation(RadioStation s) => s.countryCode == 'IL' || _jewish.hasMatch('${s.name} ${s.tags}');

final _jewish = RegExp(
  r'jewish|judaic|judaism|hebrew|israel|torah|chassid|hassid|hasid|chabad|lubavitch|klezmer|yiddish|'
  r'chazzan|hazzan|cantorial|kosher|yeshiva|shabbat|ישראל|יהוד|חסיד|תורה|קול חי|קול ברמה|מורשת',
  caseSensitive: false,
);

/// Genres to browse by. Quando? Shabbat has only Jewish ones.
List<(String, String)> get radioGenres => kodesh ? _jewishGenres : _allGenres;

const _jewishGenres = [
  ('Jewish', 'jewish'),
  ('Hebrew', 'hebrew'),
  ('Israeli', 'israeli'),
  ('Chassidic', 'chassidic'),
  ('Torah', 'torah'),
  ('Klezmer', 'klezmer'),
  ('Yiddish', 'yiddish'),
];

const _allGenres = [
  ('Pop', 'pop'),
  ('Rock', 'rock'),
  ('Jazz', 'jazz'),
  ('Classical', 'classical'),
  ('News', 'news'),
  ('Talk', 'talk'),
  ('Chill', 'chillout'),
  ('Lounge', 'lounge'),
  ('Ambient', 'ambient'),
  ('Jewish', 'jewish'),
  ('Country', 'country'),
  ('Hip hop', 'hip hop'),
  ('Electronic', 'electronic'),
  ('Oldies', 'oldies'),
  ('80s', '80s'),
  ('Latin', 'latin'),
  ('Samba', 'samba'),
  ('MPB', 'mpb'),
  ('Bossa nova', 'bossa nova'),
  ('J-pop', 'jpop'),
  ('K-pop', 'kpop'),
  ('Chinese', 'chinese'),
  ('Middle Eastern', 'arabic'),
  ('Soul', 'soul'),
  ('Reggae', 'reggae'),
  ('Kids', 'kids'),
  ('Religious', 'religious'),
];

/// Countries to browse by: name and ISO code.
const radioCountries = [
  ('Israel', 'IL'),
  ('United States', 'US'),
  ('United Kingdom', 'GB'),
  ('Canada', 'CA'),
  ('Australia', 'AU'),
  ('Brazil', 'BR'),
  ('Portugal', 'PT'),
  ('Spain', 'ES'),
  ('Mexico', 'MX'),
  ('Argentina', 'AR'),
  ('France', 'FR'),
  ('Germany', 'DE'),
  ('Italy', 'IT'),
  ('Netherlands', 'NL'),
  ('Belgium', 'BE'),
  ('Switzerland', 'CH'),
  ('Austria', 'AT'),
  ('Ireland', 'IE'),
  ('Sweden', 'SE'),
  ('Norway', 'NO'),
  ('Denmark', 'DK'),
  ('Poland', 'PL'),
  ('Russia', 'RU'),
  ('Ukraine', 'UA'),
  ('Turkey', 'TR'),
  ('Greece', 'GR'),
  ('South Africa', 'ZA'),
  ('India', 'IN'),
  ('Japan', 'JP'),
  ('South Korea', 'KR'),
  ('New Zealand', 'NZ'),
];
