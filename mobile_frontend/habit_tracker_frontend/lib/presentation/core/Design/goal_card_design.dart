import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/Themes/app_theme.dart';
import 'package:habit_tracker/presentation/core/Enums/activity_level.dart';

/// Encapsulates all design, styling, and visual logic for GoalCard
/// 
/// RESPONSIBILITY: Single - Handles only visual/design concerns
/// - Color and opacity calculations
/// - Text styles and decorations
/// - Grid layout configurations
/// - All styling getters and builders
class GoalCardDesign {
  // ========== DIMENSIONS ==========

  static const double width = 206.0;
  static const double height = 244.0;
  static const double borderRadius = 30.0;
  static const double horizontalPadding = 12.0;
  static const double verticalPadding = 10.0;

  // ========== GRID CONFIGURATION ==========

  static const int gridRows = 4; // 4 rows with vertical fade
  static const int gridColumns = 11;
  static const double squareSize = 14;
  static const double squareGap = 2.0;
  static const double squareBorderRadius = 2.0;

  // ========== GRADIENT COLORS (VERTICAL) ==========

  static const Color gradientStart = Color.fromARGB(116, 140, 189, 193);
  static const Color gradientMid = Color(0xD42F797E); // #2F797ED4 (Middle)
  static const Color gradientEnd = Color.fromARGB(255, 138, 170, 172);

  // ========== OPACITY & GRADIENT CALCULATIONS ==========

  /// Maps activity level to base opacity value
  /// 
  /// Used to differentiate activity intensity in grid squares
  static double getActivityOpacity(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.none:
        return 0.2;
      case ActivityLevel.low:
        return 0.4;
      case ActivityLevel.medium:
        return 0.6;
      case ActivityLevel.high:
        return 0.9;
      case ActivityLevel.veryHigh:
        return 0.9;
    }
  }

  /// Gets row opacity multiplier for vertical fade effect
  ///
  /// WHAT: Calculates opacity multiplier for each row (top to bottom fade)
  /// WHY: Creates vertical fade from 100% to 40%
  /// HOW: Row 0-1 = 100%, Row 2 = 80%, Row 3 = 40%
  static double getRowOpacityMultiplier(int row) {
    switch (row) {
      case 0:
      case 1:
        return 1.0; // Rows 0-1: 100% visible
      case 2:
        return 0.5; // Row 2: 80% visible
      case 3:
        return 0.3; // Row 3: 40% visible
      default:
        return 0.2;
    }
  }

  /// Gets gradient color based on row position (VERTICAL gradient)
  ///
  /// WHAT: Returns interpolated color from gradient (top to bottom)
  /// WHY: Creates vertical gradient across rows
  /// HOW: Lerps between gradient colors based on row index
  static Color getGradientColor(int row) {
    final progress = row / (gridRows - 1); // 0.0 to 1.0 from top to bottom

    if (progress <= 0.5) {
      // First half: gradientStart to gradientMid
      final t = progress * 2; // 0.0 to 1.0
      return Color.lerp(gradientStart, gradientMid, t)!;
    } else {
      // Second half: gradientMid to gradientEnd
      final t = (progress - 0.5) * 0.87; // 0.0 to 1.0
      return Color.lerp(gradientMid, gradientEnd, t)!;
    }
  }

  // ========== STYLING GETTERS ==========

  /// Main container decoration with shadow
  /// MODIFIED: Now accepts Color parameter instead of GoalCardColors
  static BoxDecoration getCardDecoration(Color cardColor) {
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Goal name text style
  static TextStyle getGoalNameStyle() {
    return GoogleFonts.karla(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      height: 1.26,
    );
  }

  /// Task name text style (subtitle)
  static TextStyle getTaskNameStyle() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white.withValues(alpha: 0.7),
      height: 1.3,
    );
  }

  /// Category chip decoration
  static BoxDecoration getCategoryChipDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Category text style
  static TextStyle getCategoryTextStyle() {
    return GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(0.9),
      letterSpacing: 0.3,
    );
  }

  /// Square decoration based on activity level and row
  ///
  /// WHAT: Returns decoration with gradient color and opacity
  /// WHY: Creates GitHub-style grid with VERTICAL gradient and fade
  /// HOW: Combines activity opacity, row fade, and row gradient
  static BoxDecoration getSquareDecoration(
    ActivityLevel level,
    int row,
    int col,
  ) {
    final baseOpacity = getActivityOpacity(level);
    final rowMultiplier = getRowOpacityMultiplier(row);

    if (level == ActivityLevel.none) {
      // Empty square with subtle border
      return BoxDecoration(
        color: const Color.fromARGB(0, 0, 0, 0),
        borderRadius: BorderRadius.circular(squareBorderRadius),
        border: Border.all(
          color: const Color.fromARGB(
            255,
            147,
            172,
            172,
          ).withValues(alpha: 0.28 * rowMultiplier),
          width: 1,
        ),
      );
    }

    // Active square with gradient color based on ROW (vertical)
    final gradientColor = getGradientColor(row);

    return BoxDecoration(
      color: gradientColor.withValues(alpha: baseOpacity),
      borderRadius: BorderRadius.circular(squareBorderRadius),
    );
  }

  /// Icon color for card header
  static Color getIconColor() {
    return AppTheme.lightTheme.scaffoldBackgroundColor;
  }

  /// Icon size for card header
  static const double iconSize = 30.0;
}