import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';

class TodayTempContainer extends StatelessWidget {
  TodayTempContainer({
    super.key,
    required this.habits,
    required this.listToView,
    required this.nameOfListHeader,
    required this.pressSeeAll,
    required this.requiredHeight,
    required this.seeAllButton,
  });

  final List<Habit> habits;
  final VoidCallback? pressSeeAll;
  final bool seeAllButton;
  final Widget listToView;
  final String nameOfListHeader;
  final double requiredHeight;

  Widget _listHeader(
    String name,
    bool seeAllButton,
    VoidCallback? onPressButton,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
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
          Spacer(),
          if (seeAllButton == true)
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 251, 250, 250),
      ),
      margin: EdgeInsets.all(12),
      width: double.infinity,

      constraints: requiredHeight != 0
          ? BoxConstraints(maxHeight: requiredHeight)
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: _listHeader(nameOfListHeader, seeAllButton, pressSeeAll),
          ),
          Flexible(flex: 3, child: listToView),
        ],
      ),
    );
  }
}
