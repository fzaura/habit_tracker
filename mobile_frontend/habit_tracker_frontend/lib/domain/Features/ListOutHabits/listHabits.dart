import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

class ListHabits {
  Future<List<Habit>> getHabitsList() async {
    final List<Habit> habits;
    HabitRepo habitRepo = HabitRepo();
    //1st Get The Habit Models List
    final List<HabitModel> habitModels = await habitRepo.listHabits();
    //2-Convert the Habit Models to Habits
    if (habitModels.isEmpty) {
      return [];
    } else {
      habits = HabitModel.toHabits(habitModels);
    }

    return habits;
  }
}
