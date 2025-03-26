import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/product_details_screen.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class WishCard extends StatelessWidget {
  const WishCard(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.onTap,
      required this.price,
      required this.offerPrice,
      required this.isPreorder,
      required this.slug,
      required this.name,
      required this.details,
      required this.brandId,
      required this.categoryId,
      required this.vendorId,
      required this.paymentType});

  final int id;
  final String slug;
  final String? imagePath;
  final String name;
  final String details;
  final String price;
  final bool isPreorder;
  final String offerPrice;
  final int? brandId;
  final int? categoryId;
  final int? vendorId;
  final String paymentType;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);

        final isCartSelected = state.cartProducts
            .where((element) => element.id == id.toString())
            .isNotEmpty;
        return GestureDetector(
          onTap: () {
            Navigation.push(context,
                appRoutes: AppRoutes.productDetails,
                arguments: ProductDetailsScreenModel(slug: slug, id: id));
          },
          child: GlobalContainer(
              height: 434.h,
              width: double.infinity,
              borderRadius: 8.r,
              backgroundColor: KColor.card.color,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GlobalContainer(
                      height: 282.h,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      borderRadius: 6,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: GlobalImageLoader(
                                  imageFor: imagePath != null
                                      ? ImageFor.network
                                      : ImageFor.asset,
                                  imagePath: imagePath ??
                                      KAssetName.icEmptyImage2png.imagePath)),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  onTap();
                                },
                                child: GlobalSvgLoader(
                                    imagePath:
                                        KAssetName.icHeartPinksvg.imagePath),
                              )),
                        ],
                      )),
                  const VerticalSpace(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 43),
                      child: GlobalText(
                        str: name ?? "",
                        maxLines: 2,
                        color: KColor.deep2.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            GlobalText(
                              str: 'BDT $price',
                              color: KColor.deepGrey.color,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              maxLines: 1,
                              decoration: TextDecoration.lineThrough,
                            ),
                            const HorizontalSpace(
                              width: 8,
                            ),
                            Container(
                              width: 160,
                              child: GlobalText(
                                str: 'BDT $offerPrice',
                                color: KColor.midPrimary.color,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        VerticalSpace(
                          height: 8.h,
                        ),
                        InkWell(
                            onTap: () {
                              //  ViewUtil.SSLSnackbar("msg....dsf................");

                              controller.toggleCartButton(CartProduct(
                                  id: id.toString(),
                                  name: name,
                                  slug: slug,
                                  shortDescription: details,
                                  imageUrl: imagePath,
                                  price: price,
                                  offerPrice: offerPrice,
                                  productImage: imagePath,
                                  isPreorder: isPreorder,
                                  quantity: 1,
                                  brandId: brandId,
                                  categoryId: categoryId,
                                  paymentType: paymentType,
                                  vendorId: vendorId,
                                  currentAttributeValueId: [],
                                  nameBn: ''));
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: isCartSelected
                                    ? KColor.deepPrimary.color
                                    : KColor.background7.color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: Material(
                                color: isCartSelected
                                    ? KColor.deepPrimary.color
                                    : KColor.background7.color,
                                borderRadius: BorderRadius.circular(4),
                                child: GlobalSvgLoader(
                                    height: 40.h,
                                    width: 40.w,
                                    imagePath: isCartSelected
                                        ? KAssetName
                                            .icCartButtonSelectedsvg.imagePath
                                        : KAssetName.icCartButtonUnselectedsvg
                                            .imagePath),
                              ),
                            )
                            //  GlobalSvgLoader(
                            //     height: 40.h,
                            //     width: 40.w,
                            //     imagePath: isCartSelected
                            //         ? KAssetName.icCartButtonSelectedsvg.imagePath
                            //         : KAssetName.icCartButtonUnselectedsvg.imagePath),
                            )
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class WishCardSmaller extends StatelessWidget {
  const WishCardSmaller(
      {super.key,
      required this.imagePath,
      required this.slug,
      required this.id});

  final String imagePath;
  final String slug;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.push(context,
            appRoutes: AppRoutes.productDetails,
            arguments: ProductDetailsScreenModel(slug: slug, id: id));
      },
      child: GlobalContainer(
          //height: 224.h,
          width: 156.w,
          borderRadius: 8.r,
          backgroundColor: KColor.card.color,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GlobalContainer(
                  height: 134.h,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  borderRadius: 6,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          child: GlobalSvgLoader(
                              imagePath: KAssetName.icHeartPinksvg.imagePath)),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: GlobalImageLoader(imagePath: imagePath)),
                    ],
                  )),
              const VerticalSpace(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 43),
                  child: GlobalText(
                    str: 'Long Sleeve Shirts cbvnv bm, hkhgjhmgj,asfddfa',
                    maxLines: 2,
                    color: KColor.deep2.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 0.11,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GlobalText(
                        str: 'BDT 59',
                        color: KColor.deepGrey.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                        height: 0.10,
                      ),
                      const HorizontalSpace(
                        width: 8,
                      ),
                      GlobalText(
                        str: 'BDT 78',
                        color: KColor.deep2.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                      ),
                    ],
                  ),
                  VerticalSpace(
                    height: 8.h,
                  ),
                  GlobalSvgLoader(
                      height: 40.h,
                      width: 40.w,
                      imagePath: KAssetName.icCartButtonUnselectedsvg.imagePath)
                ],
              ),
            ],
          )),
    );
  }
}
