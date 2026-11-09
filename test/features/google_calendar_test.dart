import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/calendar/data/calendar_reader.dart';
import 'package:quando/features/calendar/data/google_calendar.dart';
import 'package:quando/features/calendar/domain/calendar_rule.dart';
import 'package:quando/features/calendar/ui/calendar_screen.dart';
import 'package:quando/features/events/domain/event.dart';
import 'package:quando/features/rules/domain/presets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime.utc(2026, 11, 3, 12);

AnchorEvent _start(String id, String cal, String title, DateTime at) =>
    AnchorEvent(id: 'cal.$id', kind: EventKind.calendar, title: title, at: at, source: cal);

/// The phone, with the same Google account on it as online.
class _Phone implements CalendarReader {
  _Phone({this.granted = false});
  bool granted;

  @override
  Future<bool> hasAccess() async => granted;
  @override
  Future<bool> requestAccess() async => granted = true;
  @override
  Future<List<PhoneCalendar>> calendars() async => const [
    PhoneCalendar(id: '7', name: 'lemota@gmail.com', account: 'lemota@gmail.com'),
    PhoneCalendar(id: '9', name: 'Samsung', account: 'Samsung'),
  ];
  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> ids) async => [
    if (ids.contains('9')) _start('p', '9', 'Gym', DateTime.utc(2026, 11, 4, 18)),
  ];
}

class _Google implements OnlineCalendars {
  bool down = false;
  bool signedOut = false;
  Set<String>? asked;

  @override
  bool get available => true;
  @override
  Future<String?> signIn({bool prompt = true}) async => 'lemota@gmail.com';
  @override
  Future<void> signOut() async => signedOut = true;
  @override
  Future<List<PhoneCalendar>> calendars() async {
    if (down) throw Exception('offline');
    return const [
      PhoneCalendar(
        id: 'google:lemota@gmail.com',
        name: 'lemota@gmail.com',
        account: 'lemota@gmail.com',
        source: CalendarSource.google,
        primary: true,
      ),
      PhoneCalendar(id: 'google:work', name: 'Work', source: CalendarSource.google),
      PhoneCalendar(id: 'google:holidays', name: 'Holidays', source: CalendarSource.google, suggested: false),
    ];
  }

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> ids) async {
    if (down) throw Exception('offline');
    asked = ids;
    return [
      if (ids.contains('google:work')) _start('g', 'google:work', 'Dentist', DateTime.utc(2026, 11, 5, 9)),
    ];
  }
}

Future<(ProviderContainer, _Phone, _Google)> _container({bool phone = false}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final p = _Phone(granted: phone);
  final g = _Google();
  final c = ProviderContainer(
    overrides: [
      clockProvider.overrideWithValue(() => _now),
      prefsProvider.overrideWithValue(prefs),
      calendarReaderProvider.overrideWithValue(p),
      onlineCalendarsProvider.overrideWithValue(g),
    ],
  );
  addTearDown(c.dispose);
  for (final r in Presets.all) {
    c.read(rulesProvider.notifier).toggle(r.id, false);
  }
  return (c, p, g);
}

void main() {
  test('Google Calendar alone, without the phone\'s calendars', () async {
    final (c, _, _) = await _container();
    expect(await c.read(calendarProvider.notifier).connectGoogle(), isTrue);
    final cal = c.read(calendarProvider);
    expect(cal.access, isTrue);
    expect(cal.phone, isFalse);
    expect(cal.google, 'lemota@gmail.com');
    // Hidden in Google Calendar = off here too.
    expect(cal.selected, {'google:lemota@gmail.com', 'google:work'});
    c.read(calendarRulesProvider.notifier).save(const CalendarRule(id: 'r', before: [Duration(minutes: 15)]));
    final alarms = [
      for (final a in c.read(planProvider))
        if (a.ruleId.startsWith('cal.')) a.at,
    ];
    expect(alarms, [DateTime.utc(2026, 11, 5, 8, 45)]);
  });

  test('a calendar already on the phone starts off online, so it never rings twice', () async {
    final (c, _, _) = await _container(phone: true);
    await c.read(calendarProvider.notifier).refresh();
    await c.read(calendarProvider.notifier).connectGoogle();
    final cal = c.read(calendarProvider);
    expect(cal.selected, {'7', '9', 'google:work'});
    expect(cal.events.map((e) => e.title), containsAll(['Gym', 'Dentist']));
  });

  test('offline: keeps what was read and says so', () async {
    final (c, _, g) = await _container();
    await c.read(calendarProvider.notifier).connectGoogle();
    g.down = true;
    await c.read(calendarProvider.notifier).refresh();
    final cal = c.read(calendarProvider);
    expect(cal.googleError, isNotNull);
    expect(cal.events.any((e) => e.title == 'Dentist'), isTrue);
  });

  test('signing out forgets Google calendars only', () async {
    final (c, _, g) = await _container(phone: true);
    await c.read(calendarProvider.notifier).connectGoogle();
    await c.read(calendarProvider.notifier).disconnectGoogle();
    final cal = c.read(calendarProvider);
    expect(g.signedOut, isTrue);
    expect(cal.google, isNull);
    expect(cal.selected, {'7', '9'});
    expect(cal.events.map((e) => e.title), ['Gym']);
  });

  test('reads the Google Calendar API: repeats spelled out, all-day and cancelled skipped', () async {
    final asked = <Uri>[];
    final client = MockClient((req) async {
      asked.add(req.url);
      expect(req.headers['Authorization'], 'Bearer t');
      if (req.url.path.endsWith('calendarList')) {
        return http.Response(
          jsonEncode({
            'items': [
              {'id': 'me@gmail.com', 'summary': 'me@gmail.com', 'primary': true, 'selected': true},
              {'id': 'abc@group.calendar.google.com', 'summary': 'Family', 'backgroundColor': '#ff0000'},
            ],
          }),
          200,
        );
      }
      return http.Response(
        jsonEncode({
          'items': [
            {
              'id': 'a_20261104',
              'summary': 'Standup',
              'start': {'dateTime': '2026-11-04T10:00:00-03:00'},
              'end': {'dateTime': '2026-11-04T10:15:00-03:00'},
            },
            {
              'id': 'b',
              'summary': 'Holiday',
              'start': {'date': '2026-11-05'},
              'end': {'date': '2026-11-06'},
            },
            {'id': 'c', 'status': 'cancelled'},
          ],
        }),
        200,
      );
    });
    final api = GoogleCalendarApi('t', client: client);
    final cals = await api.calendars();
    expect(cals.map((c) => c.id), ['google:me@gmail.com', 'google:abc@group.calendar.google.com']);
    expect(cals.first.primary, isTrue);
    expect(cals.last.suggested, isFalse);
    expect(cals.every((c) => c.account == 'me@gmail.com'), isTrue);

    final events = await api.events(_now, _now.add(const Duration(days: 7)), {'google:me@gmail.com'});
    expect(asked.last.path, '/calendar/v3/calendars/me%40gmail.com/events');
    expect(asked.last.queryParameters['singleEvents'], 'true');
    expect(events.map((e) => (e.kind, e.at)), [
      (EventKind.calendar, DateTime.utc(2026, 11, 4, 13)),
      (EventKind.calendarEnd, DateTime.utc(2026, 11, 4, 13, 15)),
    ]);
    expect(events.first.source, 'google:me@gmail.com');
  });

  test('an expired Google sign-in is told apart from other failures', () async {
    final api = GoogleCalendarApi('t', client: MockClient((_) async => http.Response('', 401)));
    expect(api.calendars(), throwsA(isA<GoogleCalendarAuthError>()));
  });

  testWidgets('the calendars screen offers both sources, then lists Google\'s calendars', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => _now),
          prefsProvider.overrideWithValue(prefs),
          calendarReaderProvider.overrideWithValue(_Phone()),
          onlineCalendarsProvider.overrideWithValue(_Google()),
        ],
        child: const MaterialApp(home: CalendarScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('ON THIS DEVICE'), findsOneWidget);
    expect(find.text('GOOGLE CALENDAR'), findsOneWidget);
    expect(find.text('Connect calendars'), findsNWidgets(2));
    await tester.tap(find.text('Connect calendars').last);
    await tester.pumpAndSettle();
    expect(find.text('Signed in as lemota@gmail.com'), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Holidays'), findsOneWidget);
    expect(find.text('Dentist'), findsOneWidget); // coming up
    expect(find.text('Connect calendars'), findsOneWidget); // the device's, still to allow
  });
}
