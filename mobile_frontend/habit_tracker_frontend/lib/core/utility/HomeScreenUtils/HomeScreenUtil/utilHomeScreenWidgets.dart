import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/globalData.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/view(Screens)/SeeAllTemp/seeAllTodayHabits.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UtilHomeScreenWidgets {
  static takeToSeeAllPage({
    required BuildContext ctxt,
    required String nameOfListHeader,
    required String appBarText,
    required Widget lister,
    required bool showHorizentalCalendar,
  }) {
    Navigator.push(
      ctxt,
      MaterialPageRoute(
        builder: (context) => SeeAllList(
          nameOfListHeader: nameOfListHeader,
          appBarText: appBarText,
          listToView: lister,
          seeHorizentalCalendar: showHorizentalCalendar,
        ),
      ),
    );
  }

  static Widget homeScreenWelcomeMessage(
    final String formattedDate,
    final String formattedDateAfterAWeek,
  ) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Weekly Goals From :',

            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$formattedDate to $formattedDateAfterAWeek',

            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, ',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: GlobalData.currentUser.name,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: mainAppTheme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget habitsDoneToday(int habitsCheckedToday, int allTheHabits) {
    return CircularPercentIndicator(
      animation: true,
      rotateLinearGradient: true,
      backgroundColor: Colors.white.withValues(alpha: 0.6),
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.7),
          Colors.white.withValues(alpha: 1),
        ],
        begin: AlignmentGeometry.bottomLeft,
        end: AlignmentGeometry.topRight,
      ),
      lineWidth: 17,
      radius: 63,
      percent: (habitsCheckedToday / allTheHabits),
    );
  }

  static Widget homeProgressCard(int habitsCheckedToday, int allTheHabits) {
    double mainPecetnage = habitsCheckedToday / allTheHabits * 100;
    return Container(
      width: double.infinity,
      height: 199,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainAppTheme.cardColor, mainAppTheme.colorScheme.primary],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.all(13),
      child: Stack(
        children: [
          Positioned(
            right: 204,
            bottom: 34,
            top: 34,
            left: 26,
            child: habitsDoneToday(habitsCheckedToday, allTheHabits),
          ),
          Positioned(
            top: 85,

            bottom: 45,
            left: 85,
            right: 234,

            child: Text(
              '${mainPecetnage.toInt()}%',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 61,

            bottom: 54,
            left: 189,
            right: 10.24,

            child: Text(
              '${habitsCheckedToday} of ${allTheHabits} \nCompleted Today!',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 120,

            bottom: 0,
            left: 300.60,
            right: 43.24,

            child: Transform.scale(
              scale: 3.6,
              child: Image.asset(
                'resources/Calendar_Flatline.png',
                width: 132,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget listHeader(String name, VoidCallback? onPressButton) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 128),
        if (onPressButton != null)
          TextButton(
            onPressed: onPressButton,
            child: Text(
              'See all',
              style: GoogleFonts.nunito(
                color: mainAppTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  static Widget todayTemplateContainer(
    List<Habit> habits, {
    VoidCallback? pressSeeAll,
    required Widget listToView,
    required String nameOfListHeader,
    double? requiredHeight,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(12),
      width: double.infinity,

      constraints: requiredHeight != null
          ? BoxConstraints(maxHeight: requiredHeight)
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(flex: 1, child: listHeader(nameOfListHeader, pressSeeAll)),
          Flexible(flex: 3, child: listToView),
        ],
      ),
    );
  }

  static Widget todayHabitsChart(
    int numberOfCompletedHabits,
    int numberOfAllHabitsToday,
  ) {
    return CircularPercentIndicator(
      radius: 60,
      percent: numberOfCompletedHabits / numberOfAllHabitsToday,
      progressColor: mainAppTheme.colorScheme.onPrimary,
    );
  }

  static String formatEnumName(String enumName) {
    return enumName
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
