import 'package:flutter/material.dart';

class HabitaIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final double size;

  const HabitaIcon({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.size = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.04, // Exact Figma width
      height: 30.0, // Exact Figma height
      child: Center(
        child: Icon(
          icon,
          size: size,
          // Applying the specific stroke/color logic
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
          weight: 2.0, // This mimics the border-width: 2px from your spec
        ),
      ),
    );
  }
}