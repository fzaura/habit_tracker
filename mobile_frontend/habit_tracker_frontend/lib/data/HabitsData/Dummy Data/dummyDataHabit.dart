import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

class HabitSamples {
  static List<Habit> getSampleHabits() {
    final now = DateTime.now();
    
    return [
      Habit(
        id: '1',
        habitName: 'Drink Water',
        goalName: 'Drink 8 glasses of water daily',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 8,
        periodUnit: EnperiodUnit.daily,
        createdAt: now.subtract(Duration(days: 7)),
        updatedAt: now.subtract(Duration(hours: 2)), // Recently updated
        endedAt: null, // ⬅️ Added: Still active
        currentStreak: 7,
        bestStreak: 12,
        isGoalAchieved: false,
        icon: Icons.local_drink,
        completedDates: [
          now.subtract(Duration(days: 1)),
          now.subtract(Duration(days: 2)),
          now.subtract(Duration(days: 3)),
          now.subtract(Duration(days: 4)),
          now.subtract(Duration(days: 5)),
        ],
      ),
      Habit(
        id: '2',
        habitName: 'Morning Exercise',
        goalName: 'Exercise for 30 minutes every morning',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 7,
        periodUnit: EnperiodUnit.daily,
        createdAt: now.subtract(Duration(days: 14)),
        updatedAt: now.subtract(Duration(days: 1)),
        endedAt: null, // ⬅️ Added: Still active
        currentStreak: 3,
        bestStreak: 8,
        isGoalAchieved: false,
        icon: Icons.fitness_center,
        completedDates: [
          now.subtract(Duration(days: 1)),
          now.subtract(Duration(days: 2)),
          now.subtract(Duration(days: 3)),
        ],
      ),
      Habit(
        id: '3',
        habitName: 'Social Media Break',
        goalName: 'Avoid social media during work hours',
        habitType: EnhabitGoal.breakHabit,
        targettedPeriod: 7,
        periodUnit: EnperiodUnit.daily,
        createdAt: now.subtract(Duration(days: 3)),
        updatedAt: now, // Updated right now
        endedAt: null, // ⬅️ Added: Still active
        currentStreak: 7,
        bestStreak: 2,
        isGoalAchieved: true,
        icon: Icons.phone_android,
        completedDates: [
          now.subtract(Duration(days: 1)),
          now.subtract(Duration(days: 2)),
          now.subtract(Duration(days: 3)),
          now,
        ],
      ),
      Habit(
        id: '4',
        habitName: 'Read Books',
        goalName: 'Read for 1 hour, 3 times a week',
        habitType: EnhabitGoal.buildHabit,
        targettedPeriod: 3,
        periodUnit: EnperiodUnit.weekly,
        createdAt: now.subtract(Duration(days: 21)),
        updatedAt: now.subtract(Duration(hours: 1)),
        endedAt: now.subtract(Duration(days: 5)), // ⬅️ Value retained: Ended in the past
        currentStreak: 2,
        bestStreak: 4,
        isGoalAchieved: true,
        icon: Icons.book,
        completedDates: [
          now.subtract(Duration(days: 7)),
          now.subtract(Duration(days: 14)),
          now.subtract(Duration(days: 21)),
        ],
      ),
    ];
  }
}