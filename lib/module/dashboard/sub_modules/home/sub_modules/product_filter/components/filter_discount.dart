import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterDiscount extends StatelessWidget {
  const FilterDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Discount",
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Discount"),
              HorizontalSpace(),
              CheckLabelStatic(label: "No Discount"),
            ],
          ),
        ],
      ),
    );
  }
}
