import 'package:habit_tracker/data/DataModels/HabitModel.dart';

abstract class DataSourceInterface {
    Future<List<HabitModel>> getHabits();

}