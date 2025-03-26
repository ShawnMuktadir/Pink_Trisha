import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';

import '../../utils/styles/styles.dart';

class GlobalDropdown extends StatelessWidget {
  const GlobalDropdown({
    Key? key,
    required this.validator,
    required this.hintText,
    required this.onChanged,
    required this.items,
    this.hintColor,
  }) : super(key: key);

  final String? Function(Object?)? validator;
  final String? hintText;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;
  final Color? hintColor;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 200,
      validator: validator,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xff9ea1a6),
        size: 24,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: KColor.white.color,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: KColor.enableBorder.color, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KColor.red.color, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KColor.red.color, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: KColor.divider.color, width: 1.w),
        ),
      ),
      isExpanded: true,
      hint: GlobalText(
        str: "$hintText",
        color: hintColor ?? KColor.grey.color,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
      items: items,
    );
  }
}
