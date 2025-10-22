import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/gradientTheme.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/statelessUtil/utilAddNewHabit.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/EditDeleteHabitsUtil/StateFullUtil/editDeleteHabits.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/EditDeleteHabitsUtil/StateLessUtil/confirmDelete.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key, required this.habitGoals});
  final Habit habitGoals;

  // WHAT: Handle edit/delete actions
  // WHY: Separate action logic from UI
  void _handleAction(String value, BuildContext context) {
    if (value == 'Edit') {
      showDialog(
        context: context,
        builder: (_) => EditDeleteHabits(habitToEdit: habitGoals),
      );
    } else if (value == 'Delete') {
      showDialog(
        context: context,
        builder: (_) => ConfirmDelete(toDeleteHabitId: habitGoals.id),
      );
    }
  }

  // WHAT: Calculate completion percentage
  // WHY: Reusable calculation, called once
  double _getCompletionPercentage() {
    if (habitGoals.targettedPeriod == 0) return 0;
    return (habitGoals.currentStreak / habitGoals.targettedPeriod).clamp(
      0.0,
      1.0,
    );
  }

  // WHAT: Get icon based on habit type
  // WHY: Visual indicator for habit category
  IconData _getHabitIcon() {
    switch (habitGoals.habitType) {
      case EnhabitGoal.buildHabit:
        return Icons.trending_up;
      case EnhabitGoal.breakHabit:
        return Icons.block;
      case EnhabitGoal.maintain:
        return Icons.track_changes;
    }
  }

  // WHAT: Check if goal is achieved
  // WHY: Determine which action widget to show
  bool _isCompleted() {
    return habitGoals.currentStreak >= habitGoals.targettedPeriod;
  }

  // ========== WIDGET METHODS ==========

  // WHAT: Icon container with gradient background
  // WHY: Visual identity for each habit
  Widget _goalIcon(LinearGradient? gradient) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(_getHabitIcon(), color: Colors.white, size: 28),
    );
  }

  // WHAT: Title row with goal name and action button
  // WHY: Shows habit name and completion status/actions
  Widget _buildGoalNameRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            habitGoals.goal,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(width: 8),

        _buildActionWidget(context),
      ],
    );
  }

  // WHAT: Shows check icon or more button
  // WHY: Different action based on completion status
  Widget _buildActionWidget(BuildContext context) {
    return UtilAddNewHabitUI().showMoreButton(
      context,
      showMore: (value) => _handleAction(value, context),
    );
  }

  // WHAT: Progress bar with gradient fill
  // WHY: Visual representation of goal progress
  Widget _buildProgressBar(LinearGradient? gradient, double percentage) {
    final Color progressColor = gradient?.colors.first ?? Colors.blue;

    return Container(
      height: 12, // make the progress bar bigger
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // background grey
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: LinearProgressIndicator(
          value: percentage,
          minHeight: 12,
          valueColor: AlwaysStoppedAnimation<Color>(
            progressColor,
          ), // theme color (from gradient)
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  // WHAT: Stats row showing progress and period
  // WHY: Display numeric goal information
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${habitGoals.currentStreak} / ${habitGoals.targettedPeriod} target',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),

        Text(
          habitGoals.periodUnit.periodName,
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 226, 113, 8),
          ),
        ),
      ],
    );
  }

  // WHAT: Main content column
  // WHY: Organizes all content elements vertically
  Widget _buildContentColumn(
    BuildContext context,
    LinearGradient? gradient,
    double percentage,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGoalNameRow(context),

          const SizedBox(height: 8),

          _buildProgressBar(gradient, percentage),

          const SizedBox(height: 8),

          _buildStatsRow(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(
      context,
    ).extension<GradientTheme>()?.primaryGradient;
    final percentage = _getCompletionPercentage();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _goalIcon(gradient),

            const SizedBox(width: 16),

            _buildContentColumn(context, gradient, percentage),
          ],
        ),
      ),
    );
  }
}
