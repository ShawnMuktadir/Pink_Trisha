import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class HomeBestDeals extends ConsumerWidget {
  const HomeBestDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(dashboardController.notifier);
    final state = ref.watch(dashboardController);
    // final homeState = ;
    final bestDealProducts = ref.watch(homeController).bestDealProducts;
    // .where((element) =>
    //     element.product?.isFeatured != null && element.product!.isFeatured!)
    // .toList();

    // List<String> images =
    //     homeState.featuredCategories.map((e) => e.imageUrl ?? "").toList();
    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const GlobalText(
              str: "Best Deals",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            //   color: Colors.yellow,
            height: ((bestDealProducts.length > 2 ? 232.h : 120.h) * 2.7),
            child: bestDealProducts.isNotEmpty
                ? PageView.builder(
                    itemCount: bestDealProducts.length < 4
                        ? 1
                        : (bestDealProducts.length / 4).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 4;

                      Widget buildProductCard(int cardIndex) {
                        final product =
                            bestDealProducts[startIndex + cardIndex].product;
                        // final imageUrl = product?.imageUrl ??
                        //     (product?.productImages?.isNotEmpty == true
                        //         ? product!.productImages!.first.src
                        //         : null);

                        return GlobalProductCard(
                          imageUrl: product?.imageUrl,
                          id: product!.id,
                          title: product.name ?? "",
                          subTitle: product.shortDescription ?? "",
                          price: product.price,
                          offerPrice: product.offerPrice,
                          slug: product.slug ?? "",
                          productImages: product.productImages,
                          loaderScreenType: LoaderScreenType.home,
                          isPreorder: product.paymentType == "DVP",
                          points: product.points ?? 0,
                          quantity: product.quantity,
                          brandId: product.brandId,
                          categoryId: product.categoryId ?? 1,
                          vendorId: product.vendorId,
                          paymentType: product.paymentType ?? "",
                          isInStock:
                              product.quantity != null && product.quantity! > 0,
                          currentAttributeValueId: [],
                        );
                      }

                      return SizedBox(
                        width: context.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.width / 2,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return SingleChildScrollView(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minHeight: constraints.maxHeight),
                                      child: Column(
                                        children: [
                                          buildProductCard(0),
                                          SizedBox(height: 15.w),
                                          if ((startIndex + 2) <
                                              bestDealProducts.length)
                                            buildProductCard(2),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.h),
                              width: context.width / 2,
                              child: Column(
                                children: [
                                  if ((startIndex + 1) <
                                      bestDealProducts.length)
                                    buildProductCard(1),
                                  SizedBox(height: 15.w),
                                  if ((startIndex + 3) <
                                      bestDealProducts.length)
                                    buildProductCard(3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      controller.setBestDealIndex(index);
                    },
                  )
                : Center(
                    child: GlobalText(
                      str: "No Best Deals product found",
                      color: KColor.deepGrey.color,
                    ),
                  ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  bestDealProducts.length > 4
                      ? (bestDealProducts.length / 4).ceil()
                      : 1, (index) {
                late bool isSelected;
                late String imagePath;
                if (index == state.currentBestDealIndex) {
                  isSelected = true;
                  imagePath = KAssetName.icActiveCarouselpng.imagePath;
                } else {
                  isSelected = false;
                  imagePath = KAssetName.icInactiveCarouselpng.imagePath;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: GlobalImageLoader(
                    imagePath: imagePath,
                    height: isSelected ? 8.h : 6.h,
                    width: isSelected ? 8.h : 6.h,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
