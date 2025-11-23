import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/presentation/Widgets/Buttons/addNewHabit.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/editTextField.dart';

class AddANewHabitForm extends StatelessWidget {
  const AddANewHabitForm({super.key, required this.addNewHabitLogic});
  final Function() addNewHabitLogic ;

  @override
  Widget build(BuildContext context) {
     EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;
    return Form(
        child: Container(
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
              EditTextFormField(),
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
              editTextField(''),

              SizedBox(height: 15),

              // Period Dropdown
              SizedBox(height: 5),
              DropDownButtonTemp(
                buttonName: 'Habit Type',
                passedEnumValue: habitGoal,
                enumValues: EnhabitGoal.values,
              ),
              SizedBox(height: 15),

              // Habit Type Dropdown
              SizedBox(height: 25),

              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add Button
                  AddnewhabitButton(addNewHabitLogic: addNewHabitLogic),
                ],
              ),
            ],
          ),
        ),
      ),
  }
}