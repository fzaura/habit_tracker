import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/ProgressScreen/progressWheel.dart';
import 'package:habit_tracker/presentation/Widgets/RowFormats/ProgressScreen/textAndIconRow.dart';

class ProgressDoneToday extends StatelessWidget {
  const ProgressDoneToday({
    super.key,
    required this.allHabitGoals,
    required this.habitGoalAchieved,
  });
  final int habitGoalAchieved;
  final int allHabitGoals;
  @override
  Widget build(BuildContext context) {
    double currentPercentage = habitGoalAchieved / allHabitGoals * 100;

    return SizedBox(
      width: double.infinity,
      height: 307.39,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ProgressWheel(
                habitGoalAchieved: habitGoalAchieved,
                allHabitGoals: allHabitGoals,
              ),

              Text(
                '${currentPercentage.toInt().toString()}%',
                style: mainAppTheme.textTheme.labelMedium?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: mainAppTheme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Expanded(
            child: TextAndIconRow(
              variable1: habitGoalAchieved,
              color: mainAppTheme.colorScheme.primary,
              icon: Icons.check,
            ),
          ),

          Expanded(
            child: Transform.translate(
              offset: Offset(0, -20),
              child: TextAndIconRow(
                variable1: habitGoalAchieved,
                color: mainAppTheme.colorScheme.primary,
                icon: Icons.check,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
