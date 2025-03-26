import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_search.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterSeller extends StatelessWidget {
  const FilterSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterTitle(
            title: "Seller",
          ),
          // FilterSearch(),
          // VerticalSpace(
          //   height: 8,
          // ),
          Row(
            children: [
              CheckLabelStatic(label: "Arong"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Smartex"),
              HorizontalSpace(),
              CheckLabelStatic(label: "CATS EYE"),
            ],
          ),
          VerticalSpace(
            height: 8,
          ),
          Row(
            children: [
              CheckLabelStatic(label: "Rang"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Eastasy"),
              HorizontalSpace(),
              CheckLabelStatic(label: "Nabarupa"),
            ],
          ),
          VerticalSpace(
            height: 9,
          ),
          // GlobalText(
          //   str: '386 more',
          //   color: Color(0xFFF553B0),
          //   fontSize: 12,
          //   fontWeight: FontWeight.w500,
          //   height: 0.11,
          // )
        ],
      ),
    );
  }
}
