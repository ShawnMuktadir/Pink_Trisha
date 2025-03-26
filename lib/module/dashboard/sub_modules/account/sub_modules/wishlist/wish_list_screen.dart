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
                        //    flex: 1,
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
                                        ...state.wishItems!
                                            .map((e) => WishCard(
                                                imagePath:
                                                    e.product.productImages !=
                                                                null &&
                                                            e
                                                                .product
                                                                .productImages!
                                                                .isNotEmpty
                                                        ? e
                                                            .product
                                                            .productImages!
                                                            .first
                                                            .src
                                                        : null,
                                                onTap: () {
                                                  controller.deleteWish(
                                                      id: e.product.id!,
                                                      loaderScreenType:
                                                          LoaderScreenType
                                                              .wishList);
                                                },
                                                name: e.product.name ?? "",
                                                details:
                                                    e.product.shortDescription ??
                                                        "",
                                                slug: e.product.slug!,
                                                price:
                                                    e.product.price.toString(),
                                                offerPrice: e.product.offerPrice
                                                    .toString(),
                                                id: e.product.id!,
                                                isPreorder:
                                                    e.product.paymentType ==
                                                        "DVP",
                                                brandId: e.product.brandId,
                                                categoryId:
                                                    e.product.categoryId,
                                                vendorId: e.product.vendorId,
                                                paymentType:
                                                    e.product.paymentType ??
                                                        "COD"))
                                            .toList(),
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
