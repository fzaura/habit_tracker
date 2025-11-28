import 'package:habit_tracker/domain/Entities/habitUI.dart';
class FormatNames {
  // For EnhabitGoal
  static String formatHabitGoal(EnhabitGoal goal) {
    switch (goal) {
      case EnhabitGoal.breakHabit: return 'Break Habit';
      case EnhabitGoal.buildHabit: return 'Build Habit';
      case EnhabitGoal.maintain: return 'Maintain';
    }
  }

  // For EnperiodUnit  
  static String formatPeriodUnit(EnperiodUnit unit) {
    switch (unit) {
      case EnperiodUnit.daily: return 'Daily';
      case EnperiodUnit.weekly: return 'Weekly';
      case EnperiodUnit.monthly: return 'Monthly';
    }
  }

  // Generic enum formatter (optional)
  static String formatEnum(dynamic enumValue) {
    if (enumValue is EnhabitGoal) return formatHabitGoal(enumValue);
    if (enumValue is EnperiodUnit) return formatPeriodUnit(enumValue);
    return enumValue.toString().split('.').last;
  }
}