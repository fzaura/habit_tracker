import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/dropDownButtonTemp.dart';

enum EnTimePhase { thisWeek, thisMonth, thisYear }

extension StringtimePhase on EnTimePhase {
  String get timePhaseswitch {
    switch (this) {
      case EnTimePhase.thisMonth:
        return 'This Month';
      case EnTimePhase.thisWeek:
        return 'This Week';
      case EnTimePhase.thisYear:
        return 'This Year';
    }
  }
}

class Utilprogressscreen {
  static Widget homeScreenWelcomeMessage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Progress Report',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            Expanded(
              child: DropDownButtonTemp(
                buttonName: '',
                passedEnumValue: EnTimePhase.thisMonth,
                enumValues: EnTimePhase.values,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
