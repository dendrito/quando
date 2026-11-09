import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shabbat/domain/place.dart';

enum WeatherKind { clear, clouds, rain, snow, fog, thunder }

class WeatherHour {
  const WeatherHour({required this.at, required this.celsius, required this.symbol});
  final DateTime at;
  final double celsius;
  final String symbol;
  bool get night => symbol.endsWith('_night');
  WeatherKind get kind {
    if (symbol.contains('thunder')) return WeatherKind.thunder;
    if (symbol.contains('snow') || symbol.contains('sleet')) return WeatherKind.snow;
    if (symbol.contains('rain')) return WeatherKind.rain;
    if (symbol.contains('fog')) return WeatherKind.fog;
    if (symbol.contains('cloud')) return WeatherKind.clouds;
    return WeatherKind.clear;
  }

  Map<String, dynamic> toJson() => {'at': at.toIso8601String(), 'c': celsius, 'symbol': symbol};
  factory WeatherHour.fromJson(Map<String, dynamic> j) => WeatherHour(
    at: DateTime.parse(j['at'] as String),
    celsius: (j['c'] as num).toDouble(),
    symbol: j['symbol'] as String,
  );
}

class WeatherReport {
  const WeatherReport({
    required this.hours,
    required this.fetched,
    required this.expires,
    this.modified,
    this.stale = false,
  });
  final List<WeatherHour> hours;
  final DateTime fetched, expires;
  final String? modified;
  final bool stale;
  WeatherHour? current(DateTime now) {
    final past = hours.where((h) => !h.at.isAfter(now)).lastOrNull;
    return past != null && now.difference(past.at) < const Duration(hours: 6)
        ? past
        : hours
              .where((h) => h.at.difference(now) >= Duration.zero && h.at.difference(now) < const Duration(hours: 3))
              .firstOrNull;
  }

  Map<String, dynamic> toJson() => {
    'hours': [for (final h in hours) h.toJson()],
    'fetched': fetched.toIso8601String(),
    'expires': expires.toIso8601String(),
    'modified': modified,
  };
  factory WeatherReport.fromJson(Map<String, dynamic> j, {bool stale = false}) => WeatherReport(
    hours: [for (final h in j['hours'] as List) WeatherHour.fromJson((h as Map).cast<String, dynamic>())],
    fetched: DateTime.parse(j['fetched'] as String),
    expires: DateTime.parse(j['expires'] as String),
    modified: j['modified'] as String?,
    stale: stale,
  );
}

/// Opt-in MET Norway forecast, requested only while its panel is in use.
/// Uses coarse coordinates, expiry/conditional headers and local cache.
class WeatherRepository {
  WeatherRepository(this.prefs, {http.Client? client, DateTime Function()? now, Random? random})
    : _client = client ?? http.Client(),
      _now = now ?? DateTime.now,
      _random = random ?? Random();
  final SharedPreferences prefs;
  final http.Client _client;
  final DateTime Function() _now;
  final Random _random;
  final _inflight = <String, Future<WeatherReport>>{};
  static String locationKey(Place p) => '${p.latitude.toStringAsFixed(2)},${p.longitude.toStringAsFixed(2)}';
  int pollBucket(DateTime now) {
    var offset = prefs.getInt('weather.pollOffset');
    if (offset == null) {
      offset = _random.nextInt(1800000);
      prefs.setInt('weather.pollOffset', offset);
    }
    return (now.millisecondsSinceEpoch + offset) ~/ 1800000;
  }

  Future<WeatherReport> load(Place place) async {
    final key = locationKey(place), existing = _inflight[locationKey(place)];
    if (existing != null) return existing;
    final request = _load(key);
    _inflight[key] = request;
    try {
      return await request;
    } finally {
      if (identical(_inflight[key], request)) _inflight.remove(key);
    }
  }

  WeatherReport? _cached(String key) {
    try {
      return WeatherReport.fromJson(jsonDecode(prefs.getString('weather.cache.$key') ?? '{}') as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  DateTime _expiry(http.Response r, DateTime now) {
    try {
      final raw = r.headers['expires'];
      if (raw != null) {
        final date = DateFormat(
          'EEE, dd MMM yyyy HH:mm:ss',
          'en_US',
        ).parseUtc(raw.replaceFirst(RegExp(r'\s+GMT$'), ''));
        return (date.isAfter(now) ? date : now.add(const Duration(minutes: 10))).add(
          Duration(seconds: 30 + _random.nextInt(270)),
        );
      }
    } catch (_) {
      /* Missing/invalid cache header: conservative fallback. */
    }
    return now.add(Duration(minutes: 60, seconds: _random.nextInt(300)));
  }

  Future<WeatherReport> _load(String key) async {
    final now = _now().toUtc(), cached = _cached(key);
    if (cached != null && now.isBefore(cached.expires)) return cached;
    final retry = DateTime.tryParse(prefs.getString('weather.retry.$key') ?? '');
    if (retry != null && now.isBefore(retry)) {
      if (cached != null && now.difference(cached.fetched) < const Duration(days: 1)) {
        return WeatherReport.fromJson(cached.toJson(), stale: true);
      }
      throw StateError('Weather temporarily unavailable');
    }
    try {
      final coordinates = key.split(',');
      final r = await _client
          .get(
            Uri.https('api.met.no', '/weatherapi/locationforecast/2.0/compact', {
              'lat': coordinates[0],
              'lon': coordinates[1],
            }),
            headers: {
              'User-Agent': 'Quando/0.1.0 https://github.com/dendrito',
              if (cached?.modified != null) 'If-Modified-Since': cached!.modified!,
            },
          )
          .timeout(const Duration(seconds: 12));
      if (r.statusCode == 429) {
        final seconds = int.tryParse(r.headers['retry-after'] ?? '') ?? 900;
        await prefs.setString('weather.retry.$key', now.add(Duration(seconds: max(900, seconds))).toIso8601String());
      }
      final WeatherReport report;
      if (r.statusCode == 304 && cached != null) {
        report = WeatherReport(hours: cached.hours, fetched: now, expires: _expiry(r, now), modified: cached.modified);
      } else {
        if (r.statusCode != 200) throw StateError('Weather unavailable');
        final j = jsonDecode(r.body) as Map<String, dynamic>;
        final series = (j['properties'] as Map)['timeseries'] as List;
        final hours = <WeatherHour>[];
        for (final raw in series) {
          final point = raw as Map, data = point['data'] as Map;
          final temperature = ((data['instant'] as Map)['details'] as Map)['air_temperature'];
          if (temperature is! num) continue;
          final period = data['next_1_hours'] ?? data['next_6_hours'] ?? data['next_12_hours'];
          String? symbol;
          if (period is Map) {
            final summary = period['summary'];
            if (summary is Map && summary['symbol_code'] is String) symbol = summary['symbol_code'] as String;
          }
          if (symbol == null) continue;
          hours.add(
            WeatherHour(at: DateTime.parse(point['time'] as String), celsius: temperature.toDouble(), symbol: symbol),
          );
        }
        if (hours.isEmpty) throw StateError('Forecast missing');
        hours.sort((a, b) => a.at.compareTo(b.at));
        report = WeatherReport(
          hours: hours,
          fetched: now,
          expires: _expiry(r, now),
          modified: r.headers['last-modified'],
        );
      }
      await prefs.setString('weather.cache.$key', jsonEncode(report.toJson()));
      await prefs.remove('weather.retry.$key');
      return report;
    } catch (_) {
      if (prefs.getString('weather.retry.$key') == null) {
        await prefs.setString('weather.retry.$key', now.add(const Duration(minutes: 15)).toIso8601String());
      }
      if (cached != null && now.difference(cached.fetched) < const Duration(days: 1)) {
        return WeatherReport.fromJson(cached.toJson(), stale: true);
      }
      rethrow;
    }
  }

  void close() => _client.close();
}
