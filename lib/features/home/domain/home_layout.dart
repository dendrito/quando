import 'dart:convert';

/// The parts of the home screen you can move, resize and collapse.
/// The enum order is the default order: a slim clock and next alarm,
/// then the sky (sunrise, moon, weather), then the week and the alarms.
enum HomeBlock { clock, next, sky, ribbon, shabbatMode, shabbat, alarms, events, timers, world }

/// The three sizes a card can snap to, for height and for width.
enum BlockSize {
  small,
  medium,
  large;

  static BlockSize? byName(Object? n) {
    for (final v in values) {
      if (v.name == n) return v;
    }
    return null;
  }

  /// The nearest size to a scale saved by the old slider (1 = normal).
  static BlockSize fromScale(double s) => s < .9 ? small : (s <= 1.1 ? medium : large);
}

/// The size a card has until you change it.
BlockSize defaultHeight(HomeBlock b) => switch (b) {
  HomeBlock.clock || HomeBlock.next || HomeBlock.ribbon => BlockSize.small,
  HomeBlock.sky => BlockSize.large,
  _ => BlockSize.medium,
};

/// Every card is full width until you narrow it (only on wide screens).
const defaultWidth = BlockSize.large;

/// How one block is shown: folded to its title, hidden, and how tall and wide.
/// A null size means "the default for that card".
class BlockState {
  const BlockState({this.collapsed = false, this.hidden = false, this.height, this.width});

  final bool collapsed;
  final bool hidden;
  final BlockSize? height;
  final BlockSize? width;

  BlockState copyWith({bool? collapsed, bool? hidden, BlockSize? height, BlockSize? width}) => BlockState(
    collapsed: collapsed ?? this.collapsed,
    hidden: hidden ?? this.hidden,
    height: height ?? this.height,
    width: width ?? this.width,
  );

  bool get isDefault => !collapsed && !hidden && height == null && width == null;
}

/// Content scale for the cards that grow their contents (small, medium, large).
double scaleOf(BlockSize s) => switch (s) {
  BlockSize.small => 1,
  BlockSize.medium => 1.15,
  BlockSize.large => 1.3,
};

/// Blocks whose contents grow with their height. The lists (alarms, events...) get a taller or shorter
/// window instead.
const scalableBlocks = {HomeBlock.clock, HomeBlock.next, HomeBlock.sky, HomeBlock.timers, HomeBlock.world};

/// Order, folded state and size of every home block, kept between launches.
class HomeLayout {
  const HomeLayout({this.order = HomeBlock.values, this.states = const {}});

  final List<HomeBlock> order;
  final Map<HomeBlock, BlockState> states;

  BlockState of(HomeBlock b) => states[b] ?? const BlockState();

  BlockSize heightOf(HomeBlock b) => of(b).height ?? defaultHeight(b);
  BlockSize widthOf(HomeBlock b) => of(b).width ?? defaultWidth;

  HomeLayout withState(HomeBlock b, BlockState s) => HomeLayout(order: order, states: {...states, b: s});

  /// Moves [from] to [to] (the index after removing it) among only the blocks that are showing; the hidden
  /// ones keep their places.
  HomeLayout move(List<HomeBlock> visible, int from, int to) {
    final shown = [...visible];
    final moved = shown.removeAt(from);
    shown.insert(to, moved);
    final slots = [
      for (var i = 0; i < order.length; i++)
        if (visible.contains(order[i])) i,
    ];
    final next = [...order];
    for (var i = 0; i < slots.length; i++) {
      next[slots[i]] = shown[i];
    }
    return HomeLayout(order: next, states: states);
  }

  String encode() => jsonEncode({
    'order': [for (final b in order) b.name],
    'states': {
      for (final e in states.entries)
        if (!e.value.isDefault)
          e.key.name: {
            if (e.value.collapsed) 'c': true,
            if (e.value.hidden) 'x': true,
            if (e.value.height != null) 'h': e.value.height!.name,
            if (e.value.width != null) 'w': e.value.width!.name,
          },
    },
  });

  /// null when nothing usable was saved. Unknown blocks are dropped and new
  /// ones are added at the end, so an update never loses a block.
  static HomeLayout? decode(String? json) {
    if (json == null) return null;
    try {
      final m = jsonDecode(json) as Map<String, dynamic>;
      final byName = {for (final b in HomeBlock.values) b.name: b};
      final order = <HomeBlock>[for (final n in (m['order'] as List? ?? const [])) ?byName[n]];
      for (final b in HomeBlock.values) {
        if (order.contains(b)) continue;
        // The week ribbon belongs right under the sky, not at the end of a layout saved before it existed.
        if (b == HomeBlock.ribbon && order.contains(HomeBlock.sky)) {
          order.insert(order.indexOf(HomeBlock.sky) + 1, b);
        } else {
          order.add(b);
        }
      }
      final states = <HomeBlock, BlockState>{};
      (m['states'] as Map? ?? const {}).forEach((k, v) {
        final b = byName[k];
        if (b == null || v is! Map) return;
        // Layouts saved by the old slider carry a scale; it becomes the nearest size.
        final legacy = (v['s'] as num?)?.toDouble();
        final state = BlockState(
          collapsed: v['c'] == true,
          hidden: v['x'] == true,
          height:
              BlockSize.byName(v['h']) ??
              (legacy == null || legacy == 1 ? null : BlockSize.fromScale(legacy)),
          width: BlockSize.byName(v['w']),
        );
        if (!state.isDefault) states[b] = state;
      });
      return HomeLayout(order: order.toSet().toList(), states: states);
    } on Object {
      return null;
    }
  }
}
