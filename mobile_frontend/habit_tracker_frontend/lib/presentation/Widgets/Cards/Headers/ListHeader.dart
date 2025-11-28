import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';




class Listheader extends StatelessWidget {
  const Listheader({super.key,required this.name ,required this.onPressButton });
  final String name;
   final VoidCallback onPressButton;
  @override
  Widget build(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 100),
          if (onPressButton != (){})
            TextButton(
              onPressed: onPressButton,
              child: Text(
                'See all',
                style: GoogleFonts.nunito(
                  color: mainAppTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}