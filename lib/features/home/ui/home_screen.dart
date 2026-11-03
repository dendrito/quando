import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/brand.dart';
import '../../../core/util/local_time.dart';
import '../../alarms/domain/user_alarm.dart';
import '../../timezones/ui/world_clocks.dart';
import '../domain/sky.dart';
import 'day_arc.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    // Keep the countdown and the sky moving.
    _tick = Timer.periodic(const Duration(seconds: 30), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  /// One tap alarms: "in 20 min", "at sunset".
  void _quick(DateTime at, String label) {
    final home = ref.read(homeZoneProvider);
    final local = inZone(at, home);
    ref
        .read(userAlarmsProvider.notifier)
        .save(
          UserAlarm(
            id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
            hour: local.hour,
            minute: local.minute,
            label: label,
          ),
        );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$label · rings at ${hhmm(local)}')));
  }

  @override
  Widget build(BuildContext context) {
    final place = ref.watch(placeProvider);
    final plan = ref.watch(planProvider);
    final period = ref.watch(nextPeriodProvider);
    final rules = ref.watch(rulesProvider);
    final mine = ref.watch(userAlarmsProvider);
    final now = ref.watch(clockProvider)();
    final text = Theme.of(context).textTheme;
    final home = ref.watch(homeZoneProvider);
    final sky = SkyDay.of(place, now);

    // Shabbat times in the Shabbat city's clock; everything else in yours.
    String cityTime(DateTime utc) => hhmm(inZone(utc, place.timeZone));
    String cityDay(DateTime utc) => dayLabel(inZone(utc, place.timeZone));
    String local(DateTime utc) => hhmm(inZone(utc, home));
    String day(DateTime utc) => dayLabel(inZone(utc, home));

    final upcoming = plan.where((a) => a.at.isAfter(now) && a.ruleId != 'lock').toList();
    final next = upcoming.firstOrNull;
    final nextSunset = sky.nextSunset;
    final sunTime = place.timeZone;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
        height: 60,
        child: FloatingActionButton.extended(
          tooltip: 'New alarm',
          onPressed: () => context.push('/alarm/new'),
          icon: const Icon(Icons.add, size: 26),
          label: const Text('When?'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ---- The living sky ----
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            color: sky.color,
            padding: EdgeInsets.fromLTRB(24, MediaQuery.paddingOf(context).top + 12, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const QMark(size: 30),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Quando', style: text.titleLarge?.copyWith(fontSize: 23))),
                    IconButton(
                      tooltip: 'Lock mode',
                      icon: const Icon(Icons.lock_outline),
                      onPressed: () => context.push('/lock'),
                    ),
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
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NEXT ALARM', style: text.labelSmall),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          next == null ? 'Nothing set' : countdown(next.at.difference(now)),
                          style: text.displayMedium?.copyWith(fontSize: 60),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        next == null
                            ? 'If not now, when?'
                            : '${next.title} · ${day(next.at)} · ${local(next.at)}',
                        style: text.bodyLarge?.copyWith(color: const Color(0xFFF7DCD0)),
                      ),
                      const SizedBox(height: 10),
                      DayArc(
                        sky: sky,
                        marks: [
                          for (final a in upcoming)
                            if (sky.at(a.at) case final t? when t >= 0 && t <= 1) t,
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sky.sunrise == null ? '' : 'Sunrise ${hhmm(inZone(sky.sunrise!, sunTime))}',
                              style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                            ),
                          ),
                          if (sky.sunset != null)
                            Text(
                              sky.sunset!.isAfter(now)
                                  ? 'Sunset ${hhmm(inZone(sky.sunset!, sunTime))} · '
                                        '${countdown(sky.sunset!.difference(now))}'
                                  : 'Sunset ${hhmm(inZone(sky.sunset!, sunTime))}',
                              style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---- One-tap "when" ----
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final m in const [10, 20, 60])
                      _WhenChip(
                        label: m < 60 ? 'In $m min' : 'In 1 hour',
                        onTap: () => _quick(
                          DateTime.now().toUtc().add(Duration(minutes: m)),
                          m < 60 ? 'In $m min' : 'In 1 hour',
                        ),
                      ),
                    if (nextSunset != null)
                      _WhenChip(label: 'At sunset', onTap: () => _quick(nextSunset, 'Sunset')),
                  ],
                ),
                const SizedBox(height: 16),

                // ---- Shabbat ----
                if (period != null) ...[
                  _ShabbatCard(
                    title: period.contains(now) ? 'SHABBAT MODE IS ON' : 'NEXT · ${place.name.toUpperCase()}',
                    names: period.names.join(' · '),
                    rows: [
                      _TimeRow(
                        label: 'Candle lighting',
                        day: cityDay(period.start),
                        time: cityTime(period.start),
                      ),
                      _TimeRow(label: 'Havdalah', day: cityDay(period.end), time: cityTime(period.end)),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // ---- Your alarms ----
                const SizedBox(height: 8),
                Text('YOUR ALARMS', style: text.labelSmall),
                const SizedBox(height: 10),
                if (mine.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Tap When? to add an alarm.', style: text.bodySmall),
                  ),
                for (final a in mine) ...[
                  _AlarmCard(
                    alarm: a,
                    onTap: () => context.push('/alarm/${a.id}'),
                    onToggle: (v) => ref.read(userAlarmsProvider.notifier).toggle(a.id, v),
                  ),
                  const SizedBox(height: 10),
                ],

                // ---- This week ----
                const SizedBox(height: 18),
                Text('ALARMS THIS WEEK', style: text.labelSmall),
                const SizedBox(height: 6),
                if (plan.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('No alarms in the next 7 days.', style: text.bodySmall),
                  ),
                for (final a in plan.take(12))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(a.title, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text('${a.body} · ${day(a.at)}', style: text.bodySmall),
                    trailing: Text(
                      local(a.at),
                      style: text.titleLarge?.copyWith(color: QuandoColors.amber, fontSize: 24),
                    ),
                  ),
                if (plan.length > 12) Text('and ${plan.length - 12} more', style: text.bodySmall),

                // ---- World clocks ----
                const SizedBox(height: 22),
                const WorldClocks(),

                // ---- Presets ----
                const SizedBox(height: 22),
                Text('SHABBAT AND SUN PRESETS', style: text.labelSmall),
                const SizedBox(height: 6),
                for (final r in rules)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(r.name, style: text.bodyLarge),
                    value: r.enabled,
                    onChanged: (v) => ref.read(rulesProvider.notifier).toggle(r.id, v),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Alarms set themselves on this phone whenever you change something.',
                  style: text.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhenChip extends StatelessWidget {
  const _WhenChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ActionChip(
    label: Text(label),
    onPressed: onTap,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
  );
}

class _ShabbatCard extends StatelessWidget {
  const _ShabbatCard({required this.title, required this.names, required this.rows});

  final String title;
  final String names;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    const ink = QuandoColors.ground;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: const BoxDecoration(
        color: QuandoColors.amber,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: ink),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 4), child: Flame(height: 52)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: text.labelSmall?.copyWith(color: ink)),
                  const SizedBox(height: 6),
                  Text(names, style: text.headlineSmall?.copyWith(color: ink)),
                  const SizedBox(height: 10),
                  for (final r in rows) Padding(padding: const EdgeInsets.only(top: 4), child: r),
                ],
              ),
            ),
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
    const ink = QuandoColors.ground;
    return Row(
      children: [
        Expanded(
          child: Text('$label · $day', style: text.bodyMedium?.copyWith(color: ink)),
        ),
        Text(time, style: text.titleLarge?.copyWith(color: ink, fontSize: 22)),
      ],
    );
  }
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({required this.alarm, required this.onTap, required this.onToggle});

  final UserAlarm alarm;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final on = alarm.enabled;
    return Material(
      color: QuandoColors.surface,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 14, 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hhmm(DateTime(2000, 1, 1, alarm.hour, alarm.minute)),
                      style: text.displaySmall?.copyWith(
                        fontSize: 42,
                        height: 1,
                        color: on ? QuandoColors.text : QuandoColors.faint,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${alarm.title} · ${alarm.repeatLabel}',
                      style: text.bodyMedium?.copyWith(color: on ? QuandoColors.muted : QuandoColors.faint),
                    ),
                    if (alarm.zone != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: const BoxDecoration(
                          color: QuandoColors.raised,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          '${cityOf(alarm.zone!)} time',
                          style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Switch(value: on, onChanged: onToggle),
            ],
          ),
        ),
      ),
    );
  }
}
