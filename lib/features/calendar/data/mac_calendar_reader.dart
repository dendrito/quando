import 'package:flutter/services.dart';
import 'package:quando/l10n/l10n.dart';

import '../../events/domain/event.dart';
import 'calendar_reader.dart';

/// Read-only EventKit access through the Mac runner. Permissions remain an
/// explicit user choice; startup only checks the existing authorization.
class MacCalendarReader implements CalendarReader {
  static const channel = MethodChannel('quando/calendar');

  @override
  Future<bool> hasAccess() async => await channel.invokeMethod<bool>('hasAccess') ?? false;

  @override
  Future<bool> requestAccess() async => await channel.invokeMethod<bool>('requestAccess') ?? false;

  @override
  Future<List<PhoneCalendar>> calendars() async {
    final rows = await channel.invokeListMethod<Map<Object?, Object?>>('calendars') ?? [];
    return [
      for (final row in rows)
        PhoneCalendar(id: row['id']! as String, name: row['name']! as String, account: row['account'] as String?),
    ];
  }

  @override
  Future<List<AnchorEvent>> events(DateTime from, DateTime to, Set<String> calendarIds) async {
    if (calendarIds.isEmpty) return const [];
    final rows =
        await channel.invokeListMethod<Map<Object?, Object?>>('events', {
          'from': from.millisecondsSinceEpoch,
          'to': to.millisecondsSinceEpoch,
          'calendarIds': calendarIds.toList(),
        }) ??
        [];
    return [
      for (final row in rows) ...[
        AnchorEvent(
          id: 'cal.${row['instanceId']}',
          kind: EventKind.calendar,
          title: (row['title']! as String).isEmpty ? l10n.event : row['title']! as String,
          at: DateTime.fromMillisecondsSinceEpoch(row['start']! as int, isUtc: true),
          source: row['calendarId']! as String,
        ),
        AnchorEvent(
          id: 'calend.${row['instanceId']}',
          kind: EventKind.calendarEnd,
          title: l10n.eventEnds((row['title']! as String).isEmpty ? l10n.event : row['title']! as String),
          at: DateTime.fromMillisecondsSinceEpoch(row['end']! as int, isUtc: true),
          source: row['calendarId']! as String,
        ),
      ],
    ];
  }
}
