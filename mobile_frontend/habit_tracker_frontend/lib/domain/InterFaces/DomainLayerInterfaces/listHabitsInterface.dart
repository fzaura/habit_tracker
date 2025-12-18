import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

abstract class  ListHabitsFeature
{
  const ListHabitsFeature();
  Future<Either<ErrorInterface,List<Habit>>> getHabitsList();
}