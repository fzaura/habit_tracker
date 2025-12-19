import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';

AppBar signLoginBar({
  required BuildContext context,
  required String mainText,
  required String buttonText,
  required void Function(BuildContext context) onIconPressed,
}) {
  return AppBar(
    toolbarHeight: 100,
    title: Text(
      mainText,
      style: GoogleFonts.nunito(fontSize: 44, fontWeight: FontWeight.bold),
    ),
    actions: [
      Text(
        buttonText,
        style: GoogleFonts.nunito(
          color: mainAppTheme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      IconButton(
        onPressed: () {
          onIconPressed(context);
        },
        icon: Icon(
          color: mainAppTheme.colorScheme.primary,
          Icons.arrow_forward_sharp,
        ),
      ),
    ],
  );
}



Widget defaultSignLogInButton({
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

Widget defaultSignLogInGoogleButton({
  required aboveText,
  required Function(BuildContext ctxt) onPressed,
  required BuildContext ctxt,
}) {
  return Column(
    children: [
      Text(aboveText, style: const TextStyle(color: Colors.grey)),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 33,
        ), // Spacing from edges ,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Image.asset(
            'resources/google-logo.png',
            height: 32,
            width: 32,
          ),
        ),
      ),
    ],
  );
}

void showErrorDialog({
  required BuildContext ctxt,
  required String mainTitile,
  required String contentOfTitle,
}) {
  showDialog(
    context: ctxt,
    builder: (ctxt) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        mainTitile,
        style: mainAppTheme.textTheme.titleLarge,
        selectionColor: mainAppTheme.colorScheme.primary,
      ),
      content: Text(
        contentOfTitle,
        style: mainAppTheme.textTheme.bodyMedium,
        selectionColor: mainAppTheme.colorScheme.onPrimary,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainAppTheme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            elevation: 4,
          ),
          onPressed: () {
            Navigator.pop(ctxt);
          },
          child: Text(
            'OK',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

