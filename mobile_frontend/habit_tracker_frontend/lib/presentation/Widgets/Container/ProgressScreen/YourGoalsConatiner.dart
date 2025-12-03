import 'package:flutter/material.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Headers/ListHeader.dart';
import 'package:habit_tracker/presentation/Widgets/Container/ProgressScreen/progressDoneToday.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/detailedGoalsLister.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/goalsCardLister.dart';

class YourGoalsConatiner extends StatelessWidget {
  const YourGoalsConatiner({
    super.key,
    required this. numberOfAchievedGoals,
    required this. allGoals,
  });
  final int numberOfAchievedGoals;
  final int allGoals;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.fromLTRB(6, 31, 6, 0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Listheader(
              name: 'Your Goals : ',
              onPressButton: () {
                NavigationService.takeToSeeAllPage(
                  ctxt: context,
                  nameOfListHeader: '',
                  appBarText: 'Your Goals ',
                  showHorizentalCalendar: true,
                  lister: GoalsCardLister(
                    seeAll: true,
                    shrinkWrap: true,
                    canUserScroll: true,
                  ),
                );
              },
            ), //Lists All the Goals

            ProgressDoneToday(
              allHabitGoals: allGoals,
              habitGoalAchieved: numberOfAchievedGoals,
            ), //Main Container That tells how many goals are done
            Detailedgoalslister(
              canUserScroll: false,
              seeAll: false,
              shrinkWrap: true,
            ),
            TextButton(
              onPressed: () {
                NavigationService.takeToSeeAllPage(
                  ctxt: context,
                  nameOfListHeader: '',
                  appBarText: 'Your Goals ',
                  showHorizentalCalendar: false,
                  lister: Detailedgoalslister(
                    seeAll: true,
                    shrinkWrap: true,
                    canUserScroll: true,
                  ),
                );
              },
              child: Text('See all'),
            ),
          ],
        ),
      ),
    );
  }
}
