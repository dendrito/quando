import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import '../data/calendar_reader.dart';
import '../domain/calendar_rule.dart';

import 'package:quando/l10n/l10n.dart';

/// Connect calendars, pick which ones count, and manage calendar alarms.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(calendarProvider.notifier).refresh());
  }

  @override
  Widget build(BuildContext context) {
    final cal = ref.watch(calendarProvider);
    final rules = ref.watch(calendarRulesProvider);
    final home = ref.watch(homeZoneProvider);
    final text = Theme.of(context).textTheme;
    final online = ref.watch(onlineCalendarsProvider);
    final upcoming = cal.events.where((e) => e.kind == EventKind.calendar).take(8).toList();
    String when(DateTime utc) => '${dayLabel(inZone(utc, home))} · ${hhmm(inZone(utc, home))}';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendars), backgroundColor: Colors.transparent),
      floatingActionButton: cal.access
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/calendar/rule/new'),
              icon: const Icon(Icons.add_alarm),
              label: Text(l10n.calendarAlarm),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 96),
        children: [
          if (!cal.access) ...[
            Text(l10n.calendarSourcesIntro, style: text.bodyLarge),
            const SizedBox(height: 8),
          ] else ...[
            Text(l10n.calendarAlarmsHeading, style: text.labelSmall),
            if (rules.isEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(l10n.calendarNoneYet, style: text.bodySmall),
              ),
              OutlinedButton(
                onPressed: () => ref
                    .read(calendarRulesProvider.notifier)
                    .save(
                      CalendarRule(
                        id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
                        before: const [Duration(minutes: 15)],
                      ),
                    ),
                child: Text(l10n.fifteenBeforeEvery),
              ),
            ],
            for (final r in rules)
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => context.push('/calendar/rule/${r.id}'),
                title: Text(r.title),
                subtitle: Text(_describe(r), style: text.bodySmall),
                trailing: Switch(
                  value: r.enabled,
                  onChanged: (v) => ref.read(calendarRulesProvider.notifier).toggle(r.id, v),
                ),
              ),
            const SizedBox(height: 28),
          ],

          // Where events come from: the device's own calendar app (every
          // account on it), and Google Calendar read online.
          Text(l10n.deviceCalendarsHeading, style: text.labelSmall),
          if (!cal.phone)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.phone_iphone, color: QuandoColors.amber),
              title: Text(l10n.deviceCalendarsTitle),
              subtitle: Text(l10n.deviceCalendarsHint, style: text.bodySmall),
              trailing: FilledButton.tonal(
                onPressed: () => ref.read(calendarProvider.notifier).connect(),
                child: Text(l10n.connectCalendars),
              ),
            )
          else
            for (final c in cal.calendars.where((c) => c.source == CalendarSource.phone)) _calendarTile(c, cal, text),
          if (cal.error != null) Text(cal.error!, style: text.bodySmall?.copyWith(color: Colors.redAccent)),
          const SizedBox(height: 28),
          Text(l10n.googleCalendarHeading, style: text.labelSmall),
          if (cal.google == null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_available_outlined, color: QuandoColors.amber),
              title: Text(
                online.available ? l10n.googleCalendarSignIn : l10n.googleCalendarNotHere,
                style: text.bodySmall,
              ),
              trailing: online.available
                  ? FilledButton.tonal(onPressed: _signInGoogle, child: Text(l10n.connectCalendars))
                  : null,
            )
          else ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.check_circle, color: QuandoColors.amber),
              title: Text(l10n.googleCalendarSignedIn(cal.google!)),
              subtitle: cal.phone ? Text(l10n.googleCalendarTwiceHint, style: text.bodySmall) : null,
              trailing: TextButton(
                onPressed: () => ref.read(calendarProvider.notifier).disconnectGoogle(),
                child: Text(l10n.googleCalendarSignOut),
              ),
            ),
            for (final c in cal.calendars.where((c) => c.source == CalendarSource.google)) _calendarTile(c, cal, text),
            if (cal.googleError != null)
              Text(cal.googleError!, style: text.bodySmall?.copyWith(color: Colors.redAccent)),
          ],
          if (cal.access) ...[
            const SizedBox(height: 28),
            Text(l10n.comingUpHeading, style: text.labelSmall),
            if (upcoming.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(l10n.noTimedEvents, style: text.bodySmall),
              ),
            for (final e in upcoming)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(e.title),
                trailing: Text(when(e.at), style: text.bodySmall?.copyWith(color: QuandoColors.amber)),
              ),
          ],
        ],
      ),
    );
  }

  Widget _calendarTile(PhoneCalendar c, CalendarState cal, TextTheme text) => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    secondary: CircleAvatar(radius: 6, backgroundColor: _color(c.colorHex)),
    title: Text(c.name),
    subtitle: c.account == null || c.account == c.name || c.source == CalendarSource.google
        ? null
        : Text(c.account!, style: text.bodySmall),
    value: cal.selected.contains(c.id),
    onChanged: (v) => ref.read(calendarProvider.notifier).select(c.id, v),
  );

  Future<void> _signInGoogle() async {
    final ok = await ref.read(calendarProvider.notifier).connectGoogle();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.googleSignInFailed)));
    }
  }

  static Color _color(String? hex) {
    final v = int.tryParse((hex ?? '').replaceAll('#', ''), radix: 16);
    if (v == null) return QuandoColors.amber;
    return Color(hex!.replaceAll('#', '').length <= 6 ? 0xFF000000 | v : v);
  }
}

/// "15 minutes before · every 1 hour for 6 hours · 5 minutes after it ends".
String _describe(CalendarRule r) {
  final parts = <String>[
    if (r.before.isNotEmpty) l10n.spanBefore((r.before.toList()..sort()).reversed.map(formatSpan).join(', ')),
    if (r.atStart) l10n.atTheStart,
    if (r.repeatEvery != null && r.repeatFor != null)
      l10n.everyForBefore(formatSpan(r.repeatEvery!), formatSpan(r.repeatFor!)),
    if (r.after.isNotEmpty) l10n.spanAfterItEnds((r.after.toList()..sort()).map(formatSpan).join(', ')),
  ];
  return parts.isEmpty ? l10n.noAlarmsChosen : parts.join(' · ');
}
