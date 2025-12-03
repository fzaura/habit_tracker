import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Todayhabitschart extends StatelessWidget {
  const Todayhabitschart({
    super.key,
    required this.numberOfAllHabitsToday,
    required this.numberOfCompletedHabits,
  });
  final int numberOfCompletedHabits;
  final int numberOfAllHabitsToday;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60,
      percent: numberOfCompletedHabits / numberOfAllHabitsToday,
      progressColor: mainAppTheme.colorScheme.onPrimary,
    );
  }
}
