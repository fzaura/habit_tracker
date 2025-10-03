import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/themes.dart';

class DayOfWeek extends StatelessWidget {
  const DayOfWeek({super.key, required this.day, required this.currentMonth});
  final DateTime day;

  final String currentMonth;
  bool isToday(DateTime randomDay) {
    if (randomDay.day == DateTime.now().day) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1.0),
        color: isToday(day) ? const Color.fromARGB(47, 236, 101, 17) : null,
      ),
      margin: EdgeInsets.all(8),
      width: 59,
      height: 40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text(
            day.day.toString(),
            style: GoogleFonts.nunito(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: isToday(day) ? mainAppTheme.colorScheme.primary : null,
            ),
          ),
          Text(
            currentMonth,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isToday(day) ? mainAppTheme.colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
