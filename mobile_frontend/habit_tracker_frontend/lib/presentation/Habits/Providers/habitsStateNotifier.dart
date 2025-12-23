import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/core/Config/providers.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/Features/AddNewHabits/addNewHabitFeature.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/presentation/Auth/State/habitsState.dart';
import 'package:table_calendar/table_calendar.dart';

enum HabitGoal { buildHabit, breakHabit, maintain }

enum PeriodUnit { daily, weekly, monthly }

enum SortGoalsBYs { all, achieved, notAchieved }

class HabitsStateNotifier extends StateNotifier<HabitState> {
  final ListHabitsFeature _listHabitsFeature;
  final AddNewHabitFeature _addNewHabitFeature;
  List<Habit> habitsList = [];
  
  HabitsStateNotifier(this._listHabitsFeature, this._addNewHabitFeature)
    : super(HabitInitial()) {
    loadNewHabits();
  }
  Future<void> loadNewHabits() async {
    // Optionally: emit a loading state if you had one (e.g., state = const <Habit>[];)

    // Call the feature, which returns Either<ErrorInterface, List<Habit>>
    final result = await _listHabitsFeature.getHabitsList();

    // Handle the Either result
    result.fold(
      // Left (Failure): Handle the error (e.g., log it, or set an error state if using a complex state object)
      (failure) {
        // For now, we'll log the error and keep the state empty or previous
        print('Failed to load habits: ${failure.errorMessage}');
      },
      // Right (Success): Update the state with the list of habits
      (habits) {
        habits = habits;

        state = HabitSuccess(habits,null);
      },
    );
  }

  //B- Variables that Change that Data in a non immutable way
  Future<void> addNewHabit(Habit newHabit) async {
    state = HabitLoading();

    final addedHabit = await _addNewHabitFeature.addNewHabit(newHabit);
    addedHabit.fold(
      (wrongObject) {
        state = HabitFailure(wrongObject);
      },
      (rightObject) {
        state = HabitSuccess(null,rightObject);
      },
    );
  }

  //Immutabe State So we make the whole List Again without the habit we want to delete.
  void deleteHabits(String id) {}

  void updateHabits(String oldHabitId, Habit newEdittedHabit) {}

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
      currentDates = [...currentDates]..[currentIndexToUpdate] = now;
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
  //   state = state.map((habit) {
  //     if (habit.id == habitID) {
  //       final newhabitIsCompleted = !habit.isCompleted;
  //       final newCurrentStreak = newhabitIsCompleted
  //           ? habit.currentStreak + 1
  //           : habit.currentStreak - 1;
  //       final newIsGoalachieved = newCurrentStreak >= habit.targettedPeriod
  //           ? true
  //           : false;
  //       final newBestStreak = newCurrentStreak >= habit.bestStreak
  //           ? newCurrentStreak
  //           : habit.bestStreak;
  //       //I Used Variables to get the latest updates on
  //       //all the other variables too

  //       return habit.copyWith(
  //         isCompleted: newhabitIsCompleted,
  //         currentStreak: newCurrentStreak,
  //         isGoalAchieved: newIsGoalachieved,
  //         bestStreak: newBestStreak,
  //         completedDates: _updateCompletedDates(
  //           habit.completedDates,
  //           newhabitIsCompleted,
  //         ),
  //       );
  //     }
  //     return habit;
  //   }).toList();
  // }
}


}

final habitSampleProvider =
    StateNotifierProvider<HabitsStateNotifier, HabitState>((ref) {
      //Use it from the Providers inside of Core
      return HabitsStateNotifier(
        ref.watch(listFeatureProvider),
        ref.watch(addNewHabitFeatureProvider),
      );
    });
//A Provider That Accesses the Notifier.ccesses the Notifier.

