import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../../../core/util/local_time.dart';
import '../domain/lock.dart';
import '../domain/shabbat_calendar.dart';
import 'calendar_lock_sheet.dart';

import 'package:quando/l10n/l10n.dart';

/// Lock mode settings: when Quando locks itself, and "lock now".
///
/// Everything here is generic (exams, meetings, quiet evenings). Shabbat
/// shows up only for people who already have it: a Shabbat calendar among
/// the picked ones, Shabbat already in use, or the Matai? edition. For
/// everyone else it waits, folded, under "More ways to lock".
class LockScreen extends ConsumerWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(lockSettingsProvider);
    final n = ref.read(lockSettingsProvider.notifier);
    final periods = ref.watch(lockPeriodsProvider).take(5).toList();
    final zone = ref.watch(homeZoneProvider);
    final cal = ref.watch(calendarProvider);
    final shabbatCals = ref.watch(shabbatCalendarsProvider);
    final shabbatInUse = ref.watch(shabbatInUseProvider);
    final text = Theme.of(context).textTheme;
    String at(DateTime utc) => '${dayLabel(inZone(utc, zone))} ${hhmm(inZone(utc, zone))}';

    // A Shabbat calendar is picked but no lock uses it yet: offer one tap.
    final shabbatCal = cal.calendars.where((c) => shabbatCals.contains(c.id)).firstOrNull;
    final hasShabbatLock = s.calendarLocks.any((l) => l.endQuery == havdalahQuery);
    final candles = shabbatCal == null
        ? null
        : nextCandleLighting(after: ref.watch(clockProvider)(), calendarEvents: cal.events);

    final shabbatSwitch = SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(l10n.shabbatAndFestivalsLong),
      subtitle: Text(l10n.fromCandleToHavdalah),
      value: s.shabbat,
      onChanged: (v) => n.update((x) => x.copyWith(shabbat: v)),
    );
    final showShabbatOpenly = jewishHome || shabbatInUse || s.shabbat;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.lockMode), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          FeatureHeader(
            icon: Icons.lock_clock,
            sentence: showShabbatOpenly ? l10n.lockSentence : l10n.lockSentenceCalm,
          ),
          Text(l10n.lockExplain, style: text.bodyMedium),
          const SizedBox(height: 20),
          Text(l10n.lockNowHeading, style: text.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final (label, d) in [
                (l10n.minutesShort(30), const Duration(minutes: 30)),
                (l10n.spanHours(1), const Duration(hours: 1)),
                (l10n.spanHours(2), const Duration(hours: 2)),
                (l10n.spanHours(8), const Duration(hours: 8)),
              ])
                ActionChip(label: Text(label), onPressed: () => n.lockFor(d)),
            ],
          ),
          const SizedBox(height: 24),
          Text(l10n.lockCalendarHeading, style: text.labelSmall),
          const SizedBox(height: 4),
          Text(l10n.lockCalendarExplain, style: text.bodySmall),
          if (shabbatCal != null && !hasShabbatLock)
            Card(
              margin: const EdgeInsets.only(top: 12),
              child: ListTile(
                leading: const Icon(Icons.local_fire_department_outlined, color: QuandoColors.amber),
                title: Text(l10n.lockShabbatFromCalendar),
                subtitle: Text(
                  candles != null
                      ? l10n.nextCandleLightingFrom(at(candles.at), shabbatCal.name)
                      : l10n.lockShabbatCalendarFound(shabbatCal.name),
                ),
                trailing: const Icon(Icons.add),
                onTap: () => n.update(
                  (x) => x.withLock(
                    CalendarLock(
                      id: 'shabbat.${shabbatCal.id}',
                      startQuery: candleLightingQuery,
                      endQuery: havdalahQuery,
                      calendarIds: {shabbatCal.id},
                      name: l10n.shabbat,
                    ),
                  ),
                ),
              ),
            ),
          for (final lock in s.calendarLocks)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(lock.name.isNotEmpty ? lock.name : lockTitle(lock)),
              subtitle: lock.name.isNotEmpty ? Text(lockTitle(lock)) : null,
              value: lock.enabled,
              onChanged: (v) => n.update((x) => x.withLock(lock.copyWith(enabled: v))),
              secondary: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => showCalendarLockSheet(context, lock),
              ),
            ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(cal.access ? l10n.lockAddCalendar : l10n.connectCalendarsFirst),
              onPressed: cal.access ? () => showCalendarLockSheet(context, null) : null,
            ),
          ),
          if (showShabbatOpenly) shabbatSwitch,
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.openWhenLockStarts),
            subtitle: Text(l10n.openWhenLockStartsHint),
            value: s.openAtStart,
            onChanged: (v) => n.update((x) => x.copyWith(openAtStart: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.pinToScreen),
            subtitle: Text(l10n.pinToScreenHint),
            value: s.pin,
            onChanged: (v) => n.update((x) => x.copyWith(pin: v)),
          ),
          const SizedBox(height: 24),
          Text(l10n.comingUpHeading, style: text.labelSmall),
          if (periods.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l10n.noLocksComingUp, style: text.bodySmall),
            ),
          for (final p in periods)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(p.reason),
              subtitle: Text('${at(p.start)} → ${at(p.end)}', style: text.bodySmall),
              trailing: const Icon(Icons.lock_outline, color: QuandoColors.amber, size: 18),
            ),
          const SizedBox(height: 16),
          Text(l10n.leaveLockEarly, style: text.bodySmall),
          if (!showShabbatOpenly)
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                title: Text(l10n.lockMoreWays, style: text.bodySmall),
                children: [shabbatSwitch],
              ),
            ),
        ],
      ),
    );
  }
}

/// "During “exam”" or "From “Leave office” to the next “Back home”".
String lockTitle(CalendarLock l) => l.endQuery == havdalahQuery
    ? l10n.fromCandleToHavdalah
    : l.between
    ? l10n.lockBetweenTitle(l.startQuery, l.endQuery)
    : l10n.lockDuringTitle(l.startQuery);
