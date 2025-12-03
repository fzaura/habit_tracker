import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/statelessWidgets/Detailed%20Goals%20Lister/utilProgressScreen.dart';
import 'package:habit_tracker/presentation/Widgets/DropDownButton/dropDownButtonTemp.dart';

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


class HomeScreenProgressReport extends StatelessWidget {
  const HomeScreenProgressReport({super.key});
  @override
  Widget build(BuildContext context) {
   return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 29),
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
                onChanged: (passedValue) {
                  
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}