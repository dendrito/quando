import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../domain/lock.dart';

import 'package:quando/l10n/l10n.dart';

/// Add or change a calendar lock. [lock] null = a new one.
Future<void> showCalendarLockSheet(BuildContext context, CalendarLock? lock) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _CalendarLockSheet(lock: lock),
);

class _CalendarLockSheet extends ConsumerStatefulWidget {
  const _CalendarLockSheet({required this.lock});

  final CalendarLock? lock;

  @override
  ConsumerState<_CalendarLockSheet> createState() => _CalendarLockSheetState();
}

class _CalendarLockSheetState extends ConsumerState<_CalendarLockSheet> {
  late CalendarLock _lock =
      widget.lock ?? CalendarLock(id: 'c${DateTime.now().millisecondsSinceEpoch}', startQuery: '');
  late bool _between = _lock.between;
  late final _name = TextEditingController(text: _lock.name);
  late final _start = TextEditingController(text: _lock.startQuery);
  late final _end = TextEditingController(text: _lock.endQuery);

  @override
  void dispose() {
    _name.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  CalendarLock get _draft => _lock.copyWith(
    name: _name.text.trim(),
    startQuery: _start.text.trim(),
    endQuery: _between ? _end.text.trim() : '',
  );

  void _save() {
    final d = _draft;
    if (d.startQuery.isEmpty || (_between && d.endQuery.isEmpty)) return;
    ref.read(lockSettingsProvider.notifier).update((s) => s.withLock(d));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cal = ref.watch(calendarProvider);
    final zone = ref.watch(homeZoneProvider);
    final now = ref.watch(clockProvider)();
    final text = Theme.of(context).textTheme;
    final preview = calendarLockPeriods(
      _draft,
      cal.events,
      shabbatCalendars: ref.watch(shabbatCalendarsProvider),
    ).where((p) => p.end.isAfter(now)).take(3).toList();
    String at(DateTime utc) => '${dayLabel(inZone(utc, zone))} ${hhmm(inZone(utc, zone))}';
    final picked = [
      for (final c in cal.calendars)
        if (cal.selected.contains(c.id)) c,
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.lockEditCalendar, style: text.titleLarge),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(l10n.lockDuring)),
                ButtonSegment(value: true, label: Text(l10n.lockBetween)),
              ],
              selected: {_between},
              onSelectionChanged: (v) => setState(() => _between = v.first),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _start,
              decoration: InputDecoration(
                labelText: _between ? l10n.lockStartsAtBetween : l10n.lockStartsAt,
                hintText: l10n.lockStartHint,
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_between)
              TextField(
                controller: _end,
                decoration: InputDecoration(labelText: l10n.lockEndsAt, hintText: l10n.lockEndHint),
                onChanged: (_) => setState(() {}),
              ),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l10n.nameOptional),
              onChanged: (_) => setState(() {}),
            ),
            if (picked.length > 1) ...[
              const SizedBox(height: 16),
              Text(l10n.calendars.toUpperCase(), style: text.labelSmall),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  FilterChip(
                    label: Text(l10n.lockAnyCalendar),
                    selected: _lock.calendarIds.isEmpty,
                    onSelected: (_) => setState(() => _lock = _lock.copyWith(calendarIds: const {})),
                  ),
                  for (final c in picked)
                    FilterChip(
                      label: Text(c.name),
                      selected: _lock.calendarIds.contains(c.id),
                      onSelected: (on) => setState(() {
                        final ids = {..._lock.calendarIds};
                        on ? ids.add(c.id) : ids.remove(c.id);
                        _lock = _lock.copyWith(calendarIds: ids);
                      }),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Text(l10n.lockNextTimes, style: text.labelSmall),
            if (preview.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(l10n.lockNoMatches, style: text.bodySmall),
              ),
            for (final p in preview)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(p.reason),
                subtitle: Text('${at(p.start)} → ${at(p.end)}', style: text.bodySmall),
                trailing: const Icon(Icons.lock_outline, color: QuandoColors.amber, size: 18),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (widget.lock != null)
                  TextButton(
                    onPressed: () {
                      ref.read(lockSettingsProvider.notifier).update((s) => s.withoutLock(_lock.id));
                      Navigator.pop(context);
                    },
                    child: Text(l10n.delete),
                  ),
                const Spacer(),
                TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
                const SizedBox(width: 8),
                FilledButton(onPressed: _save, child: Text(l10n.save)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
