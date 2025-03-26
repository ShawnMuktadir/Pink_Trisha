import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

class ProductDetailsExtras extends StatelessWidget {
  const ProductDetailsExtras({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: 'Ext',
            color: Color(0xFF40363C),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
          VerticalSpace(),
          ExtCardList(),
        ],
      ),
    );
  }
}

class ExtCardList extends StatelessWidget {
  const ExtCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ExtCard(
            isSelected: true,
            assetName: KAssetName.watch_beltpng.imagePath,
            text: "24mm Black LiteHide ™M Leather Strap",
            amount: "40",
          ),
          ExtCard(
            assetName: KAssetName.watch_belt2png.imagePath,
            text: "24mm Black LiteHide ™M Leather Strap",
            amount: "30",
          ),
          ExtCard(
            assetName: KAssetName.watch_beltpng.imagePath,
            text: "24mm Black LiteHide ™M Leather Strap",
            amount: "40",
          ),
          ExtCard(
            assetName: KAssetName.watch_belt2png.imagePath,
            text: "24mm Black LiteHide ™M Leather Strap",
            amount: "30",
          ),
          ExtCard(
            assetName: KAssetName.watch_belt2png.imagePath,
            text: "24mm Black LiteHide ™M Leather Strap",
            amount: "30",
          ),
        ],
      ),
    );
  }
}

class ExtCard extends StatelessWidget {
  const ExtCard(
      {super.key,
      required this.assetName,
      required this.text,
      required this.amount,
      this.isSelected = false});
  final String amount;
  final String text;
  final String assetName;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 83.96,
          height: 66.84,
          decoration: ShapeDecoration(
            color: const Color(0xFFFBFBFF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Center(
            child: GlobalImageLoader(
                width: 64.17, height: 58.72, imagePath: assetName),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 108,
            child: GlobalText(
              str: text,
              color: const Color(0xFF2C2328),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
        ),
        const VerticalSpace(
          height: 14,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalSvgLoader(
                width: isSelected ? 20 : 12,
                height: isSelected ? 20 : 12,
                imagePath: isSelected
                    ? KAssetName.icCheckMarkPinksvg.imagePath
                    : KAssetName.icCheckMarkDeepsvg.imagePath),
            const HorizontalSpace(
              width: 10,
            ),
            GlobalText(
              str: '+$amount\$',
              color: const Color(0xFF2C2328),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 0.11,
            ),
          ],
        )
      ],
    );
  }
}
