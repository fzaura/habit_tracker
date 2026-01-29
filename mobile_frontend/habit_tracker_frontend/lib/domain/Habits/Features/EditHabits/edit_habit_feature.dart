import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/editHabitInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class EditHabitFeature implements EditHabitInterface {
  @override
  final HabitRepoInterface repo;
  const EditHabitFeature({required this.repo});
  @override
  Future<Either<ErrorInterface, String>> editHabit(Habit habit) async {
    final newHabitName = await repo.editHabit(habit.id);
    return newHabitName.fold(
      (errorObject) {
        return Left(errorObject);
      },
      (newHabitName) {
        return Right(newHabitName);
      },
    );
  }
}
