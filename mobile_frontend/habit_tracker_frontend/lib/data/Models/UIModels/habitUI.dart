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
  List<DateTime> completedDates;

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
    this.completedDates = const [],
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
