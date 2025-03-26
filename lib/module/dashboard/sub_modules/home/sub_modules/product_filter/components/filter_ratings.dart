import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterRatings extends StatelessWidget {
  const FilterRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Ratings",
          ),
          Row(
            children: [
              CheckLabelStatic(
                label: "5",
                hasStar: true,
              ),
              HorizontalSpace(),
              CheckLabelStatic(
                label: "4.00-4.99",
                hasStar: true,
              ),
              HorizontalSpace(),
              CheckLabelStatic(
                label: "3.00-3.99",
                hasStar: true,
              ),
            ],
          ),
          VerticalSpace(
            height: 8,
          ),
          Row(
            children: [
              CheckLabelStatic(
                label: "2.00-2.99",
                hasStar: true,
              ),
              HorizontalSpace(),
              CheckLabelStatic(
                label: "1.00-1.99",
                hasStar: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
