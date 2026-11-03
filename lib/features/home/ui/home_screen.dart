import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    final plan = ref.watch(planProvider);
    final period = ref.watch(nextPeriodProvider);
    final rules = ref.watch(rulesProvider);
    final mine = ref.watch(userAlarmsProvider);
    final now = ref.watch(clockProvider)();
    final text = Theme.of(context).textTheme;

    String local(DateTime utc) => hhmm(inZone(utc, place.timeZone));
    String day(DateTime utc) => dayLabel(inZone(utc, place.timeZone));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'New alarm',
        onPressed: () => context.push('/alarm/new'),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          children: [
            Row(
              children: [
                Expanded(child: Text('Quando', style: text.headlineSmall)),
                IconButton(
                  tooltip: 'Calendars',
                  icon: const Icon(Icons.event_outlined),
                  onPressed: () => context.push('/calendar'),
                ),
                IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.tune),
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
            Text('If not now, when?', style: text.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
            const SizedBox(height: 28),
            Text('YOUR ALARMS', style: text.labelSmall),
            if (mine.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text('Tap + to add an alarm.', style: text.bodySmall),
              ),
            for (final a in mine)
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => context.push('/alarm/${a.id}'),
                title: Text(
                  hhmm(DateTime(2000, 1, 1, a.hour, a.minute)),
                  style: text.headlineMedium?.copyWith(
                    color: a.enabled ? QuandoColors.text : QuandoColors.muted,
                  ),
                ),
                subtitle: Text('${a.title} · ${a.repeatLabel}', style: text.bodySmall),
                trailing: Switch(
                  value: a.enabled,
                  onChanged: (v) => ref.read(userAlarmsProvider.notifier).toggle(a.id, v),
                ),
              ),
            const SizedBox(height: 28),
            if (period != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        period.contains(now) ? 'SHABBAT MODE IS ON' : 'NEXT · ${place.name.toUpperCase()}',
                        style: text.labelSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(period.names.join(' · '), style: text.headlineSmall),
                      const SizedBox(height: 14),
                      _TimeRow(label: 'Candle lighting', day: day(period.start), time: local(period.start)),
                      const SizedBox(height: 6),
                      _TimeRow(label: 'Havdalah', day: day(period.end), time: local(period.end)),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 28),
            Text('ALARMS THIS WEEK', style: text.labelSmall),
            const SizedBox(height: 8),
            if (plan.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('No alarms in the next 7 days.', style: text.bodySmall),
              ),
            for (final a in plan.take(12))
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(a.title, style: text.bodyMedium),
                subtitle: Text('${a.body} · ${day(a.at)}', style: text.bodySmall),
                trailing: Text(local(a.at), style: text.titleMedium?.copyWith(color: QuandoColors.amber)),
              ),
            if (plan.length > 12) Text('and ${plan.length - 12} more', style: text.bodySmall),
            const SizedBox(height: 28),
            Text('SHABBAT AND SUN PRESETS', style: text.labelSmall),
            for (final r in rules)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(r.name, style: text.bodyMedium),
                value: r.enabled,
                onChanged: (v) => ref.read(rulesProvider.notifier).toggle(r.id, v),
              ),
            const SizedBox(height: 16),
            Text('Alarms set themselves on this phone whenever you change something.', style: text.bodySmall),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({required this.label, required this.day, required this.time});

  final String label;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(child: Text('$label · $day', style: text.bodyMedium)),
        Text(time, style: text.titleMedium?.copyWith(color: QuandoColors.amber, fontSize: 22)),
      ],
    );
  }
}
