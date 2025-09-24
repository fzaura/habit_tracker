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

  void showEditHabitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Edit Habit Goal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Your Goal Field
            Text('Your Goal', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Finish 5 Philosophy Books',
                ),
              ),
            ),
            SizedBox(height: 15),
            
            // Habit Name Field
            Text('Habit Name', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Read Philosophy',
                ),
              ),
            ),
            SizedBox(height: 15),
            
            // Period Dropdown
            Text('Period', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: '1 Month (30 Days)',
                  items: ['1 Month (30 Days)'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            SizedBox(height: 15),
            
            // Habit Type Dropdown
            Text('Habit Type', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Everyday',
                  items: ['Everyday'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            SizedBox(height: 25),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Delete Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ),
                SizedBox(width: 10),
                
                // Update Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Update'),
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