import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterSize extends StatelessWidget {
  const FilterSize({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Size",
          ),
          Row(
            children: [
              CheckLabelStatic(label: "S"),
              HorizontalSpace(),
              CheckLabelStatic(label: "M"),
              HorizontalSpace(),
              CheckLabelStatic(label: "L"),
              HorizontalSpace(),
              CheckLabelStatic(label: "XL"),
              HorizontalSpace(),
              CheckLabelStatic(label: "XXL"),
            ],
          ),
        ],
      ),
    );
  }
}
