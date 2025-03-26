import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/components/cart_empty_widget.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../global/widget/global_back_button.dart';
import '../../../../global/widget/global_button.dart';
import '../../../../global/widget/global_space.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/navigation.dart';
import 'components/cart_item_list.dart';
import 'components/cart_payment.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(cartController);
        final addressState = ref.watch(allAddressController);

        return Scaffold(
          resizeToAvoidBottomInset: false,
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
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        GlobalBackButton(
                          title: "My Cart",
                          onTap: () {
                            final controller =
                                ref.read(dashboardController.notifier);
                            controller.onOptionChange(0);
                          },
                        ),
                        VerticalSpace(
                          height: 20.h,
                        ),
                        state.cartProducts.isEmpty
                            ? const CartEmptyWidget()
                            : Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CartItemList(
                                        productList: state.cartProducts,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const CartPaymentSummary(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 38, vertical: 30),
                                          child: GlobalButton(
                                              //    btnHeight: 44,
                                              onPressed: () {
                                                StorageController.isLoggedIn
                                                    ? addressState
                                                            .addressList.isEmpty
                                                        ? Navigation.push(
                                                            context,
                                                            appRoutes: AppRoutes
                                                                .createAddress,
                                                            arguments: true)
                                                        : Navigation.push(
                                                            context,
                                                            appRoutes: AppRoutes
                                                                .shippingAddress)
                                                    : Navigation.push(context,
                                                        appRoutes:
                                                            AppRoutes.signIn,
                                                        arguments: true);
                                              },
                                              buttonText: "Checkout"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
