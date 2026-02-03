import 'package:habit_tracker/data/ToDo/DataModels/HabitModel.dart';

abstract class DataSourceInterface {
  const DataSourceInterface();
  Future<List<HabitModel>> getHabits();

  //The Add habit Feature Return Type is
  //A Habit Why ? So we can Update the HAbit in the UI

  Future<HabitModel> addNewHabit(HabitModel newHabit);

//This Shiuld be a HAbit Model But am Waiting for the backend to update
  Future<String> editHabit(HabitModel habitID);

  Future<String> deleteHabit(String habit);
}
