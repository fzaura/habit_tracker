import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressWheel extends StatelessWidget {
  const ProgressWheel({
    super.key,
    required this.allHabitGoals,
    required this.habitGoalAchieved,
  });
  final int habitGoalAchieved;
  final int allHabitGoals;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      startAngle: 3,
      lineWidth: 25,
      radius: 95,
      percent: (habitGoalAchieved / allHabitGoals),
      animation: true,
      animationDuration: 500,
      rotateLinearGradient: true,
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 234, 59, 6),
          const Color.fromARGB(255, 246, 161, 50),
        ],
      ),
    );
  }
}
