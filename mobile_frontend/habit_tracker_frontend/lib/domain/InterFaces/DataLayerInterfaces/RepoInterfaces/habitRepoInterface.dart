import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/HabitsData/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

abstract class HabitRepoInterface {
const HabitRepoInterface();
//Either Will Return a Failure Object or a Succces Object
Future<Either<ErrorInterface, List<HabitModel>>> getHabits();  
}
