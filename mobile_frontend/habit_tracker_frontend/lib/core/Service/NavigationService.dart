import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Habits/view(Screens)/SeeAllTemp/seeAllTodayHabits.dart';

takeToSeeAllPage({
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

class NavigationService {
  static void takeToSeeAllPage({
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
}
