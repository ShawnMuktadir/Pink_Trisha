import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class ProfileEditTitle extends StatelessWidget {
  const ProfileEditTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 29, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GlobalText(
              str: 'Edit Account Information',
              color: KColor.deep2.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 0.09,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 24,
              height: 24,
              decoration: ShapeDecoration(
                color: KColor.background6.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Center(
                child: GlobalSvgLoader(
                    height: 16,
                    width: 16,
                    imagePath: KAssetName.icEditProfilesvg.imagePath),
              ),
            ),
          )
        ],
      ),
    );
  }
}
