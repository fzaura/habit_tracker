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

  // The "Pro" Addition:
  HabitHomeScreenDataBundle copyWith({
    List<Habit>? habitsToList,
    Habit? habit,
    int? allTheHabits,
    int? habitsCheckedToday,
  }) {
    return HabitHomeScreenDataBundle(
      habitsToList: habitsToList ?? this.habitsToList,
      habit: habit ?? this.habit,
      allTheHabits: allTheHabits ?? this.allTheHabits,
      habitsCheckedToday: habitsCheckedToday ?? this.habitsCheckedToday,
    );
  }
}
