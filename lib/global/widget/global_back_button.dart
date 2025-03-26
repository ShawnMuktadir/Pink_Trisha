import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class GlobalBackButton extends StatelessWidget {
  const GlobalBackButton({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: GestureDetector(
              onTap: () {
                onTap == null ? Navigation.pop(context) : onTap!();
              },
              child: GlobalSvgLoader(
                  imagePath: KAssetName.icArrowBacksvg.imagePath),
            ),
          ),
          const HorizontalSpace(
            width: 8,
          ),
          GlobalText(
            str: title,
            color: KColor.deep2.color,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 0.07,
          )
        ],
      ),
    );
  }
}
