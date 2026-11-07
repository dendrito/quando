import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/home/domain/sky.dart';
import 'package:quando/features/home/ui/day_arc.dart';
import 'package:quando/features/shabbat/domain/hebrew_date.dart';
import 'package:quando/features/shabbat/domain/parasha_references.dart';

void main() {
  test('Rosh Hodesh includes both days, evening start and evening rollover', () {
    final next = RoshHodeshDate.next(DateTime(2026, 11, 7));
    expect(next.first, DateTime(2026, 11, 10));
    expect(next.last, DateTime(2026, 11, 11));
    expect(next.begins, DateTime(2026, 11, 9));
    expect(next.month, 'Kislev');
    expect(RoshHodeshDate.next(DateTime(2026, 11, 10), afterSunset: true).first, next.first);
    expect(RoshHodeshDate.next(DateTime(2026, 11, 11), afterSunset: true).first.isAfter(next.last), isTrue);
    expect(RoshHodeshDate.next(DateTime(2026, 11, 7), hebrew: true).month, 'כסלו');
  });

  test('Rosh Hashanah is not mislabeled Rosh Hodesh and one-day months work', () {
    final next = RoshHodeshDate.next(DateTime(2026, 9, 12));
    expect(next.month, 'Cheshvan');
    expect(next.first.isAfter(DateTime(2026, 9, 12)), isTrue);
    final lengths = <int>{};
    for (var month = 1; month <= 12; month++) {
      final next = RoshHodeshDate.next(DateTime(2026, month, 15));
      lengths.add(next.last.difference(next.first).inDays + 1);
    }
    expect(lengths, {1, 2});
  });

  test('Sefaria opens the displayed weekly portion, including combined and festival weeks', () {
    expect(parashaReferences.length, 61);
    final chayei = parashaSefaria(DateTime(2026, 11, 4));
    expect(chayei?.host, 'www.sefaria.org');
    expect(chayei?.path, '/Genesis.23.1-25.18');
    expect(parashaSefaria(DateTime(2026, 11, 7), afterSunset: true)?.path, '/Genesis.25.19-28.9');
    expect(parashaSefaria(DateTime(2026, 4, 4)), isNull); // Pesach replaces the weekly portion.
    var combined = false, divergence = false;
    for (var day = DateTime(2026, 1, 3); day.year == 2026; day = day.add(const Duration(days: 7))) {
      final (_, name) = hebrewDate(day);
      final link = parashaSefaria(day);
      if (name == 'Matot-Masei') {
        combined = true;
        expect(link?.path, '/Numbers.30.2-36.13');
      }
      if (link != parashaSefaria(day, inIsrael: true)) divergence = true;
    }
    expect(combined, isTrue);
    expect(divergence, isTrue);
  });

  testWidgets('the complete Sun and glow fit at dawn, noon and sunset', (tester) async {
    tester.view.physicalSize = const Size(400, 200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final rise = DateTime.utc(2026, 11, 7, 6), set = DateTime.utc(2026, 11, 7, 18);
    for (final hour in [6, 9, 12, 15, 18]) {
      final key = GlobalKey();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: RepaintBoundary(
              key: key,
              child: SizedBox(
                width: 360,
                child: DayArc(
                  sky: SkyDay(now: DateTime.utc(2026, 11, 7, hour), sunrise: rise, sunset: set),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!.buffer.asUint8List();
        var minX = image.width, minY = image.height, maxX = 0, maxY = 0;
        for (var y = 0; y < image.height; y++) {
          for (var x = 0; x < image.width; x++) {
            final i = (y * image.width + x) * 4;
            if (bytes[i + 3] > 0 && bytes[i] > bytes[i + 1] && bytes[i + 1] > bytes[i + 2] * 1.3) {
              if (x < minX) minX = x;
              if (x > maxX) maxX = x;
              if (y < minY) minY = y;
              if (y > maxY) maxY = y;
            }
          }
        }
        expect(minX, lessThan(maxX), reason: 'Sun and glow were drawn');
        expect(minX, greaterThan(0), reason: '$hour: left edge');
        expect(minY, greaterThan(0), reason: '$hour: top edge');
        expect(maxX, lessThan(image.width - 1), reason: '$hour: right edge');
        expect(maxY, lessThan(image.height - 1), reason: '$hour: bottom edge');
        image.dispose();
      });
    }
  });
}
