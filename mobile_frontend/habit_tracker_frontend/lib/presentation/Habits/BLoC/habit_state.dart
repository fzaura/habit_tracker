import 'package:equatable/equatable.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

sealed class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object?> get props => [];
}

class HabitInitial extends HabitState {
  const HabitInitial();

  @override
  List<Object?> get props => [];
}

class HabitLoading extends HabitState {
  const HabitLoading();

  @override
  List<Object?> get props => [];
}

class HabitFailure extends HabitState {
  const HabitFailure({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class HabitSuccess extends HabitState {
  const HabitSuccess({required this.bundle});
  final HabitHomeScreenDataBundle bundle;
  @override
  List<Object?> get props => [bundle];
}
