import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/presentation/Widgets/Buttons/addNewHabit.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';
import 'package:habit_tracker/presentation/Widgets/Forms/addANewHabitForm.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/editTextField.dart';
import 'package:habit_tracker/presentation/view(Screens)/HomeScreens/sucessScreenUtil.dart';
import 'package:habit_tracker/domain/Providers/habitsStateNotifier.dart';

class Addnewhabit extends ConsumerStatefulWidget {
  const Addnewhabit({super.key});
  @override
  ConsumerState<Addnewhabit> createState() => _AddnewhabitState();
}

class _AddnewhabitState extends ConsumerState<Addnewhabit> {
  void _addNewHabitLogic() {
    //We Need to Return the Values of the Form to this Method Right Here 
    //And I think Such thing Will Be done Through Async and Await 
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
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: AddANewHabitForm(addNewHabitLogic: _addNewHabitLogic));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
