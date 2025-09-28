import 'package:flutter/material.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/stateFulUtil/dropDownButtonTemp.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditDeleteHabits extends ConsumerStatefulWidget {
  const EditDeleteHabits({super.key, required this.habitToEdit});
  final Habit habitToEdit;

  @override
  ConsumerState<EditDeleteHabits> createState() => _EditDeleteHabitsState();
}

class _EditDeleteHabitsState extends ConsumerState<EditDeleteHabits> {
  @override
  late TextEditingController yourGoalController;
  late TextEditingController yourHabitController;

  EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;

  @override
  void initState() {
    super.initState();
    yourGoalController = TextEditingController();
    yourHabitController = TextEditingController();
  }

  Widget editTextField(String mainHintText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: mainHintText,
        ),
      ),
    );
  }

  Widget defaultUpdateButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainAppTheme.colorScheme.primary, // Orange color
          foregroundColor: Colors.white, // Text color
          shadowColor: Colors.orangeAccent.withOpacity(0.5), // Shadow color
          elevation: 5, // Shadow elevation
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ), // Matches text field height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              6,
            ), // Same border radius as text field
          ),
        ),
        onPressed: () {},
        child: Text(
          'Update',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Edit Habit Goal',
              style: mainAppTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            Divider(),
            SizedBox(height: 20),

            // Your Goal Field
            Text(
              'Your Goal',
              style: mainAppTheme.textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            editTextField(widget.habitToEdit.goal),
            SizedBox(height: 15),

            // Habit Name Field
            Text(
              'Habit Name',
              style: mainAppTheme.textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            editTextField(widget.habitToEdit.habitName),

            SizedBox(height: 15),

            // Period Dropdown
            SizedBox(height: 5),
            DropDownButtonTemp(
              buttonName: 'Period',
              passedEnumValue: periodUnit,
              enumValues: EnperiodUnit.values,
            ),
            SizedBox(height: 15),

            // Habit Type Dropdown
            DropDownButtonTemp(
              buttonName: 'Habit Type',
              passedEnumValue: habitGoal,
              enumValues: EnhabitGoal.values,
            ),

            SizedBox(height: 25),

            // Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Delete Button
                defaultUpdateButton(),

                // Update Button
                ElevatedButton(onPressed: () {}, child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    yourGoalController.dispose();
    yourHabitController.dispose();
    super.dispose();
  }
}
