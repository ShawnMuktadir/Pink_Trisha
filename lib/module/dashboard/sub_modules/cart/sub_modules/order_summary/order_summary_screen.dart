import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';

import '../../../../../../global/widget/global_button.dart';
import '../../../account/sub_modules/order_details/components/order_items.dart';
import '../../../account/sub_modules/order_details/components/order_payment.dart';
import '../../../account/sub_modules/order_details/components/order_shipping_address.dart';

class OrderSummeryScreen extends StatelessWidget {
  const OrderSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);
        return GlobalBackground(
          child: GlobalTopLoader(
            isLoading: state.isSSLLoading,
            text: "Payment loading...",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GlobalBackButton(title: "Order Summary"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          VerticalSpace(
                            height: 28.h,
                          ),
                          OrderItemsSection(
                            cartProducts: state.cartProducts,
                          ),
                          OrderShippingAddress(
                            shippingAddress: state.shippingAddress!,
                          ),
                          OrderPaymentTitle(
                            paymentType: state.paymentType,
                          ),
                          OrderPaymentSummary(
                            subtotal: state.subtotal.toString(),
                            paymentType: state.paymentType.name.toString(),
                            total: state.subtotal.toString(),
                            shippingCharge: state.discount.toString(),
                            discount: state.discount.toString(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 22,
                              right: 26,
                              bottom: 32,
                            ),
                            child: GlobalButton(
                              isLoading: state.isOrderCreateBtnLoading,
                              btnHeight: 44,
                              onPressed: () {
                                controller.reqCreateOrder(context);
                              },
                              buttonText: "Confirm Order",
                            ),
                          ),
                        ],
                      ),
                    ),
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
