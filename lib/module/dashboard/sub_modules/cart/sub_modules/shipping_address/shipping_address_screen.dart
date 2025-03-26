import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../../global/widget/global_button.dart';
import 'components/billing_address_button.dart';
import 'components/checkbox_billing_address.dart';
import 'components/shipping_address_button.dart';
import 'components/shipping_home_address.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, widget) {
      final controller = ref.read(cartController.notifier);
      final state = ref.watch(allAddressController);
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: context.width,
            constraints: BoxConstraints(
              minHeight: context.height,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  KColor.homeGradientStart.color,
                  KColor.homeGradientEnd.color,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const GlobalBackButton(title: "Shipping Address"),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ShippingHomeAddress(),
                            const ShippingAddressButton(),
                            const CheckBillingAddress(),
                            const BillinAddressButton(),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 40),
                              child: GlobalButton(
                                onPressed: () {
                                  controller.setShippingAddress(
                                      addressData: state.addressList.first,
                                      context: context);
                                  // Navigation.pop(context);
                                },
                                buttonText: "Continue",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
