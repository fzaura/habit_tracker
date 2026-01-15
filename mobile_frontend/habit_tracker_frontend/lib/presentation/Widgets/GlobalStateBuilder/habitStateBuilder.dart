import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Auth/StateClasses/Habits/habitsState.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/habitListerBundle.dart';

class HabitStateBuilder<Template> extends StatelessWidget {
  const HabitStateBuilder({
    super.key,
    required this.state,
    required this.successWidget,
     this.failureWidget,
     this.loadingWidget,
     this.providedError,
  });
  final HabitState state;
  final Widget Function(HabitListerBundle data) successWidget;
  final Widget? loadingWidget;
  final Widget? failureWidget;
  final ErrorInterface? providedError;
  @override
  Widget build(BuildContext context) {
   final currentState = state; // Capture state

  if (currentState is HabitLoading) {
    return loadingWidget ?? const SizedBox.shrink();
  }

  if (currentState is HabitFailure) {
    return failureWidget ?? const SizedBox.shrink();
  }

  // KEY FIX: Use 'is' check with the Template
  if (currentState is HabitSuccess) {
    return successWidget(currentState.data);
  }

  return const SizedBox.shrink();
  }
}
