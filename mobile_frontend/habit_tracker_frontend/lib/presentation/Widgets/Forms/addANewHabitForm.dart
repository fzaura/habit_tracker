import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/presentation/Widgets/Buttons/addNewHabit.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/editTextField.dart';

class AddANewHabitForm extends StatefulWidget {
  const AddANewHabitForm({super.key, required this.addNewHabitLogic});
  final Function(
    String habitName,
    String golaName,
    EnhabitGoal habitGoal,
    EnperiodUnit periodUnit,
  )
  addNewHabitLogic;

  @override
  State<AddANewHabitForm> createState() => _AddANewHabitFormState();
}

class _AddANewHabitFormState extends State<AddANewHabitForm> {
  late TextEditingController habitController;
  late TextEditingController goalController;

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
              child: EditTextFormField(
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
              child: EditTextFormField(
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
                widget.addNewHabitLogic(
                  goalController.text,
                  habitController.text,
                  habitGoal,
                  periodUnit,
                );
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
