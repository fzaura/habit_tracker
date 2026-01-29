import 'package:equatable/equatable.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

sealed class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object?> get props => [];
}


sealed class HabitInitial extends HabitState {
  const HabitInitial();

  @override
  List<Object?> get props => [];
}


sealed class HabitLoading extends HabitState {
  const HabitLoading();

  @override
  List<Object?> get props => [];
}


sealed class HabitSuccess extends HabitState {
  const HabitSuccess({required this.bundle});
  final HabitHomeScreenDataBundle bundle;
  @override
  List<Object?> get props => [bundle];
}