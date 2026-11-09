import 'package:flutter/material.dart';

/// Warm and bold: plum nights, coral and amber light, cream text.
/// Matches the "living sky" mockups and the Q-hand logo.
class QuandoColors {
  static const ground = Color(0xFF1B1020);
  static const night = Color(0xFF120A16);
  static const surface = Color(0xFF2E1B33);
  static const raised = Color(0xFF3D2544);
  static const line = Color(0xFF5A3A55);
  static const text = Color(0xFFFFF4E6);
  static const muted = Color(0xFFCDB8C9);
  static const faint = Color(0xFF9C8399);
  static const blush = Color(0xFFF3C9B8);
  static const coral = Color(0xFFFF6B4A);
  static const amber = Color(0xFFFFB547);
}

const quandoFont = 'Bricolage';

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: QuandoColors.coral, brightness: Brightness.dark).copyWith(
    primary: QuandoColors.coral,
    onPrimary: QuandoColors.ground,
    secondary: QuandoColors.amber,
    onSecondary: QuandoColors.ground,
    surface: QuandoColors.ground,
    onSurface: QuandoColors.text,
    onSurfaceVariant: QuandoColors.muted,
    surfaceContainerLowest: QuandoColors.night,
    surfaceContainerLow: QuandoColors.surface,
    surfaceContainer: QuandoColors.surface,
    surfaceContainerHigh: QuandoColors.raised,
    surfaceContainerHighest: QuandoColors.raised,
    outline: QuandoColors.line,
    outlineVariant: QuandoColors.line,
  );

  const pill = StadiumBorder();
  const bold = TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w800, fontSize: 18);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: quandoFont,
    scaffoldBackgroundColor: QuandoColors.ground,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -4, height: 0.95),
      displayMedium: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -2.5, height: 0.95),
      displaySmall: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1.5),
      headlineLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1.5),
      headlineMedium: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1.2),
      headlineSmall: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.3),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 17),
      bodyMedium: TextStyle(fontSize: 15),
      bodySmall: TextStyle(fontSize: 14, color: QuandoColors.muted),
      labelLarge: TextStyle(fontWeight: FontWeight.w600),
      labelSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.5, color: QuandoColors.blush),
    ).apply(bodyColor: QuandoColors.text, displayColor: QuandoColors.text),
    cardTheme: const CardThemeData(
      color: QuandoColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: quandoFont,
        fontWeight: FontWeight.w800,
        fontSize: 24,
        letterSpacing: -0.5,
        color: QuandoColors.text,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: QuandoColors.coral,
        foregroundColor: QuandoColors.ground,
        minimumSize: const Size(64, 52),
        shape: pill,
        textStyle: bold,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: QuandoColors.text,
        minimumSize: const Size(64, 52),
        side: const BorderSide(color: QuandoColors.line, width: 1.5),
        shape: pill,
        textStyle: bold,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: QuandoColors.amber,
        textStyle: const TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: QuandoColors.coral,
      foregroundColor: QuandoColors.ground,
      shape: pill,
      // No hard dark ring around it: the home screen gives it a soft glow instead.
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      extendedTextStyle: TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w800, fontSize: 19),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? QuandoColors.text : QuandoColors.faint,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? QuandoColors.coral : QuandoColors.raised,
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Colors.transparent,
      side: BorderSide(color: QuandoColors.line, width: 1.5),
      shape: StadiumBorder(),
      labelStyle: TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w600, color: QuandoColors.text),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: QuandoColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18)), borderSide: BorderSide.none),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: QuandoColors.amber,
      contentTextStyle: TextStyle(fontFamily: quandoFont, fontWeight: FontWeight.w600, color: QuandoColors.ground),
      behavior: SnackBarBehavior.floating,
      shape: StadiumBorder(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: QuandoColors.surface),
    dialogTheme: const DialogThemeData(backgroundColor: QuandoColors.surface),
    dividerColor: QuandoColors.line,
  );
}
