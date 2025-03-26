import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class HomeReviewPrice extends StatelessWidget {
  const HomeReviewPrice({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(homeController);
        final controller = ref.read(homeController.notifier);

        return Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                str: 'Estimated Price Breakdown',
                color: KColor.deep2.color,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0.09,
              ),
              const VerticalSpace(
                height: 16,
              ),
              GlobalText(
                str: 'Item Price',
                color: KColor.deep2.color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 0.10,
              ),
              const VerticalSpace(
                height: 4,
              ),
              const GlobalText(
                str: '(Including  10% tax)',
                color: Color(0xFF666465),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
              SingleBorderTextField(controller: state.itemPriceCon),
              const VerticalSpace(),
              GlobalText(
                str: 'Shipping Fee',
                color: KColor.deep2.color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 0.10,
              ),
              SingleBorderTextField(controller: state.sellerShippingFeeCon),
              const VerticalSpace(),
              GlobalText(
                str: 'Total Price',
                color: KColor.deep2.color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 0.10,
              ),
              SingleBorderTextField(controller: state.totalPriceCon),
              const VerticalSpace(
                height: 24,
              ),
              GlobalButton(
                  isLoading: state.isReviewBtnLoading,
                  onPressed: () {
                    state.reviewPriceResponse == null
                        ? controller.reqHomeReviewPrice()
                        : StorageController.isLoggedIn
                            ? controller.reqHomeReviewPriceConfirmation()
                            : Navigation.push(context,
                                appRoutes: ViewUtil.showLoginDialog(
                                    subtitle:
                                        "You need to login for request an order."));
                  },
                  buttonText: state.reviewPriceResponse == null
                      ? "Review Price"
                      : "Request Order"),
            ],
          ),
        );
      },
    );
  }
}

class SingleBorderTextField extends StatelessWidget {
  const SingleBorderTextField({super.key, this.hint, required this.controller});
  final String? hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.yellow,
      width: double.infinity,
      height: 30,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFD9D0DA),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFD9D0DA),
            ),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
