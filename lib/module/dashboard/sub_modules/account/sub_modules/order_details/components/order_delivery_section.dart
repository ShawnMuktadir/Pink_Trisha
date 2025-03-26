import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_delivery_flow.dart';
import 'package:pink_by_trisha_app/utils/date_util.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class OrderDeliverySection extends StatelessWidget {
  const OrderDeliverySection(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.date});
  final String orderId;
  final String orderStatus;
  final DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 26, left: 22),
      child: GlobalContainer(
          width: double.infinity,
          borderCornerRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: OrderDetailsText(
                    orderId: orderId,
                    orderStatus: orderStatus,
                    date: date,
                  )),
              // OrderDeliveryFlow(
              //   orderStatus: orderStatus,
              // ),
            ],
          )),
    );
  }
}

class OrderDetailsText extends StatelessWidget {
  const OrderDetailsText(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.date});
  final String orderId;
  final String orderStatus;
  final DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Order ID:',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deepGrey.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                  TextSpan(
                    text: ' #$orderId',
                    style: KTextStyle.customTextStyle(
                      color: KColor.deep2.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const VerticalSpace(
          height: 6,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Status:',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deepGrey.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: KTextStyle.customTextStyle(
                        color: KColor.deep2.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                    TextSpan(
                      text: orderStatus,
                      style: KTextStyle.customTextStyle(
                        color: KColor.deepPrimary.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(
                height: 8,
              ),
              date == null
                  ? SizedBox.shrink()
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date: ',
                            style: KTextStyle.customTextStyle(
                              color: KColor.deepGrey.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          TextSpan(
                            text: DateUtil.dateFormattingDMYWithSlash(date!),
                            //text: DateUtil.dateFormattingDMYWithSlash(date),
                            style: KTextStyle.customTextStyle(
                              color: KColor.deep2.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
