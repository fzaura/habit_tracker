import 'package:flutter/material.dart';

class HabitLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const HabitLoadingIndicator({
    super.key,
    this.size = 24.0, // Smaller, cleaner default
    this.strokeWidth = 2.5, // Thinner for that "Retina" look
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        strokeCap: StrokeCap.round, // Makes the ends soft/rounded
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        backgroundColor: primaryColor.withValues(alpha: 0.1), // Subtle track
      ),
    );
  }
}