import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';


class TextAndIconRow extends StatelessWidget {
  TextAndIconRow({
    super.key,
    required this.color,
    required this.icon,
    required this.variable1,
  });
  int? variable1;
  Color color;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Text(
          ' ${variable1} Habit goals has been achieved',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
