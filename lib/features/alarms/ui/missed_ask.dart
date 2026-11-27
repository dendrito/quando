import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../beta/beta_log.dart';
import '../data/missed_log.dart';

import 'package:quando/l10n/l10n.dart';

/// "Did 07:00 ring?" on Home, for an alarm the app never saw ring. One at a
/// time, oldest first; an answer makes it go away for good.
class MissedAsk extends ConsumerStatefulWidget {
  const MissedAsk({super.key});

  @override
  ConsumerState<MissedAsk> createState() => _MissedAskState();
}

class _MissedAskState extends ConsumerState<MissedAsk> {
  void _answer(PlannedRing r, {required bool rang}) {
    MissedLog.answered(r);
    if (!rang) BetaLog.event('missed', detail: '${r.at.toUtc().toIso8601String()} id ${r.id}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final unsure = MissedLog.unsure(ref.watch(clockProvider)());
    if (unsure.isEmpty) return const SizedBox.shrink();
    final r = unsure.first;
    final time = hhmm(inZone(r.at, ref.watch(homeZoneProvider)));
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        key: const Key('missedAsk'),
        color: DuskColors.surface,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 8, 8),
          child: Row(
            children: [
              Icon(Icons.alarm_off, color: DuskColors.coral),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.missedAsk(time), style: text.titleMedium)),
              TextButton(
                key: const Key('missedYes'),
                onPressed: () => _answer(r, rang: true),
                child: Text(l10n.missedYes),
              ),
              TextButton(
                key: const Key('missedNo'),
                onPressed: () => _answer(r, rang: false),
                child: Text(l10n.missedNo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
