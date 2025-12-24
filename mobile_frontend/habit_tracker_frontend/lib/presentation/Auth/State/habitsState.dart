// lib/features/auth/presentation/state/auth_state.dart
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

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
  final Habit? habity;
  final List<Habit> requiredhabitsList;//The List Should Always Exist
  //Becauase Ur Always Updating the habits.

  const HabitSuccess(this.requiredhabitsList,this.habity);
}


class HabitFailure extends HabitState {
  final ErrorInterface error;
  const HabitFailure(this.error);
}
