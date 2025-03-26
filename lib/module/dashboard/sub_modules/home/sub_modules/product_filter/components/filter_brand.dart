import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_top_brands/controller/brand_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/controller/product_list_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterBrand extends StatelessWidget {
  const FilterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productListController.notifier);
        final state = ref.watch(productListController);
        final brandState = ref.watch(brandController);
        return Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterTitle(
                title: "Brand",
              ),
              // FilterSearch(),
              // VerticalSpace(
              //   height: 8,
              // ),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  ...brandState.topBrandsList
                      .map((e) => CheckLabel(
                          label: e.name ?? "",
                          isSelected: controller.isSelectedBrand(e),
                          onTap: () {
                            controller.toogleBrandBox(e);
                          }))
                      .toList()
                ],
              ),
              //  CheckLabel(label: "Health & Beauty"),

              // Row(
              //   children: [
              //     CheckLabelStatic(label: "Arong"),
              //     HorizontalSpace(),
              //     CheckLabelStatic(label: "Smartex"),
              //     HorizontalSpace(),
              //     CheckLabelStatic(label: "CATS EYE"),
              //   ],
              // ),
              // VerticalSpace(
              //   height: 8,
              // ),
              // Row(
              //   children: [
              //     CheckLabelStatic(label: "Rang"),
              //     HorizontalSpace(),
              //     CheckLabelStatic(label: "Eastasy"),
              //     HorizontalSpace(),
              //     CheckLabelStatic(label: "Nabarupa"),
              //   ],
              // ),
              // VerticalSpace(
              //   height: 9,
              // ),
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
      },
    );
  }
}
// @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {


//         return Padding(
//           padding: EdgeInsets.only(bottom: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FilterTitle(
//                 title: "Brand",
//               ),

//         );
//       },
//     );
//   }
// }