class Habit {
  final String id;
   String habitName;
   String goal;
   EnhabitGoal habitType;
   int periodValue; // How many days will be needed to make the habit a habit
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
     this.periodValue=21,
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


