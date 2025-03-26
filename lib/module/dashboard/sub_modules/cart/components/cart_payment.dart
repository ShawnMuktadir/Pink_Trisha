import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';

import '../../../../../global/widget/global_space.dart';
import '../../../../../global/widget/global_text.dart';
import '../../../../../utils/styles/k_colors.dart';
import '../../../../../utils/styles/k_text_style.dart';

class CartPaymentSummary extends StatelessWidget {
  const CartPaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final state = ref.watch(cartController);

        return Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Container(
            decoration: ShapeDecoration(
              // color: const Color(0xFFFBFBFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: .5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFC1C1C1),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: 'Sub Total ',
                          color: KColor.deep2.color,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.09,
                        ),
                        const VerticalSpace(
                          height: 10,
                        ),
                        GlobalText(
                          str: 'Discount ',
                          color: KColor.deep3.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.09,
                        ),
                        const VerticalSpace(
                          height: 10,
                        ),
                        // GlobalText(
                        //   str: 'Shipping Charge ',
                        //   color: KColor.deep3.color,
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w400,
                        //   height: 0.09,
                        // ),
                      ],
                    ),
                    const HorizontalSpace(
                      width: 27,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'BDT ',
                                style: KTextStyle.customTextStyle(
                                  color: KColor.deep2.color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0.09,
                                ),
                              ),
                              TextSpan(
                                text: state.subtotal.toString(),
                                style: KTextStyle.customTextStyle(
                                  color: KColor.deep2.color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0.09,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const VerticalSpace(
                          height: 10,
                        ),
                        GlobalText(
                          str: 'BDT ${state.discount.toString()}',
                          textAlign: TextAlign.right,
                          color: KColor.deep3.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                        const VerticalSpace(
                          height: 10,
                        ),
                        // GlobalText(
                        //   str: 'BDT ${state.shippingFee.toString()}',
                        //   textAlign: TextAlign.right,
                        //   color: KColor.deep3.color,
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w500,
                        //   height: 0.09,
                        // ),
                        // const VerticalSpace(
                        //   height: 10,
                        // ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GlobalText(
                    str: '* Delivery charge will be added later.',
                    color: KColor.deep3.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 16),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: .5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFC1C1C1),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GlobalText(
                      str: 'Total ',
                      color: KColor.deep2.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                    const HorizontalSpace(
                      width: 22,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'BDT',
                            style: KTextStyle.customTextStyle(
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                            ),
                          ),
                          TextSpan(
                            text: ' ${state.subtotal.toString()}',
                            style: KTextStyle.customTextStyle(
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 0.09,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
