import 'dart:convert';

/// The parts of the home screen you can move, resize and collapse.
/// The enum order is the default order: a slim clock and next alarm,
/// then the sky (sunrise, moon, weather), then the week and the alarms.
enum HomeBlock { clock, next, sky, ribbon, shabbatMode, shabbat, alarms, events, timers, world }

/// How one block is shown: folded to its title, and how big (1 = normal).
class BlockState {
  const BlockState({this.collapsed = false, this.scale = 1});

  final bool collapsed;
  final double scale;

  static const minScale = .5;
  static const maxScale = 2.0;

  BlockState copyWith({bool? collapsed, double? scale}) => BlockState(
    collapsed: collapsed ?? this.collapsed,
    scale: (scale ?? this.scale).clamp(minScale, maxScale).toDouble(),
  );
}

/// Blocks whose size can be changed. The lists (alarms, events) just fold.
const scalableBlocks = {HomeBlock.clock, HomeBlock.next, HomeBlock.sky, HomeBlock.timers, HomeBlock.world};

/// Order, folded state and size of every home block, kept between launches.
class HomeLayout {
  const HomeLayout({this.order = HomeBlock.values, this.states = const {}});

  final List<HomeBlock> order;
  final Map<HomeBlock, BlockState> states;

  BlockState of(HomeBlock b) => states[b] ?? const BlockState();

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
        if (e.value.collapsed || e.value.scale != 1) e.key.name: {'c': e.value.collapsed, 's': e.value.scale},
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
        states[b] = const BlockState().copyWith(collapsed: v['c'] == true, scale: (v['s'] as num?)?.toDouble());
      });
      return HomeLayout(order: order.toSet().toList(), states: states);
    } on Object {
      return null;
    }
  }
}
