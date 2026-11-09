import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/home/data/home_layout_provider.dart';
import 'package:quando/features/home/domain/home_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('layout survives a save, drops unknown blocks and adds new ones', () {
    final l = const HomeLayout()
        .withState(HomeBlock.sky, const BlockState(collapsed: true, scale: 1.4))
        .move(HomeBlock.values, 0, 2);
    final back = HomeLayout.decode(l.encode())!;
    expect(back.order, l.order);
    expect(back.of(HomeBlock.sky).collapsed, isTrue);
    expect(back.of(HomeBlock.sky).scale, 1.4);
    final old = HomeLayout.decode('{"order":["alarms","sky","quick","gone"],"states":{"gone":{"s":3}}}')!;
    expect(old.order.first, HomeBlock.alarms);
    // A layout saved before the ribbon existed gets it right under the sky.
    expect(old.order[old.order.indexOf(HomeBlock.sky) + 1], HomeBlock.ribbon);
    expect(old.order.length, HomeBlock.values.length);
    expect(HomeLayout.decode('nonsense'), isNull);
  });

  test('moving among the shown blocks leaves hidden ones in place', () {
    const l = HomeLayout();
    final shown = [HomeBlock.clock, HomeBlock.sky, HomeBlock.alarms];
    final moved = l.move(shown, 0, 1); // clock goes after sky
    final inOrder = moved.order.where(shown.contains).toList();
    expect(inOrder, [HomeBlock.sky, HomeBlock.clock, HomeBlock.alarms]);
    expect(moved.order.indexOf(HomeBlock.next), l.order.indexOf(HomeBlock.next));
  });

  test('size is kept between half and double', () {
    expect(const BlockState().copyWith(scale: 9).scale, 2);
    expect(const BlockState().copyWith(scale: 0).scale, .5);
  });

  testWidgets('arranging home: fold and resize a card, and it is remembered', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 9, 12)),
        prefsProvider.overrideWithValue(prefs),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const QuandoApp()));
    await tester.pumpAndSettle();
    expect(find.text('CLOCK'), findsOneWidget);
    final before = tester.getSize(find.byKey(const ValueKey(HomeBlock.clock))).height;

    await tester.tap(find.byTooltip('Arrange home'));
    await tester.pumpAndSettle();
    expect(find.byType(Slider), findsWidgets);
    container.read(homeLayoutProvider.notifier).setBlock(HomeBlock.clock, const BlockState(scale: 1.5));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byKey(const ValueKey(HomeBlock.clock))).height, greaterThan(before));

    await tester.tap(find.byTooltip('Fold').first);
    await tester.pumpAndSettle();
    expect(container.read(homeLayoutProvider).of(HomeBlock.clock).collapsed, isTrue);
    expect(prefs.getString('home.layout'), contains('clock'));
    await tester.tap(find.text('Done').first);
    await tester.pumpAndSettle();
    expect(find.byType(Slider), findsNothing);
  });
}
