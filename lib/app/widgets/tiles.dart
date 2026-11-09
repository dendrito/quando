import 'package:flutter/material.dart';

import '../../core/util/format.dart';
import '../theme.dart';

import 'package:quando/l10n/l10n.dart';

/// "5 times · 2 hours before to 5 minutes before", "at the moment".
String timesLabel(List<Duration> offsets) {
  if (offsets.isEmpty) return l10n.noTimesSet;
  String one(Duration d) => d == Duration.zero ? l10n.atTheMoment : describeOffset(d);
  return offsets.length == 1
      ? one(offsets.single)
      : l10n.timesRange(offsets.length, one(offsets.first), one(offsets.last));
}

/// Swipe left to delete.
class SwipeToDelete extends StatelessWidget {
  const SwipeToDelete({super.key, required this.id, required this.onDelete, required this.child});

  final String id;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) => Dismissible(
    key: ValueKey(id),
    direction: DismissDirection.endToStart,
    onDismissed: (_) => onDelete(),
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      decoration: const BoxDecoration(color: QuandoColors.coral, borderRadius: BorderRadius.all(Radius.circular(24))),
      child: const Icon(Icons.delete_outline, color: QuandoColors.ground),
    ),
    child: child,
  );
}

/// A rule as a card: name, when it rings, a switch; tap to edit.
class RuleTile extends StatelessWidget {
  const RuleTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.on,
    required this.onTap,
    required this.onToggle,
  });

  final String title;
  final String subtitle;
  final bool on;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Material(
      color: QuandoColors.surface,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(18, 6, 10, 6),
        onTap: onTap,
        title: Text(
          title,
          style: text.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: on ? QuandoColors.text : QuandoColors.faint,
          ),
        ),
        subtitle: Text(subtitle, style: text.bodySmall),
        trailing: Switch(value: on, onChanged: onToggle),
      ),
    );
  }
}
