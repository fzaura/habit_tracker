import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressCalendarWidget extends StatefulWidget {
  const ProgressCalendarWidget({super.key});

  @override
  State<ProgressCalendarWidget> createState() => _ProgressCalendarWidgetState();
}

class _ProgressCalendarWidgetState extends State<ProgressCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.now().subtract(const Duration(days: -3650)),
      lastDay: DateTime.now().add(const Duration(days: 3650)),
    );
  }
}
