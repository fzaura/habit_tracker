// 1. Create the extension
import 'package:flutter/material.dart';


class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient primaryGradient;
  
  const GradientTheme({required this.primaryGradient});
  
  @override
  ThemeExtension<GradientTheme> copyWith({LinearGradient? primaryGradient}) {
    return GradientTheme(
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
  
  @override
  ThemeExtension<GradientTheme> lerp(ThemeExtension<GradientTheme>? other, double t) {
    return this;
  }
}



// 3. Use anywhere
