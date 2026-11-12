import 'dart:convert';
import 'dart:math';

/// The cards you can put on the home grid.
enum HomeCard {
  next,
  clock,
  sky,
  moon,
  weather,
  alarms,
  quick,

  /// Stopwatch, countdown and get set together in one card.
  tools,
  stopwatch,
  countdown,
  getSet,
  world,
  week,
  shabbat,
}

enum CardSize { small, medium, large }

/// Where one card sits on the grid, in grid cells.
class Placement {
  const Placement(this.card, this.c, this.r, this.w, this.h);
  final HomeCard card;
  final int c, r, w, h;

  int get right => c + w;
  int get bottom => r + h;

  Placement at(int c, int r) => Placement(card, c, r, w, h);
  Placement sized(int w, int h) => Placement(card, c, r, w, h);

  bool overlaps(Placement o) => c < o.right && o.c < right && r < o.bottom && o.r < bottom;

  @override
  bool operator ==(Object other) =>
      other is Placement &&
      other.card == card &&
      other.c == c &&
      other.r == r &&
      other.w == w &&
      other.h == h;

  @override
  int get hashCode => Object.hash(card, c, r, w, h);

  @override
  String toString() => '${card.name}@$c,$r ${w}x$h';
}

/// Cards on a snap grid. Every change packs the cards upwards, so there are
/// no holes: moving or growing a card pushes the ones in its way down, and
/// removing or shrinking one lets the ones below move up.
class HomeGrid {
  HomeGrid(this.cols, List<Placement> items) : items = List.unmodifiable(_pack(cols, items, null));

  final int cols;
  final List<Placement> items;

  /// 12 columns on iPad and Mac, 4 on a phone.
  static int colsFor(double width) => width >= 700 ? 12 : 4;

  Placement? of(HomeCard card) => items.where((p) => p.card == card).firstOrNull;
  bool has(HomeCard card) => of(card) != null;
  int get rows => items.fold(0, (m, p) => max(m, p.bottom));

  /// The width and height of each card size.
  static (int, int) sizeOf(HomeCard card, CardSize size, int cols) {
    final wide = cols >= 12;
    final i = size.index;
    (int, int) pick(List<(int, int)> s) => s[i];
    return switch (card) {
      HomeCard.next => wide ? pick([(4, 1), (5, 2), (8, 2)]) : pick([(4, 1), (4, 2), (4, 3)]),
      HomeCard.clock => wide ? pick([(3, 1), (3, 2), (4, 2)]) : pick([(2, 1), (4, 1), (4, 2)]),
      HomeCard.sky => wide ? pick([(6, 4), (8, 4), (12, 4)]) : pick([(4, 5), (4, 5), (4, 6)]),
      HomeCard.moon => wide ? pick([(4, 4), (6, 4), (8, 4)]) : pick([(4, 5), (4, 5), (4, 6)]),
      HomeCard.weather => wide ? pick([(4, 3), (6, 3), (8, 3)]) : pick([(4, 4), (4, 4), (4, 5)]),
      HomeCard.alarms => wide ? pick([(4, 2), (4, 3), (4, 5)]) : pick([(4, 2), (4, 3), (4, 5)]),
      HomeCard.quick => wide ? pick([(4, 1), (4, 2), (6, 1)]) : pick([(2, 1), (4, 1), (4, 2)]),
      HomeCard.tools => wide ? pick([(4, 2), (4, 3), (12, 1)]) : pick([(4, 3), (4, 3), (4, 4)]),
      HomeCard.stopwatch ||
      HomeCard.countdown ||
      HomeCard.getSet => wide ? pick([(2, 1), (3, 1), (4, 1)]) : pick([(2, 1), (4, 1), (4, 1)]),
      HomeCard.world => wide ? pick([(4, 2), (4, 3), (6, 3)]) : pick([(4, 2), (4, 3), (4, 4)]),
      HomeCard.week => wide ? pick([(4, 3), (6, 4), (12, 4)]) : pick([(4, 4), (4, 5), (4, 6)]),
      HomeCard.shabbat => wide ? pick([(4, 2), (6, 2), (8, 2)]) : pick([(4, 2), (4, 3), (4, 3)]),
    };
  }

  /// The named size nearest to a placement's size.
  static CardSize nearestSize(Placement p, int cols) {
    var best = CardSize.medium;
    var bestScore = 1 << 30;
    for (final s in CardSize.values) {
      final (w, h) = sizeOf(p.card, s, cols);
      final score = (w - p.w).abs() * 2 + (h - p.h).abs() * 3;
      if (score < bestScore) (best, bestScore) = (s, score);
    }
    return best;
  }

  /// The smallest a card may be dragged to.
  static (int, int) minOf(HomeCard card, int cols) => sizeOf(card, CardSize.small, cols);

  static HomeGrid defaults(int cols, {bool shabbat = false}) {
    Placement p(HomeCard card, int c, int r, [CardSize size = CardSize.medium]) {
      final (w, h) = sizeOf(card, size, cols);
      return Placement(card, c, r, w, h);
    }

    if (cols >= 12) {
      return HomeGrid(cols, [
        p(HomeCard.next, 0, 0),
        p(HomeCard.clock, 5, 0),
        p(HomeCard.quick, 8, 0, CardSize.small),
        p(HomeCard.sky, 0, 2),
        p(HomeCard.alarms, 8, 1),
        if (shabbat) p(HomeCard.shabbat, 8, 4, CardSize.small),
        p(HomeCard.tools, 8, 6, CardSize.small),
      ]);
    }
    return HomeGrid(cols, [
      p(HomeCard.next, 0, 0),
      p(HomeCard.clock, 0, 2, CardSize.small),
      p(HomeCard.quick, 2, 2, CardSize.small),
      p(HomeCard.sky, 0, 3),
      if (shabbat) p(HomeCard.shabbat, 0, 9, CardSize.small),
      p(HomeCard.alarms, 0, 11),
      p(HomeCard.tools, 0, 14, CardSize.small),
    ]);
  }

  /// Puts [card] at [c],[r] with size [w] x [h] (clamped to the grid); cards
  /// in the way move down, then everything packs up.
  HomeGrid place(HomeCard card, int c, int r, int w, int h) {
    final (minW, minH) = minOf(card, cols);
    w = w.clamp(min(minW, cols), cols);
    h = max(h, minH);
    c = c.clamp(0, cols - w);
    r = max(r, 0);
    final moved = Placement(card, c, r, w, h);
    return HomeGrid._packed(cols, [moved, ...items.where((p) => p.card != card)], moved);
  }

  HomeGrid move(HomeCard card, int c, int r) {
    final p = of(card);
    return p == null ? this : place(card, c, r, p.w, p.h);
  }

  HomeGrid resize(HomeCard card, int w, int h) {
    final p = of(card);
    return p == null ? this : place(card, p.c, p.r, w, h);
  }

  HomeGrid setSize(HomeCard card, CardSize size) {
    final (w, h) = sizeOf(card, size, cols);
    return resize(card, w, h);
  }

  HomeGrid remove(HomeCard card) => HomeGrid(cols, [...items.where((p) => p.card != card)]);

  /// Adds [card] in the first free spot, reading left to right, top to bottom.
  HomeGrid add(HomeCard card, {CardSize size = CardSize.medium}) {
    if (has(card)) return this;
    final (w, h) = sizeOf(card, size, cols);
    for (var r = 0; ; r++) {
      for (var c = 0; c + w <= cols; c++) {
        final p = Placement(card, c, r, w, h);
        if (!items.any(p.overlaps)) return HomeGrid._packed(cols, [...items, p], null);
      }
    }
  }

  HomeGrid._packed(this.cols, List<Placement> items, Placement? first)
    : items = List.unmodifiable(_pack(cols, items, first));

  /// Resolves overlaps (the [first] card keeps its spot; others move down
  /// below whatever they hit) and then lets every card float up.
  static List<Placement> _pack(int cols, List<Placement> input, Placement? first) {
    final seen = <HomeCard>{};
    final list = <Placement>[
      for (final p in input)
        if (seen.add(p.card))
          Placement(
            p.card,
            p.c.clamp(0, max(0, cols - min(p.w, cols))),
            max(0, p.r),
            min(p.w, cols),
            max(1, p.h),
          ),
    ];
    final ordered = [
      ?list.where((p) => p.card == first?.card).firstOrNull,
      ...(list.where((p) => p.card != first?.card).toList()
        ..sort((a, b) => a.r != b.r ? a.r - b.r : a.c - b.c)),
    ];
    final placed = <Placement>[];
    for (var p in ordered) {
      while (true) {
        final hits = placed.where(p.overlaps);
        if (hits.isEmpty) break;
        p = p.at(p.c, hits.map((h) => h.bottom).reduce(max));
      }
      placed.add(p);
    }
    // Float up, top cards first.
    placed.sort((a, b) => a.r != b.r ? a.r - b.r : a.c - b.c);
    final out = <Placement>[];
    for (var p in placed) {
      while (p.r > 0) {
        final up = p.at(p.c, p.r - 1);
        if (out.any(up.overlaps)) break;
        p = up;
      }
      out.add(p);
    }
    return out;
  }

  String encode() => jsonEncode({
    'cols': cols,
    'cards': [
      for (final p in items) [p.card.name, p.c, p.r, p.w, p.h],
    ],
  });

  /// null when nothing usable was saved for this many columns.
  static HomeGrid? decode(String? json, int cols) {
    if (json == null) return null;
    try {
      final m = jsonDecode(json) as Map<String, dynamic>;
      if (m['cols'] != cols) return null;
      final byName = {for (final c in HomeCard.values) c.name: c};
      return HomeGrid(cols, [
        for (final e in m['cards'] as List)
          if (byName[(e as List)[0]] case final card?)
            Placement(card, e[1] as int, e[2] as int, e[3] as int, e[4] as int),
      ]);
    } catch (_) {
      return null;
    }
  }
}
