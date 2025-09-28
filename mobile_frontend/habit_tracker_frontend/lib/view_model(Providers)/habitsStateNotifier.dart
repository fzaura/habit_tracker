import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/data/Dummy%20Data/dummyDataHabit.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

enum HabitGoal { buildHabit, breakHabit, maintain }

enum PeriodUnit { daily, weekly, monthly }

class HabitsStateNotifier extends StateNotifier<List<Habit>> {
  HabitsStateNotifier()
    : super(HabitSamples.getSampleHabits()); //A-Initial Data

  //B- Variables that Change that Data in a non immutable way
  void addNewHabit(Habit newHabit) {
    state = [...state, newHabit];
  }

  //Immutabe State So we make the whole List Again without the habit we want to delete.
  void deleteHabits(String id) {
    state = state.where((habit) => habit.id != id).toList();
  }

  void updateHabits(String oldHabitId, Habit newEdittedHabit) {
    state = state
        .map(
          (oldhabit) =>
              oldhabit.id == newEdittedHabit.id ? newEdittedHabit : oldhabit,
        )
        .toList();
  }
}

final habitSampleProvider =
    StateNotifierProvider<HabitsStateNotifier, List<Habit>>(
      (ref) => HabitsStateNotifier(),
    );
//A Provider That Accesses the Notifier.
