import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../controller/product_list_controller.dart';

class ProductList extends StatelessWidget {
  final PageController pageController;
  final Function() onRefresh;
  const ProductList(
      {super.key, required this.pageController, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(productListController);
      final controller = ref.read(productListController.notifier);

      return Expanded(
        child: PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (state.products.isNotEmpty) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          color: KColor.primary.color,
                          onRefresh: () async {
                            controller.refresh();
                          },
                          child: GridView.builder(
                              itemCount: state.products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      // childAspectRatio: 2,
                                      crossAxisCount: 2,
                                      mainAxisExtent: 310),
                              padding: const EdgeInsets.only(top: 20),
                              itemBuilder: (ctx, itemIndex) {
                                int productIndex = itemIndex;
                                //  if (productIndex < state.products.length) {
                                return Container(
                                  width: context.width / 2,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 14.w,
                                  ),
                                  child: GlobalProductCard(
                                    // imageUrl: state.products[productIndex].imageUrl,
                                    productImages: state
                                        .products[productIndex].productImages,
                                    title:
                                        state.products[productIndex].name ?? "",
                                    subTitle: state.products[productIndex]
                                            .shortDescription ??
                                        "",
                                    price: state.products[productIndex].price,
                                    offerPrice:
                                        state.products[productIndex].offerPrice,
                                    slug:
                                        state.products[productIndex].slug ?? "",
                                    id: state.products[productIndex].id!,
                                    loaderScreenType:
                                        LoaderScreenType.productList,
                                    isPreorder: state.products[productIndex]
                                            .paymentType ==
                                        "DVP",
                                    points:
                                        state.products[productIndex].points ??
                                            0,
                                    quantity:
                                        state.products[productIndex].quantity,
                                    brandId:
                                        state.products[productIndex].brandId,
                                    categoryId: state.products[productIndex]
                                            .categoryId ??
                                        1,
                                    vendorId:
                                        state.products[productIndex].vendorId,
                                    paymentType: state.products[productIndex]
                                            .paymentType ??
                                        "",
                                    isInStock: state.products[productIndex]
                                                .quantity !=
                                            null &&
                                        state.products[productIndex].quantity !=
                                            0,
                                    currentAttributeValueId: [],
                                  ),
                                );
                                // } else {
                                //   return Container();
                                // }
                              }),
                        );
                  //   }
                }
              } else {
                return const Center(child: Text("Data Not Found!"));
              }
            }),
      );
    });
  }
}
