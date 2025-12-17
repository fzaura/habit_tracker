import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/domain/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

class ListHabits implements ListHabitsFeature{
  final HabitRepo repo;
  const ListHabits({required this.repo});



  @override
  Future<Either<ErrorInterface, List<Habit>>> getHabitsList() async{
   final habits= await repo.getHabits();
// 2. Use fold to handle success/failure and perform conversion on success
    return habits.fold(
      // Left (Failure): Pass the failure up immediately
      (failure) => left(failure),
      
      // Right (Success): Perform the final conversion to HabitEntity
      (habitModels) {
        final habitEntities = HabitModel.toHabits(habitModels);
        return right(habitEntities);
      },
    );
  }
  }

