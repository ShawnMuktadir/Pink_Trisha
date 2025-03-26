import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/controller/product_details_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/model/product_details_response.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class ProductVariantSection extends StatelessWidget {
  const ProductVariantSection({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productDetailsController(id).notifier);
        final state = ref.watch(productDetailsController(id));
        Map<int, List<ProductDetailsVariant>> groupedAttributes = {};
        final variants = state.productDetailsData?.productVariants;
        print("variants?.length ${variants?.length}");

        // Grouping variants by product attribute ID
        if (variants != null) {
          print("1");
          for (var variant in variants) {
            print("2");
            final productAttributeId = variant.attribute?.id;
            print("3 $productAttributeId");
            if (productAttributeId != null) {
              print("4");
              groupedAttributes.putIfAbsent(productAttributeId, () => []);
              print("5");
              groupedAttributes[productAttributeId]!.add(variant);
            }
          }
        }
        controller.totalVariants = groupedAttributes.length;
        print(
            "totalVariants ${controller.totalVariants} groupedAttributes ${groupedAttributes.length}");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (groupedAttributes.isNotEmpty)
              ...groupedAttributes.entries.map(
                (entry) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(
                      height: 14,
                    ),
                    GlobalText(
                      str: '${entry.value.first.attribute?.name ?? "Type"} : ',
                      color: KColor.deep2.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      // alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        ...entry.value
                            .map(
                              (attribute) => AttributeValueWidget(
                                label: attribute.name ?? '',
                                onTap: () {
                                  controller
                                      .toggleAttributes(SelectedAttributeModel(
                                    price: attribute.price,
                                    offerPrice: attribute.offerPrice,
                                    priceInUSD: 0,
                                    // priceInUSD: attribute.priceInUSD,
                                    offerPriceInUSD: 0,
                                    quantity: attribute.quantity,
                                    imageUrl: attribute.productImage?.src,
                                    attributeId: attribute.attribute!.id!,
                                    attributeValueId: attribute.id!,
                                    attributeName:
                                        attribute.attribute?.name ?? "",
                                    attributeValueName: attribute.name ?? "",
                                  ));
                                },
                                isSelected: state.currentAttributeValueId
                                    .where((element) =>
                                        attribute.id! ==
                                        element.attributeValueId)
                                    .toList()
                                    .isNotEmpty,
                              ),
                            )
                            .toList(),
                      ],
                    )
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class AttributeValueWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() onTap;

  const AttributeValueWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: ShapeDecoration(
              color: isSelected
                  ? const Color(0xFFF553B0)
                  : const Color(0xFFF1F0F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: isSelected
                      ? const Color(0x19000000)
                      : const Color(0x0AFF00B7),
                  blurRadius: 60,
                  offset: const Offset(0, 30),
                  spreadRadius: 5,
                )
              ],
            ),
            child: Center(
              child: GlobalText(
                str: label,
                textAlign: TextAlign.center,
                color: isSelected
                    ? const Color(0xFFFDFDFD)
                    : const Color(0xFF666465),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
