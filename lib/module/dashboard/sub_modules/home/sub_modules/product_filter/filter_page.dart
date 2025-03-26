import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/controller/product_list_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_brand.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_category.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_price.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_seller.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productListController.notifier);
        final state = ref.watch(productListController);
        return SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalBackButton(
                    title: "Filter",
                    onTap: () {
                      Navigation.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GlobalButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            controller.callFilter();
                            Navigation.pop(context);
                          },
                          buttonText: "Done"),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 31, top: 20, right: 19, bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterCategory(),
                        FilterBrand(),
                        //  FilterSeller(),
                        // FilterColor(),
                        // FilterLocation(),
                        // FilterGender(),
                        // FilterSize(),
                        FilterPrice(),
                        //  FilterWarrantyType(),
                        //  FilterService(),
                        // FilterRatings(),
                        //  FilterDiscount(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
