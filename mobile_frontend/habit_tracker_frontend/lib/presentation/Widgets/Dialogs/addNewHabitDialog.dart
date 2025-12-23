import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';

import 'package:habit_tracker/presentation/Widgets/Forms/addANewHabitForm.dart';

class AddnewhabitDialog extends ConsumerStatefulWidget {
  const AddnewhabitDialog({super.key});
  @override
  ConsumerState<AddnewhabitDialog> createState() => _AddnewhabitState();
}

class _AddnewhabitState extends ConsumerState<AddnewhabitDialog> {
  void _addNewHabitLogic(
    String habitName,
    String golaName,
    EnhabitGoal habitGoal,
    EnperiodUnit periodUnit,
  ) {
    //We Need to Return the Values of the Form to this Method Right Here
    //And I think Such thing Will Be done Through Async and Await
    print(habitName);
    print(golaName);
    print(habitGoal.name);
    print(periodUnit.name);


    
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
