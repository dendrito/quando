import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
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
            Text(l10n.calendarIntro, style: text.bodyLarge),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              onPressed: () => ref.read(calendarProvider.notifier).connect(),
              child: Text(l10n.connectCalendars),
            ),
            if (cal.error != null) ...[
              const SizedBox(height: 12),
              Text(cal.error!, style: text.bodySmall?.copyWith(color: Colors.redAccent)),
            ],
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
            Text(l10n.useTheseCalendarsHeading, style: text.labelSmall),
            for (final c in cal.calendars)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: CircleAvatar(radius: 6, backgroundColor: _color(c.colorHex)),
                title: Text(c.name),
                subtitle: c.account == null || c.account == c.name
                    ? null
                    : Text(c.account!, style: text.bodySmall),
                value: cal.selected.contains(c.id),
                onChanged: (v) => ref.read(calendarProvider.notifier).select(c.id, v),
              ),
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
            if (cal.error != null) Text(cal.error!, style: text.bodySmall?.copyWith(color: Colors.redAccent)),
          ],
        ],
      ),
    );
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
