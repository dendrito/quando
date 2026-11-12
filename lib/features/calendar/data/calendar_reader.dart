import 'package:device_calendar_plus/device_calendar_plus.dart';

import '../../events/domain/event.dart';

import 'package:quando/l10n/l10n.dart';

/// Where a calendar is read from.
enum CalendarSource {
  /// The phone's own calendars: every account on it (Google, iCloud,
  /// Samsung, Outlook...) and calendars kept only on the phone.
  phone,

  /// Google Calendar, read straight from Google after signing in here.
  google,
}

/// A calendar you can pick: one of the phone's (Google accounts, Samsung,
/// Outlook, local...) or one read online from Google.
class PhoneCalendar {
  const PhoneCalendar({
    required this.id,
    required this.name,
    this.account,
    this.colorHex,
    this.source = CalendarSource.phone,
    this.suggested = true,
    this.primary = false,
  });

  final String id;
  final String name;
  final String? account;
  final String? colorHex;
  final CalendarSource source;

  /// Switched on when first seen. Google calendars you hide in Google
  /// Calendar start off here too.
  final bool suggested;

  /// The account's main calendar.
  final bool primary;
}

/// Reads the phone's calendars. Google Calendar shows up here once the
/// Google account is on the phone, so no separate sign-in is needed.
abstract class CalendarReader {
  Future<bool> hasAccess();
  Future<bool> requestAccess();
  Future<List<PhoneCalendar>> calendars();

  /// Start and end events for every timed event between [from] and [to].
  /// All-day events are skipped: they "start" at midnight.
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds);
}

class DeviceCalendarReader implements CalendarReader {
  DeviceCalendar get _plugin => DeviceCalendar.instance;

  @override
  Future<bool> hasAccess() async => await _plugin.hasPermissions() == CalendarPermissionStatus.granted;

  @override
  Future<bool> requestAccess() async =>
      await _plugin.requestPermissions() == CalendarPermissionStatus.granted;

  @override
  Future<List<PhoneCalendar>> calendars() async => [
    for (final c in await _plugin.listCalendars())
      if (!c.hidden) PhoneCalendar(id: c.id, name: c.name, account: c.accountName, colorHex: c.colorHex),
  ];

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds) async {
    if (calendarIds.isEmpty) return const [];
    final raw = await _plugin.listEvents(from.toLocal(), to.toLocal(), calendarIds: calendarIds.toList());
    return [
      for (final e in raw)
        if (!e.isAllDay && e.status != EventStatus.canceled) ...[
          AnchorEvent(
            id: 'cal.${e.instanceId}',
            kind: EventKind.calendar,
            title: e.title.isEmpty ? l10n.event : e.title,
            at: e.startDate.toUtc(),
            source: e.calendarId,
            reminders: [
              for (final r in e.reminders ?? const <Duration>[])
                if (r >= Duration.zero) r,
            ],
          ),
          AnchorEvent(
            id: 'calend.${e.instanceId}',
            kind: EventKind.calendarEnd,
            title: l10n.eventEnds(e.title.isEmpty ? l10n.event : e.title),
            at: e.endDate.toUtc(),
            source: e.calendarId,
          ),
        ],
    ];
  }
}
