import 'package:flutter/material.dart';

class AppTheme {
  static const Color _background = Color(0xFFD9D9D9);
  static const Color _primaryBrand = Color(0xFF6B2A77);
  static const Color _secondaryBrand = Color(0xFF197278);
  static const Color _tertiaryBrand = Color(0xFF686B6B);
  static const Color _accentAction = Color(0xFF283D3B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _background,
      
      // 1. Color Scheme Mapping - AccentAction is now Primary
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accentAction,
        primary: _accentAction,        // Main UI color
        secondary: _secondaryBrand,
        tertiary: _primaryBrand,       // Purple moved here
        surface: Colors.white,
        onSurface: _accentAction,
        onPrimary: Colors.white,
      ),

      // 2. Component Styling - FIXED CardThemeData
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

      // FIXED: Use CardThemeData instead of CardTheme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return _accentAction;
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // 3. Typography
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _accentAction,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: _accentAction,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: _accentAction,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
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

// Custom Extension updated with more semantic names
class GoalCardColors extends ThemeExtension<GoalCardColors> {
  final Color? purpleGoal;
  final Color? tealGoal;
  final Color? greyGoal;

  const GoalCardColors({
    required this.purpleGoal,
    required this.tealGoal,
    required this.greyGoal,
  });

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