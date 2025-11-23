import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/gradientTheme.dart';
import 'package:habit_tracker/app/Themes/themes.dart';


class AddnewhabitButton extends StatelessWidget {
  const AddnewhabitButton({super.key, required this.addNewHabitLogic});
  final Function() addNewHabitLogic;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).extension<GradientTheme>()?.primaryGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white, // Text color
          shadowColor: Colors.orangeAccent.withOpacity(0.5), // Shadow color
          elevation: 5, // Shadow elevation
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ), // Matches text field height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              6,
            ), // Same border radius as text field
          ),
        ),
        onPressed: () {
          addNewHabitLogic();
        },
        child: Text(
          'Add New Habit',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}