import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quando/app/theme.dart';

double _lum(Color c) {
  double f(double v) => v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * f(c.r) + 0.7152 * f(c.g) + 0.0722 * f(c.b);
}

double _ratio(Color a, Color b) {
  final x = _lum(a), y = _lum(b);
  return (max(x, y) + 0.05) / (min(x, y) + 0.05);
}

void main() {
  tearDown(() => buildTheme());

  for (final light in [false, true]) {
    test('${light ? 'Light' : 'Dark'} palette meets WCAG AA on every surface', () {
      buildTheme(light: light);
      final c = QuandoColors.ground, s = QuandoColors.surface, r = QuandoColors.raised;
      for (final bg in [c, s, r]) {
        for (final (name, fg) in [
          ('text', QuandoColors.text),
          ('muted', QuandoColors.muted),
          ('faint', QuandoColors.faint),
          ('blush', QuandoColors.blush),
          ('coral', QuandoColors.coral),
          ('amber', QuandoColors.amber),
        ]) {
          expect(
            _ratio(fg, bg),
            greaterThanOrEqualTo(4.5),
            reason: '$name on ${bg.toARGB32().toRadixString(16)}',
          );
        }
        expect(_ratio(QuandoColors.outline, bg), greaterThanOrEqualTo(3), reason: 'outline');
      }
      // Text on the filled coral and amber buttons.
      expect(_ratio(QuandoColors.ground, QuandoColors.coral), greaterThanOrEqualTo(4.5));
      expect(_ratio(QuandoColors.ground, QuandoColors.amber), greaterThanOrEqualTo(4.5));
    });
  }

  test('the night palette never changes with the theme', () {
    buildTheme(light: true);
    expect(DuskColors.ground, const Color(0xFF1B1020));
    expect(nightTheme().brightness, Brightness.dark);
  });
}
