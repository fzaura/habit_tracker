import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';

class HabitHomeScreenDataBundle {
  final int habitsCheckedToday;
  final int allTheHabits;
  const HabitHomeScreenDataBundle({
    required this.habitsToList,
    this.habit,
    this.allTheHabits=0,
     this.habitsCheckedToday=0
  });
  final List<Habit> habitsToList;
  final Habit? habit;
}
