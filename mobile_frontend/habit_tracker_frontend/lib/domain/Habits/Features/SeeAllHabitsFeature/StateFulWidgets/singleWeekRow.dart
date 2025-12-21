import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Habits/Features/SeeAllHabitsFeature/StatelessWidgets/dayOfWeek.dart';
import 'package:intl/intl.dart';

class SingleWeekRow extends StatefulWidget {
  const SingleWeekRow({super.key});

  @override
  State<SingleWeekRow> createState() => _SingleWeekRowState();
}

class _SingleWeekRowState extends State<SingleWeekRow> {
  DateTime today = DateTime.now();
  String currentMonth = DateFormat('MMM').format(DateTime.now());
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {

        return DayOfWeek(
          day: today.subtract(Duration(days:index )),
          currentMonth: this.currentMonth,
        );

      },
    );
  }
}
