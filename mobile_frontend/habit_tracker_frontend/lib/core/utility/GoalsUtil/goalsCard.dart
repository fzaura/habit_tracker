import 'package:flutter/material.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key, required this.habitGoals});
  final Habit habitGoals;
  Row GoalNameAndActions() {
    return Row(
      children: [
        Text(
          habitGoals.goal,
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(child: Column(children: [])),
    );
  }
}
