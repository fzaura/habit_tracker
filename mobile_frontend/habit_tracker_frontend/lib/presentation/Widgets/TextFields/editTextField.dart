import 'package:flutter/material.dart';

Widget editTextField(String mainHintText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(4),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: mainHintText,
      ),
    ),
  );
}

class EditTextFormField extends StatelessWidget {
  const EditTextFormField({super.key});
  @override
  Widget build(BuildContext context) {
    return editTextField(
      'Write this down Hey Am a text field Am The Widget You just made',
    );
  }
}
