import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_logo.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

class HomeLogoWithBackground extends StatelessWidget {
  const HomeLogoWithBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFFBF1F4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              Center(
                child: GlobalPrimaryLogo(
                  height: 20.h,
                  width: 130.w,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 24,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: GestureDetector(
                    onTap: () {
                      Navigation.pop(context);
                    },
                    child: GlobalSvgLoader(
                        imagePath: KAssetName.icArrowBacksvg.imagePath),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
