import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/app/globalData.dart';



class HomeScreenWelcomeMessage extends StatelessWidget {

  const HomeScreenWelcomeMessage({super.key,required this.formattedDate , required this.formattedDateAfterAWeek});
   final String formattedDate;
    final String formattedDateAfterAWeek;
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 6),
          Text(
            '$formattedDate to $formattedDateAfterAWeek',

            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              shadows: [Shadow(offset: Offset(0, 1),blurRadius: 1)]
            ),
          ),
          const SizedBox(height: 6),

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
}