import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/ToDo/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class ListHabits implements ListHabitsFeatureInterface {
  final HabitRepoInterface repo;
  const ListHabits({required this.repo});

  @override
  Future<Either<ErrorInterface, List<Habit>>> getHabitsList() async {
    // Cal the Repo
    final habitModels = await repo.getHabits();
    //2- We need To Understand Each Case the Failure Case
    //And the Success Case

    
    return habitModels.fold((failureObject) => left(failureObject), (//Now if we get the success Object
      habitModelsList,
    ) {
      //We need to conver the Habits to Normal entities
      final habitEntities = HabitModel.toHabits(habitModelsList);
      return right(habitEntities);
    });
  }
}
