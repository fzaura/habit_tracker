import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

abstract class HabitRepoInterface {

  Future<List<HabitModel>> listHabits();
  
}
