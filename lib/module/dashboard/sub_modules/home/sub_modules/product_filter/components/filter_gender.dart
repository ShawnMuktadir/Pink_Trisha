import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterGender extends StatelessWidget {
  const FilterGender({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Gender",
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CheckLabelStatic(label: "Male"),
              //HorizontalSpace(),
              CheckLabelStatic(label: "Female"),
              CheckLabelStatic(label: "Children"),
              CheckLabelStatic(label: "Children"),
              CheckLabelStatic(label: "Children"),
            ],
          ),
        ],
      ),
    );
  }
}
