import 'package:habit_tracker/data/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

abstract class  listHabitsFeature
{
  const listHabitsFeature({required this.habitRepo});
  final HabitRepo habitRepo;
  Future<List<Habit>> getHabitsList();
}