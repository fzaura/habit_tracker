import 'package:flutter/material.dart';
import 'package:habit_tracker/app/Themes/themes.dart';

class EditTextFormField extends StatelessWidget {
  const EditTextFormField({
    super.key,
    required this.mainHintText,
    required this.errorMessage,
    required this.controller
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
          if (value!.isEmpty || value.trim().length <= 1) {
            return errorMessage;
          }
          else
          {
            return null;
          }
        },
        onSaved: (newValue) {controller.text=newValue!;},
      ),
    );
    
  }
}
