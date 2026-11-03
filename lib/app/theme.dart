import 'package:flutter/material.dart';

/// Warm, candlelit, minimal. Matches the Quando mockups.
class QuandoColors {
  static const ground = Color(0xFF16110D);
  static const surface = Color(0xFF221912);
  static const line = Color(0xFF4A3626);
  static const text = Color(0xFFF6EDE3);
  static const muted = Color(0xFFBCA894);
  static const amber = Color(0xFFF2A65A);
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: QuandoColors.amber, brightness: Brightness.dark).copyWith(
    primary: QuandoColors.amber,
    onPrimary: QuandoColors.ground,
    surface: QuandoColors.ground,
    onSurface: QuandoColors.text,
    surfaceContainer: QuandoColors.surface,
    outline: QuandoColors.line,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: QuandoColors.ground,
    fontFamily: 'serif',
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontWeight: FontWeight.w300, letterSpacing: -2, color: QuandoColors.text),
      headlineSmall: TextStyle(fontWeight: FontWeight.w600, color: QuandoColors.text),
      titleMedium: TextStyle(fontFamily: 'sans-serif', fontWeight: FontWeight.w600, color: QuandoColors.text),
      bodyMedium: TextStyle(fontFamily: 'sans-serif', color: QuandoColors.text),
      bodySmall: TextStyle(fontFamily: 'sans-serif', color: QuandoColors.muted),
      labelSmall: TextStyle(fontFamily: 'sans-serif', letterSpacing: 1.5, color: QuandoColors.muted),
    ),
    cardTheme: const CardThemeData(
      color: QuandoColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
    ),
    dividerColor: QuandoColors.line,
  );
}
