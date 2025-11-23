import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/Themes/gradientTheme.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/dropDownButtonTemp.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/presentation/view(Screens)/HomeScreens/sucessScreenUtil.dart';
import 'package:habit_tracker/domain/Providers/habitsStateNotifier.dart';

class Addnewhabit extends ConsumerStatefulWidget {
  const Addnewhabit({super.key});
  @override
  ConsumerState<Addnewhabit> createState() => _AddnewhabitState();
}

class _AddnewhabitState extends ConsumerState<Addnewhabit> {
 


  EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;

  

  Widget editTextField(String mainHintText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: mainHintText,
        ),
      ),
    );
  }

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

  Widget defaultAddHabitButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).extension<GradientTheme>()?.primaryGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
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
          _addNewHabitLogic();
        },
        child: Text(
          'Add New Habit',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
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
              editTextField('',),
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
              editTextField('',),
        
              SizedBox(height: 15),
        
              // Period Dropdown
              SizedBox(height: 5),
              DropdownButtonFormField(
              
              ),
              SizedBox(height: 15),
        
              // Habit Type Dropdown
             
        
              SizedBox(height: 25),
        
              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add Button
                  defaultAddHabitButton(),
        
                 
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
