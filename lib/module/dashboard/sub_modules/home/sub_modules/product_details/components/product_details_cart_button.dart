import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/model/wish_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class ProductDetailsCartButton extends StatefulWidget {
  const ProductDetailsCartButton(
      {super.key, required this.cartProduct, required this.isHeartSelected});
  final CartProduct cartProduct;
  final bool isHeartSelected;

  @override
  State<ProductDetailsCartButton> createState() =>
      _ProductDetailsCartButtonState();
}

class _ProductDetailsCartButtonState extends State<ProductDetailsCartButton> {
  // bool isHSelected = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);

        final isCartSelected = state.cartProducts
            .where((element) => element.slug == (widget.cartProduct.slug ?? ""))
            .isNotEmpty;
        // final state = ref.watch(cartController);
        final productId = int.parse(widget.cartProduct.id);
        final detailsController =
            ref.read(productDetailsController(productId).notifier);
        final detailsState = ref.watch(productDetailsController(productId));
        final wishCon = ref.read(wishController.notifier);
        // final isWishSelected = wishCon.isSelected(productId);
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            width: 375,
            height: 68,
            decoration: const BoxDecoration(color: Color(0xFFFBFBFF)),
            padding: const EdgeInsets.only(
                top: 12.16, left: 24, right: 24, bottom: 11.84),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // isHSelected = !isHSelected;
                    // setState(() {});
                    if (!widget.isHeartSelected) {
                      wishCon.createWish(
                          loaderScreenType: LoaderScreenType.productDetails,
                          createWishData: CreateWishData(
                              // customerId: int.parse(PrefHelper.getString(
                              //     AppConstant.USER_ID.key)),
                              productId: productId));
                    } else {
                      wishCon.deleteWish(
                          id: productId,
                          loaderScreenType: LoaderScreenType.productDetails);
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEEF3F7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Center(
                      child: GlobalSvgLoader(
                          width: 32.36,
                          height: 32.36,
                          imagePath: widget.isHeartSelected
                              ? KAssetName.icHeartRedsvg.imagePath
                              : KAssetName.icHeartGreysvg.imagePath),
                    ),
                  ),
                ),
                const HorizontalSpace(
                  width: 16,
                ),
                Expanded(
                  child: GlobalButton(
                    onPressed: () {
                      if (detailsController.totalVariants !=
                          detailsState.currentAttributeValueId.length) {
                        ViewUtil.SSLSnackbar("Please select all variants.");
                      } else if (isCartSelected) {
                        StorageController.isLoggedIn
                            ? Navigation.push(context,
                                appRoutes: AppRoutes.shippingAddress)
                            : Navigation.push(context,
                                appRoutes: AppRoutes.signIn, arguments: true);
                        // : showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const CheckoutLoginDialogue();
                        //     },
                        //   );
                      } else {
                        print(
                            "get 6 ${widget.cartProduct.name} ${widget.cartProduct.currentAttributeValueId}");
                        controller.toggleCartButton(widget.cartProduct);
                      }
                    },
                    buttonText: isCartSelected ? "Checkout" : "Add to Cart",
                    //isCartSelected ? "Cancel from Cart" : "Add to Cart",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
