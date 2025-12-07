import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
class FormatNames {
  // For EnhabitGoal

static EnperiodUnit mapStringToPeriodUnit(String type) {
  switch (type.toLowerCase()) {
    case 'daily': return EnperiodUnit.daily;
    case 'weekly': return EnperiodUnit.weekly;
    case 'monthly': return EnperiodUnit.monthly;
    default: throw Exception('Invalid frequency type: $type');
  }
}

static IconData stringToIconConverter(String iconName)
{
  if(iconName=='flag')
  {
    return Icons.flag;
  }
  else
  {
   return Icons.access_alarm_outlined;
  }
}
// 2. Helper to map Frontend Enum to Mongoose String
static String mapPeriodUnitToString(EnperiodUnit unit) {
  return unit.toString().split('.').last; // e.g., EnperiodUnit.daily -> 'daily'
}// lib/features/habit_management/data/models/frequency_model.dart

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