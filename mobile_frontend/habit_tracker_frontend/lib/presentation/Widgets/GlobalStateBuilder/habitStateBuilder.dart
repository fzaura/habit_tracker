import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Auth/State/habitsState.dart';

class HabitStateBuilder extends StatelessWidget {
  const HabitStateBuilder({
    super.key,
    required this.state,
    required this.successWidget,
    required this.failureWidget,
    required this.loadingWidget,
    required this.providedError,
  });
  final HabitState state;
  final Widget Function(List<Habit> habits , Habit? newHabit)  successWidget;
  final Widget loadingWidget;
  final Widget failureWidget;
  final  ErrorInterface providedError;
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      HabitLoading() => loadingWidget,
      HabitFailure(error: final providedError) => failureWidget,
      HabitSuccess(requiredhabitsList : final newHabitList, habity : final habit )=>successWidget(newHabitList,habit),
      _ => const SizedBox.shrink()//Default of the Habit StateBuilder
    };
  }
}
