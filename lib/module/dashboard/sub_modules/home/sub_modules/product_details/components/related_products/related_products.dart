import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_product_card.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/product_list_response.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../../../../utils/app_routes.dart';
import '../../../../../../../../utils/navigation.dart';

class RelatedProducts extends StatefulWidget {
  const RelatedProducts(
      {super.key, required this.categoryId, required this.id});
  final int categoryId;
  final int id;
  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  void initState() {
    super.initState();
    // final controller =
    //     context.read(productDetailsController(widget.id).notifier);
    // Future(() {
    //   controller.getRelatedProductsResponse(categoryId: widget.categoryId);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller =
            ref.read(productDetailsController(widget.id).notifier);
        final state = ref.watch(productDetailsController(widget.id));
        return state.isRelatedProductsLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.relatedProducts.isEmpty
                ? SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 30, right: 20),
                    child: Column(
                      children: [
                        RelatedPorductsLabel(
                          categoryId: widget.categoryId,
                        ),
                        RelatedPorductsImages(
                            relatedProducts: state.relatedProducts)
                      ],
                    ),
                  );
      },
    );
  }
}

class RelatedPorductsImages extends StatelessWidget {
  const RelatedPorductsImages({super.key, required this.relatedProducts});
  final List<Product> relatedProducts;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: context.width,
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              // alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                relatedProducts.length,
                (index) {
                  final product = relatedProducts[index];
                  double paddingValue = 10;
                  return Container(
                    // width: context.width / 2,
                    padding: EdgeInsets.only(
                      right: index / 0 == 0 ? paddingValue : 0,
                      left: index / 0 != 0 ? paddingValue : 0,
                      bottom: 10,
                    ),
                    child: GlobalProductCard(
                      imageUrl: product.imageUrl,
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
                      isInStack:
                          product.quantity != null && product.quantity != 0,
                      currentAttributeValueId: [],
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }
}

class RelatedPorductsLabel extends StatelessWidget {
  final int categoryId;
  const RelatedPorductsLabel({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlobalText(
          str: 'Related Products',
          color: KColor.deep2.color,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 0.09,
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context)=> RelatedProductSeeAll(categoryId: categoryId,)));
            Navigation.push(context,
                appRoutes: AppRoutes.product,
                arguments: ScreenSourceData(sourceType: SourceType.all));
          },
          child: GlobalText(
            str: 'See All',
            color: KColor.deepPrimary.color,
            textAlign: TextAlign.right,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 0.11,
          ),
        )
      ],
    );
  }
}
