import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/Features/Habits/DeleteHabits/confirmDelete.dart';
import 'package:habit_tracker/domain/Habits/Features/Habits/EditHabits/editDeleteHabits.dart';

class Showmorebutton extends StatelessWidget {
  
  const Showmorebutton({super.key, required this.habitToDisplay});
  final Habit habitToDisplay;

  void _editOrDelete(BuildContext context, String value) {
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
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey.shade600, size: 26),
      onSelected: (String value) {
        _editOrDelete(context, value);
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit, size: 18, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
      ],
    );
  }
}
