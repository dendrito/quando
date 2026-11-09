import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/tiles.dart';
import '../../../l10n/l10n.dart';
import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import 'city_picker.dart';

class PreparationControls extends ConsumerWidget {
  const PreparationControls({super.key, this.detailed = false, this.showActions = true});
  final bool detailed;
  final bool showActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(rulesProvider);
    final hidden = ref.read(rulesProvider.notifier).hidden;
    final prep = rules.where(
      (r) =>
          r.appliesTo.contains(EventKind.holyDayStart) &&
          r.offsets().any((d) => d.isNegative) &&
          !hidden.contains(r.id),
    );
    final place = ref.watch(placeProvider);
    final lock = ref.watch(lockSettingsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.place_outlined, color: QuandoColors.amber),
          title: Text(timesInLabel(place.name, place.timeZone)),
          subtitle: Text(l10n.changeCity),
          onTap: () => pickShabbatPlace(context),
        ),
        Material(
          color: QuandoColors.surface,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.beforeShabbat, style: Theme.of(context).textTheme.titleLarge),
                if (showActions) const PreparationActions(),
                for (final rule in prep) ...[
                  RuleTile(
                    title: rule.name,
                    subtitle: timesLabel(rule.offsets()),
                    on: rule.enabled,
                    onTap: () => context.push('/preset/${rule.id}'),
                    onToggle: (v) => ref.read(rulesProvider.notifier).toggle(rule.id, v),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: () => context.push('/preset/${rule.id}'),
                      icon: const Icon(Icons.tune),
                      label: Text(l10n.timesAndSound),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (detailed) ...[
          Text(l10n.duringAfterShabbat, style: Theme.of(context).textTheme.titleLarge),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.lockForShabbat),
            value: lock.shabbat,
            onChanged: (v) => ref.read(lockSettingsProvider.notifier).update((s) => s.copyWith(shabbat: v)),
          ),
          for (final rule in rules.where((r) => !prep.any((p) => p.id == r.id) && !hidden.contains(r.id)))
            RuleTile(
              title: rule.name,
              subtitle: timesLabel(rule.offsets()),
              on: rule.enabled,
              onTap: () => context.push('/preset/${rule.id}'),
              onToggle: (v) => ref.read(rulesProvider.notifier).toggle(rule.id, v),
            ),
        ] else
          TextButton.icon(
            onPressed: () => context.push('/shabbat'),
            icon: const Icon(Icons.tune),
            label: Text(l10n.shabbatControls),
          ),
      ],
    );
  }
}

/// Always visible near the home tabs, before the larger Shabbat times card.
class PreparationActions extends ConsumerWidget {
  const PreparationActions({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(preparationProvider);
    final now = ref.watch(clockProvider)();
    final period = ref.watch(nextPeriodProvider);
    final skipped = settings.skipUntil?.isAfter(now) ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.preparationReminders),
          subtitle: Text(l10n.beforeShabbat),
          value: settings.enabled,
          onChanged: (v) => ref.read(preparationProvider.notifier).setEnabled(v),
        ),
        if (!settings.enabled) Text(l10n.preparationOff),
        if (skipped) Text(l10n.preparationSkipped),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: period == null
                ? null
                : () => ref.read(preparationProvider.notifier).skipUntil(skipped ? null : period.end),
            icon: const Icon(Icons.event_busy_outlined),
            label: Text(skipped ? l10n.restoreThisWeek : l10n.skipThisWeek),
          ),
        ),
      ],
    );
  }
}
