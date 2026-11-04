import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../../../core/util/local_time.dart';

import 'package:quando/l10n/l10n.dart';

/// Lock mode settings: when Quando locks itself, and "lock now".
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  late final TextEditingController _keyword = TextEditingController(
    text: ref.read(lockSettingsProvider).calendarKeyword,
  );

  @override
  void dispose() {
    _keyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(lockSettingsProvider);
    final n = ref.read(lockSettingsProvider.notifier);
    final periods = ref.watch(lockPeriodsProvider).take(5).toList();
    final zone = ref.watch(homeZoneProvider);
    final calendarConnected = ref.watch(calendarProvider.select((c) => c.access));
    final text = Theme.of(context).textTheme;
    String at(DateTime utc) => '${dayLabel(inZone(utc, zone))} ${hhmm(inZone(utc, zone))}';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.lockMode), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          FeatureHeader(icon: Icons.lock_clock, sentence: l10n.lockSentence),
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
          Text(l10n.lockAutoHeading, style: text.labelSmall),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.shabbatAndFestivalsLong),
            subtitle: Text(l10n.fromCandleToHavdalah),
            value: s.shabbat,
            onChanged: (v) => n.update((x) => x.copyWith(shabbat: v)),
          ),
          TextField(
            controller: _keyword,
            enabled: calendarConnected,
            decoration: InputDecoration(
              labelText: l10n.lockCalendarWord,
              hintText: l10n.lockCalendarWordHint,
              helperText: calendarConnected ? l10n.leaveEmptyForNone : l10n.connectCalendarsFirst,
            ),
            onChanged: (v) => n.update((x) => x.copyWith(calendarKeyword: v.trim())),
          ),
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
        ],
      ),
    );
  }
}
