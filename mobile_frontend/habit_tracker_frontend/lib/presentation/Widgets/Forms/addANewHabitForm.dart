import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/Buttons/Habits/addNewHabit.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/editTextFieldAddHabits.dart';

class AddANewHabitForm extends ConsumerStatefulWidget {
  const AddANewHabitForm({super.key});
  @override
  ConsumerState<AddANewHabitForm> createState() => _AddANewHabitFormState();
}

class _AddANewHabitFormState extends ConsumerState<AddANewHabitForm> {
  late TextEditingController habitController;
  late TextEditingController goalController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    habitController = TextEditingController();
    goalController = TextEditingController();
    super.initState();
  }

  EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 331,
        height: 430,
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Add New Habit',
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
            Expanded(
              child: EditTextFormFieldAddHabits(
                controller: goalController,
                mainHintText: '',
                errorMessage: 'Please Enter a Correct Goal Name',
              ),
            ),
            SizedBox(height: 15),

            // Habit Name Field
            SizedBox(height: 5),
            Text(
              'Habit Name : ',
              style: mainAppTheme.textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: EditTextFormFieldAddHabits(
                controller: habitController,
                mainHintText: '',
                errorMessage: 'Please Enter a Correct Habit Name',
              ),
            ),

            SizedBox(height: 15),

            // Period Dropdown
            SizedBox(height: 5),
            Expanded(
              child: DropDownButtonTemp(
                buttonName: 'Habit Type',
                passedEnumValue: habitGoal,
                enumValues: EnhabitGoal.values,
                onChanged: (passedValue) => setState(() {
                  habitGoal = passedValue as EnhabitGoal;
                }),
              ),
            ),
            SizedBox(height: 15),

            Expanded(
              child: DropDownButtonTemp(
                buttonName: 'Period',
                passedEnumValue: periodUnit,
                enumValues: EnperiodUnit.values,
                onChanged: (passedValue) => setState(() {
                  periodUnit = passedValue as EnperiodUnit;
                }),
              ),
            ),

            // Habit Type Dropdown
            SizedBox(height: 25),
            // Buttons
            AddnewhabitButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .watch(habitsProvider.notifier)
                      .addNewHabit(
                        Habit(
                          id: 'nullToBeReturned',
                          habitName: habitController.text,
                          goalName: goalController.text,
                          habitType: habitGoal,
                          periodUnit: periodUnit,
                          createdAt: DateTime.now(),
                          endedAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
