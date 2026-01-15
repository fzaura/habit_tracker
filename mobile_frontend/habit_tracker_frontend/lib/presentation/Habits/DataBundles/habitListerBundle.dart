import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';

class HabitListerBundle {
  const HabitListerBundle({required this.habitsToList, this.habit});
  final List<Habit> habitsToList;
  final Habit? habit;
}
