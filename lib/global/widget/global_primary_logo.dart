import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

class GlobalPrimaryLogo extends StatelessWidget {
  const GlobalPrimaryLogo({Key? key, this.height, this.width})
      : super(key: key);
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GlobalImageLoader(
        imagePath: KAssetName.primaryLogopng.imagePath,
        height: height ?? 20.h,
        width: width ?? 128.w,
        fit: BoxFit.fitWidth,
      ),
      // child: GlobalSvgLoader(
      //   imagePath: KAssetName.icAppLogosvg.imagePath,
      //   height: height ?? 20.h,
      //   width: width ?? 98.w,
      // ),
    );
  }
}
