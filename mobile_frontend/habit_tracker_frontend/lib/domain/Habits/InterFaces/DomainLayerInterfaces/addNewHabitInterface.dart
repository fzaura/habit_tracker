import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class AddNewHabitInterface {
  final HabitRepoInterface repo;
  const AddNewHabitInterface({required this.repo});
  Future<Either<ErrorInterface, Habit>> addNewHabit(Habit newHabit);
}
