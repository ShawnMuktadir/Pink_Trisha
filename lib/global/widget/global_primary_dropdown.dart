import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_dropdown.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalPrimaryDropdown extends StatelessWidget {
  final String title;
  final String? hint;
  final bool isRequired;
  const GlobalPrimaryDropdown(
      {super.key, required this.title, this.hint, this.isRequired = true});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GlobalText(
                  str: title,
                  color: KColor.deep2.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                isRequired
                    ? GlobalText(
                        str: "*",
                        color: KColor.deepPrimary.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                    : const SizedBox.shrink(),
              ],
            )),
        const SizedBox(
          height: 4,
        ),
        GlobalDropdown(
            validator: (validator) {},
            hintText: hint ?? "Select",
            onChanged: (value) {},
            items: dropdownItems),
      ],
    );
  }
}

List<DropdownMenuItem<String>>? dropdownItems = [
  const DropdownMenuItem(
    child: Text("Value 1"),
    value: "Value 1",
  ),
  const DropdownMenuItem(
    child: Text("Value 2"),
    value: "Value 2",
  ),
  const DropdownMenuItem(
    child: Text("Value 3"),
    value: "Value 3",
  ),
  const DropdownMenuItem(
    child: Text("Value 4"),
    value: "Value 4",
  ),
];
