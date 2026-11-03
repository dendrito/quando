import 'package:device_calendar_plus/device_calendar_plus.dart';

import '../../events/domain/event.dart';

/// A calendar on the phone: Google accounts, Samsung, Outlook, local...
class PhoneCalendar {
  const PhoneCalendar({required this.id, required this.name, this.account, this.colorHex});

  final String id;
  final String name;
  final String? account;
  final String? colorHex;
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
            title: e.title.isEmpty ? 'Event' : e.title,
            at: e.startDate.toUtc(),
            source: e.calendarId,
          ),
          AnchorEvent(
            id: 'calend.${e.instanceId}',
            kind: EventKind.calendarEnd,
            title: '${e.title.isEmpty ? 'Event' : e.title} (ends)',
            at: e.endDate.toUtc(),
            source: e.calendarId,
          ),
        ],
    ];
  }
}
