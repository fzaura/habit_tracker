import 'package:flutter/material.dart';
import 'package:habit_tracker/core/Themes/app_theme.dart';
import 'package:habit_tracker/presentation/core/Design/goal_card_design.dart';
import 'package:habit_tracker/presentation/core/Enums/activity_level.dart';




/// All design/styling delegated to [GoalCardDesign]
class GoalCard extends StatelessWidget {
  final String goalName;
  final String taskName;
  final String category;
  final List<ActivityLevel> progressData;
  final IconData? icon;
  final int cardIndex;
  final Color? cardColor; // NEW: Custom card color

  const GoalCard({
    super.key,
    required this.goalName,
    required this.taskName,
    required this.category,
    required this.progressData,
    required this.cardIndex,
    this.icon,
    this.cardColor, // NEW: Optional custom color
  });

  // ========== WIDGET BUILDERS ==========

  /// Builds the header row with icon and category tag
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIcon(),
        _buildCategoryChip(),
      ],
    );
  }

  /// Builds the icon on the left side of header
  Widget _buildIcon() {
    return Icon(
      icon ?? Icons.abc,
      color: GoalCardDesign.getIconColor(),
      size: GoalCardDesign.iconSize,
    );
  }

  /// Builds the category tag chip
  Widget _buildCategoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: GoalCardDesign.getCategoryChipDecoration(),
      child: Text(
        category.toUpperCase(),
        style: GoalCardDesign.getCategoryTextStyle(),
      ),
    );
  }

  /// Builds the goal name text
  Widget _buildGoalName() {
    return Text(
      goalName,
      style: GoalCardDesign.getGoalNameStyle(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the task name subtitle
  Widget _buildTaskName() {
    return Text(
      taskName,
      style: GoalCardDesign.getTaskNameStyle(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the VERTICAL GitHub-style activity grid with vertical gradient
  ///
  /// Grid layout:
  /// - 4 rows with vertical gradient (top to bottom)
  /// - 11 columns
  /// - Vertical fade: Row 0-1 (100%), Row 2 (80%), Row 3 (40%)
  Widget _buildActivityGrid() {
    //1-The Number of squares in the grid
    final totalSquares = GoalCardDesign.gridRows * GoalCardDesign.gridColumns;

    // Pad progressData to match grid size
    final gridData = List<ActivityLevel>.generate(
      totalSquares,
      (index) => index < progressData.length
          ? progressData[index]
          : ActivityLevel.none,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(GoalCardDesign.gridRows, (row) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: row < GoalCardDesign.gridRows - 1
                ? GoalCardDesign.squareGap
                : 0,
          ),
          child: _buildGridRow(row, gridData),
        );
      }),
    );
  }

  /// Builds a single row of the activity grid
  Widget _buildGridRow(int row, List<ActivityLevel> gridData) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(GoalCardDesign.gridColumns, (col) {
        final index = row * GoalCardDesign.gridColumns + col;
        final activityLevel = gridData[index];

        return Padding(
          padding: EdgeInsets.only(
            right: col < GoalCardDesign.gridColumns - 1
                ? GoalCardDesign.squareGap
                : 0,
          ),
          child: _buildGridSquare(activityLevel, row, col),
        );
      }),
    );
  }

  /// Builds a single square in the activity grid
  Widget _buildGridSquare(ActivityLevel level, int row, int col) {
    return Container(
      width: GoalCardDesign.squareSize,
      height: GoalCardDesign.squareSize,
      decoration: GoalCardDesign.getSquareDecoration(level, row, col),
    );
  }

  // ========== MAIN BUILD ==========

  @override
  Widget build(BuildContext context) {
    final goalColors = Theme.of(context).extension<GoalCardColors>()!;
    
    // MODIFIED: Use provided cardColor or fallback to theme color by index
    final effectiveColor = cardColor ?? goalColors.getColorByIndex(cardIndex);

    return SizedBox(
      width: GoalCardDesign.width,
      height: GoalCardDesign.height,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: GoalCardDesign.horizontalPadding,
          vertical: GoalCardDesign.verticalPadding,
        ),
        decoration: GoalCardDesign.getCardDecoration(effectiveColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 5),
            _buildGoalName(),
            const SizedBox(height: 6),
            _buildTaskName(),
            const Spacer(),
            _buildActivityGrid(),
          ],
        ),
      ),
    );
  }
}