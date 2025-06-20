import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterColor extends StatelessWidget {
  const FilterColor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Color",
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Black"),
              HorizontalSpace(),
              CheckLabelStatic(label: "White"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Red"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Pink"),
            ],
          ),
          VerticalSpace(
            height: 8,
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Green"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Blue"),
            ],
          ),
        ],
      ),
    );
  }
}
