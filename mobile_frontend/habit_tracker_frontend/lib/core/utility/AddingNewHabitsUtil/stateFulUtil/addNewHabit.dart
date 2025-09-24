import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/statelessUtil/utilAddNewHabit.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/stateFulUtil/dropDownButtonTemp.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';
import 'package:habit_tracker/view(Screens)/HomeScreens/sucessScreenUtil.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class Addnewhabit extends ConsumerStatefulWidget {
  const Addnewhabit({super.key});
  @override
  ConsumerState<Addnewhabit> createState() => _AddnewhabitState();
}

class _AddnewhabitState extends ConsumerState<Addnewhabit> {
  late TextEditingController yourGoalController;
  late TextEditingController yourHabitController;

  EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;

  void _addNewHabitLogic() {
    ref
        .read(habitSampleProvider.notifier)
        .addNewHabit(
          Habit(
            id: '33',
            habitName: yourHabitController.text,
            goal: yourGoalController.text,
            habitType: habitGoal,
            periodUnit: periodUnit,
            createdAt: DateTime.now(),
          ),
        );
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SucessScreenUtil()),
    );
  }

  @override
  void initState() {
    super.initState();
    yourGoalController = TextEditingController();
    yourHabitController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Create New Habit',
        style: mainAppTheme.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          SigninInputField('Your Goal', yourGoalController, context),
          SigninInputField('Habit Name', yourHabitController, context),
          DropDownButtonTemp(
            buttonName: 'Period',
            passedEnumValue: periodUnit,
            enumValues: EnperiodUnit.values,
          ),
          DropDownButtonTemp(
            buttonName: 'Habit Type',
            passedEnumValue: habitGoal,
            enumValues: EnhabitGoal.values,
          ),
          UtilAddNewHabitUI().defaultCreateHabitButton(
            text: "Create Habit",
            onPressed: (context) {
              _addNewHabitLogic();
            },
            ctxt: context,
          ),
        ],
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
