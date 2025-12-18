import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/HomeScreen/habitsDoneTodayChart.dart';

class HomeScreenWelcomeCard extends StatelessWidget {
  const HomeScreenWelcomeCard({
    super.key,
    required this.habitsCheckedToday,
    required this.allTheHabits,
  });

  final int habitsCheckedToday;
  final int allTheHabits;

  @override
  Widget build(BuildContext context) {
    //For Debug Purposes :
    print('All the Habits checked todsy Number  : ${habitsCheckedToday}');
    print('All the Habits Number : ${allTheHabits}');

    final double mainPecetnage = habitsCheckedToday / allTheHabits * 100;

    print('All the Main Percentage  Number : ${mainPecetnage}');

    return Container(
      width: double.infinity,
      height: 199,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainAppTheme.cardColor, mainAppTheme.colorScheme.primary],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.all(13),
      child: Stack(
        children: [
          Positioned(
            right: 204,
            bottom: 34,
            top: 34,
            left: 26,
            child: HabitsDoneTodayChart(
              habitsCheckedToday: habitsCheckedToday,
              allTheHabits: allTheHabits,
            ),
          ),
          Positioned(
            top: 85,

            bottom: 45,
            left: 85,
            right: 234,

            child: Text(
              '${mainPecetnage.toInt()}%',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 61,

            bottom: 54,
            left: 189,
            right: 10.24,

            child: Text(
              '$habitsCheckedToday of $allTheHabits \nCompleted Today!',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 120,

            bottom: 0,
            left: 300.60,
            right: 43.24,

            child: Transform.scale(
              scale: 3.6,
              child: Image.asset(
                'resources/Calendar_Flatline.png',
                width: 132,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
