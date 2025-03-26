import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

class BillinAddressButton extends StatelessWidget {
  const BillinAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24),
      child: GlobalButton(
        btnHeight: 40.h,
        btnWidth: 200.w,
        textFontSize: 14.sp,
        textFontWeight: FontWeight.w700,
        textFontHeight: 0.08,
        // padding: EdgeInsets.all(13),
        onPressed: () {
          Navigation.push(context,
              appRoutes: AppRoutes.createAddress, arguments: true);
        },
        buttonText: " Billing Address",
        isPlusButton: true,
      ),
    );
  }
}
