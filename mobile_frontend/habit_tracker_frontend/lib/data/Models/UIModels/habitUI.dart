import 'package:flutter/material.dart';

class Habit {
  final String id;
  String habitName;
  String goal;
  EnhabitGoal habitType;
  int targettedPeriod; // How many days will be needed to make the habit a habit
  EnperiodUnit periodUnit; // daily, weekly, monthly
  DateTime createdAt;
  bool isCompleted;
  int currentStreak;
  int bestStreak;
  bool isGoalAchieved;
  List<DateTime> completedDates;
  // New: icon to represent the habit in UI. Uses IconData so widgets can render
  // with an Icon(habit.icon). If user doesn't choose an icon, this defaults
  // to [Icons.flag] (a sensible generic icon).
  IconData icon;

  Habit({
    required this.id,
    required this.habitName,
    required this.goal,
    required this.habitType,
    this.targettedPeriod = 21,
    required this.periodUnit,
    required this.createdAt,
    this.isCompleted = false,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.isGoalAchieved = false,
    this.completedDates = const [],
    this.icon = Icons.flag,
  });

  // Helper methods

  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }

  Habit copyWith({
    String? id,
    String? habitName,
    String? goal,
    EnhabitGoal? habitType,
    int? targettedPeriod,
    EnperiodUnit? periodUnit,
    DateTime? createdAt,
    bool? isCompleted,
    bool? isGoalAchieved,
    int? currentStreak,
    int? bestStreak,
    List<DateTime>? completedDates,
    IconData? icon,
  }) {
    return Habit(
      id: id ?? this.id,
      habitName: habitName ?? this.habitName,
      goal: goal ?? this.goal,
      habitType: habitType ?? this.habitType,
      targettedPeriod: targettedPeriod ?? this.targettedPeriod,
      periodUnit: periodUnit ?? this.periodUnit,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      isGoalAchieved: isGoalAchieved ?? this.isGoalAchieved,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      completedDates: completedDates ?? this.completedDates,
      icon: icon ?? this.icon,
    );
  }
}

enum EnhabitGoal { buildHabit, breakHabit, maintain }

enum EnperiodUnit { daily, weekly, monthly }

extension EnhabitGoalExtentsion on EnhabitGoal {
  String get habitGoalName {
    switch (this) {
      case EnhabitGoal.breakHabit:
        return 'Break Habit';
      case EnhabitGoal.buildHabit:
        return 'Build Habit';
      case EnhabitGoal.maintain:
        return 'Maintain';
    }
  }
}

extension EnperiodUnitExtentions on EnperiodUnit {
  String get periodName {
    switch (this) {
      case EnperiodUnit.daily:
        return 'Daily';
      case EnperiodUnit.monthly:
        return 'Monthly';
      case EnperiodUnit.weekly:
        return 'Weekly';
    }
  }
}
