import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utility/statelessUtil/utilAddNewHabit.dart';

class SucessScreenUtil extends StatelessWidget {
  const SucessScreenUtil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('resources/Notes_Outline 1.png'),
            Text(
              'Done!',
              style: GoogleFonts.nunito(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'New Habit has been Added ',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Let\'s do the Best to achieve your Goals',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            UtilAddNewHabitUI().defaultCreateHabitButton(
              text: 'OK',
              onPressed: (context) {
                Navigator.pop(context);
              },
              ctxt: context,
            ),
          ],
        ),
      ),
    );
  }
}
