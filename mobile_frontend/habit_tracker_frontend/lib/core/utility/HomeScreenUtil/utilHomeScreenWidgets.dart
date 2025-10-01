import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/globalData.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/stateFulUtil/habitsLister.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';

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
      margin: EdgeInsets.all(6),
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
}
