import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/presentation/Auth/StateClasses/Habits/habitsState.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenWelcomeCardBundle.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/HomeScreen/habitsDoneTodayChart.dart';
import 'package:habit_tracker/presentation/Widgets/GlobalStateBuilder/habitStateBuilder.dart';

class HomeScreenWelcomeCard extends StatelessWidget {
  const HomeScreenWelcomeCard({super.key, required this.state});
  final HabitState state;

  Widget onSuccess(HomeScreenWelcomeCardBundle dataBundle) {
    print('THE ON SUCCESS HOME SCREEN WELCOME CARD GOT RENDERED');
    final double mainPercentage = (dataBundle.allTheHabits > 0)
        ? (dataBundle.habitsCheckedToday / dataBundle.allTheHabits * 100)
        : 0.0;
    print('All the Main Percentage  Number : ${mainPercentage}');

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
              habitsCheckedToday: dataBundle.habitsCheckedToday,
              allTheHabits: dataBundle.allTheHabits,
            ),
          ),
          Positioned(
            top: 85,

            bottom: 45,
            left: 85,
            right: 234,

            child: Text(
              '${mainPercentage.isNaN ? mainPercentage.toInt() : 0}%',
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
              (dataBundle.allTheHabits > 0)
                  ? '${dataBundle.habitsCheckedToday} of ${dataBundle.allTheHabits}\nCompleted Today!'
                  : "No habits yet? \n Let's build a better routine together!",
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

  @override
  Widget build(BuildContext context) {
    return HabitStateBuilder<HomeScreenWelcomeCardBundle>(
      state: state,
      successWidget: onSuccess,
    );
  }
}
