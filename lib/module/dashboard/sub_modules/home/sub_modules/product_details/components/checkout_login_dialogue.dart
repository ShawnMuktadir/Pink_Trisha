import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/global_double_circle.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../../../utils/app_routes.dart';
import '../../../../../../../utils/navigation.dart';

class CheckoutLoginDialogue extends StatelessWidget {
  const CheckoutLoginDialogue({
    super.key,
    /*required this.cartProduct*/
  });
  /*final CartProduct cartProduct;*/
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(cartController);
        final controller = ref.read(cartController.notifier);

        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigation.pop(context);
                    },
                    child: GlobalSvgLoader(
                        width: 24,
                        height: 24,
                        imagePath: KAssetName.icClosesvg.imagePath),
                  ),
                ),
                Column(
                  children: [
                    const VerticalSpace(
                      height: 20,
                    ),
                    const GlobalText(
                      str: 'Choose your Secure Checkout Method',
                      color: Color(0xFF2C2328),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                    const VerticalSpace(
                      height: 18,
                    ),
                    CheckoutLoginButtons(),
                    const VerticalSpace(
                      height: 12,
                    ),
                    const AuthTextFormField(
                        title: "Email",
                        hint: "Your Email",
                        textInputType: TextInputType.emailAddress),
                    const VerticalSpace(
                      height: 24,
                    ),
                    const GlobalText(
                      str:
                          'Your email address will be used only to send information about order  ',
                      color: Color(0xFF666465),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                    const VerticalSpace(
                      height: 24,
                    ),
                  ],
                ),
                GlobalButton(
                    onPressed: () {
                      Navigation.pushReplacement(context,
                          appRoutes: AppRoutes.signIn, arguments: true);
                      // controller.addToCartFromDetails(
                      //     cartProduct: cartProduct, context: context);
                    },
                    buttonText: "Checkout")
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckoutLoginButtons extends StatefulWidget {
  const CheckoutLoginButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutLoginButtons> createState() => _CheckoutLoginButtonsState();
}

class _CheckoutLoginButtonsState extends State<CheckoutLoginButtons> {
  bool isGuest = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleTextButton(
          circleColor: isGuest ? Color(0xFFC1C1C1) : KColor.deepPrimary.color,
          text: 'Sign in to checkout',
          textColor: Color(0xFF2F80ED),
          onTap: () {
            isGuest = false;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 16,
        ),
        CircleTextButton(
          circleColor: !isGuest ? Color(0xFFC1C1C1) : KColor.deepPrimary.color,
          text: 'Checkout as a Guest',
          textColor: Color(0xFF2F80ED),
          onTap: () {
            isGuest = true;
            setState(() {});
          },
        ),
      ],
    );
  }
}

class CircleTextButton extends StatelessWidget {
  final Color circleColor;
  final String text;
  final Color textColor;
  final void Function() onTap;
  const CircleTextButton({
    Key? key,
    required this.circleColor,
    required this.text,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          GlobalDoubleCircle(
            color: circleColor,
          ),
          HorizontalSpace(
            width: 6,
          ),
          GlobalText(
            str: text,
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 0.10,
          )
        ],
      ),
    );
  }
}
