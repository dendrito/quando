import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../domain/home_layout.dart';

/// Below this width the cards stack one per row.
const homeWideBreakpoint = 700.0;

/// The home cards: stacked on a phone, side by side on a wide screen according to each card's width.
/// Press and hold a card to drag it onto another to swap places.
class HomeCards extends StatefulWidget {
  const HomeCards({
    super.key,
    required this.blocks,
    required this.widthOf,
    required this.titleOf,
    required this.builder,
    required this.onMove,
  });

  final List<HomeBlock> blocks;
  final BlockSize Function(HomeBlock) widthOf;
  final String Function(HomeBlock) titleOf;
  final Widget Function(HomeBlock, {required bool canWiden}) builder;

  /// Called with the dragged card's index and the index of the card it was dropped on.
  final void Function(int from, int to) onMove;

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  Timer? _scroller;
  double _pointerY = 0;

  /// Scrolls the page while a card is held near the top or bottom edge.
  void _autoScroll() {
    _scroller ??= Timer.periodic(const Duration(milliseconds: 16), (_) {
      final c = PrimaryScrollController.maybeOf(context);
      if (c == null || !c.hasClients) return;
      final h = MediaQuery.sizeOf(context).height;
      const zone = 110.0;
      final dy = _pointerY < zone + 40
          ? -(zone + 40 - _pointerY) / 8
          : _pointerY > h - zone
          ? (_pointerY - (h - zone)) / 8
          : 0.0;
      if (dy != 0) c.jumpTo((c.offset + dy).clamp(0, c.position.maxScrollExtent).toDouble());
    });
  }

  void _stopScroll() {
    _scroller?.cancel();
    _scroller = null;
  }

  @override
  void dispose() {
    _stopScroll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, box) {
        final wide = box.maxWidth >= homeWideBreakpoint;
        double fraction(HomeBlock b) => !wide
            ? 1
            : switch (widget.widthOf(b)) {
                BlockSize.small => 1 / 3,
                BlockSize.medium => 2 / 3,
                BlockSize.large => 1,
              };
        return Wrap(
          children: [
            for (var i = 0; i < widget.blocks.length; i++)
              SizedBox(
                key: ValueKey(widget.blocks[i]),
                width: (box.maxWidth - 0.01) * fraction(widget.blocks[i]),
                child: _slot(i, wide, text),
              ),
          ],
        );
      },
    );
  }

  Widget _slot(int i, bool wide, TextTheme text) {
    final b = widget.blocks[i];
    final card = widget.builder(b, canWiden: wide);
    return DragTarget<HomeBlock>(
      onWillAcceptWithDetails: (d) => d.data != b,
      onAcceptWithDetails: (d) => widget.onMove(widget.blocks.indexOf(d.data), i),
      builder: (context, candidates, _) => LongPressDraggable<HomeBlock>(
        data: b,
        onDragStarted: _autoScroll,
        onDragUpdate: (d) => _pointerY = d.globalPosition.dy,
        onDragEnd: (_) => _stopScroll(),
        onDraggableCanceled: (_, _) => _stopScroll(),
        feedback: Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: QuandoColors.amber,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [BoxShadow(blurRadius: 16, color: Colors.black54)],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Text(widget.titleOf(b), style: text.labelLarge?.copyWith(color: QuandoColors.ground)),
            ),
          ),
        ),
        childWhenDragging: Opacity(opacity: .3, child: card),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: candidates.isEmpty ? null : Border.all(color: QuandoColors.amber, width: 2),
          ),
          child: card,
        ),
      ),
    );
  }
}
