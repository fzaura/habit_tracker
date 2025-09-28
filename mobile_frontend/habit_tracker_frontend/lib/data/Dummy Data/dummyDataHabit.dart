// Sample data for testing
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

class HabitSamples {
  static List<Habit> getSampleHabits() {
    return [
      Habit(
        id: '1',
        habitName: 'Drink Water',
        goal: 'Drink 8 glasses of water daily',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 8,
        periodUnit: EnperiodUnit.daily,
        createdAt: DateTime.now().subtract(Duration(days: 7)),
        currentStreak: 5,
        bestStreak: 12,
      ),
      Habit(
        id: '2',
        habitName: 'Morning Exercise',
        goal: 'Exercise for 30 minutes every morning',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 1,
        periodUnit: EnperiodUnit.daily,
        createdAt: DateTime.now().subtract(Duration(days: 14)),
        currentStreak: 3,
        bestStreak: 8,
      ),
      Habit(
        id: '3',
        habitName: 'Social Media Break',
        goal: 'Avoid social media during work hours',
        habitType: EnhabitGoal.breakHabit,
        targettedPeriod: 1,
        periodUnit: EnperiodUnit.daily,
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        currentStreak: 2,
        bestStreak: 2,
      ),
      Habit(
        id: '4',
        habitName: 'Read Books',
        goal: 'Read for 1 hour, 3 times a week',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 3,
        periodUnit: EnperiodUnit.weekly,
        createdAt: DateTime.now().subtract(Duration(days: 21)),
        currentStreak: 1,
        bestStreak: 4,
      ),
    ];
  }
}