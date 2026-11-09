import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../domain/home_layout.dart';

import 'package:quando/l10n/l10n.dart';

String sizeLabel(BlockSize s) => switch (s) {
  BlockSize.small => l10n.homeSizeSmall,
  BlockSize.medium => l10n.homeSizeMedium,
  BlockSize.large => l10n.homeSizeLarge,
};

/// One card on the home screen. Its height is resized by dragging the bottom edge, its width (on wide screens)
/// by dragging a side edge, and both snap to small, medium or large. The header menu does the same by tap.
class HomeBlockFrame extends StatefulWidget {
  const HomeBlockFrame({
    super.key,
    required this.block,
    required this.title,
    required this.state,
    required this.height,
    required this.width,
    required this.canWiden,
    required this.onChanged,
    required this.onHeight,
    required this.onWidth,
    required this.onHide,
    required this.child,
    this.color,
  });

  final HomeBlock block;
  final String title;
  final BlockState state;
  final BlockSize height;
  final BlockSize width;

  /// Side edges can be dragged only when cards sit side by side.
  final bool canWiden;
  final ValueChanged<BlockState> onChanged;
  final ValueChanged<BlockSize> onHeight;
  final ValueChanged<BlockSize> onWidth;

  /// Null when the card cannot be hidden.
  final VoidCallback? onHide;
  final Widget child;
  final Color? color;

  @override
  State<HomeBlockFrame> createState() => _HomeBlockFrameState();
}

/// Pixels of dragging per step between sizes.
const _stepPx = 70.0;

class _HomeBlockFrameState extends State<HomeBlockFrame> {
  bool _hover = false;

  /// What is being dragged now (for the size badge), and where it started.
  Axis? _axis;
  BlockSize? _preview;
  late BlockSize _from;

  bool get _scalable => scalableBlocks.contains(widget.block);

  void _start(Axis axis) => setState(() {
    _axis = axis;
    _from = axis == Axis.vertical ? widget.height : widget.width;
    _preview = _from;
  });

  /// [total] is how far the pointer has moved along the axis since the start, towards "bigger".
  void _update(double total) {
    final i = (_from.index + (total / _stepPx).round()).clamp(0, BlockSize.values.length - 1);
    final next = BlockSize.values[i];
    if (next == _preview) return;
    setState(() => _preview = next);
    (_axis == Axis.vertical ? widget.onHeight : widget.onWidth)(next);
  }

  void _end() => setState(() {
    _axis = null;
    _preview = null;
  });

  Widget _edge({
    required Axis axis,
    required double sign,
    required AlignmentGeometry alignment,
    required double length,
    required MouseCursor cursor,
  }) {
    final vertical = axis == Axis.vertical;
    final active = _axis == axis;
    var total = 0.0;
    final pill = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: vertical ? 44 : 5,
      height: vertical ? 5 : 44,
      decoration: BoxDecoration(
        color: QuandoColors.amber.withValues(alpha: active ? 1 : (_hover ? .8 : .28)),
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: MouseRegion(
          cursor: cursor,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            dragStartBehavior: DragStartBehavior.down,
            onVerticalDragStart: vertical
                ? (_) {
                    total = 0;
                    _start(axis);
                  }
                : null,
            onVerticalDragUpdate: vertical ? (d) => _update(total += d.delta.dy * sign) : null,
            onVerticalDragEnd: vertical ? (_) => _end() : null,
            onVerticalDragCancel: vertical ? _end : null,
            onHorizontalDragStart: vertical
                ? null
                : (_) {
                    total = 0;
                    _start(axis);
                  },
            onHorizontalDragUpdate: vertical ? null : (d) => _update(total += d.delta.dx * sign),
            onHorizontalDragEnd: vertical ? null : (_) => _end(),
            onHorizontalDragCancel: vertical ? null : _end,
            child: SizedBox(
              width: vertical ? length : 24,
              height: vertical ? 24 : length,
              child: Center(child: pill),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final folded = widget.state.collapsed;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        decoration: BoxDecoration(
          color: widget.color ?? QuandoColors.raised.withValues(alpha: .45),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => widget.onChanged(widget.state.copyWith(collapsed: !folded)),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: text.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _menu(),
                      ],
                    ),
                  ),
                ),
                if (!folded) Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 22), child: _body()),
              ],
            ),
            if (!folded) ...[
              _edge(
                axis: Axis.vertical,
                sign: 1,
                alignment: Alignment.bottomCenter,
                length: 140,
                cursor: SystemMouseCursors.resizeUpDown,
              ),
              if (widget.canWiden) ...[
                _edge(
                  axis: Axis.horizontal,
                  sign: rtl ? -1 : 1,
                  alignment: AlignmentDirectional.centerEnd,
                  length: 120,
                  cursor: SystemMouseCursors.resizeLeftRight,
                ),
                _edge(
                  axis: Axis.horizontal,
                  sign: rtl ? 1 : -1,
                  alignment: AlignmentDirectional.centerStart,
                  length: 120,
                  cursor: SystemMouseCursors.resizeLeftRight,
                ),
              ],
            ],
            if (_preview != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: QuandoColors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        child: Text(
                          sizeLabel(_preview!),
                          style: text.labelLarge?.copyWith(color: QuandoColors.ground),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _menu() => PopupMenuButton<Object>(
    tooltip: l10n.homeSize,
    icon: const Icon(Icons.more_horiz, size: 22),
    padding: EdgeInsets.zero,
    onSelected: (v) {
      if (v is BlockSize) {
        widget.onHeight(v);
        if (widget.canWiden) widget.onWidth(v);
      } else {
        widget.onHide?.call();
      }
    },
    itemBuilder: (_) => [
      for (final s in BlockSize.values)
        CheckedPopupMenuItem<Object>(value: s, checked: s == widget.height, child: Text(sizeLabel(s))),
      if (widget.onHide != null) ...[
        const PopupMenuDivider(),
        PopupMenuItem<Object>(value: 'hide', child: Text(l10n.homeHide)),
      ],
    ],
  );

  /// Scalable cards grow their contents; list cards get a window that is shorter or taller and scrolls.
  Widget _body() {
    if (_scalable) return _Scaled(scale: scaleOf(widget.height), child: widget.child);
    final max = switch (widget.height) {
      BlockSize.small => .22,
      BlockSize.medium => .5,
      BlockSize.large => null,
    };
    if (max == null) return widget.child;
    final screen = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screen * max),
      child: SingleChildScrollView(child: widget.child),
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
