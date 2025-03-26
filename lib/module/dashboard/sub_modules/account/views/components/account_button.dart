import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class AccountButton extends StatelessWidget {
  const AccountButton(
      {super.key,
      this.isSelected,
      this.selectIndex,
      required this.iconName,
      required this.title,
      // this.onTap
      });
  final int? isSelected;
  final int? selectIndex;
  final String iconName;
  final String title;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // int selectValue = 0;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          // onTap: () => onTap!(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: KColor.white.color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isSelected == selectIndex
                      ? KColor.deepPrimary.color
                      : KColor.grey2.color,
                  width: .5.w),
            ),
            child: Row(
              children: [
                GlobalSvgLoader(
                  imagePath: iconName,
                  height: 24.h,
                  width: 24.w,
                ),
                HorizontalSpace(
                  width: 8.w,
                ),
                GlobalText(
                  textAlign: TextAlign.center,
                  str: title,
                  color: KColor.deep4.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
