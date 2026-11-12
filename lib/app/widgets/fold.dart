import 'package:flutter/material.dart';

import '../theme.dart';

/// A group that opens and folds: a title, how many rows it holds, and the
/// rows. Nothing in it is removed when it is folded.
class Fold extends StatelessWidget {
  const Fold({
    super.key,
    required this.title,
    required this.children,
    this.count,
    this.summary,
    this.initiallyExpanded = false,
  });

  final String title;

  /// Shown after the title. null = none.
  final int? count;
  final List<Widget> children;

  /// Shown after the title instead of [count], e.g. "3 setups · 1 on".
  final String? summary;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(22)),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: PageStorageKey<String>('fold-$title'),
            initiallyExpanded: initiallyExpanded,
            tilePadding: const EdgeInsets.symmetric(horizontal: 18),
            childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            shape: const RoundedRectangleBorder(),
            collapsedShape: const RoundedRectangleBorder(),
            title: Row(
              children: [
                Expanded(child: Text(title, style: text.titleMedium)),
                if (count != null) Text('$count', style: text.bodySmall),
              ],
            ),
            subtitle: summary == null ? null : Text(summary!, style: text.bodySmall),
            children: children,
          ),
        ),
      ),
    );
  }
}
