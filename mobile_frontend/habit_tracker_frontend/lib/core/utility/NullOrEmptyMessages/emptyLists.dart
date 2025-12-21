import 'package:flutter/material.dart';

class Emptylists {
 static Widget emptyGoalsList({required String mainMessage ,required String secondMessage}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Don't take up the whole screen
          children: [
            Icon(Icons.auto_awesome, size: 48, color: const Color.fromARGB(255, 131, 130, 130)),
            const SizedBox(height: 16),
             Text(
              mainMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
             Text(
              secondMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}