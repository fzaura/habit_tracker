import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/Buttons/Habits/showMoreButton.dart';

class Habitscheckcard extends ConsumerStatefulWidget {
  const Habitscheckcard({super.key, required this.habitToDisplay});
  final Habit habitToDisplay;

  @override
  ConsumerState<Habitscheckcard> createState() => _HabitscheckcardState();
}

class _HabitscheckcardState extends ConsumerState<Habitscheckcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: AnimatedContainer(
          duration: const Duration(microseconds: 300),
          decoration: BoxDecoration(
            color: widget.habitToDisplay.isCompleted
                ? Colors.green.shade50
                : const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (widget.habitToDisplay.isCompleted)
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: widget.habitToDisplay.isCompleted
                        ? Colors.green.shade700
                        : Colors.black87,
                  ),
                  child: Text(widget.habitToDisplay.habitName),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: widget.habitToDisplay.isCompleted,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          ref
                              .read(habitSampleProvider.notifier)
                              .toggleHabit(widget.habitToDisplay.id);
                        }
                      },
                      activeColor: Colors.green.shade600,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-8, 0),
                    child: Showmorebutton(
                      habitToDisplay: widget.habitToDisplay,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
