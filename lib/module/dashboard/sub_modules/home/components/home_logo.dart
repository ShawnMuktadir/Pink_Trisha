import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_logo.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: GlobalPrimaryLogo(
          height: 22.h,
          width: 180.w,
        )
        // child: GlobalSvgLoader(
        //   imagePath: KAssetName.icAppLogosvg.imagePath,
        //   height: 22.h,
        //   width: 98.w,
        // ),
        );
  }
}
