import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/model/wish_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/product_details_screen.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import '../../module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';

class GlobalProductCard extends StatefulWidget {
  GlobalProductCard(
      {super.key,
      this.imageUrl,
      this.productImages,
      required this.title,
      required this.subTitle,
      required this.offerPrice,
      required this.price,
      required this.slug,
      required this.id,
      required this.loaderScreenType,
      required this.isPreorder,
      this.points,
      this.productImage,
      required this.quantity,
      required this.brandId,
      required this.categoryId,
      required this.vendorId,
      required this.paymentType,
      required this.isInStock,
      required this.currentAttributeValueId});

  final int id;
  final int? quantity;
  final int? brandId;
  final int categoryId;
  final int? vendorId;
  final String? imageUrl;
  final String paymentType;
  String? productImage;
  List<ProductImage>? productImages;
  final String slug;
  final String title;
  final String subTitle;
  final double offerPrice;
  final double price;
  int? points;
  final bool isPreorder;
  final bool isInStock;
  final LoaderScreenType loaderScreenType;
  final List<SelectedAttributeModel> currentAttributeValueId;

  @override
  State<GlobalProductCard> createState() => _GlobalProductCardState();
}

class _GlobalProductCardState extends State<GlobalProductCard> {
  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (widget.productImages != null && widget.productImages!.isNotEmpty) {
      imageUrl = widget.productImages![0]
          .src; // Accessing the imageUrl property from ProductImage
    } else if (widget.productImage != null) {
      imageUrl = widget.productImage!;
    }

    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final cartCon = context.read(cartController.notifier);
        final wishCon = ref.read(wishController.notifier);
        final wishState = ref.watch(wishController);
        final cartState = ref.watch(cartController);
        final isCartSelected = cartState.cartProducts
            .where((element) => element.slug == widget.slug)
            .isNotEmpty;
        final isWishSelected = wishCon.isSelected(widget.id);
        return GestureDetector(
          onTap: () {
            Navigation.push(context,
                appRoutes: AppRoutes.productDetails,
                arguments: ProductDetailsScreenModel(
                    slug: widget.slug, id: widget.id));
          },
          child: GlobalContainer(
              width: 156.w,
              borderRadius: 8.r,
              backgroundColor: KColor.card.color,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalContainer(
                      height: 134.h,
                      width: double.infinity,
                      padding: const EdgeInsets.all(0),
                      borderRadius: 6,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 10,
                              bottom: 10,
                              right: 10,
                              left: 10,
                              child: GlobalImageLoader(
                                  imageFor: imageUrl == null
                                      ? ImageFor.asset
                                      : ImageFor.network,
                                  imagePath: imageUrl ??
                                      KAssetName.icEmptyImage2png.imagePath)),
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StockStatusWidget(
                                  paymentType: widget.paymentType,
                                  quantity: widget.quantity ?? 0,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                widget.offerPrice != 0
                                    ? DiscountShow(
                                        saveTk: calculateSaveTk(
                                            widget.price, widget.offerPrice))
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  if (!isWishSelected) {
                                    wishCon.createWish(
                                        createWishData: CreateWishData(
                                            productId: widget.id),
                                        loaderScreenType:
                                            widget.loaderScreenType);
                                  } else {
                                    wishCon.deleteWish(
                                        id: widget.id,
                                        loaderScreenType:
                                            widget.loaderScreenType);
                                  }
                                  // isWishSelected = !isWishSelected;
                                  // setState(() {});
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        blurRadius: 40,
                                        offset: Offset(2, 8),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: GlobalSvgLoader(
                                        height: 16.h,
                                        width: 16.w,
                                        imagePath: isWishSelected
                                            ? KAssetName.icHeartRedsvg.imagePath
                                            : KAssetName
                                                .icHeartGreysvg.imagePath),
                                  ),
                                ),
                              )),
                        ],
                      )),
                  const VerticalSpace(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 43),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: widget.title ?? '',
                            maxLines: 1,
                            color: KColor.deep2.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          GlobalText(
                            str: widget.subTitle ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: KColor.deep2.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (widget.price != 0) ...[
                        GlobalText(
                          str: 'BDT ${widget.offerPrice}',
                          color: KColor.deepGrey.color,
                          fontSize: 14,
                          maxLines: 1,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          decoration: TextDecoration.lineThrough,
                          height: 0.10,
                        ),
                        const HorizontalSpace(
                          width: 8,
                        ),
                      ],
                      GlobalText(
                        textAlign: TextAlign.center,
                        str:
                            'BDT ${widget.price != 0 ? widget.price : widget.offerPrice ?? "0"}',
                        color: KColor.deep2.color,
                        fontSize: 16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                      ),
                    ],
                  ),
                  VerticalSpace(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 87,
                        // height: 16,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0x66F553B0)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: widget.points != null
                            ? GlobalText(
                                str: 'Club Point ${widget.points}',
                                color: const Color(0xFF2C2328),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.16,
                              )
                            : SizedBox(),
                      ),
                      Container(
                        width: 24,
                        height: 24,
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
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              cartCon.toggleCartButton(CartProduct(
                                  id: widget.id.toString(),
                                  name: widget.title,
                                  slug: widget.slug,
                                  shortDescription: widget.subTitle,
                                  imageUrl: imageUrl,
                                  price: widget.price,
                                  offerPrice: widget.offerPrice,
                                  productImage: '',
                                  isPreorder: widget.isPreorder,
                                  quantity: 1,
                                  brandId: widget.brandId,
                                  categoryId: widget.categoryId,
                                  vendorId: widget.vendorId,
                                  paymentType: widget.paymentType,
                                  currentAttributeValueId:
                                      widget.currentAttributeValueId,
                                  nameBn: ''));
                            },
                            child: GlobalSvgLoader(
                                height: 40.h,
                                width: 40.w,
                                imagePath: isCartSelected
                                    ? KAssetName
                                        .icCartButtonSelectedsvg.imagePath
                                    : KAssetName
                                        .icCartButtonUnselectedsvg.imagePath),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}

int calculateSaveTk(dynamic originalPrice, dynamic discountedPrice) {
  // if (originalPrice <= 0 || discountedPrice <= 0) {
  //   throw ArgumentError('Prices must be greater than zero.');
  // }

  // Calculate discount
  dynamic discount = discountedPrice - originalPrice;

  // Convert discount to integer
  int discountInt = discount.toInt();

  return discountInt;
}

int calculateDiscountPercent(dynamic originalPrice, dynamic discountedPrice) {
  if (originalPrice <= 0 || discountedPrice <= 0) {
    throw ArgumentError('Prices must be greater than zero.');
  }

  // Calculate discount percentage
  dynamic discount = discountedPrice - originalPrice;
  dynamic discountPercent = (discount / originalPrice * 100).round();

  return discountPercent;
}

class InStockShow extends StatelessWidget {
  const InStockShow({super.key, required this.isInStock});

  final bool isInStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      height: 17.03,
      decoration: ShapeDecoration(
        color: KColor.primary.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: GlobalText(
          str: isInStock ? 'In stock' : 'Out of stock',
          textAlign: TextAlign.center,
          color: Colors.white,
          fontSize: 8,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
          height: 0.23,
        ),
      ),
    );
  }
}

class PreorderShow extends StatelessWidget {
  const PreorderShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 17.03,
      decoration: ShapeDecoration(
        color: KColor.primary.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: const Center(
        child: GlobalText(
          str: 'Pre Order',
          textAlign: TextAlign.center,
          color: Colors.white,
          fontSize: 8,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
          height: 0.23,
        ),
      ),
    );
  }
}

class DiscountShow extends StatelessWidget {
  const DiscountShow({super.key, required this.saveTk});

  final int saveTk;

  @override
  Widget build(BuildContext context) {
    // icSaveMoneyBadge
    return Stack(
      children: [
        GlobalImageLoader(
          imagePath: KAssetName.saveMoneyBadgepng.imagePath,
          width: 88,
          height: 24,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          top: 5.5,
          bottom: 4,
          right: 0,
          left: 19,
          child: SizedBox(
            width: 60,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: 'Save $saveTk TK',
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  fontSize: 7,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  height: 0.23,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StockStatusWidget extends StatelessWidget {
  final String paymentType;
  final int quantity;

  const StockStatusWidget({
    super.key,
    required this.paymentType,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    if (paymentType == "DVP") {
      return const PreorderShow(); // Pre Order
    } else if (quantity > 0 && paymentType != "DVP") {
      return const InStockShow(isInStock: true); // In Stock
    } else if (quantity == 0 && paymentType != "DVP") {
      return const InStockShow(isInStock: false); // Out of Stock
    } else {
      return const SizedBox(); // Default fallback (optional)
    }
  }
}

class SaveAmountWidget extends StatelessWidget {
  final double price;
  final double offerPrice;

  const SaveAmountWidget({
    super.key,
    required this.price,
    required this.offerPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (price > 0 && offerPrice > price) {
      final savings = offerPrice - price;
      return Text(
        'Save ৳${savings.toStringAsFixed(0)}',
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }
    return const SizedBox.shrink(); // empty widget
  }
}
