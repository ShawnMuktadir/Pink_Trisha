import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/controller/category_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/controller/product_list_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/check_label.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/components/filter_title.dart';

class FilterCategory extends StatelessWidget {
  const FilterCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(productListController.notifier);
        final state = ref.watch(productListController);
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilterTitle(
                title: "Catagory",
              ),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  ...state.categories
                      .map((e) => CheckLabel(
                          label: e.name ?? "",
                          isSelected: controller.isSelectedCategory(e),
                          onTap: () {
                            controller.toogleCategoryBox(e);
                          }))
                      .toList()
                ],
              ),
              state.categories.isNotEmpty &&
                      state.selectedCategory?.subcategories != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const FilterTitle(
                          title: "Subcategories",
                        ),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            ...state.selectedCategory!.subcategories!
                                .map((e) => CheckLabel(
                                    label: e.name ?? "",
                                    isSelected:
                                        controller.isSelectedSubcategory(e),
                                    onTap: () {
                                      controller.toogleSubcategoryBox(e);
                                    }))
                                .toList()
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              //  CheckLabel(label: "Health & Beauty"),
            ],
          ),
        );
      },
    );
  }
}
