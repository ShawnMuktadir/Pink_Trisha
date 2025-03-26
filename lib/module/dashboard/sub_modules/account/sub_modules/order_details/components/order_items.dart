import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class OrderItemsSection extends StatelessWidget {
  const OrderItemsSection({super.key, required this.cartProducts});

  final List<CartProduct> cartProducts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 26),
      child: Column(
        children: [
          ...cartProducts
              .map((e) => OrderItemCard(
                    productName: e.name ?? "",
                    productImage: e.imageUrl ?? "",
                    productPrice: e.price == 0
                        ? e.offerPrice.toString()
                        : e.price.toString(),
                    productQuantity: e.quantity.toString(),
                    currentAttributeValueId: e.currentAttributeValueId,
                    productBorderColor: "",
                    productDetails: e.shortDescription ?? "",
                    attributes: e.attributes,
                    variants: e.variants,
                  ))
              .toList()
        ],
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final String productName;
  final String productDetails;
  final String? productImage;
  final String productPrice;
  final String productQuantity;
  final List<SelectedAttributeModel> currentAttributeValueId;
  final String productBorderColor;
  final List<String>? attributes;
  final List<String>? variants;

  const OrderItemCard({
    super.key,
    required this.productName,
    required this.productDetails,
    this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productBorderColor,
    required this.currentAttributeValueId,
    this.attributes,
    this.variants,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalContainer(
        //height: 164,
        padding:
            const EdgeInsets.only(top: 12, left: 12, right: 10, bottom: 16),
        borderCornerRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: GlobalImageLoader(
                  imageFor:
                      productImage == null ? ImageFor.asset : ImageFor.network,
                  imagePath:
                      productImage ?? KAssetName.icEmptyImage2png.imagePath),
            ),
            const HorizontalSpace(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: GlobalText(
                    str:
                        '$productName${productDetails.isNotEmpty ? "\n$productDetails" : ""}',
                    color: KColor.deep2.color,
                    fontSize: 16,
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
                const VerticalSpace(
                  height: 4,
                ),
                productPrice.isNotEmpty
                    ? Column(
                        children: [
                          Row(
                            children: [
                              GlobalText(
                                str: 'Price:',
                                color: KColor.deep4.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                              const HorizontalSpace(
                                width: 8,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'BDT',
                                      style: KTextStyle.customTextStyle(
                                        color: KColor.deep2.color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 0.10,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' $productPrice',
                                      style: KTextStyle.customTextStyle(
                                        color: KColor.deep2.color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        height: 0.09,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const VerticalSpace(
                            height: 4,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    GlobalText(
                      str: 'Quantity :',
                      color: KColor.deep4.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                    const HorizontalSpace(
                      width: 8,
                    ),
                    GlobalText(
                      str: productQuantity,
                      color: KColor.deep7.color,
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    )
                  ],
                ),
                const VerticalSpace(
                  height: 0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (attributes != null && variants != null)
                      ...List.generate(attributes!.length, (index) {
                        final attributeName = attributes?[index];
                        final attributeValueName = variants?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: GlobalText(
                            str: '${attributeName} : ${attributeValueName}',
                            color: KColor.deepGrey.color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        );
                      }).toList(),
                    ...currentAttributeValueId.map((data) => Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: GlobalText(
                            str:
                                '${data.attributeName} : ${data.attributeValueName}',
                            color: KColor.deepGrey.color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        )),

                    // const HorizontalSpace(
                    //   width: 20,
                    // ),
                    // GlobalText(
                    //   str: 'Color :',
                    //   color: KColor.deep2.color,
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w500,
                    //   height: 0.10,
                    // ),
                    // const HorizontalSpace(
                    //   width: 6,
                    // ),
                    // const BorderedEllipse()
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
