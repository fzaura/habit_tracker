import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';
import 'package:table_calendar/table_calendar.dart';

// Change to ConsumerStatefulWidget
class ProgressCalendarWidget extends ConsumerStatefulWidget {
  const ProgressCalendarWidget({super.key, required this.habitToDisplayInfo});
  final Habit habitToDisplayInfo;

  @override
  ConsumerState<ProgressCalendarWidget> createState() =>
      _ProgressCalendarWidgetState();
}

// Use ConsumerState and add WidgetRef ref to build
class _ProgressCalendarWidgetState
    extends ConsumerState<ProgressCalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Now you can use ref.watch or ref.read here
    final habits = ref.watch(habitSampleProvider);
    final habit = habits.firstWhere(
      (h) => h.id == widget.habitToDisplayInfo.id,
    );
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now().subtract(Duration(days: 3650)),
      lastDay: DateTime.now().add(Duration(days: 3650)),
      headerStyle: HeaderStyle(titleCentered: true, formatButtonVisible: false),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final isComplete = habit.completedDates.any(
            (savedDay) => isSameDay(day, savedDay),
          );
          if (isComplete) {
            return Container(
              color: Colors.green,
              child: Center(child: Text('${day.day}')),
              
            );
          } else {
            return Container(
              color: const Color.fromARGB(255, 113, 117, 113),
              child: Center(child: Text('${day.day}')),
            );
          }
        },
      ),
    );
  }
}
