import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/components/cart_product_qty_selection.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/model/product_details_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_cart_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/product_details_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../../../global/widget/global_image_loader.dart';
import '../../../../../global/widget/global_space.dart';
import '../../../../../global/widget/global_text.dart';
import '../../../../../utils/styles/k_colors.dart';

class GlobalCartItem extends StatelessWidget {
  final String imgPath;
  final String slug;
  final int quantity;
  final String? titleText;
  final String? availableProduct;
  final List<SelectedAttributeModel> variants;
  final String? price;
  final void Function() onDeleteButtonTap;
  final String? paymentType;

  const GlobalCartItem({
    super.key,
    required this.imgPath,
    required this.titleText,
    required this.availableProduct,
    required this.onDeleteButtonTap,
    required this.price,
    required this.slug,
    required this.quantity,
    required this.variants,
    required this.paymentType,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read(cartController.notifier);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        // onDeleteButtonTap();
        controller.deleteCart(slug);
      },
      background: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
        child: Container(
          alignment: Alignment.centerRight,
          width: context.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: KColor.primary.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          //   height: 170,
          width: context.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: KColor.card.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalContainer(
                height: 77,
                width: 80,
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GlobalImageLoader(
                    imageFor:
                        imgPath.isEmpty ? ImageFor.asset : ImageFor.network,
                    imagePath: imgPath.isEmpty
                        ? KAssetName.icEmptyImage2png.imagePath
                        : imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const HorizontalSpace(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        width: 190.w,
                        child: GlobalText(
                          str: titleText ?? "",
                          maxLines: 2,
                          color: KColor.deep2.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                      ),
                      VerticalSpace(
                        height: 8,
                      ),
                      paymentType == "DVP"
                          ? GlobalText(
                              str: "(50% of the product)",
                              color: KColor.deepGrey.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                            )
                          : SizedBox(),
                      VerticalSpace(
                        height: 8,
                      ),
                      Visibility(
                        visible: false,
                        child: GlobalText(
                          str: availableProduct ?? "",
                          color: KColor.cardBlueText.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 0.10,
                        ),
                      ),
                      VerticalSpace(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CartProductQuantitySection(
                            quantity: quantity,
                            slug: slug,
                          ),
                          Row(
                            children: [
                              GlobalText(
                                str: 'BDT',
                                color: KColor.deep2.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0.09,
                              ),
                              GlobalText(
                                str: ' $price',
                                color: KColor.deep2.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalCartItem2 extends StatelessWidget {
  final String imgPath;
  final String slug;
  final int quantity;
  final String? titleText;
  final String? availableProduct;
  final String? price;
  final void Function() onDeleteButtonTap;

  const GlobalCartItem2({
    Key? key,
    required this.imgPath,
    required this.titleText,
    required this.availableProduct,
    required this.onDeleteButtonTap,
    required this.price,
    required this.slug,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: context.width,
      padding: const EdgeInsets.all(12),
      //color: Colors.yellow,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: context.width - 40,
                height: 170 - 25,
                decoration: BoxDecoration(
                  color: KColor.primary.color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final state = ref.watch(cartController);
                    final controller = ref.read(cartController.notifier);

                    return InkWell(
                      onTap: () {
                        controller.deleteCart(slug);
                      },
                      child: Stack(
                        children: [
                          Positioned(
                            right: 10,
                            top: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GlobalSvgLoader(
                                width: 24,
                                height: 24,
                                imagePath:
                                    KAssetName.icDeleteButtonsvg.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 170,
                // Adjusted height to match the parent container
                width: context.width - 65,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: KColor.card.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalContainer(
                      height: 77,
                      width: 80,
                      padding: EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: GlobalImageLoader(
                          imageFor: imgPath.isEmpty
                              ? ImageFor.asset
                              : ImageFor.network,
                          imagePath: imgPath.isEmpty
                              ? KAssetName.icEmptyImage2png.imagePath
                              : imgPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const HorizontalSpace(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: titleText ?? "",
                              maxLines: 2,
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                            VerticalSpace(
                              height: 8,
                            ),
                            GlobalText(
                              str: availableProduct ?? "",
                              color: KColor.cardBlueText.color,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                            ),
                            VerticalSpace(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CartProductQuantitySection(
                                  quantity: quantity,
                                  slug: slug,
                                ),
                                Row(
                                  children: [
                                    GlobalText(
                                      str: 'BDT',
                                      color: KColor.deep2.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      height: 0.09,
                                    ),
                                    GlobalText(
                                      str: ' $price',
                                      color: KColor.deep2.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      height: 0.09,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
