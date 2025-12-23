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
  final Habit? habity;
  final List<Habit>? habitsList;

  const HabitSuccess(this.habitsList,this.habity);
}


class HabitFailure extends HabitState {
  final ErrorInterface error;
  const HabitFailure(this.error);
}
