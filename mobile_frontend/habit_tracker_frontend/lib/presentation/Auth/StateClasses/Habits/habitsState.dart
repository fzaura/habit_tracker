// lib/features/auth/presentation/state/auth_state.dart
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/habitListerBundle.dart';

sealed class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitSuccess extends HabitState {
  //1- Made the Habit Sucess alway return a 
  //New Updated List
  // final Habit? habity;
  // final List<Habit> requiredhabitsList;//The List Should Always Exist
  // //Becauase Ur Always Updating the habits.
  final HabitListerBundle data;//1- We Want Our Data To Be generic Because the success state has many implementations

  const HabitSuccess({required this.data});
}


class HabitFailure extends HabitState {
  final ErrorInterface error;
  const HabitFailure(this.error);
}
