import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/data/Dummy%20Data/dummyDataHabit.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:table_calendar/table_calendar.dart';

enum HabitGoal { buildHabit, breakHabit, maintain }

enum PeriodUnit { daily, weekly, monthly }

enum SortGoalsBYs { all, achieved, notAchieved }

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

  List<DateTime> _updateCurrentDatesList(
    List<DateTime> currentDates,
    DateTime todayDate,
    DateTime now,
  ) {
    //Using an index to get better perferomance
    int currentIndexToUpdate = currentDates.indexWhere(
      (currentDate) => isSameDay(todayDate, currentDate),
    );
    if (currentIndexToUpdate != -1) {
      currentDates = [...currentDates]
        ..[currentIndexToUpdate] = now;
    }
    return currentDates;
  }

  List<DateTime> _updateCompletedDates(
    List<DateTime> currentDates,
    bool isHabitCompleted,
  ) {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final hasToday = currentDates.any(
      (date) => isSameDay(DateTime(date.year, date.month, date.day), todayDate),
    );

    if (isHabitCompleted) {
      if (hasToday) {
        //Update the List with a new update Date
        return _updateCurrentDatesList(currentDates, todayDate, now);
      } else {
        return [...currentDates, now]; //Just add a new Date
      }
    } else {
      if (hasToday) {
        return currentDates
            .where(
              (dayToIterateThrough) =>
                  !isSameDay(dayToIterateThrough, todayDate),
            )
            .toList();
        //Delete Day
      }
    }

    return currentDates;
  }

  // In your StateNotifier
  void toggleHabit(String habitID) {
    state = state.map((habit) {
      if (habit.id == habitID) {
        final newhabitIsCompleted = !habit.isCompleted;
        final newCurrentStreak = newhabitIsCompleted
            ? habit.currentStreak + 1
            : habit.currentStreak - 1;
        final newIsGoalachieved = newCurrentStreak >= habit.targettedPeriod
            ? true
            : false;
        final newBestStreak = newCurrentStreak >= habit.bestStreak
            ? newCurrentStreak
            : habit.bestStreak;
        //I Used Variables to get the latest updates on
        //all the other variables too

        return habit.copyWith(
          isCompleted: newhabitIsCompleted,
          currentStreak: newCurrentStreak,
          isGoalAchieved: newIsGoalachieved,
          bestStreak: newBestStreak,
          completedDates: _updateCompletedDates(
            habit.completedDates,
            newhabitIsCompleted,
          ),
        );
      }
      return habit;
    }).toList();
  }
}

final habitSampleProvider =
    StateNotifierProvider<HabitsStateNotifier, List<Habit>>(
      (ref) => HabitsStateNotifier(),
    );
//A Provider That Accesses the Notifier.
