import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_filter/filter_page.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../sub_modules/product/controller/product_list_controller.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
    this.hasFilter = true,
  }) : super(key: key);
  final bool hasFilter;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final controller = ref.read(productListController.notifier);
      final state = ref.watch(productListController);

      return InkWell(
        onTap: hasFilter
            ? null
            : () {
                Navigation.push(context,
                    appRoutes: AppRoutes.product,
                    arguments: ScreenSourceData(sourceType: SourceType.all));
              },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 20.w,
          ),
          child: Container(
            height: 48.h,
            width: context.width,
            padding: EdgeInsets.only(left: 16.w, right: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: KColor.white.color,
            ),
            child: Row(
              children: [
                GlobalSvgLoader(
                  imagePath: KAssetName.icSearchsvg.imagePath,
                  height: 24.h,
                  width: 24.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextField(
                      //controller: state.searchCon,
                      enabled: hasFilter,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Product",
                      ),
                      textInputAction: TextInputAction.search,
                      // onSubmitted: (data) async {
                      //   if (data.isNotEmpty) {
                      //     controller.callSearch(data);
                      //   }
                      // },
                      onChanged: (data) async {
                        if (data.isNotEmpty) controller.callSearch(data);
                      },
                    ),
                  ),
                ),
                hasFilter
                    ? InkWell(
                        onTap: () {
                          showAlertFilterDialogue(context);
                        },
                        child: GlobalImageLoader(
                          imagePath: KAssetName.icFilterpng.imagePath,
                          height: 36.h,
                          width: 40.w,
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
        ),
      );
    });
  }
}

void showAlertFilterDialogue(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "ljkl",
    pageBuilder: (_, __, ___) {
      return Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Material(
          color: Colors.transparent, // Set the color to transparent
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: const FilterPage(),
          ),
        ),
      );
    },
  );
}
