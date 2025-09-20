import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/globalData.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/stateFulUtil/habitsCheckCard.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';

class UtilHomeScreenWidgets {
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

  static Widget homeProgressCard() {
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
      child: Row(),
    );
  }

  static Widget listHeader(String name, {required VoidCallback onPressButton}) {
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

  static Widget todayHabitContainer(
    List<Habit> habits, {
    required VoidCallback pressSeeAll,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(6),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 352),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listHeader('Today\'s Habits', onPressButton: pressSeeAll),
          const SizedBox(height: 4),
          habitsColumn(habits),
        ],
      ),
    );
  }

  static Widget habitsColumn(List<Habit> habits) {
    return Column(
      children: [
        Habitscheckcard(habitToDisplay: habits[0]),
        Habitscheckcard(habitToDisplay: habits[1]),
        Habitscheckcard(habitToDisplay: habits[2]),
      ],
    );
  }

  
}
