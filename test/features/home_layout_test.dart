import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/app.dart';
import 'package:quando/app/providers.dart';
import 'package:quando/features/home/data/home_layout_provider.dart';
import 'package:quando/features/home/domain/home_layout.dart';
import 'package:quando/features/home/ui/home_block_frame.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('layout survives a save, drops unknown blocks and adds new ones', () {
    final l = const HomeLayout()
        .withState(
          HomeBlock.sky,
          const BlockState(collapsed: true, height: BlockSize.large, width: BlockSize.small),
        )
        .move(HomeBlock.values, 0, 2);
    final back = HomeLayout.decode(l.encode())!;
    expect(back.order, l.order);
    expect(back.of(HomeBlock.sky).collapsed, isTrue);
    expect(back.of(HomeBlock.sky).height, BlockSize.large);
    expect(back.of(HomeBlock.sky).width, BlockSize.small);
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

  test('layouts saved with the old size slider map to the nearest size', () {
    final l = HomeLayout.decode(
      '{"order":["clock"],"states":{"clock":{"s":1.6},"sky":{"s":0.6},"next":{"c":true,"s":1}}}',
    )!;
    expect(l.heightOf(HomeBlock.clock), BlockSize.large);
    expect(l.heightOf(HomeBlock.sky), BlockSize.small);
    expect(l.of(HomeBlock.next).collapsed, isTrue);
  });

  test('default sizes', () {
    const l = HomeLayout();
    expect(l.heightOf(HomeBlock.clock), BlockSize.small);
    expect(l.heightOf(HomeBlock.next), BlockSize.small);
    expect(l.heightOf(HomeBlock.sky), BlockSize.large);
    expect(l.heightOf(HomeBlock.ribbon), BlockSize.small);
    expect(l.heightOf(HomeBlock.alarms), BlockSize.medium);
  });

  testWidgets('cards: menu resizes, bottom edge drags, hide and restore, remembered', (tester) async {
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
    expect(find.byTooltip('Arrange home'), findsNothing);
    final clockFrame = find.byWidgetPredicate((w) => w is HomeBlockFrame && w.block == HomeBlock.clock);
    final small = tester.getSize(clockFrame).height;

    // The header menu picks a size.
    await tester.tap(find.descendant(of: clockFrame, matching: find.byTooltip('Size')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(CheckedPopupMenuItem<Object>, 'Large'));
    await tester.pumpAndSettle();
    expect(container.read(homeLayoutProvider).heightOf(HomeBlock.clock), BlockSize.large);
    expect(tester.getSize(clockFrame).height, greaterThan(small));
    expect(prefs.getString('home.layout'), contains('large'));

    // Dragging the bottom edge snaps back down.
    final box = tester.getRect(clockFrame);
    await tester.dragFrom(Offset(box.center.dx, box.bottom - 24), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(container.read(homeLayoutProvider).heightOf(HomeBlock.clock), BlockSize.small);

    // Hide it, then bring it back.
    await tester.tap(find.descendant(of: clockFrame, matching: find.byTooltip('Size')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hide'));
    await tester.pumpAndSettle();
    expect(find.text('CLOCK'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('1 hidden card'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('1 hidden card'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CLOCK'));
    await tester.pumpAndSettle();
    expect(find.text('CLOCK'), findsOneWidget);
  });
}
