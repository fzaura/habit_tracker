import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Habits/DataModels/TokenModel.dart';
abstract class DataSourceInterface {
  const DataSourceInterface();
  Future<List<HabitModel>> getHabits();

  //The Add habit Feature Return Type is
  //A Habit Why ? So we can Update the HAbit in the UI

  Future<HabitModel> addNewHabit(HabitModel newHabit);

  Future<HabitModel> editHabit(HabitModel oldHabit);

  Future<TokenModel> refreshTokens(String oldRefreshToken);
}
