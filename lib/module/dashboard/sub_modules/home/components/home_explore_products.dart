import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
import 'package:pink_by_trisha_app/global/widget/global_seel_all_button_text.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class HomeExploreProducts extends ConsumerWidget {
  const HomeExploreProducts({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(homeController.notifier);
    final state = ref.watch(dashboardController);
    final homeState = ref.watch(homeController);
    final featuredProducts = ref.watch(homeController).featuredProducts;
    // .where((element) =>
    //     element.product?.isFeatured != null && element.product!.isFeatured!)
    // .toList();
    ;

    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const GlobalText(
                  str: "Explore Our Products",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
                GlobalSeeAllTextButton(onTap: () {
                  Navigation.push(context,
                      appRoutes: AppRoutes.product,
                      arguments: ScreenSourceData(sourceType: SourceType.all));
                })
              ],
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(homeState.categoryTitles.length, (index) {
                final category = homeState.categoryTitles[index];
                final bool isSelected = category == homeState.selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 20.w : 22.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.onCategoryChange(data: category);
                      controller.getHomeResponse(
                          isReload: false,
                          skip: 0,
                          take: 10,
                          categoryId: category.id);
                    },
                    child: Container(
                      height: 34.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? KColor.primary.color : null,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: GlobalText(
                          str: category.name ?? "",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? KColor.white.color
                              : KColor.disabledText.color,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          featuredProducts.isNotEmpty
              ? Wrap(
                  children: List.generate(
                    featuredProducts.length,
                    (index) {
                      final product = featuredProducts[index].product;
                      final imageUrl = product?.imageUrl ??
                          (product?.productImages?.isNotEmpty == true
                              ? product!.productImages!.first.src
                              : null);
                      print("\nimageUrl of ${product?.name} is : \n");
                      print(imageUrl);
                      print("\n..........");
                      return Container(
                        width: context.width / 2,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 14.w,
                        ),
                        child: GlobalProductCard(
                          imageUrl: imageUrl,
                          id: product!.id!,
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
                              product.quantity != null && product.quantity != 0,
                          currentAttributeValueId: [],
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Empty Products'),
                  ),
                ),
        ],
      ),
    );
  }
}
