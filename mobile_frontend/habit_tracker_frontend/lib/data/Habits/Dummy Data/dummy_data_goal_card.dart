import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/goal_card.dart';
import 'package:habit_tracker/presentation/core/Design/goal_card_design.dart';
import 'package:habit_tracker/presentation/core/Enums/activity_level.dart';

/// Dummy data for testing Goal Cards UI
/// 
/// RESPONSIBILITY: Single - Provides test data for Goal Cards
/// Located in data layer following clean architecture principles
class DummyGoalCardData {
  /// List of dummy goal cards with varied activities and colors
  static const List<GoalCardModel> dummyGoalCards = [
    GoalCardModel(
      goalName: 'Reach 15% body fat',
      taskName: 'go to the gym for 30min',
      category: 'Health',
      icon: Icons.favorite_border,
      cardColor: null, // Will use primary teal color
      progressData: [
        // Week 1
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.none,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        // Week 2
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.low,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.medium,
        ActivityLevel.high,
        // Week 3
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.none,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        // Week 4
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.none,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
      ],
    ),
    GoalCardModel(
      goalName: 'Read a book each week',
      taskName: 'finish 20 pages',
      category: 'Learning',
      icon: Icons.book_outlined,
      cardColor: Color(0xFF686B6B), // Gray color from theme
      progressData: [
        // Week 1
        ActivityLevel.low,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        // Week 2
        ActivityLevel.none,
        ActivityLevel.low,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.none,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        // Week 3
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        // Week 4
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.none,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
      ],
    ),
    GoalCardModel(
      goalName: 'Meditate daily',
      taskName: 'practice for 10 minutes',
      category: 'Wellness',
      icon: Icons.self_improvement,
      cardColor: Color(0xFF686B6B), // Gray color from theme
      progressData: [
        // Week 1
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        // Week 2
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        // Week 3
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.high,
        ActivityLevel.medium,
        // Week 4
        ActivityLevel.low,
        ActivityLevel.veryHigh,
        ActivityLevel.high,
        ActivityLevel.medium,
        ActivityLevel.veryHigh,
        ActivityLevel.low,
        ActivityLevel.none,
        ActivityLevel.high,
        ActivityLevel.veryHigh,
        ActivityLevel.medium,
        ActivityLevel.high,
        ActivityLevel.low,
      ],
    ),
  ];
}

/// Model to represent a Goal Card with all necessary data
/// 
/// RESPONSIBILITY: Single - Data transfer object for Goal Cards
/// Follows immutable pattern for predictability
class GoalCardModel {
  final String goalName;
  final String taskName;
  final String category;
  final IconData? icon;
  final Color? cardColor;
  final List<ActivityLevel> progressData;

  const GoalCardModel({
    required this.goalName,
    required this.taskName,
    required this.category,
    required this.progressData,
    this.icon,
    this.cardColor,
  });
}