import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/presentation/Widgets/Calendar/progressCalendarWidget.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

class TheGoalInDetail extends StatelessWidget {
  const TheGoalInDetail({super.key, required this.habit});
  final Habit habit;

  Row detailsFormat(Widget fieldToFill, Widget filedWith) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [fieldToFill, filedWith],
    );
  }

  Widget goalDetails(Habit habitToDisplay) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with habit name and status
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                habitToDisplay.goal,
                style: mainAppTheme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: habitToDisplay.isGoalAchieved
                      ? Colors.green.shade50
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  habitToDisplay.isGoalAchieved ? 'Achieved' : 'In Progress',
                  style: TextStyle(
                    color: habitToDisplay.isGoalAchieved
                        ? Colors.green
                        : Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),
          Divider(height: 1),
          SizedBox(height: 16),

          // Habit Name
          detailsFormat(
            Text(
              'Habit Name:',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              habitToDisplay.habitName,
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Target
          detailsFormat(
            Text(
              'Target:',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              '${habitToDisplay.targettedPeriod} from ${habitToDisplay.targettedPeriod} Days',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Days complete
          detailsFormat(
            Text(
              'Days complete:',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              '${habitToDisplay.completedDates.length} from ${habitToDisplay.targettedPeriod} Days',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Days failed
          detailsFormat(
            Text(
              'Days failed:',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              '${habitToDisplay.targettedPeriod - habitToDisplay.completedDates.length} Day',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Habit type
          detailsFormat(
            Text(
              'Habit type',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              habitToDisplay.periodUnit.periodName,
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: 12),

          // Created on
          detailsFormat(
            Text(
              'Created on',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            Text(
              '${habitToDisplay.createdAt.month}/${habitToDisplay.createdAt.day}/${habitToDisplay.createdAt.year}',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF5F5F5),
      appBar: AppBar( toolbarHeight: 80,

        backgroundColor:const Color(0xFFF5F5F5),
        title: Text(
          maxLines: 2,
          habit.goal,
          style: mainAppTheme.textTheme.labelLarge?.copyWith(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProgressCalendarWidget(habitToDisplayInfo: habit),
            goalDetails(habit),
          ],
        ),
      ),
    );
  }
}
