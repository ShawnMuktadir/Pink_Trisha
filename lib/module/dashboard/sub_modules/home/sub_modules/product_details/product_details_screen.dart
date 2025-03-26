import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_cart_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_common.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_image.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_details_slip.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/related_products/related_products.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

class ProductDetailsScreenModel {
  final String slug;
  final int id;

  ProductDetailsScreenModel({required this.slug, required this.id});
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(this.productDetailsScreenModel, {super.key});
  final ProductDetailsScreenModel productDetailsScreenModel;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late int pid;
  late String slug;
  @override
  void initState() {
    pid = widget.productDetailsScreenModel.id;
    slug = widget.productDetailsScreenModel.slug;
    super.initState();
    final controller = context.read(productDetailsController(pid).notifier);
    Future(() {
      controller.getProductDetailsResponse(slug: slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        print("_ProductDetailsScreenState called");

        final controller = ref.read(productDetailsController(pid).notifier);
        final state = ref.watch(productDetailsController(pid));
        final wishCon = ref.read(wishController.notifier);
        final productId = state.productDetailsData?.id;
        final wishState = ref.watch(wishController);
        final isWishSelected = wishState.wishProductIds
            .where((element) => productId == element)
            .isNotEmpty;
        // wishCon.isSelected(state.productDetailsData!.id!);
        print("check wish state of selection is : $isWishSelected ");
        return GlobalBackground(
          child: GlobalTopLoader(
            isLoading:
                wishState.loaderScreenType == LoaderScreenType.productDetails,
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.productDetailsData == null
                    ? const Center(
                        child: GlobalText(str: "Something went wrong..."),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          Future(() {
                            controller.getProductDetailsResponse(slug: slug);
                          });
                        },
                        child: SingleChildScrollView(
                          controller: state.scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageSwiper(
                                id: pid,
                              ),
                              // ProductDetailsImage(
                              //     images:
                              //         state.productDetailsData?.productImages,
                              //     discount: 20),
                              RoundedWhiteBackground(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductDetailsCommon(
                                    title: state.productDetailsData?.name ?? "",
                                    offerPrice: state
                                            .variantArgument?.offerPrice ??
                                        state.productDetailsData?.offerPrice ??
                                        0,
                                    price: state.variantArgument?.price ??
                                        state.productDetailsData?.price ??
                                        0,
                                    productVariants: state.productDetailsData
                                            ?.productVariants ??
                                        [],
                                    id: pid,
                                    stackQty: state.variantArgument?.quantity ??
                                        state.productDetailsData?.quantity ??
                                        0,
                                  ),

                                  // const ProductDetailsExtras(),
                                  //const PaymentOptions(),
                                  ProductDetailsCartButton(
                                    cartProduct: CartProduct(
                                        id: state.productDetailsData!.id!
                                            .toString(),
                                        name: state.productDetailsData?.name ??
                                            "",
                                        slug: slug,
                                        shortDescription: state
                                            .productDetailsData
                                            ?.shortDescription,
                                        imageUrl:
                                            state.productDetailsData?.imageUrl,
                                        price: state.variantArgument?.price ??
                                            state.productDetailsData?.price,
                                        offerPrice:
                                            state.variantArgument?.offerPrice ??
                                                state.productDetailsData
                                                    ?.offerPrice,
                                        productImage: state
                                                .variantArgument?.imageUrl ??
                                            state.productDetailsData?.imageUrl,
                                        quantity: state.currentProductQuantity,
                                        brandId: null,
                                        categoryId: state
                                            .productDetailsData!.category!.id!,
                                        vendorId: null,
                                        paymentType: state
                                            .productDetailsData!.paymentType,
                                        currentAttributeValueId:
                                            state.currentAttributeValueId,
                                        isPreorder:
                                            state.productDetailsData!.paymentType ==
                                                "DVP",
                                        nameBn: ''),
                                    isHeartSelected: isWishSelected,
                                  ),

                                  ProductDetailsSlip(
                                    detailsDescription: state.productDetailsData
                                            ?.longDescription ??
                                        " ",
                                    warrantyDescription: state
                                            .productDetailsData
                                            ?.productWarranty ??
                                        " ",
                                    returnPolicyDescription: state
                                            .productDetailsData
                                            ?.productReturnPolicy ??
                                        " ",
                                    id: pid,
                                  ),
                                  state.productDetailsData?.category?.id == null
                                      ? const SizedBox.shrink()
                                      : RelatedProducts(
                                          categoryId: state.productDetailsData
                                                  ?.category?.id ??
                                              1,
                                          id: pid,
                                        ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}

class RoundedWhiteBackground extends StatelessWidget {
  const RoundedWhiteBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        width: context.width,
        constraints: BoxConstraints(
          minHeight: context.height,
        ),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
