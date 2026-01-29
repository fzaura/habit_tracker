import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class  ListHabitsFeatureInterface
{
  const ListHabitsFeatureInterface();
  Future<Either<ErrorInterface,List<Habit>>> getHabitsList();
}