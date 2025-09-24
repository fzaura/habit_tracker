import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownButtonTemp<enumTemp extends Enum> extends StatefulWidget {
  DropDownButtonTemp({
    super.key,
    required this.buttonName,
    required this.passedEnumValue,
    required this.enumValues,
  });
  final String buttonName;
  final List<enumTemp> enumValues;
  enumTemp passedEnumValue;

  @override
  State<DropDownButtonTemp> createState() => _DropDownButtonTempState();
}

class _DropDownButtonTempState extends State<DropDownButtonTemp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.buttonName,
            style: GoogleFonts.nunito(fontSize: 16),
          ),
        ),
        DropdownButton(
          value: widget.passedEnumValue,
          items: widget.enumValues
              .map(
                (item) => DropdownMenuItem(value: item, child: Text(item.name)),
              )
              .toList(),
          onChanged: (value) => setState(() {
            widget.passedEnumValue = value!;
          }),
        ),
      ],
    );
  }
}
