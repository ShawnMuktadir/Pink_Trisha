import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';

class HomeCarouselImages extends ConsumerWidget {
  const HomeCarouselImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(dashboardController.notifier);
    final state = ref.watch(dashboardController);
    final homeState = ref.watch(homeController);
    List<String> images = homeState.heroBanners.map((e) => e.imageUrl ?? "").toList();
    return SizedBox(
      width: context.width,
      child: Column(
        children: [
          SizedBox(
            height: 132.h,
            width: context.width,
            child: CarouselSlider(
              items: List.generate(homeState.heroBanners.length, (index) {
                final image = images[index];
                return Container(
                  //color: Colors.red,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      // color: Colors.yellow,
                      child: GlobalImageLoader(
                        imageFor: ImageFor.network,
                        imagePath: image,
                        //imagePath: "assets/static_images/banner.png",
                        height: 132.h,
                        width: 266.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
              options: CarouselOptions(
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  controller.setCarouselIndex(index);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(homeState.heroBanners.length, (index) {
              late bool isSelected;
              late String imagePath;
              if (index == state.currentCarouselIndex) {
                isSelected = true;
                imagePath = KAssetName.icActiveCarouselpng.imagePath;
              } else {
                isSelected = false;
                imagePath = KAssetName.icInactiveCarouselpng.imagePath;
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: GlobalImageLoader(
                  imagePath: imagePath,
                  height: isSelected ? 8.h : 6.h,
                  width: isSelected ? 8.h : 6.h,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
