import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Habits/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class DeleteHabitInterface {
  final HabitRepoInterface repo;
  const DeleteHabitInterface({required this.repo});
  Future<Either<ErrorInterface, String>> deleteHabit(String habitID);
}
