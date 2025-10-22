import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // Read current habits from provider and pick the one we display.
    final habits = ref.watch(habitSampleProvider);
    final habit = habits.firstWhere(
      (h) => h.id == widget.habitToDisplayInfo.id,
    );

    // Build a column with a custom header above the calendar so we can match
    // the provided design: start date at left, month centered with arrows,
    // end date at right.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 35),
          _buildCalendar(habit),
        ],
      ),
    );
  }

  // ------------------------- Helpers & Builders -------------------------

  /// Builds a compact custom header that shows a start date on left,
  /// month selector with arrows centered, and end date on right.
  Widget _buildHeader(BuildContext context) {
    final start = _formatDate(_focusedDay.subtract(const Duration(days: 7)));
    final end = _formatDate(_focusedDay.add(const Duration(days: 6)));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          // Start date - left aligned
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start date',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Text(
                start,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Spacer keeps center widget centered
          const Spacer(),

          // Center month with previous / next buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Prev month button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_left, color: Colors.black54),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                _formatMonth(_focusedDay),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(width: 8),
              // Next month button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_right, color: Colors.black54),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),

          const Spacer(),
          // End date - right aligned
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'End date',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                end,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the TableCalendar with custom day builders to match the provided
  /// decoration: completed days are green, others grey; selected day is dark.
  Widget _buildCalendar(Habit habit) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now().subtract(const Duration(days: 3650)),
      lastDay: DateTime.now().add(const Duration(days: 3650)),
      headerVisible: false, // we use our custom header
      daysOfWeekHeight: 28,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black54),
        weekendStyle: TextStyle(color: Colors.black54),
      ),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: true,
        cellMargin: EdgeInsets.zero,
        // Keep default text style here; we override in builders when needed
      ),
      calendarBuilders: CalendarBuilders(
        // Default cell builder for days inside the month
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(context, day, habit);
        },
        // Builder for selected day to emphasize with dark rounded box
        selectedBuilder: (context, day, focusedDay) {
          return _buildSelectedDayCell(context, day);
        },
        // Builder for days outside current month (muted)
        outsideBuilder: (context, day, focusedDay) {
          return _buildDayCell(context, day, habit, isOutside: true);
        },
        // Builder for today (optional highlight)
        todayBuilder: (context, day, focusedDay) {
          // Keep today appearance equal to normal unless it's selected
          return _buildDayCell(context, day, habit);
        },
      ),
    );
  }

  /// Returns true if the provided day is present in habit.completedDates
  bool _isDayCompleted(DateTime day, Habit habit) {
    return habit.completedDates.any((savedDay) => isSameDay(savedDay, day));
  }

  /// Builds a normal day cell. If [isOutside] is true the cell looks muted.
  Widget _buildDayCell(
    BuildContext context,
    DateTime day,
    Habit habit, {
    bool isOutside = false,
  }) {
    final bool completed = _isDayCompleted(day, habit);
    final bool isSelected = isSameDay(day, _selectedDay);

    // Performance tip: avoid heavy layout here; use const where possible and
    // small widgets. Decoration is lightweight.
    final Color bgColor;
    final Color textColor;

    if (isSelected) {
      // Selected day uses dark rounded box (as in the screenshot)
      bgColor = Colors.black87;
      textColor = Colors.white;
    } else if (completed) {
      // Completed days are green with slightly rounded rectangle
      bgColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else {
      // Regular days
      bgColor = isOutside ? Colors.grey.shade200 : Colors.transparent;
      textColor = isOutside ? Colors.black38 : Colors.black87;
    }

    return Center(
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  /// Builds selected day cell with a stronger visual (dark box)
  Widget _buildSelectedDayCell(BuildContext context, DateTime day) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Small helper to format a date like "June 4 2022"
  String _formatDate(DateTime dt) {
    // Use month name and day + year
    return '${_monthName(dt.month)} ${dt.day} ${dt.year}';
  }

  // Small helper to return month name only (e.g., "July")
  String _formatMonth(DateTime dt) {
    return _monthName(dt.month);
  }

  // Map month integer to a short name. Kept local for simplicity and speed.
  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
