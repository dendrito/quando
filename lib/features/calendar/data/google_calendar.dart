import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../events/domain/event.dart';
import '../../sounds/data/youtube_library.dart';
import 'calendar_reader.dart';

import 'package:quando/l10n/l10n.dart';

/// Calendars that live online rather than on the phone: today, Google
/// Calendar read straight from Google, for when your Google account isn't
/// on this phone (or this is an iPad or a Mac).
abstract class OnlineCalendars {
  /// Can this device sign in at all?
  bool get available;

  /// Signs in and asks to read calendars. The account's email, or null when
  /// you said no or it failed. Without [prompt] it only uses what's already
  /// allowed and never shows a screen.
  Future<String?> signIn({bool prompt = true});

  /// Forget the calendars here. Leaves YouTube, which shares the Google
  /// sign-in, connected.
  Future<void> signOut();

  /// Throws when signed out or offline.
  Future<List<PhoneCalendar>> calendars();
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds);
}

/// Google Calendar over its web API, with the Google sign-in YouTube uses.
class GoogleCalendars implements OnlineCalendars {
  GoogleCalendars({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const scope = 'https://www.googleapis.com/auth/calendar.readonly';

  @override
  bool get available => YouTubeAccount.available;

  String? _token;

  Future<String?> _authorize({required bool prompt}) async {
    try {
      await YouTubeAccount.init();
      final account =
          await GoogleSignIn.instance.attemptLightweightAuthentication() ??
          (prompt ? await GoogleSignIn.instance.authenticate(scopeHint: const [scope]) : null);
      if (account == null) return null;
      final client = account.authorizationClient;
      final auth =
          await client.authorizationForScopes(const [scope]) ??
          (prompt ? await client.authorizeScopes(const [scope]) : null);
      _token = auth?.accessToken;
      return _token == null ? null : account.email;
    } catch (e) {
      debugPrint('Quando?: Google Calendar sign-in: $e');
      return null;
    }
  }

  @override
  Future<String?> signIn({bool prompt = true}) => _authorize(prompt: prompt);

  @override
  Future<void> signOut() async => _token = null;

  Future<GoogleCalendarApi> _api() async {
    if (_token == null && await _authorize(prompt: false) == null) {
      throw StateError('Not signed in to Google Calendar');
    }
    return GoogleCalendarApi(_token!, client: _client);
  }

  /// Tokens last an hour: on a 401, get a fresh one once and try again.
  Future<T> _withApi<T>(Future<T> Function(GoogleCalendarApi api) run) async {
    try {
      return await run(await _api());
    } on GoogleCalendarAuthError {
      _token = null;
      return run(await _api());
    }
  }

  @override
  Future<List<PhoneCalendar>> calendars() => _withApi((api) => api.calendars());

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds) {
    final ids = {
      for (final id in calendarIds)
        if (GoogleCalendarApi.owns(id)) id,
    };
    if (ids.isEmpty) return Future.value(const []);
    return _withApi((api) => api.events(from, to, ids));
  }
}

class GoogleCalendarAuthError implements Exception {
  const GoogleCalendarAuthError();
}

/// The Google Calendar API v3, read-only. Calendar ids are kept with a
/// "google:" in front, so they never mix with the phone's own.
class GoogleCalendarApi {
  GoogleCalendarApi(this.token, {http.Client? client}) : _client = client ?? http.Client();

  final String token;
  final http.Client _client;

  static const prefix = 'google:';
  static bool owns(String id) => id.startsWith(prefix);

  static const _base = 'https://www.googleapis.com/calendar/v3';

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final res = await _client.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 401) throw const GoogleCalendarAuthError();
    if (res.statusCode != 200) {
      throw Exception(
        'Google Calendar ${res.statusCode}: ${res.body.length > 200 ? res.body.substring(0, 200) : res.body}',
      );
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  /// Every calendar in the account. The ones you switched off in Google
  /// Calendar come back too, marked not [PhoneCalendar.suggested].
  Future<List<PhoneCalendar>> calendars() async {
    final out = <PhoneCalendar>[];
    String? page;
    String? me;
    do {
      final j = await _get(
        Uri.parse('$_base/users/me/calendarList').replace(queryParameters: {'maxResults': '250', 'pageToken': ?page}),
      );
      for (final c in (j['items'] as List? ?? const []).cast<Map<String, dynamic>>()) {
        final id = c['id'] as String?;
        if (id == null || c['deleted'] == true) continue;
        if (c['primary'] == true) me = id;
        final name = (c['summaryOverride'] ?? c['summary'] ?? id) as String;
        out.add(
          PhoneCalendar(
            id: '$prefix$id',
            name: name,
            colorHex: c['backgroundColor'] as String?,
            source: CalendarSource.google,
            suggested: c['selected'] == true && c['hidden'] != true,
            primary: c['primary'] == true,
          ),
        );
      }
      page = j['nextPageToken'] as String?;
    } while (page != null);
    return [
      for (final c in out)
        PhoneCalendar(
          id: c.id,
          name: c.name,
          account: me,
          colorHex: c.colorHex,
          source: c.source,
          suggested: c.suggested,
          primary: c.primary,
        ),
    ]..sort((a, b) => a.primary != b.primary ? (a.primary ? -1 : 1) : a.name.compareTo(b.name));
  }

  /// Start and end of every timed event, repeating events spelled out one
  /// by one. All-day events and cancelled ones are skipped, as on the phone.
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds) async {
    final out = <AnchorEvent>[];
    for (final full in calendarIds) {
      final id = full.substring(prefix.length);
      String? page;
      do {
        final j = await _get(
          Uri.parse('$_base/calendars/${Uri.encodeComponent(id)}/events').replace(
            queryParameters: {
              'timeMin': from.toUtc().toIso8601String(),
              'timeMax': to.toUtc().toIso8601String(),
              'singleEvents': 'true',
              'orderBy': 'startTime',
              'maxResults': '2500',
              'fields': 'nextPageToken,items(id,status,summary,start,end)',
              'pageToken': ?page,
            },
          ),
        );
        for (final e in (j['items'] as List? ?? const []).cast<Map<String, dynamic>>()) {
          if (e['status'] == 'cancelled') continue;
          final start = DateTime.tryParse((e['start'] as Map?)?['dateTime'] as String? ?? '');
          final end = DateTime.tryParse((e['end'] as Map?)?['dateTime'] as String? ?? '');
          if (start == null || end == null) continue; // all day
          final summary = (e['summary'] as String? ?? '').trim();
          final title = summary.isEmpty ? l10n.event : summary;
          final key = '$id/${e['id']}';
          out
            ..add(
              AnchorEvent(id: 'cal.g.$key', kind: EventKind.calendar, title: title, at: start.toUtc(), source: full),
            )
            ..add(
              AnchorEvent(
                id: 'calend.g.$key',
                kind: EventKind.calendarEnd,
                title: l10n.eventEnds(title),
                at: end.toUtc(),
                source: full,
              ),
            );
        }
        page = j['nextPageToken'] as String?;
      } while (page != null);
    }
    return out;
  }
}
