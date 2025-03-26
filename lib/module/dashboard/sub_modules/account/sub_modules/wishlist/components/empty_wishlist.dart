import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class EmptyWishListWidget extends StatelessWidget {
  const EmptyWishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalSvgLoader(
                height: 90,
                width: 90,
                imagePath: KAssetName.icWishEmptysvg.imagePath),
            const VerticalSpace(
              height: 19,
            ),
            GlobalText(
              str: 'Your Wishlist is Empty!',
              textAlign: TextAlign.center,
              color: KColor.deep2.color,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
