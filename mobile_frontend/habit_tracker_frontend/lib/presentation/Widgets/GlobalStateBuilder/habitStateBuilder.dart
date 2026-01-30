import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habit_state.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

class HabitStateBuilder extends StatelessWidget {
  const HabitStateBuilder({
    super.key,
    required this.state,
    this.successHomeScreenWidget,
    this.failureWidget, // A function that accepts the error
    this.loadingWidget,
    this.initialWidget,
  });

  final HabitState state;
  final Widget Function(HabitHomeScreenDataBundle data)?
  successHomeScreenWidget;
  final Widget Function(ErrorInterface error)? failureWidget;
  final Widget? loadingWidget;
  final Widget? initialWidget;

  @override
  Widget build(BuildContext context) {
    // Using Dart 3 Switch Expression for maximum "Cleanliness"
    return switch (state) {
      HabitInitial() => initialWidget ?? const SizedBox.shrink(),

      HabitLoading() =>
        loadingWidget ?? const Center(child: CircularProgressIndicator()),

      HabitSuccess(bundle: final data) =>
        successHomeScreenWidget?.call(data) ?? const SizedBox.shrink(),

      HabitFailure(errorMessage: final error) => Center(child: Text(error)),

      // Fallback for safety
      _ => const SizedBox.shrink(),
    };
  }
}
