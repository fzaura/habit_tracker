import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class ConfirmDelete extends ConsumerWidget {
  const ConfirmDelete({super.key, required this.toDeleteHabitId});

  final String toDeleteHabitId;

  Widget defaultDeleteButton({
    required text,
    required Function(BuildContext ctxt) onPressed,
    required BuildContext ctxt,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 33,
      ), // Spacing from edges ,

      child: ElevatedButton(
        onPressed: () {
          onPressed(ctxt);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: mainAppTheme.colorScheme.primary, // Orange color
          foregroundColor: Colors.white, // Text color
          shadowColor: Colors.orangeAccent.withOpacity(0.5), // Shadow color
          elevation: 5, // Shadow elevation
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ), // Matches text field height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              6,
            ), // Same border radius as text field
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _deleteHabitLogic(String deletedHabitId, WidgetRef ref) {
    ref.watch(habitSampleProvider.notifier).deleteHabits(deletedHabitId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  //  final myHabits = habitSampleProvider;
    return AlertDialog(
      content: SizedBox(
        width: 330,
        height: 323,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_forever, size: 48),
            ),
            Text(
              'Are You Sure You want To Delete The Habit ?',
              style: mainAppTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            defaultDeleteButton(
              text: 'Delete',
              onPressed: (context) {
                _deleteHabitLogic(toDeleteHabitId, ref);
                Navigator.pop(context);
              },
              ctxt: context,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: mainAppTheme.textTheme.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}
