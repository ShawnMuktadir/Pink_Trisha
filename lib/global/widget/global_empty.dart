import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import '../../utils/styles/k_assets.dart';
import '../../utils/styles/k_colors.dart';
import 'global_image_loader.dart';
import 'global_space.dart';
import 'global_text.dart';

class GlobalEmpty extends StatelessWidget {
  final String title;
  final String subTitle;
  const GlobalEmpty({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlobalImageLoader(
          imagePath: KAssetName.icCart.imagePath,
          height: 80,
          width: 80,
        ),
        VerticalSpace(
          height: 15.h,
        ),
        GlobalText(
          str: title,
          color: KColor.deep2.color,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 0.07,
        ),
        VerticalSpace(
          height: 10.h,
        ),
        SizedBox(
          width: 313,
          child: GlobalText(
            str: subTitle,
            color: KColor.deep2.color,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 0.09,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
