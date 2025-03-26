import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class OrderLine extends StatelessWidget {
  const OrderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 2.h,
          decoration: ShapeDecoration(
            color: KColor.line2.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 107.w,
            height: 2.h,
            decoration: ShapeDecoration(
              color: KColor.deepPrimary.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
