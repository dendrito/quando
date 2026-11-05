import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import 'zone_picker.dart';

import 'package:quando/l10n/l10n.dart';

/// Home-screen clocks for the zones you care about, ticking every 20 s.
class WorldClocks extends ConsumerStatefulWidget {
  const WorldClocks({super.key, this.now});

  /// For tests.
  final DateTime Function()? now;

  @override
  ConsumerState<WorldClocks> createState() => _WorldClocksState();
}

class _WorldClocksState extends ConsumerState<WorldClocks> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 20), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zones = ref.watch(timeZonesProvider);
    final home = ref.watch(homeZoneProvider);
    final now = (widget.now ?? () => DateTime.now().toUtc())();
    final text = Theme.of(context).textTheme;
    final homeLocal = inZone(now, home);

    String dayNote(String z) {
      final l = inZone(now, z);
      final diff = DateTime(l.year, l.month, l.day)
          .difference(DateTime(homeLocal.year, homeLocal.month, homeLocal.day))
          .inDays;
      return diff == 0
          ? ''
          : (diff > 0
                ? ' · ${l10n.tomorrowLower}'
                : ' · ${l10n.yesterdayLower}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(l10n.worldClocksHeading, style: text.labelSmall),
            ),
            TextButton.icon(
              onPressed: () async {
                final z = await pickZone(context, home: home);
                if (z != null) ref.read(timeZonesProvider.notifier).addClock(z);
              },
              icon: const Icon(Icons.add, size: 18),
              label: Text(l10n.add),
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(l10n.cityHere(cityOf(home)), style: text.bodyMedium),
          trailing: Text(
            hhmm(homeLocal),
            style: text.titleLarge?.copyWith(color: QuandoColors.amber),
          ),
        ),
        for (final z in zones.clocks)
          Dismissible(
            key: ValueKey(z),
            direction: DismissDirection.endToStart,
            onDismissed: (_) =>
                ref.read(timeZonesProvider.notifier).removeClock(z),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete_outline),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(cityOf(z), style: text.bodyMedium),
              subtitle: Text(
                '${offsetFrom(z, home, now)}${dayNote(z)}',
                style: text.bodySmall,
              ),
              trailing: Text(hhmm(inZone(now, z)), style: text.titleLarge),
              onLongPress: () =>
                  ref.read(timeZonesProvider.notifier).removeClock(z),
            ),
          ),
        if (zones.clocks.isEmpty)
          Text(l10n.worldClocksHint, style: text.bodySmall),
      ],
    );
  }
}
