import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/domain/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

class ListHabits implements ListHabitsFeature {
  final HabitRepo repo;
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
