import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/model/payment_type.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/styles/k_text_style.dart';

class OrderPaymentTitle extends StatelessWidget {
  const OrderPaymentTitle({super.key, required this.paymentType});

  final PaymentType? paymentType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 26, left: 22, bottom: 16),
      child: GlobalContainer(
          backgroundColor: KColor.card.color,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16, left: 16, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                str: 'Payment Method',
                color: KColor.deep2.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.07,
              ),
              const VerticalSpace(
                height: 13,
              ),
              paymentType!.imageLink != null
                  ? GlobalImageLoader(
                      imagePath: paymentType!.imageLink!,
                    )
                  : paymentType!.imageLink != null
                      ? GlobalImageLoader(
                          imagePath: paymentType!.imageLink!,
                          width: 94,
                          height: 42,
                        )
                      : GlobalText(
                          str: paymentType!.title ?? "",
                          color: KColor.deep2.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
            ],
          )),
    );
  }
}

class OrderPaymentSummary extends StatelessWidget {
  const OrderPaymentSummary(
      {super.key,
      required this.subtotal,
      this.paymentType,
      required this.total,
      required this.shippingCharge,
      required this.discount});

  final String subtotal;
  final String? paymentType;
  final String total;
  final String shippingCharge;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 32,
      ),
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFFBFBFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GlobalText(
                  str: 'Total Summary',
                  color: KColor.deep2.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 13,
                bottom: 11,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                      const VerticalSpace(
                        height: 10,
                      ),
                      GlobalText(
                        str: 'Shipping Charge ',
                        color: KColor.deep3.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                      const VerticalSpace(
                        height: 10,
                      ),
                    ],
                  ),
                  // HorizontalSpace(
                  //   width: 10,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text.rich(
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
                                text: subtotal,
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
                      ),
                      const VerticalSpace(
                        height: 10,
                      ),
                      GlobalText(
                        str: 'BDT $discount',
                        textAlign: TextAlign.right,
                        color: KColor.deep3.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                      const VerticalSpace(
                        height: 10,
                      ),
                      GlobalText(
                        str: 'BDT $shippingCharge',
                        textAlign: TextAlign.right,
                        color: KColor.deep3.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                      const VerticalSpace(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 15,
              ),
              child: Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFC1C1C1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 127,
                right: 36,
                bottom: 37,
              ),
              child: Row(
                children: [
                  GlobalText(
                    str: 'Total ',
                    color: KColor.deep2.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                  Expanded(
                    child: Text.rich(
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
                            text: total,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
