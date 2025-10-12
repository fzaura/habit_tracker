import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailedGoalCard extends ConsumerWidget {
  const DetailedGoalCard({super.key, required this.habitToDisplay});
  final Habit habitToDisplay;
  Widget _circlePercentage(int currentStreak, int targettedStreak) {
    double percentageOfStreak = (currentStreak / targettedStreak) * 100;
    double actualPercent = currentStreak / targettedStreak;
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        CircularPercentIndicator(
          percent: actualPercent > 1.0 ? 1.0 : actualPercent,
          radius: 25,
        ),
        Text(
          percentageOfStreak.toInt() >= 100
              ? '100%'
              : '${percentageOfStreak.toInt()}%',
          style: mainAppTheme.textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _habitNameTarget() {
    return Column(
      children: [
        Text(
          habitToDisplay.habitName,
          style: mainAppTheme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${habitToDisplay.currentStreak} from ${habitToDisplay.targettedPeriod} days target',
          style: mainAppTheme.textTheme.labelMedium?.copyWith(),
        ),
      ],
    );
  }

  bool isTargetAchieved() {
    if (habitToDisplay.isGoalAchieved) {
      return true;
    } else {
      return false;
    }
  }

  Widget _achievedCard() {
    final bool isTargetDone = isTargetAchieved();
    return Container(
      padding: EdgeInsets.all(8),
      color: isTargetDone ? Colors.lightGreen : Colors.grey,
      child: Card(
        color: Colors.white,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: isTargetDone ? Text('Achieved') : Text('Unachieved'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            _circlePercentage(
              habitToDisplay.currentStreak,
              habitToDisplay.targettedPeriod,
            ),
            _habitNameTarget(),
            _achievedCard(),
          ],
        ),
      ),
    );
  }
}
