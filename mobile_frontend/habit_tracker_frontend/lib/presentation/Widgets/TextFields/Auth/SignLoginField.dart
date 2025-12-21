import 'package:flutter/material.dart';

class SignLoginField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String? value)? onValidate;
  const SignLoginField({
    super.key,
    required this.text,
    required this.controller,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.left,
            text,
            selectionColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 12),
          TextFormField(
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
            validator: onValidate,
          ),
        ],
      ),
    );
  }
}
