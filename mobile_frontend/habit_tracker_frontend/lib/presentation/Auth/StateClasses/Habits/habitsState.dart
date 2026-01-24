// lib/features/auth/presentation/state/auth_state.dart
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitFailure extends HabitState {
  final ErrorInterface error;
  const HabitFailure(this.error);
}

class HabitSuccess extends HabitState {
  final HabitHomeScreenDataBundle
  data; //1- We Want Our Data To Be generic Because the success state has many implementations

  const HabitSuccess({required this.data});
}
