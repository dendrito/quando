import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../alarms/domain/user_alarm.dart';

import 'package:quando/l10n/l10n.dart';

/// A named group of alarms: one switch for all of them, and the alarms
/// themselves when opened.
class AlarmGroupCard extends StatelessWidget {
  const AlarmGroupCard({
    super.key,
    required this.name,
    required this.alarms,
    required this.open,
    required this.onOpen,
    required this.onToggleAll,
    required this.onRename,
    required this.alarmCard,
  });

  final String name;
  final List<UserAlarm> alarms;
  final bool open;
  final VoidCallback onOpen;
  final ValueChanged<bool> onToggleAll;
  final VoidCallback onRename;
  final Widget Function(UserAlarm) alarmCard;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final on = alarms.where((a) => a.enabled).length;
    final times = [for (final a in alarms) hhmm(DateTime(2000, 1, 1, a.hour, a.minute))];
    final summary = [
      l10n.alarmCount(alarms.length),
      on == alarms.length ? l10n.allOn : (on == 0 ? l10n.allOff : l10n.someOn(on)),
    ].join(' · ');

    return Material(
      color: QuandoColors.surface,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: onOpen,
            onLongPress: onRename,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 14, 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: QuandoColors.raised, shape: BoxShape.circle),
                    child: Text(
                      name.characters.first.toUpperCase(),
                      style: text.titleLarge?.copyWith(color: QuandoColors.amber),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: text.titleLarge),
                        const SizedBox(height: 2),
                        Text(
                          open ? summary : '$summary · ${times.take(3).join(', ')}${times.length > 3 ? '…' : ''}',
                          style: text.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more, color: QuandoColors.muted),
                  ),
                  Switch(value: on > 0, onChanged: onToggleAll),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: !open
                ? const SizedBox(width: double.infinity)
                : Column(
                    children: [
                      for (final a in alarms) ...[const Divider(height: 1, indent: 20, endIndent: 20), alarmCard(a)],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                          child: TextButton.icon(
                            onPressed: onRename,
                            icon: const Icon(Icons.edit_outlined, size: 18),
                            label: Text(l10n.renameGroup),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
