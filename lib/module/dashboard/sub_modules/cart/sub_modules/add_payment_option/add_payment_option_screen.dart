import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';

import 'package:pink_by_trisha_app/utils/extension.dart';

import '../../../../../../global/widget/global_button.dart';
import '../../../../../../utils/app_routes.dart';
import '../../../../../../utils/navigation.dart';
import '../../../../../authentication/sign_in/views/components/buttons.dart';
import 'components/payment_button.dart';

class AddPaymentOptionScreen extends StatefulWidget {
  const AddPaymentOptionScreen({super.key});

  @override
  State<AddPaymentOptionScreen> createState() => _AddPaymentOptionScreenState();
}

class _AddPaymentOptionScreenState extends State<AddPaymentOptionScreen> {
  bool isPayOnline = false; // Switch State

  @override
  void dispose() {
    final controller =
        Navigation.key.currentContext!.read(cartController.notifier);
    Future(() {
      controller.clearPayments();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);
        return Builder(builder: (context) {
          final hasPreorder = state.cartProducts
              .where((element) => element.isPreorder == true)
              .toList()
              .isNotEmpty;
          List<PaymentType> currentPaymentTypes = List.from(paymentTypes);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: GlobalBackground(
                child: Column(
                  children: [
                    const GlobalBackButton(title: "Add Payment Option"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 24, right: 24, bottom: 62),
                        child: Column(
                          children: [
                            ...currentPaymentTypes
                                .map(
                                  (e) => PaymentButtonScreen(
                                    isSelected:
                                        e.index == state.paymentType.index,
                                    iconName: e.imageLink ?? "",
                                    title: e.title?? "",
                                    onTap: () {
                                      controller.setPaymentTypeIndex(e);
                                    },
                                  ),
                                )
                                .toList(),
                            VerticalSpace(
                              height: 18.h,
                            ),
                            const TermsAndPrivacyButton(),
                            Expanded(child: Container()),
                            GlobalButton(
                              btnHeight: 44,
                              onPressed: () {
                                if (!state.isAcceptedTAP) {
                                  // Show SnackBar if checkbox is not checked
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Please agree to the terms and conditions before proceeding"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  // Navigate only if checkbox is checked
                                  Navigation.push(context,
                                      appRoutes: AppRoutes.orderSummery);
                                }
                              },
                              buttonText: "Continue",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
