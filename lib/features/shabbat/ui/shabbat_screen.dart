import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/tiles.dart';
import '../../../core/util/local_time.dart';
import 'shabbat_card.dart';

import 'package:quando/l10n/l10n.dart';

/// Everything about Shabbat and festivals in one place: the times, what's
/// coming, Quando's ready-made alarms, your own, and Shabbat lock.
class ShabbatScreen extends ConsumerWidget {
  const ShabbatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final place = ref.watch(placeProvider);
    final now = ref.watch(clockProvider)();
    final periods = ref.watch(periodsProvider);
    final rules = ref.watch(rulesProvider);
    final hiddenPresets = ref.read(rulesProvider.notifier).hidden;
    final mine = ref.watch(calendarRulesProvider).where((r) => r.includeTimes).toList();
    final lock = ref.watch(lockSettingsProvider);
    String day(DateTime utc) => dayLabel(inZone(utc, place.timeZone));
    String time(DateTime utc) => hhmm(inZone(utc, place.timeZone));

    void undo(String message, VoidCallback action) => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: l10n.undo, textColor: QuandoColors.ground, onPressed: action),
        ),
      );

    final next = periods.firstOrNull;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.shabbatAndFestivals)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        children: [
          if (next != null)
            ShabbatCard(
              title: next.contains(now) ? l10n.shabbatModeIsOn : l10n.nextInCity(place.name.toUpperCase()),
              names: next.names.join(' · '),
              rows: [
                ShabbatTimeRow(label: l10n.candleLighting, day: day(next.start), time: time(next.start)),
                ShabbatTimeRow(label: l10n.havdalah, day: day(next.end), time: time(next.end)),
              ],
            ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.place_outlined, size: 18),
              label: Text(l10n.placeChange(place.name, place.inIsrael ? l10n.israel : l10n.outsideIsrael)),
              onPressed: () => context.push('/settings'),
            ),
          ),

          // ---- Coming up ----
          if (periods.length > 1) ...[
            const SizedBox(height: 14),
            Text(l10n.comingUpHeading, style: text.labelSmall),
            const SizedBox(height: 10),
            Material(
              color: QuandoColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (final (i, p) in periods.skip(1).take(8).indexed) ...[
                    if (i > 0) const Divider(height: 1, indent: 18, endIndent: 18),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                      title: Text(
                        p.names.join(' · '),
                        style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        l10n.timeToTime(
                          '${day(p.start)} · ${time(p.start)}',
                          '${day(p.end)} · ${time(p.end)}',
                        ),
                        style: text.bodySmall,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // ---- Lock ----
          const SizedBox(height: 22),
          Material(
            color: QuandoColors.surface,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            clipBehavior: Clip.antiAlias,
            child: SwitchListTile(
              contentPadding: const EdgeInsets.fromLTRB(18, 6, 10, 6),
              secondary: const Icon(Icons.lock_outline, color: QuandoColors.amber),
              title: Text(l10n.lockForShabbat, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text(l10n.lockForShabbatHint, style: text.bodySmall),
              value: lock.shabbat,
              onChanged: (v) => ref.read(lockSettingsProvider.notifier).update((s) => s.copyWith(shabbat: v)),
            ),
          ),

          // ---- Your own ----
          const SizedBox(height: 22),
          Text(l10n.ownShabbatAlarmsHeading, style: text.labelSmall),
          const SizedBox(height: 10),
          for (final r in mine) ...[
            SwipeToDelete(
              id: 'cal.${r.id}',
              onDelete: () {
                ref.read(calendarRulesProvider.notifier).delete(r.id);
                undo(l10n.deletedNamed(r.title), () => ref.read(calendarRulesProvider.notifier).save(r));
              },
              child: RuleTile(
                title: r.title,
                subtitle: timesLabel(r.toAlarmRules().expand((a) => a.offsets()).toSet().toList()..sort()),
                on: r.enabled,
                onTap: () => context.push('/calendar/rule/${r.id}'),
                onToggle: (v) => ref.read(calendarRulesProvider.notifier).toggle(r.id, v),
              ),
            ),
            const SizedBox(height: 8),
          ],
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(l10n.addShabbatAlarm),
            onPressed: () => context.push('/calendar/rule/new?times=candle*'),
          ),

          // ---- Presets ----
          const SizedBox(height: 22),
          Text(l10n.readyMadeHeading, style: text.labelSmall),
          const SizedBox(height: 10),
          for (final r in rules.where((r) => !hiddenPresets.contains(r.id))) ...[
            SwipeToDelete(
              id: 'preset.${r.id}',
              onDelete: () {
                ref.read(rulesProvider.notifier).hide(r.id);
                undo(l10n.deletedNamed(r.name), () => ref.read(rulesProvider.notifier).restore(r.id));
              },
              child: RuleTile(
                title: r.name,
                subtitle: timesLabel(r.offsets()),
                on: r.enabled,
                onTap: () => context.push('/preset/${r.id}'),
                onToggle: (v) => ref.read(rulesProvider.notifier).toggle(r.id, v),
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (hiddenPresets.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.restore),
                label: Text(l10n.bringBackDeleted(hiddenPresets.length)),
                onPressed: () async {
                  final names = {for (final r in rules) r.id: r.name};
                  final id = await showModalBottomSheet<String>(
                    context: context,
                    showDragHandle: true,
                    builder: (context) => SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final h in hiddenPresets)
                            ListTile(
                              leading: const Icon(Icons.restore),
                              title: Text(names[h] ?? h),
                              onTap: () => Navigator.pop(context, h),
                            ),
                        ],
                      ),
                    ),
                  );
                  if (id != null) ref.read(rulesProvider.notifier).restore(id);
                },
              ),
            ),
          Text(l10n.presetsHint, style: text.bodySmall),
        ],
      ),
    );
  }
}
