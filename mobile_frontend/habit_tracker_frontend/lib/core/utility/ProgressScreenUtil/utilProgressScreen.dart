import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/dropDownButtonTemp.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/GoalsUtil/StateFulWidgets/goalsCardLister.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/HomeScreenUtil/utilHomeScreenWidgets.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/Detailed%20Goals%20Lister/detailedGoalsLister.dart';
import 'package:habit_tracker/view(Screens)/SeeAllTemp/seeAllTodayHabits.dart';
import 'package:percent_indicator/percent_indicator.dart';

enum EnTimePhase { thisWeek, thisMonth, thisYear }

extension StringtimePhase on EnTimePhase {
  String get timePhaseswitch {
    switch (this) {
      case EnTimePhase.thisMonth:
        return 'This Month';
      case EnTimePhase.thisWeek:
        return 'This Week';
      case EnTimePhase.thisYear:
        return 'This Year';
    }
  }
}

class Utilprogressscreen {
  static Widget homeScreenWelcomeMessage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 29),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Progress Report',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            Expanded(
              child: DropDownButtonTemp(
                buttonName: '',
                passedEnumValue: EnTimePhase.thisMonth,
                enumValues: EnTimePhase.values,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget progressWheel(int habitGoalAchieved, int allHabitGoals) {
    return CircularPercentIndicator(
      startAngle: 3,
      progressColor: mainAppTheme.colorScheme.onPrimary.withValues(alpha: 0.8),
      lineWidth: 25,
      radius: 95,
      percent: (habitGoalAchieved / allHabitGoals),
    );
  }

  static Widget textAndIcon(int? variable1, Color color, IconData icon) {
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

  static Widget progressDoneTodayConatiner(
    int habitGoalAchieved,
    int allHabitGoals,
  ) {
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
              progressWheel(habitGoalAchieved, allHabitGoals),

              Text(
                '${currentPercentage.toInt().toString()}%',
                style: mainAppTheme.textTheme.labelMedium?.copyWith(
                  fontSize: 29,
                ),
              ),
            ],
          ),
          Expanded(
            child: textAndIcon(
              habitGoalAchieved,
              mainAppTheme.colorScheme.primary,
              Icons.check,
            ),
          ),

          Expanded(
            child: Transform.translate(
              offset: Offset(0, -20),
              child: textAndIcon(
                allHabitGoals - habitGoalAchieved,
                Colors.grey,
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget yourGoalsContainer(BuildContext ctxt) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.fromLTRB(6, 31, 6, 0),
      color: Colors.white,
      width: double.infinity,
      height: 700,
      child: Column(
        children: [
          UtilHomeScreenWidgets.listHeader('Your Goals : ', () {
            UtilHomeScreenWidgets.takeToSeeAllPage(
              ctxt: ctxt,
              nameOfListHeader: '',
              appBarText: 'Your Goals ',
              lister: GoalsCardLister(
                seeAll: true,
                shrinkWrap: true,
                canUserScroll: true,
              ),
            );
          }),
          progressDoneTodayConatiner(4, 6),
          Flexible(
            child: Detailedgoalslister(
              canUserScroll: false,
              seeAll: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
