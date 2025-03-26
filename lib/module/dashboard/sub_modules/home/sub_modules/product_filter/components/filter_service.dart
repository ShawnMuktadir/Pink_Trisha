import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterService extends StatelessWidget {
  const FilterService({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Service",
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Instalment"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Free Shipping"),
            ],
          ),
          VerticalSpace(
            height: 8,
          ),
          CheckLabelStatic(label: "Cash On Delivery"),
        ],
      ),
    );
  }
}
