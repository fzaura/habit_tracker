import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/data/Dummy%20Data/dummyDataHabit.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';


enum HabitGoal { buildHabit, breakHabit, maintain }

enum PeriodUnit { daily, weekly, monthly }


class HabitsStateNotifier extends StateNotifier<List<Habit>> {
  HabitsStateNotifier()
    : super(HabitSamples.getSampleHabits()); //A-Initial Data

  //B- Variables that Change that Data in a non immutable way
}

final habitSampleProvider =
    StateNotifierProvider<HabitsStateNotifier, List<Habit>>(
      (ref) => HabitsStateNotifier(),
    );
//A Provider That Accesses the Notifier. 