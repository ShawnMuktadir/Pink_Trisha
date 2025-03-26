import 'package:flutter/material.dart';
import '../../../../../global/widget/global_empty.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1, // <-- Added this line
      child: Center(
        // <-- Wrapped with Center widget
        child: GlobalEmpty(
            title: "Your Cart is Empty",
            subTitle: "Add product to your cart & enjoy shopping with us"),
      ),
    );
  }
}
