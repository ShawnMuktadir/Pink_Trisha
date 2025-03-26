import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class EllipseList extends StatelessWidget {
  const EllipseList({super.key, this.color, this.size = 44});
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconEllipse(
          hasCheck: true,
          icon: GlobalSvgLoader(imagePath: KAssetName.icOnprocesssvg.imagePath),
        ),
        IconEllipse(
          icon: GlobalSvgLoader(
              imagePath: KAssetName.icOrderConfirmsvg.imagePath),
        ),
        IconEllipse(
          color: KColor.background3.color,
          icon: GlobalSvgLoader(
              imagePath: KAssetName.icDeliveryTrucksvg.imagePath),
        ),
        IconEllipse(
          size: 35,
          color: KColor.background3.color,
          icon: GlobalSvgLoader(
              imagePath: KAssetName.icDeliveryHandsvg.imagePath),
        ),
      ],
    );
  }
}

class IconEllipse extends StatelessWidget {
  const IconEllipse(
      {super.key,
      this.color,
      this.size = 44,
      this.hasCheck = false,
      this.icon});
  final Color? color;
  final double size;
  final bool hasCheck;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 44,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: 44,
              height: 44,
              decoration: ShapeDecoration(
                color: color ?? KColor.deepPrimary.color,
                shape: const OvalBorder(),
              ),
              child: Center(child: icon),
            ),
          ),
          hasCheck
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: ShapeDecoration(
                      //   color: KColor.softPrimary.color,
                      shape: const OvalBorder(),
                    ),
                    child: GlobalSvgLoader(
                        imagePath: KAssetName.icRoundedCheckmarksvg.imagePath),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class TextEllipse extends StatelessWidget {
  const TextEllipse(
      {super.key,
      this.color,
      this.size = 16,
      this.hasCheck = false,
      this.text});
  final Color? color;
  final double size;
  final bool hasCheck;
  final Widget? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: color ?? KColor.deepPrimary.color,
        shape: const OvalBorder(),
      ),
      child: Center(child: text),
    );
  }
}

class BorderedEllipse extends StatelessWidget {
  const BorderedEllipse(
      {super.key,
      this.color,
      this.size = 44,
      this.hasCheck = false,
      this.text});
  final Color? color;
  final double size;
  final bool hasCheck;
  final Widget? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFCAA996)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 2.40,
            top: 2.40,
            child: Container(
              width: 11.20,
              height: 11.20,
              decoration: const ShapeDecoration(
                color: Color(0xFF977164),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
