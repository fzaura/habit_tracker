import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';

abstract class DataSourceInterface {
  const DataSourceInterface();
    Future<List<HabitModel>> getHabits();

}