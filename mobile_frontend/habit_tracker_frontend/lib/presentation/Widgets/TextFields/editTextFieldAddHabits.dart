import 'package:flutter/material.dart';

class EditTextFormFieldAddHabits extends StatelessWidget {
  const EditTextFormFieldAddHabits({
    super.key,
    required this.mainHintText,
    required this.errorMessage,
    required this.controller,
  });

  final String mainHintText;
  final String errorMessage;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        controller: controller,

        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: mainHintText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Field is required';
          if (value.trim().length < 2) return 'Minimum 2 characters';
          if (value.trim().length > 50) return 'Maximum 50 characters';
          return null;
        },
      ),
    );
  }
}
