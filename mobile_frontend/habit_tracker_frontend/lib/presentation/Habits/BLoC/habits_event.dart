import 'package:equatable/equatable.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';

sealed class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object?> get props => [];
}

sealed class HabitsLoadStarted extends HabitsEvent
{

}

sealed class HabitsAddRequested extends HabitsEvent
{
  final Habit habit;
  const HabitsAddRequested({required this.habit});
  @override
  List<Object?> get props => [habit];
}


sealed class HabitsDeleteRequested extends HabitsEvent
{
  final String habitId;
  const HabitsDeleteRequested({required this.habitId});
  @override
  List<Object?> get props => [habitId];
}

sealed class HabitsUpdateRequested extends HabitsEvent
{
   final Habit habit;
  const HabitsUpdateRequested({required this.habit});
  @override
  List<Object?> get props => [habit];
}

// 4. Triggered when toggling completion
final class HabitsToggleRequested extends HabitsEvent {
  final String id;
  const HabitsToggleRequested(this.id);

  @override
  List<Object?> get props => [id];
}