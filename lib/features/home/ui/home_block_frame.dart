import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../domain/home_layout.dart';

import 'package:quando/l10n/l10n.dart';

/// One movable, foldable, resizable card on the home screen.
class HomeBlockFrame extends StatelessWidget {
  const HomeBlockFrame({
    super.key,
    required this.block,
    required this.title,
    required this.state,
    required this.editing,
    required this.onChanged,
    required this.child,
    this.color,
    this.index,
  });

  final HomeBlock block;
  final String title;
  final BlockState state;

  /// Editing shows a handle to drag, a size slider and a grip to pull.
  final bool editing;
  final ValueChanged<BlockState> onChanged;
  final Widget child;
  final Color? color;

  /// Position in the reorderable list while editing.
  final int? index;

  bool get _scalable => scalableBlocks.contains(block);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final folded = state.collapsed;
    final pct = (state.scale * 100).round();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: color ?? QuandoColors.raised.withValues(alpha: .45),
        borderRadius: BorderRadius.circular(24),
        border: editing ? Border.all(color: QuandoColors.amber.withValues(alpha: .8), width: 1.5) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onChanged(state.copyWith(collapsed: !folded)),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
              child: Row(
                children: [
                  if (editing && index != null)
                    ReorderableDragStartListener(
                      index: index!,
                      child: Tooltip(
                        message: l10n.homeMove,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.drag_indicator, size: 22),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(title, style: text.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (editing && _scalable && !folded) Text('$pct%', style: text.labelSmall),
                  IconButton(
                    tooltip: folded ? l10n.homeExpand : l10n.homeCollapse,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(folded ? Icons.expand_more : Icons.expand_less, size: 22),
                    onPressed: () => onChanged(state.copyWith(collapsed: !folded)),
                  ),
                ],
              ),
            ),
          ),
          if (!folded) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: _scalable ? _Scaled(scale: state.scale, child: child) : child,
            ),
            if (editing && _scalable)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        label: l10n.homeSize,
                        value: '$pct%',
                        child: Slider(
                          min: BlockState.minScale,
                          max: BlockState.maxScale,
                          divisions: 30,
                          value: state.scale,
                          label: '$pct%',
                          onChanged: (v) => onChanged(state.copyWith(scale: v)),
                        ),
                      ),
                    ),
                    // Pull this up or down to size by hand.
                    GestureDetector(
                      onVerticalDragUpdate: (d) =>
                          onChanged(state.copyWith(scale: state.scale + d.delta.dy / 160)),
                      child: Tooltip(
                        message: l10n.homeSize,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.open_in_full, size: 22),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: state.scale == 1 ? null : () => onChanged(state.copyWith(scale: 1)),
                      child: const Text('100%'),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// Shows [child] [scale] times as big: it lays out at 1/scale of the width and
/// is then scaled to fit the real width, so the height follows.
class _Scaled extends StatelessWidget {
  const _Scaled({required this.scale, required this.child});
  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (scale == 1) return child;
    return LayoutBuilder(
      builder: (context, box) => FittedBox(
        fit: BoxFit.fitWidth,
        alignment: AlignmentDirectional.topStart,
        child: SizedBox(width: box.maxWidth / scale, child: child),
      ),
    );
  }
}
