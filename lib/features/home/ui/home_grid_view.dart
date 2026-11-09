import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../domain/home_grid.dart';

/// How one card looks on the grid.
class GridCardSpec {
  const GridCardSpec({required this.title, required this.child, this.fill});
  final String title;
  final Widget child;

  /// Background; null is the plain translucent card.
  final Color? fill;
}

/// The home cards on a snap grid. While [editing], a card moves when you
/// drag it, resizes from its right edge, bottom edge or corner, has a size
/// menu and an × to remove it. The other cards move out of the way as you
/// drag, and everything packs up when you let go.
class HomeGridView extends StatefulWidget {
  const HomeGridView({
    super.key,
    required this.grid,
    required this.cards,
    required this.editing,
    required this.onChanged,
  });

  final HomeGrid grid;
  final Map<HomeCard, GridCardSpec> cards;
  final bool editing;
  final ValueChanged<HomeGrid> onChanged;

  @override
  State<HomeGridView> createState() => _HomeGridViewState();
}

enum _Drag { move, right, bottom, corner }

class _HomeGridViewState extends State<HomeGridView> {
  HomeCard? _active;
  _Drag? _mode;
  Offset _delta = Offset.zero;

  double get _unit => widget.grid.cols >= 12 ? 96 : 74;
  double get _gap => widget.grid.cols >= 12 ? 14 : 10;

  /// The grid as it would be if the drag ended now.
  HomeGrid _preview(double colW) {
    final g = widget.grid, card = _active, mode = _mode;
    if (card == null || mode == null) return g;
    final p = g.of(card);
    if (p == null) return g;
    final dc = (_delta.dx / (colW + _gap)).round(), dr = (_delta.dy / (_unit + _gap)).round();
    return switch (mode) {
      _Drag.move => g.move(card, p.c + dc, p.r + dr),
      _Drag.right => g.resize(card, p.w + dc, p.h),
      _Drag.bottom => g.resize(card, p.w, p.h + dr),
      _Drag.corner => g.resize(card, p.w + dc, p.h + dr),
    };
  }

  void _start(HomeCard card, _Drag mode) => setState(() {
    _active = card;
    _mode = mode;
    _delta = Offset.zero;
  });

  void _update(DragUpdateDetails d) => setState(() => _delta += d.delta);

  void _end(double colW) {
    final next = _preview(colW);
    setState(() {
      _active = null;
      _mode = null;
      _delta = Offset.zero;
    });
    if (next.encode() != widget.grid.encode()) widget.onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final still = MediaQuery.disableAnimationsOf(context);
    return LayoutBuilder(
      builder: (context, box) {
        final cols = widget.grid.cols;
        final colW = (box.maxWidth - _gap * (cols - 1)) / cols;
        final shown = _preview(colW);
        Rect rectOf(Placement p) => Rect.fromLTWH(
          p.c * (colW + _gap),
          p.r * (_unit + _gap),
          p.w * colW + (p.w - 1) * _gap,
          p.h * _unit + (p.h - 1) * _gap,
        );
        // Room to drag a card below the last one while arranging.
        final rows = shown.rows + (widget.editing ? 2 : 0);
        final height = max(0.0, rows * _unit + (rows - 1) * _gap);
        final dragged = _active == null ? null : widget.grid.of(_active!);
        return SizedBox(
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (final p in shown.items)
                if (widget.cards[p.card] case final spec?)
                  if (p.card == _active && dragged != null)
                    // The card under your finger follows it; the snapped spot shows as an outline.
                    ..._dragging(rectOf(p), rectOf(dragged), spec, p)
                  else
                    AnimatedPositioned.fromRect(
                      key: ValueKey(p.card),
                      duration: still ? Duration.zero : const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      rect: rectOf(p),
                      child: _card(p, spec, colW),
                    ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _dragging(Rect snapped, Rect from, GridCardSpec spec, Placement p) {
    final live = switch (_mode!) {
      _Drag.move => from.shift(_delta),
      _Drag.right => Rect.fromLTWH(from.left, from.top, max(40, from.width + _delta.dx), from.height),
      _Drag.bottom => Rect.fromLTWH(from.left, from.top, from.width, max(40, from.height + _delta.dy)),
      _Drag.corner => Rect.fromLTWH(
        from.left,
        from.top,
        max(40, from.width + _delta.dx),
        max(40, from.height + _delta.dy),
      ),
    };
    return [
      Positioned.fromRect(
        rect: snapped,
        child: IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: QuandoColors.amber.withAlpha(150), width: 2),
              color: QuandoColors.amber.withAlpha(25),
            ),
          ),
        ),
      ),
      Positioned.fromRect(
        key: ValueKey(p.card),
        rect: live,
        child: Opacity(opacity: .85, child: _card(p, spec, 0, lifted: true)),
      ),
    ];
  }

  Widget _card(Placement p, GridCardSpec spec, double colW, {bool lifted = false}) {
    final editing = widget.editing;
    final body = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: spec.fill ?? QuandoColors.surface.withAlpha(150),
        borderRadius: BorderRadius.circular(22),
        border: editing ? Border.all(color: QuandoColors.amber, width: 2) : null,
        boxShadow: lifted ? const [BoxShadow(color: Color(0x99000000), blurRadius: 24)] : null,
      ),
      child: editing ? IgnorePointer(child: _content(spec)) : _content(spec),
    );
    if (!editing) return Semantics(container: true, label: spec.title, child: body);
    Widget handle({Key? key, required _Drag mode, required Widget child, required MouseCursor cursor}) =>
        MouseRegion(
          key: key,
          cursor: cursor,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (_) => _start(p.card, mode),
            onPanUpdate: _update,
            onPanEnd: (_) => _end(colW),
            onPanCancel: () => _end(colW),
            child: child,
          ),
        );
    final size = HomeGrid.nearestSize(p, widget.grid.cols);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: handle(
            mode: _Drag.move,
            cursor: SystemMouseCursors.move,
            child: Semantics(label: '${spec.title} · ${l10n.homeMove}', child: body),
          ),
        ),
        // × removes the card.
        Positioned(
          left: 6,
          top: 6,
          child: _Badge(
            key: ValueKey('remove-${p.card.name}'),
            tooltip: '${l10n.homeRemoveCard} · ${spec.title}',
            onTap: () => widget.onChanged(widget.grid.remove(p.card)),
            child: const Icon(Icons.close, size: 16, color: QuandoColors.coral),
          ),
        ),
        // Size menu: Small, Medium, Large.
        Positioned(
          right: 40,
          top: 6,
          child: PopupMenuButton<CardSize>(
            key: ValueKey('size-${p.card.name}'),
            tooltip: l10n.homeSize,
            initialValue: size,
            onSelected: (s) => widget.onChanged(widget.grid.setSize(p.card, s)),
            itemBuilder: (_) => [
              for (final s in CardSize.values)
                CheckedPopupMenuItem(
                  value: s,
                  checked: s == size,
                  child: Text(switch (s) {
                    CardSize.small => l10n.sizeSmall,
                    CardSize.medium => l10n.sizeMedium,
                    CardSize.large => l10n.sizeLarge,
                  }),
                ),
            ],
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
              decoration: BoxDecoration(color: QuandoColors.amber, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(switch (size) {
                    CardSize.small => 'S',
                    CardSize.medium => 'M',
                    CardSize.large => 'L',
                  }, style: const TextStyle(color: QuandoColors.ground, fontWeight: FontWeight.w800)),
                  const Icon(Icons.arrow_drop_down, size: 18, color: QuandoColors.ground),
                ],
              ),
            ),
          ),
        ),
        // Edges and corner resize.
        Positioned(
          right: -8,
          top: 30,
          bottom: 30,
          width: 22,
          child: handle(
            mode: _Drag.right,
            cursor: SystemMouseCursors.resizeLeftRight,
            child: Center(child: _bar(vertical: true)),
          ),
        ),
        Positioned(
          left: 30,
          right: 30,
          bottom: -8,
          height: 22,
          child: handle(
            mode: _Drag.bottom,
            cursor: SystemMouseCursors.resizeUpDown,
            child: Center(child: _bar(vertical: false)),
          ),
        ),
        Positioned(
          right: -6,
          bottom: -6,
          width: 34,
          height: 34,
          child: handle(
            key: ValueKey('corner-${p.card.name}'),
            mode: _Drag.corner,
            cursor: SystemMouseCursors.resizeDownRight,
            child: const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.south_east, size: 16, color: QuandoColors.amber),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bar({required bool vertical}) => Container(
    width: vertical ? 6 : 44,
    height: vertical ? 44 : 6,
    decoration: BoxDecoration(color: QuandoColors.amber, borderRadius: BorderRadius.circular(3)),
  );

  /// The card's own content, scrolling inside the card when it is taller.
  Widget _content(GridCardSpec spec) => SingleChildScrollView(
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.all(16),
    child: spec.child,
  );
}

class _Badge extends StatelessWidget {
  const _Badge({super.key, required this.tooltip, required this.onTap, required this.child});
  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: Material(
      color: QuandoColors.ground,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 28, height: 28, child: Center(child: child)),
      ),
    ),
  );
}
