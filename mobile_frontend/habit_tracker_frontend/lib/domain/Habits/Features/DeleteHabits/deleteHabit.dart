import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/deleteHabitInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class DeleteHabitUseCase implements DeleteHabitInterface {
  @override
  final HabitRepoInterface repo;
  const DeleteHabitUseCase({required this.repo});

  Future<Either<ErrorInterface, String>> deleteHabit(String habitID) async {
    final deleteHabitMessage = await repo.deleteHabit(habitID);
    return deleteHabitMessage.fold(
      (errorObject) {
        return Left(errorObject);
      },
      (message) {
        return Right(message);
      },
    );
  }
}
