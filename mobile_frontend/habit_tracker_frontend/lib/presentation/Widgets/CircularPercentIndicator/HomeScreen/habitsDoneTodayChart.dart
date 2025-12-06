import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HabitsDoneTodayChart extends StatelessWidget {
  const HabitsDoneTodayChart({
    super.key,
    required this.allTheHabits,
    required this.habitsCheckedToday,
  });
  final int habitsCheckedToday;
  final int allTheHabits;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animation: true,
      rotateLinearGradient: true,
      backgroundColor: Colors.white.withValues(alpha: 0.6),
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.7),
          Colors.white.withValues(alpha: 1),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      lineWidth: 17,
      radius: 63,
      percent: (habitsCheckedToday / allTheHabits),
    );
  }
}
