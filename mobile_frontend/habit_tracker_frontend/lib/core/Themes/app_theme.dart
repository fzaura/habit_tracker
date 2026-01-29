import 'package:flutter/material.dart';

class AppTheme {
  static const Color _background = Color(0xDDD9D9D9);
  static const Color _primaryBrand = Color.fromRGBO(107, 42, 119, 1);
  static const Color _secondaryBrand = Color.fromARGB(255, 24, 112, 118);
  static const Color _tertiaryBrand = Color(0xFF686B6B);
  static const Color _accentAction = Color(0xFF283D3B);
  static const Color _creamColor= Color(0xEEEDDDD4);
    static const Color _test= Color.fromARGB(255, 201, 81, 11);


  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _background,
      
      // 1. Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accentAction,
        primary: _accentAction,
        secondary: _secondaryBrand,
        tertiary: _primaryBrand,
        surface: Colors.white,
        onSurface: _accentAction,
        onPrimary: Colors.white,
        onSecondary: _creamColor,
        surfaceTint: Colors.transparent, 
        // Clean iPhone look
      ),

      // 2. Component Styling
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: _accentAction),
        titleTextStyle: TextStyle(
          color: _accentAction,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      cardTheme: CardThemeData(
        color:_background,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // 3. Typography
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _accentAction,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(color: _accentAction, fontSize: 16),
        bodyMedium: TextStyle(color: _accentAction, fontSize: 14),
      ),

      // 4. Custom Theme Extensions
      extensions: <ThemeExtension<dynamic>>[
        GoalCardColors(
          purpleGoal: _primaryBrand,
          tealGoal: _secondaryBrand,
          greyGoal: _tertiaryBrand,
        ),
      ],
    );
  }
}

// Updated Extension with Helper Logic
class GoalCardColors extends ThemeExtension<GoalCardColors> {
  final Color? purpleGoal;
  final Color? tealGoal;
  final Color? greyGoal;

  const GoalCardColors({
    required this.purpleGoal,
    required this.tealGoal,
    required this.greyGoal,
  });

  /// Helper to rotate colors based on index automatically
  Color getColorByIndex(int index) {
    switch (index % 3) {
      case 0: return tealGoal ?? const Color(0xFF197278);
      case 1: return purpleGoal ?? const Color(0xFF6B2A77);
      case 2: return greyGoal ?? const Color(0xFF686B6B);
      default: return tealGoal ?? const Color(0xFF197278);
    }
  }

  @override
  GoalCardColors copyWith({Color? purple, Color? teal, Color? grey}) {
    return GoalCardColors(
      purpleGoal: purple ?? purpleGoal,
      tealGoal: teal ?? tealGoal,
      greyGoal: grey ?? greyGoal,
    );
  }

  @override
  GoalCardColors lerp(ThemeExtension<GoalCardColors>? other, double t) {
    if (other is! GoalCardColors) return this;
    return GoalCardColors(
      purpleGoal: Color.lerp(purpleGoal, other.purpleGoal, t),
      tealGoal: Color.lerp(tealGoal, other.tealGoal, t),
      greyGoal: Color.lerp(greyGoal, other.greyGoal, t),
    );
  }
}