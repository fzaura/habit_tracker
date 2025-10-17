import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/statelessUtil/utilAddNewHabit.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/EditDeleteHabitsUtil/StateFullUtil/editDeleteHabits.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/EditDeleteHabitsUtil/StateLessUtil/confirmDelete.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key, required this.habitGoals});
  final Habit habitGoals;

  void editOrDelete(String value, BuildContext ctxt) {
    if (value == 'Edit') {
      showDialog(
        context: ctxt,
        builder: (context) => EditDeleteHabits(habitToEdit: habitGoals),
      );
    } else if (value == 'Delete') {
      showDialog(
        context: ctxt,
        builder: (context) => ConfirmDelete(toDeleteHabitId: habitGoals.id),
      );
    }
  }

  Row goalNameAndActions(BuildContext ctxt) {
    return Row(
      children: [
        Expanded(
          child: Text(
            habitGoals.goal,
            style: mainAppTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        UtilAddNewHabitUI().showMoreButton(
          ctxt,
          showMore: (value) => editOrDelete(value, ctxt),
        ),
      ],
    );
  }

  Widget progressBarForHabits() {
    return LinearPercentIndicator(
      width: 264.75,
      progressColor: mainAppTheme.colorScheme.primary,
      lineHeight: 13,
      percent: 0.6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        color: Colors.white,
        child: Column(
          
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             goalNameAndActions(context),
            progressBarForHabits(),
            Text(
              '${habitGoals.currentStreak} from ${habitGoals.targettedPeriod} target',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              habitGoals.periodUnit.periodName,
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: mainAppTheme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
