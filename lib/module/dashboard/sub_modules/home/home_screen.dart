import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_best_deals.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_calculate_price.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_carousel_images.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/home_categories.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_explore_products.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_logo.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_search/home_search.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_top_brands/home_top_brands.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read(homeController.notifier);

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeController);
        final wishState = ref.watch(wishController);
        return Scaffold(
          body: SafeArea(
            child: GlobalTopLoader(
              isLoading: wishState.loaderScreenType == LoaderScreenType.home,
              child: Container(
                width: context.width,
                constraints: BoxConstraints(
                  minHeight: context.height,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      KColor.homeGradientStart.color,
                      KColor.homeGradientEnd.color,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const HomeLogo(),
                    state.isLoading
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                Future(() {
                                  controller.getHomeResponse(
                                      categoryId: null, skip: 0, take: 10);
                                });
                              },
                              child: ListView(
                                children: const [
                                  HomeSearch(
                                    hasFilter: false,
                                  ),
                                  HomeCarouselImages(),
                                  HomeCategories(),
                                  HomeBestDeals(),
                                  HomeTopBrands(),
                                  HomeExploreProducts(),
                                  HomeCalculatePrice(),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
