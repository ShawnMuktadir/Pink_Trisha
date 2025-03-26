import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/delivery_date.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/ellipse_list.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/components/order_line.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class OrderDeliveryFlow extends StatelessWidget {
  const OrderDeliveryFlow({super.key, required this.orderStatus});
  final String orderStatus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 33),
      child: Column(
        children: [
          const EllipseList(),
          const VerticalSpace(
            height: 10,
          ),
          const OrderLine(),
          const VerticalSpace(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlobalText(
                str: 'On\nProcess',
                textAlign: TextAlign.center,
                color: KColor.deep2.color,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              const SizedBox(width: 33),
              SizedBox(
                child: GlobalText(
                  str: 'Order\nConfirmed',
                  textAlign: TextAlign.center,
                  color: KColor.deep2.color,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
          const DeliveryDate(),
        ],
      ),
    );
  }
}
