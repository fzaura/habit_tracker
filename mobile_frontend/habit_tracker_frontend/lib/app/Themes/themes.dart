import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/gradientTheme.dart';

ThemeData mainAppTheme = ThemeData(
  cardColor: Colors.orangeAccent,
  textTheme: GoogleFonts.nunitoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 234, 59, 6),
    primary: const Color.fromARGB(255, 234, 59, 6),
  ),
  //Add To your Theme
  extensions: [
    GradientTheme(
      primaryGradient: LinearGradient(
        colors: [
          mainAppTheme.colorScheme.primary,
          Colors.white.withValues(alpha: 0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ],
);
