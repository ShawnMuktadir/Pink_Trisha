import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'styles.dart';

class KTextStyle {
  static TextStyle customTextStyle({
    double fontSize = 16,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    TextDecoration? decoration,
  }) =>
      GoogleFonts.poppins(
        color: color ?? KColor.grey2.color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        height: height != null ? height * fontSize : null,
        decoration: decoration,
      );
}
