import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterWarrantyType extends StatelessWidget {
  const FilterWarrantyType({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Warranty Type",
          ),
          Row(
            children: [
              CheckLabelStatic(label: "No Warranty"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Local Seller Warranty"),
            ],
          ),
          VerticalSpace(
            height: 8,
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Seller Warranty"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Non Local Warranty"),
            ],
          ),
        ],
      ),
    );
  }
}
