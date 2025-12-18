import 'package:habit_tracker/data/HabitsData/DataModels/HabitModel.dart';

abstract class DataSourceInterface {
  const DataSourceInterface();
    Future<List<HabitModel>> getHabits();

}