import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';

class Habitscheckcard extends StatefulWidget {
   Habitscheckcard({super.key, required this.habitToDisplay});
  Habit habitToDisplay;
  @override
  State<Habitscheckcard> createState() => _HabitscheckcardState();
}

class _HabitscheckcardState extends State<Habitscheckcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: widget.habitToDisplay.isCompleted
            ? Colors.lightGreen.shade50
            : Colors.white,
        child: Container(
          padding: const EdgeInsets.all(6),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.habitToDisplay.habitName,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: widget.habitToDisplay.isCompleted
                        ? Colors.green.shade700
                        : Colors.black87,
                    decoration: widget.habitToDisplay.isCompleted
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
                      value: widget.habitToDisplay.isCompleted,
                      onChanged: (bool? newValue) {
                        setState(() {
                          widget.habitToDisplay.isCompleted = newValue!;
                        });
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
                    child: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey.shade600,
                        size: 26,
                      ),
                      onSelected: (String value) {
                        // Handle menu selection
                        if (value == 'edit') {
                          // Handle edit
                          print(
                            'Edit habit: ${widget.habitToDisplay.habitName}',
                          );
                        } else if (value == 'delete') {
                          // Handle delete
                          print(
                            'Delete habit: ${widget.habitToDisplay.habitName}',
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.red.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
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
