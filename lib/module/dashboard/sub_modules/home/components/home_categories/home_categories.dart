import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_seel_all_button_text.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/controller/category_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

import '../../../../../../utils/app_util.dart';

class HomeCategories extends ConsumerWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(dashboardController.notifier);
    final state = ref.watch(dashboardController);
    final homeState = ref.watch(homeController);
    final categoryState = ref.watch(categoryController);
    final isFeaturedCategories = categoryState.cateAllData
        .where((element) => element.isFeatured != null && element.isFeatured!)
        .toList();
    //homeState.featuredCategories.map((e) => e.imageUrl ?? "assets/static_images/man.png").toList();
    // print(images);
    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: 31.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: "Shop by Category",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
                GlobalSeeAllTextButton(
                  onTap: () {
                    // Navigation.push(context, appRoutes: AppRoutes.product);
                    Navigation.push(context,
                        appRoutes: AppRoutes.categoriesSeeAll);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: categoryState.isLoading
                ? const Center(
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator()))
                : categoryState.cateAllData.isEmpty
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GlobalText(
                          str: "No Category found",
                          color: KColor.deepGrey.color,
                        ),
                      ))
                    : Wrap(
                        //alignment: WrapAlignment.spaceBetween,
                        children: List.generate(
                            isFeaturedCategories.length <= 6
                                ? isFeaturedCategories.length
                                : 6, (index) {
                          final image = isFeaturedCategories[index].imageUrl;
                          return Padding(
                            padding: EdgeInsets.only(
                                left: index == 0 || index == 3 ? 20.w : 14.w,
                                bottom: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigation.push(context,
                                    appRoutes: AppRoutes.product,
                                    arguments: ScreenSourceData(
                                        sourceType: SourceType.category,
                                        sourceId:
                                            isFeaturedCategories[index].id,
                                        sourceName: categoryState
                                            .cateAllData[index].name));
                              },
                              child: Container(
                                width: 100.h,
                                height: 140,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 13,
                                        left: 11,
                                        child: GlobalText(
                                          str: capitalizeFirstLetter(categoryState
                                              .cateAllData[index].name) ??
                                              '',
                                          color: const Color(0xFF2C2328),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.08,
                                          // height: 0.09,
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: GlobalSvgLoader(
                                            imagePath: KAssetName
                                                .icCategoryBackgroundsvg
                                                .imagePath,
                                            fit: BoxFit.fitHeight,
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: GlobalImageLoader(
                                          imagePath: image ??
                                              KAssetName
                                                  .icEmptyImage2png.imagePath,
                                          imageFor: image != null
                                              ? ImageFor.network
                                              : ImageFor.asset,
                                          // imagePath: "assets/static_images/man.png",
                                          height: 74,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
          )
        ],
      ),
    );
  }
}
// class HomeCategories extends ConsumerWidget {
//   const HomeCategories({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     final controller = ref.read(dashboardController.notifier);
//     final state = ref.watch(dashboardController);
//     final homeState = ref.watch(homeController);
//     final categoryState = ref.watch(categoryController);
//     //homeState.featuredCategories.map((e) => e.imageUrl ?? "assets/static_images/man.png").toList();
//     // print(images);
//     return Container(
//       width: context.width,
//       margin: EdgeInsets.only(top: 31.h),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const GlobalText(
//                   str: "Categories",
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   height: 0.09,
//                 ),
//                 GlobalSeeAllTextButton(
//                   onTap: () {
//                     // Navigation.push(context, appRoutes: AppRoutes.product);
//                     Navigation.push(context,
//                         appRoutes: AppRoutes.categoryStateSeeAll);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 12.h,
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: List.generate(isFeaturedCategories.length, (index) {
//                   final image = isFeaturedCategories[index].imageUrl;
//                   return Padding(
//                     padding: EdgeInsets.only(
//                       left: index == 0 ? 20.w : 14.w,
//                     ),
//                     child: SizedBox(
//                       width: 120,
//                       height: 46,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.r),
//                         child: Stack(
//                           children: [
//                             GlobalImageLoader(
//                               imageFor: image != null
//                                   ? ImageFor.network
//                                   : ImageFor.asset,
//                               imagePath: image ??
//                                   KAssetName.icCategoryBackgroundpng.imagePath,
//                               // imagePath: "assets/static_images/man.png",
//                               height: 46.h,
//                               width: 120.w,
//                               fit: BoxFit.fill,
//                             ),
//                             Center(
//                               child: GlobalText(
//                                 str:
//                                     isFeaturedCategories[index].name ?? 'Men',
//                                 textAlign: TextAlign.center,
//                                 color: Color(0xFFFDFDFD),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 // height: 0.09,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
