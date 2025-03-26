import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class TopBrandsBackButton extends StatelessWidget {
  const TopBrandsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, left: 16),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: GlobalSvgLoader(
                    height: 24.h,
                    width: 24.w,
                    imagePath: KAssetName.icArrowBacksvg.imagePath),
              ),
              const HorizontalSpace(
                width: 8,
              ),
              GlobalText(
                str: 'Top Brands',
                color: KColor.deep2.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.07,
              )
            ],
          )),
    );
  }
}
