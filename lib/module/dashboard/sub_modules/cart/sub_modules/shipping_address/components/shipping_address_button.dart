import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

class ShippingAddressButton extends StatelessWidget {
  const ShippingAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GlobalButton(
              btnHeight: 40.h,
              btnWidth: 200.w,
              textFontSize: 14.sp,
              textFontWeight: FontWeight.w700,
              textFontHeight: 0.08,
              onPressed: () {
                Navigation.push(context,
                    appRoutes: AppRoutes.createAddress, arguments: true);
              },
              buttonText: " Shipping Address",
              isPlusButton: true,
            ),
          )
        ],
      ),
    );
  }
}
