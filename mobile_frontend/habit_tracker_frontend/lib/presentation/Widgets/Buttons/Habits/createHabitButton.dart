import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';

class CreateHabitButton extends StatelessWidget {
  const CreateHabitButton({
    super.key,
    required this.labelText,
    required this.onPressed,
  });
  final String labelText;
  final Function(BuildContext context) onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ), // Spacing from edges ,

      child: ElevatedButton(
        onPressed: () {
          onPressed(context);
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
          labelText,
          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
