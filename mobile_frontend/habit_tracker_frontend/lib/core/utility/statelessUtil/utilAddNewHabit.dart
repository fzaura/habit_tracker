import 'package:flutter/material.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilAddNewHabitUI {
  Widget defaultCreateHabitButton({
    required text,
    required Function(BuildContext ctxt) onPressed,
    required BuildContext ctxt,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
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

  Container defaultInputField(
    String text,
    TextEditingController controller,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: double.infinity,
      ),
      //margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textAlign: TextAlign.left, text, selectionColor: Colors.grey),
          const SizedBox(height: 12),
          TextField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  

}