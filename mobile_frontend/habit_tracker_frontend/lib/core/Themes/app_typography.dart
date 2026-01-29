import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const Color _mainColor = Color(0xFF283D3B);

  static TextTheme get textTheme {
    return TextTheme(
      // main title (41/100)
      displayLarge: GoogleFonts.inter(
        fontSize: 41,
        height: 1.0, // 41/41
        color: _mainColor,
        fontWeight: FontWeight.bold,
      ),

      // h2 subTitle (25/126)
      headlineMedium: GoogleFonts.inter(
        fontSize: 25,
        height: 1.26, // 31.5/25
        color: _mainColor,
        fontWeight: FontWeight.w600,
      ),

      // card title (25/Auto)
      titleLarge: GoogleFonts.inter(
        fontSize: 25,
        color: _mainColor,
        fontWeight: FontWeight.bold,
      ),

      // task title (18/126)
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        height: 1.26,
        color: _mainColor,
        fontWeight: FontWeight.w500,
      ),

      // h3 card (16/140)
      titleSmall: GoogleFonts.inter(
        fontSize: 16,
        height: 1.4,
        color: _mainColor,
        fontWeight: FontWeight.w600,
      ),

      // text (16/Auto)
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: _mainColor,
      ),

      // sub text (16/126)
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        height: 1.26,
        color: _mainColor,
      ),

      // button text (14/140)
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        height: 1.4,
        color: _mainColor,
        fontWeight: FontWeight.bold,
      ),

      // progress tag (15/Auto)
      labelMedium: GoogleFonts.inter(
        fontSize: 15,
        color: _mainColor,
      ),

      // large category tag (14/Auto)
      labelSmall: GoogleFonts.inter(
        fontSize: 14,
        color: _mainColor,
      ),

      // italic soft text (12/126)
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 1.26,
        color: _mainColor,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  // mini category text (10/Auto) - Custom Helper
  static TextStyle get miniCategoryText => GoogleFonts.inter(
        fontSize: 10,
        color: _mainColor,
      );
}