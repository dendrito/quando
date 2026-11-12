import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/home/domain/home_grid.dart';

void noOverlaps(HomeGrid g) {
  for (final a in g.items) {
    expect(a.c >= 0 && a.right <= g.cols, isTrue, reason: '$a is off the grid');
    for (final b in g.items) {
      if (a.card != b.card) expect(a.overlaps(b), isFalse, reason: '$a overlaps $b');
    }
  }
}

void main() {
  test('default layouts: tools card on, single timers off, nothing overlaps', () {
    for (final cols in [4, 12]) {
      final g = HomeGrid.defaults(cols);
      noOverlaps(g);
      expect(g.has(HomeCard.tools), isTrue);
      expect(g.has(HomeCard.stopwatch), isFalse);
      expect(g.has(HomeCard.sky), isTrue);
      expect(g.of(HomeCard.next)!.r, 0);
    }
    expect(HomeGrid.defaults(12, shabbat: true).has(HomeCard.shabbat), isTrue);
  });

  test('moving onto a card pushes it down; everything packs up with no holes', () {
    var g = HomeGrid.defaults(12);
    g = g.move(HomeCard.tools, 0, 0);
    noOverlaps(g);
    expect(g.of(HomeCard.tools)!.r, 0);
    expect(g.of(HomeCard.next)!.r, greaterThan(0));
    // Every card touches the top or sits on another card.
    for (final p in g.items) {
      if (p.r == 0) continue;
      final above = p.at(p.c, p.r - 1);
      expect(g.items.any((o) => o.card != p.card && o.overlaps(above)), isTrue, reason: '$p floats');
    }
  });

  test('resize clamps to the grid and the smallest size; sizes map back', () {
    var g = HomeGrid.defaults(12).resize(HomeCard.next, 40, 0);
    expect(g.of(HomeCard.next)!.w, 12);
    expect(g.of(HomeCard.next)!.h, 1);
    noOverlaps(g);
    g = g.setSize(HomeCard.next, CardSize.large);
    expect(HomeGrid.nearestSize(g.of(HomeCard.next)!, 12), CardSize.large);
  });

  test('add goes to the first free spot, remove packs up, both are remembered', () {
    var g = HomeGrid.defaults(4).add(HomeCard.stopwatch).add(HomeCard.countdown, size: CardSize.small);
    noOverlaps(g);
    expect(g.has(HomeCard.stopwatch), isTrue);
    g = g.remove(HomeCard.sky);
    expect(g.has(HomeCard.sky), isFalse);
    noOverlaps(g);
    final back = HomeGrid.decode(g.encode(), 4)!;
    expect(back.items, g.items);
    expect(HomeGrid.decode(g.encode(), 12), isNull);
    expect(HomeGrid.decode('nonsense', 4), isNull);
  });
}
