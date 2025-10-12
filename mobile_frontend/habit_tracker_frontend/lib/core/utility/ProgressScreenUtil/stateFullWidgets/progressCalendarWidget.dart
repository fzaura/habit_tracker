import 'package:flutter/material.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressCalendarWidget extends StatefulWidget {
  const ProgressCalendarWidget({super.key, required this.habitToDisplayInfo});
  final Habit habitToDisplayInfo;
  @override
  State<ProgressCalendarWidget> createState() => _ProgressCalendarWidgetState();
}

class _ProgressCalendarWidgetState extends State<ProgressCalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now().subtract(const Duration(days: 3650)),
      lastDay: DateTime.now().add(const Duration(days: 3650)),
      headerStyle: HeaderStyle(titleCentered: true, formatButtonVisible: false),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, focusedDay) {
          final isCompleted = widget.habitToDisplayInfo.completedDates.any(
            (day) => isSameDay(day, date),
          );
          if (isCompleted) {
            return Container(
              color: Colors.green,
              child: Text(date.day.toString()),
            );
          }
        },
      ),
    );
  }
}
