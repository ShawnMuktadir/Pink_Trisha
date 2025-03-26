import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class CheckLabel extends StatelessWidget {
  const CheckLabel(
      {super.key,
      required this.label,
      this.hasStar = false,
      required this.isSelected,
      required this.onTap});
  final String label;
  final bool hasStar;
  final bool isSelected;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalSvgLoader(
              height: 14,
              width: 14,
              imagePath: isSelected
                  ? KAssetName.icCheckMarkSelectedsvg.imagePath
                  : KAssetName.icCheckMarkUnselectedsvg.imagePath),
          hasStar
              ? Row(
                  children: [
                    HorizontalSpace(
                      width: 4,
                    ),
                    GlobalSvgLoader(
                        height: 16,
                        width: 16,
                        imagePath: KAssetName.icStarYellowsvg.imagePath),
                  ],
                )
              : SizedBox.shrink(),
          HorizontalSpace(
            width: 4,
          ),
          GlobalText(
            str: label,
            color: KColor.deep3.color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 0.11,
          )
        ],
      ),
    );
  }
}

class CheckLabelStatic extends StatefulWidget {
  const CheckLabelStatic(
      {super.key, required this.label, this.hasStar = false});
  final String label;
  final bool hasStar;

  @override
  State<CheckLabelStatic> createState() => _CheckLabelStaticState();
}

class _CheckLabelStaticState extends State<CheckLabelStatic> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalSvgLoader(
              height: 14,
              width: 14,
              imagePath: isSelected
                  ? KAssetName.icCheckMarkSelectedsvg.imagePath
                  : KAssetName.icCheckMarkUnselectedsvg.imagePath),
          widget.hasStar
              ? Row(
                  children: [
                    HorizontalSpace(
                      width: 4,
                    ),
                    GlobalSvgLoader(
                        height: 16,
                        width: 16,
                        imagePath: KAssetName.icStarYellowsvg.imagePath),
                  ],
                )
              : SizedBox.shrink(),
          HorizontalSpace(
            width: 4,
          ),
          GlobalText(
            str: widget.label,
            color: KColor.deep3.color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 0.11,
          )
        ],
      ),
    );
  }
}
