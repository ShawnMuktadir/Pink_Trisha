import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class CartProductQuantitySection extends StatelessWidget {
  final int quantity;
  final String slug;

  const CartProductQuantitySection({
    Key? key,
    required this.quantity,
    required this.slug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(cartController);
        final controller = ref.read(cartController.notifier);

        return Container(
          width: 86,
          height: 32,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFC1C1C1)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  //    color: Colors.yellow,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => controller.decrementQuantity(slug),
                    child: GlobalSvgLoader(
                        //    width: 21.82,
                        //      height: 21.82,
                        imagePath: KAssetName.icProductMinussvg.imagePath),
                  ),
                ),
                GlobalText(
                  str: quantity.toString(), // Display the current quantity
                  color: Color(0xFF0D0D0D),
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
                Material(
                  //    color: Colors.yellow,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => controller.incrementQuantity(slug),
                    child: GlobalSvgLoader(
                        //width: 21.82,
                        //  height: 21.82,
                        imagePath: KAssetName.icProductPlussvg.imagePath),
                  ),
                ),
              ]),
        );
      },
    );
  }
}
  //  return Container(
  //     height: 100,
  //     width: 100,
  //     padding: const EdgeInsets.only(top: 16, bottom: 38),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 106,
  //           decoration: ShapeDecoration(
  //             color: Colors.white,
  //             shape: RoundedRectangleBorder(
  //               side: const BorderSide(width: 1, color: Color(0xFFC1C1C1)),
  //               borderRadius: BorderRadius.circular(4),
  //             ),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(9),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Material(
  //                   //    color: Colors.yellow,
  //                   color: Colors.white,
  //                   child: InkWell(
  //                     onTap: decrementQuantity,
  //                     child: GlobalSvgLoader(
  //                         //    width: 21.82,
  //                         //      height: 21.82,
  //                         imagePath: KAssetName.icProductMinussvg.imagePath),
  //                   ),
  //                 ),
  //                 GlobalText(
  //                   str: quantity.toString(), // Display the current quantity
  //                   color: Color(0xFF0D0D0D),
  //                   fontSize: 16,
  //                   textAlign: TextAlign.center,
  //                   fontWeight: FontWeight.w600,
  //                   height: 0.09,
  //                 ),
  //                 Material(
  //                   //    color: Colors.yellow,
  //                   color: Colors.white,
  //                   child: InkWell(
  //                     onTap: incrementQuantity,
  //                     child: GlobalSvgLoader(
  //                         //width: 21.82,
  //                         //  height: 21.82,
  //                         imagePath: KAssetName.icProductPlussvg.imagePath),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
 