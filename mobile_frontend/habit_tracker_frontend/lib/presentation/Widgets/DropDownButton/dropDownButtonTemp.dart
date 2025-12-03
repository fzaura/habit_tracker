import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/utility/Format/formatNames.dart';

class DropDownButtonTemp extends StatefulWidget {
 const DropDownButtonTemp({
    super.key,
    required this.buttonName,
    required this.passedEnumValue,
    required this.enumValues,
    required this.onChanged
  });
  final String buttonName;
  final List<Enum> enumValues;
 final Enum passedEnumValue;
  final Function(Enum passedValue) onChanged;

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
        Expanded(
          child: DropdownButtonFormField(
            value: widget.passedEnumValue,
            items: [
              for (final items in widget.enumValues)
                DropdownMenuItem(
                  value: items,
                  child: Text(
                    FormatNames.formatEnum(FormatNames.formatEnum(items)),
                    style: mainAppTheme.textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],

            onChanged: (value) =>widget.onChanged(value!)
          ),
        ),
      ],
    );
  }
}
