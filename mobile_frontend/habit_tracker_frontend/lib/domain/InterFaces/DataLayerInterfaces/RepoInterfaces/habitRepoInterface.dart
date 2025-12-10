import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

abstract class HabitRepoInterface {

  Future<bool> createHabit(Habit habitToCreate);
  Future<List<HabitModel>> listHabits();
  // Future<Habit> updateHabit(Habit habit);

  // // 4. DELETE (DELETE)
  // // Defines the method signature for removing a habit by its ID.
  // Future<bool> deleteHabit(String id);

  // // 5. CUSTOM ACTION (POST for Completion)
  // // Defines the method signature for marking a habit as complete on a specific date.
  // Future<bool> completeHabit(String habitId, DateTime date);
}
