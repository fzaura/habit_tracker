import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailedGoalCard extends ConsumerWidget {
  const DetailedGoalCard({super.key, required this.habitToDisplay});
  final Habit habitToDisplay;

  // Public build - uses small well-named helpers below.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.white, // ensure card background is white as requested
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPercentageIndicator(),
            const SizedBox(width: 12),
            Expanded(child: _buildNameAndTarget(context)),
            const SizedBox(width: 12),
            _buildAchievedChip(),
          ],
        ),
      ),
    );
  }

  // Determine the color to use for both the circular indicator and the chip.
  Color get _statusColor {
    return habitToDisplay.isGoalAchieved
        ? const Color.fromARGB(255, 62, 189, 8)
        : const Color.fromARGB(255, 145, 143, 143);
  }

  // Build the circular percentage indicator. Styling only — logic untouched.
  Widget _buildPercentageIndicator() {
    final double rawPercent =
        habitToDisplay.targettedPeriod > 0
            ? habitToDisplay.currentStreak / habitToDisplay.targettedPeriod
            : 0.0;//The Actual Percent Number We Deal With
    final double percent = rawPercent > 1.0 ? 1.0 : rawPercent;//If The Percent Is Bigger Always Return to 1 
    final int percentText = ((rawPercent * 100).clamp(0, 100)).toInt();

    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: 23,
            percent: percent,
            lineWidth: 3,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: _statusColor,
            backgroundColor: _statusColor.withOpacity(0.12),
          ),
          Text(
            percentText >= 100 ? '100%' : '$percentText%',
            style: mainAppTheme.textTheme.labelSmall?.copyWith(
              color: _statusColor,
              fontWeight: FontWeight.w700,
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }

  // Build the main name + subtext column.
  Widget _buildNameAndTarget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          habitToDisplay.habitName,
          style: mainAppTheme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          '${habitToDisplay.currentStreak} from ${habitToDisplay.targettedPeriod} days target',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Build the achieved/unachieved chip that matches the indicator color.
  Widget _buildAchievedChip() {
    final bool achieved = habitToDisplay.isGoalAchieved;
    final Color bg = _statusColor.withOpacity(0.14);
    final Color textColor = _statusColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _statusColor.withOpacity(0.18)),
      ),
      child: Text(
        achieved ? 'Achieved' : 'Unachieved',
        style: mainAppTheme.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
