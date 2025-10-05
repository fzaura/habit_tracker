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
  }) {
    Navigator.push(
      ctxt,
      MaterialPageRoute(
        builder: (context) => SeeAllList(
          nameOfListHeader: nameOfListHeader,
          appBarText: appBarText,
          listToView: lister,
        ),
      ),
    );
  }

  static Widget homeScreenWelcomeMessage(final String formattedDate) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate,
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
      progressColor: mainAppTheme.colorScheme.onPrimary.withValues(alpha: 0.8),
      lineWidth: 15,
      radius: 60,
      percent: (habitsCheckedToday / allTheHabits),
    );
  }

  static Widget homeProgressCard(int habitsCheckedToday, int allTheHabits) {
    double mainPecetnage = habitsCheckedToday / allTheHabits * 100;
    return Container(
      width: double.infinity,
      height: 189,
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
            top: 80,

            bottom: 55,
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
          const SizedBox(width: 20),
          Positioned(
            top: 61,

            bottom: 54,
            left: 169,
            right: 10.24,

            child: Text(
              '${habitsCheckedToday} of ${allTheHabits} \n Completed Today :D',
              style: mainAppTheme.textTheme.labelMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 108,

            bottom: 5,
            left: 0.60,
            right: 10.24,

            child: Image.asset(
              'resources/Calender_Flatline.png',
              errorBuilder: (context, error, stackTrace) {
                print('IMAGE ERROR: $error');
                return Text('Image failed to load');
              },
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
