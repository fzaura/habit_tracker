import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class HabitRepoInterface {
  const HabitRepoInterface();
  //Either Will Return a Failure Object or a Succces Object
  Future<Either<ErrorInterface, List<HabitModel>>> getHabits();

  Future<Either<ErrorInterface, HabitModel>> addNewHabit(HabitModel newHabit);

  
}
