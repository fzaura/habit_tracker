import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Habits/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/addNewHabitInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class AddNewHabitFeature implements AddNewHabitInterface {
  @override
  final HabitRepoInterface repo;
  const AddNewHabitFeature({required this.repo});



  @override
  Future<Either<ErrorInterface, Habit>> addNewHabit(Habit newHabit) async {
    //Change the new Habit into a model
    //So we can Add the Habit.
    HabitModel habitModel = HabitModel.fromEntity(newHabit);
    final response = await repo.addNewHabit(habitModel);
   return response.fold(
      (wrongObject) {
        return Left( wrongObject);
      },
      (rightObject) {
        return Right(rightObject.toEntity());
      },
    );
  }
}
