import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/globalData.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/stateFulUtil/dropDownButtonTemp.dart';
import 'package:habit_tracker/core/utility/stateFulUtil/habitsCheckCard.dart';
import 'package:habit_tracker/core/utility/utilitySignLogWidgets.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';

class UtilAddNewHabit {
  Container defaultInputField(
    String text,
    TextEditingController controller,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: double.infinity,
      ),
      //margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textAlign: TextAlign.left, text, selectionColor: Colors.grey),
          const SizedBox(height: 12),
          TextField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  static void addNewHabit(
    BuildContext context,
    TextEditingController yourGoalController,
    TextEditingController yourHabitController,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content:  Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New Habit',
              style: mainAppTheme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            SigninInputField('Your Goal', yourGoalController, context),
            SigninInputField('Habit Name', yourHabitController, context),
            DropDownButtonTemp(
              buttonName: 'Period',
              passedEnumValue: EnperiodUnit.daily,
              enumValues: EnperiodUnit.values,
            ),
            DropDownButtonTemp(
              buttonName: 'Habit Type',
              passedEnumValue: EnhabitGoal.buildHabit,
              enumValues: EnhabitGoal.values,
            ),
          ],
        ),
      ),
    );
  }
}
