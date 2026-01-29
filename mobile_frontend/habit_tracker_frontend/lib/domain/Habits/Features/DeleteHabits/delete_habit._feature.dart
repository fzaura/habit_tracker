import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/deleteHabitInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class DeleteHabitFeature implements DeleteHabitInterface {
  @override
  final HabitRepoInterface repo;
  const DeleteHabitFeature({required this.repo});

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
