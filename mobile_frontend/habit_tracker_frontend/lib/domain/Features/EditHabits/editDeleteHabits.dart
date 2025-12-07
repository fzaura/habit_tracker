import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';
import 'package:habit_tracker/domain/Features/DeleteHabits/confirmDelete.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/domain/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/editTextField.dart';

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

  void _updateHabitLogic() {
    Habit newHabit = Habit(
      id: widget.habitToEdit.id,
      habitName: yourHabitController.text,
      goalName: yourGoalController.text,
      habitType: habitGoal,
      periodUnit: periodUnit,
      createdAt: widget.habitToEdit.createdAt,
      endedAt: widget.habitToEdit.endedAt,
            updatedAt: widget.habitToEdit.updatedAt,

    );
    ref
        .watch(habitSampleProvider.notifier)
        .updateHabits(widget.habitToEdit.id, newHabit);
  }

  Widget editTextField(
    String mainHintText,
    String mainLabelText,
    TextEditingController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
          labelText: mainLabelText,
          labelStyle: mainAppTheme.textTheme.titleSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          hintText: mainHintText,
        ),
        controller: controller,
      ),
    );
  }

  Widget defaultUpdateButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainAppTheme.cardColor, mainAppTheme.colorScheme.primary],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
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
        onPressed: () {
          _updateHabitLogic();
          Navigator.pop(context);
        },
        child: Text(
          'Update',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget deleteButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Orange color
          foregroundColor: Colors.black, // Text color
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                ConfirmDelete(toDeleteHabitId: widget.habitToEdit.id),
          );
        },
        child: Text('Delete', style: mainAppTheme.textTheme.labelMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Edit Habit Goal',
                style: mainAppTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
              EditTextFormField(
                errorMessage: 'Goal Name Should be between 1 and 50 characters',
                mainHintText: '',
                controller: yourGoalController,
              ),
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
              EditTextFormField(
                errorMessage: 'Habit Name Should be between 1 and 50 characters',
                mainHintText: '',
                controller: yourHabitController,
              ),

              SizedBox(height: 15),

              // Period Dropdown
              SizedBox(height: 5),
              DropDownButtonTemp(
                buttonName: 'Period',
                passedEnumValue: periodUnit,
                enumValues: EnperiodUnit.values,
                onChanged: (passedValue) {
                  periodUnit=passedValue as EnperiodUnit;
                },
              ),
              SizedBox(height: 15),

              // Habit Type Dropdown
              DropDownButtonTemp(
                buttonName: 'Habit Type',
                passedEnumValue: habitGoal,
                enumValues: EnhabitGoal.values,
                onChanged: (passedValue) {
                  habitGoal=passedValue as EnhabitGoal;
                },
              ),

              SizedBox(height: 25),

              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Update Button
                  defaultUpdateButton(),

                  // Delete Button
                  deleteButton(),
                ],
              ),
            ],
          ),
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
