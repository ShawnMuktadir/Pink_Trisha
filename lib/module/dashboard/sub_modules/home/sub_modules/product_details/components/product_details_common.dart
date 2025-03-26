import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/components/product_variants_section.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/product_details_response.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class ProductDetailsCommon extends StatelessWidget {
  const ProductDetailsCommon({
    super.key,
    required this.title,
    required this.offerPrice,
    required this.price,
    required this.productVariants,
    required this.id,
    required this.stackQty,
    // required this.shades,
    // required this.colors
  });

  final int id;
  final int stackQty;
  final String title;
  final dynamic offerPrice;
  final dynamic price;
  final List<ProductDetailsVariant> productVariants;

  // final List<ProductVariant> colors;
  // final List<ProductVariant> shades;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productDetailsController(id).notifier);
        final state = ref.watch(productDetailsController(id));
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 266,
                child: GlobalText(
                  str: title,
                  color: KColor.deep2.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
              VerticalSpace(
                height: 16.h,
              ),
              GlobalText(
                str: 'In stock ($stackQty)',
                color: KColor.blue.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.07,
              ),
              VerticalSpace(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalText(
                    str: 'BDT${price != 0 ? price : offerPrice}',
                    color: KColor.deepPrimary.color,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 0.06,
                  ),
                  HorizontalSpace(
                    width: 10.w,
                  ),
                  if (price != 0)
                    GlobalText(
                      str: 'BDT${offerPrice} ',
                      color: KColor.grey2.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      height: 0.09,
                    ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
              ProductVariantSection(
                id: id,
              ),
              ProductQuantitySection(
                maxQuantity: 20,
                id: id,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductQuantitySection extends StatefulWidget {
  final int maxQuantity;
  final int id;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const ProductQuantitySection(
      {super.key,
      required this.maxQuantity,
      this.height,
      this.width,
      this.padding,
      required this.id});

  @override
  State<ProductQuantitySection> createState() => _ProductQuantitySectionState();
}

class _ProductQuantitySectionState extends State<ProductQuantitySection> {
  // int quantity = 1; // Initial quantity

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller =
            ref.read(productDetailsController(widget.id).notifier);
        final state = ref.watch(productDetailsController(widget.id));
        return Container(
          height: widget.height,
          width: widget.width,
          padding: widget.padding ?? const EdgeInsets.only(top: 16, bottom: 38),
          child: Row(
            children: [
              const GlobalText(
                str: 'Quantity :   ',
                color: Color(0xFF2C2328),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 0.09,
              ),
              const HorizontalSpace(
                width: 15,
              ),
              Container(
                width: 106,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFC1C1C1)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        //    color: Colors.yellow,
                        color: Colors.white,
                        child: InkWell(
                          onTap: controller.decrementQuantity,
                          child: GlobalSvgLoader(
                              //    width: 21.82,
                              //      height: 21.82,
                              imagePath:
                                  KAssetName.icProductMinussvg.imagePath),
                        ),
                      ),
                      GlobalText(
                        str: state.currentProductQuantity.toString(),
                        // Display the current quantity
                        color: const Color(0xFF0D0D0D),
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                      ),
                      Material(
                        //    color: Colors.yellow,
                        color: Colors.white,
                        child: InkWell(
                          onTap: controller.incrementQuantity,
                          child: GlobalSvgLoader(
                              //width: 21.82,
                              //  height: 21.82,
                              imagePath: KAssetName.icProductPlussvg.imagePath),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
