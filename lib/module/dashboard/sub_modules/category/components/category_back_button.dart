import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CategoryBackButton extends StatelessWidget {
  const CategoryBackButton({super.key, required this.fromPush});
  final bool fromPush;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 26, left: 16),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      final controller = ref.read(dashboardController.notifier);
                      fromPush
                          ? Navigation.pop(context)
                          : controller.onOptionChange(0);
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
                    str: 'Categories',
                    color: KColor.deep2.color,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0.07,
                  )
                ],
              )),
        );
      },
    );
  }
}
