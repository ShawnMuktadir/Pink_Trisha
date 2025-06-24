import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/components/empty_wishlist.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/components/wish_card.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(wishController.notifier);
        final state = ref.watch(wishController);

        // Print all wishlist items
        if (state.wishItems != null) {
          for (var item in state.wishItems!) {
            final product = item.product;
            print("Product full details:");
            print(product.toJson()); // Automatically prints all properties
          }
        }

        return GlobalBackground(
          child: GlobalTopLoader(
            isLoading: state.loaderScreenType == LoaderScreenType.wishList,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GlobalBackButton(title: "My Wishlist"),
                state.isLoading
                    ? const Center(
                        child: SizedBox(child: CircularProgressIndicator()),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await controller.getWishList();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: (state.wishItems == null ||
                                    state.wishItems!.isEmpty)
                                ? const EmptyWishListWidget()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 24, left: 24),
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < state.wishItems!.length;
                                            i++) ...[
                                          WishCard(
                                            imagePath: state
                                                .wishItems![i]
                                                .product
                                                .productImages
                                                ?.first
                                                .src,
                                            onTap: () {
                                              controller.deleteWish(
                                                id: state
                                                    .wishItems![i].product.id!,
                                                loaderScreenType:
                                                    LoaderScreenType.wishList,
                                              );
                                            },
                                            name: state.wishItems![i].product
                                                    .name ??
                                                "",
                                            details: state.wishItems![i].product
                                                    .shortDescription ??
                                                "",
                                            slug: state
                                                .wishItems![i].product.slug!,
                                            price: state
                                                .wishItems![i].product.price
                                                .toString(),
                                            offerPrice: state.wishItems![i]
                                                .product.offerPrice
                                                .toString(),
                                            id: state.wishItems![i].product.id!,
                                            isPreorder: state.wishItems![i]
                                                    .product.paymentType ==
                                                "DVP",
                                            brandId: state
                                                .wishItems![i].product.brandId,
                                            categoryId: state.wishItems![i]
                                                .product.categoryId,
                                            vendorId: state
                                                .wishItems![i].product.vendorId,
                                            paymentType: state.wishItems![i]
                                                    .product.paymentType ??
                                                "COD",
                                          ),
                                          if (i != state.wishItems!.length - 1)
                                            SizedBox(height: 16),
                                        ]
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
