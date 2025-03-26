import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

class NewAddressButton extends StatelessWidget {
  const NewAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          const VerticalSpace(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GlobalButton(
              btnHeight: 40.h,
              btnWidth: 160.w,
              textFontSize: 14.sp,
              textFontHeight: 0.08,
              padding: const EdgeInsets.symmetric(vertical: 12),
              onPressed: () async {
                Navigation.push(context,
                    appRoutes: AppRoutes.createAddress, arguments: false);
              },
              buttonText: "New Address",
              isPlusButton: true,
            ),
          ),
          const VerticalSpace(
            height: 25,
          ),
        ],
      ),
    );
  }
}
