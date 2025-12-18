import 'package:habit_tracker/data/DataModels/HabitModel.dart';

abstract class DataSourceInterface {
  const DataSourceInterface();
    Future<List<HabitModel>> getHabits();

}