import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/bordered_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/controller/signup_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/styles/k_text_style.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../utils/navigation.dart';

class BorderedWhiteButton extends StatelessWidget {
  const BorderedWhiteButton(
      {super.key, required this.title, required this.svgPath});

  final String title;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlobalSvgLoader(imagePath: svgPath),
        const HorizontalSpace(width: 8),
        GlobalText(
          str: title,
          color: KColor.deep2.color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 0.10,
        ),
      ],
    ));
  }
}

class CoupleTextButton extends StatelessWidget {
  final String firstText;
  final String secondText;

  const CoupleTextButton(
      {super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: KTextStyle.customTextStyle(
              color: KColor.deepGrey.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
          TextSpan(
            text: ' ',
            style: KTextStyle.customTextStyle(
              color: KColor.deep2.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
          TextSpan(
            text: secondText,
            style: KTextStyle.customTextStyle(
              color: KColor.midPrimary.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.10,
            ),
          ),
        ],
      ),
    );
  }
}

class TermsAndPrivacyButton extends StatelessWidget {
  const TermsAndPrivacyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(cartController.notifier);
        final state = ref.watch(cartController);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                  value: state.isAcceptedTAP,
                  activeColor: KColor.deepPrimary.color, // Color when checked
                  checkColor: Colors.white, // Checkmark color
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return KColor.deepPrimary.color; // Background when checked
                      }
                      return Colors.white10; // Background when unchecked
                    },
                  ),
                  onChanged: (value) {
                    controller.setTermsAndPrivacyPolicy(value ?? false);
                  }),
            ),
            const HorizontalSpace(
              width: 8,
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'I accepted',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep3.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.08,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep3.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms & Conditions,',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deepPrimary.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigation.push(context,
                              appRoutes: AppRoutes.termsAndCondition);
                        },
                    ),
                    TextSpan(
                      text: ' ',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep3.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy & Policy, ',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deepPrimary.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigation.push(context,
                              appRoutes: AppRoutes.privacyPolicy);
                        },
                    ),
                    TextSpan(
                      text: ' ',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep3.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: 'Return & Policy',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deepPrimary.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigation.push(context,
                              appRoutes: AppRoutes.returnPolicy);
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class SignUpTermsAndPrivacyButton extends StatefulWidget {
  const SignUpTermsAndPrivacyButton({super.key});

  @override
  State<SignUpTermsAndPrivacyButton> createState() =>
      _SignUpTermsAndPrivacyButtonState();
}

class _SignUpTermsAndPrivacyButtonState
    extends State<SignUpTermsAndPrivacyButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(signUpController.notifier);
        final state = ref.watch(signUpController);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                  value: controller.isSelect,
                  onChanged: (value) {
                    setState(() {
                      controller.isSelect = value!;
                      print('Check: ${controller.isSelect}');
                      // print('Check: ${value}');
                    });
                  }),
            ),
            const HorizontalSpace(
              width: 8,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'I accepted',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deep3.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.08,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deep3.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms & Privacy Policy',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deepPrimary.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
