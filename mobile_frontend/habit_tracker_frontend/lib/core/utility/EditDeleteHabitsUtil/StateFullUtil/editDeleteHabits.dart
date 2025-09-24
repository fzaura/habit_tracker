import 'package:flutter/material.dart';
import 'package:habit_tracker/data/Models/UIModels/habit.dart';

class EditDeleteHabits extends StatefulWidget {
  const EditDeleteHabits({super.key});

  @override
  State<EditDeleteHabits> createState() => _EditDeleteHabitsState();
}

class _EditDeleteHabitsState extends State<EditDeleteHabits> {
 @override
 

    late TextEditingController yourGoalController;
  late TextEditingController yourHabitController;

  EnhabitGoal habitGoal = EnhabitGoal.buildHabit;
  EnperiodUnit periodUnit = EnperiodUnit.daily;


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
  
  @override
  void initState() {
    super.initState();
    yourGoalController = TextEditingController();
    yourHabitController = TextEditingController();
  }

   Widget build(BuildContext context) {
    // TODO: implement build
    return  Dialog(
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
    );
  }


  @override
  void dispose() {
    yourGoalController.dispose();
    yourHabitController.dispose();
    super.dispose();
  }
}