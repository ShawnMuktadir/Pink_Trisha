import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_seel_all_button_text.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../../utils/app_routes.dart';
import '../../../../../../utils/navigation.dart';

class HomeTopBrands extends ConsumerWidget {
  const HomeTopBrands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(homeController.notifier);
    final state = ref.watch(homeController);
    final brands = state.featuredBrands
        .where((element) => element.isFeatured != null && element.isFeatured!)
        .toList();
    ;
    List<String> images =
        state.featuredBrands.map((e) => e.imageUrl ?? "").toList();
    // List<String> images = [
    //   'assets/static_images/Amazon_logo.png',
    //   'assets/static_images/Aliexpress_logo.png',
    //   'assets/static_images/EBay_logo.png',
    //   'assets/static_images/Best_Buy_logo_2018.png',
    // ];

    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: 30.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const GlobalText(
                  str: "Top Brands",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
                GlobalSeeAllTextButton(
                  onTap: () {
                    Navigation.push(context,
                        appRoutes: AppRoutes.topBrandsSeeAll);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 64.h,
            child: brands.isEmpty
                ? Center(
                    child: GlobalText(
                    str: "No brands found",
                    color: KColor.deepGrey.color,
                  ))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(brands.length, (index) {
                        final brand = brands[index];
                        final image = brand.imageUrl;
                        return InkWell(
                          onTap: () {
                            Navigation.push(context,
                                appRoutes: AppRoutes.product,
                                arguments: ScreenSourceData(
                                    sourceType: SourceType.brand,
                                    sourceId: brand.id,
                                    sourceName: brand.name));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 20.w : 32.w,
                            ),
                            child: GlobalImageLoader(
                              imageFor: image != null
                                  ? ImageFor.network
                                  : ImageFor.asset,
                              imagePath: image ??
                                  KAssetName.icEmptyImage2png.imagePath,
                              height: 24.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
