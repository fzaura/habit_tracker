import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/statelessUtil/utilAddNewHabit.dart';
import 'package:habit_tracker/core/utility/EditDeleteHabitsUtil/StateFullUtil/editDeleteHabits.dart';
import 'package:habit_tracker/core/utility/EditDeleteHabitsUtil/StateLessUtil/confirmDelete.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class Habitscheckcard extends ConsumerWidget {
  const Habitscheckcard({super.key, required this.habitToDisplay});
  final Habit habitToDisplay;

  void editOrDelete(BuildContext context, String value) {
    if (value == 'Edit') {
      showDialog(
        context: context,
        builder: (context) => EditDeleteHabits(habitToEdit: habitToDisplay),
      );
    } else if (value == 'Delete') {
      showDialog(
        context: context,
        builder: (context) => ConfirmDelete(toDeleteHabitId: habitToDisplay.id),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: habitToDisplay.isCompleted
            ? Colors.lightGreen.shade50
            : Colors.white,
        child: Container(
          padding: const EdgeInsets.all(6),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  habitToDisplay.habitName,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: habitToDisplay.isCompleted
                        ? Colors.green.shade700
                        : Colors.black87,
                    decoration: habitToDisplay.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: 1.5, // Make checkbox slightly bigger
                    child: Checkbox(
                      value: habitToDisplay.isCompleted,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          ref
                              .read(habitSampleProvider.notifier)
                              .toggleHabit(habitToDisplay.id);
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
                    child: UtilAddNewHabitUI().showMoreButton(
                      context,
                      showMore: (value) => editOrDelete(context, value),
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
