import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/cart_product.dart';
import 'global_cart_item.dart';

class CartItemList extends StatefulWidget {
  const CartItemList({super.key, required this.productList});

  final List<CartProduct> productList;

  @override
  State<CartItemList> createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.productList.length,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          final product = widget.productList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: GlobalCartItem(
              imgPath: product.imageUrl ?? "",
              titleText: product.name ?? "",
              availableProduct:
                  product.quantity != 0 ? 'In stock' : 'Out of stock',
              price: product.price == 0
                  ? product.offerPrice.toString()
                  : product.price.toString(),
              slug: product.slug ?? "",
              quantity: product.quantity,
              paymentType: product.paymentType,
              onDeleteButtonTap: () {},
              variants: product.currentAttributeValueId,
            ),
          );
        });
  }
}
