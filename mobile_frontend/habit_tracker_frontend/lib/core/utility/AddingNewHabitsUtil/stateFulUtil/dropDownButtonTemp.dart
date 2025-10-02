import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtil/utilHomeScreenWidgets.dart';

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
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    UtilHomeScreenWidgets.formatEnumName(item.name),
                    style: mainAppTheme.textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
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
