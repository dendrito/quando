import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';

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
      appBar: AppBar(title: const Text('Lock mode'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          Text(
            'While locked, Quando shows only the time, the next alarm and when the lock ends. Alarms keep '
            'working, and nothing can be changed until it unlocks.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text('LOCK NOW', style: text.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final (label, d) in [
                ('30 min', const Duration(minutes: 30)),
                ('1 hour', const Duration(hours: 1)),
                ('2 hours', const Duration(hours: 2)),
                ('8 hours', const Duration(hours: 8)),
              ])
                ActionChip(label: Text(label), onPressed: () => n.lockFor(d)),
            ],
          ),
          const SizedBox(height: 24),
          Text('LOCK AUTOMATICALLY', style: text.labelSmall),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Shabbat and festivals'),
            subtitle: const Text('From candle lighting to havdalah'),
            value: s.shabbat,
            onChanged: (v) => n.update((x) => x.copyWith(shabbat: v)),
          ),
          TextField(
            controller: _keyword,
            enabled: calendarConnected,
            decoration: InputDecoration(
              labelText: 'During calendar events with this word',
              hintText: 'e.g. lock, exam, focus',
              helperText: calendarConnected
                  ? 'Leave empty for none'
                  : 'Connect calendars first (calendar icon)',
            ),
            onChanged: (v) => n.update((x) => x.copyWith(calendarKeyword: v.trim())),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Open Quando when a lock starts'),
            subtitle: const Text('A soft 1-second chime brings Quando to the front so it can lock'),
            value: s.openAtStart,
            onChanged: (v) => n.update((x) => x.copyWith(openAtStart: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Pin Quando to the screen'),
            subtitle: const Text(
              'Other apps can\'t be opened while locked. Android asks you to confirm the first time.',
            ),
            value: s.pin,
            onChanged: (v) => n.update((x) => x.copyWith(pin: v)),
          ),
          const SizedBox(height: 24),
          Text('COMING UP', style: text.labelSmall),
          if (periods.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No locks coming up.', style: text.bodySmall),
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
          Text('To leave a lock early, hold "Hold to unlock" for 3 seconds.', style: text.bodySmall),
        ],
      ),
    );
  }
}
