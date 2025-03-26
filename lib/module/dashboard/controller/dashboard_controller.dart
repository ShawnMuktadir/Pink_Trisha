import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/model/bottomnav_widget_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/account_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/cart_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/category/category_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/home_screen.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import '../../../global/widget/global_text.dart';
import '../../../utils/styles/k_colors.dart';
import '../sub_modules/cart/controller/cart_controller.dart';

final dashboardController =
    StateNotifierProvider<DashboardController, DashboardState>(
        (ref) => DashboardController());

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController()
      : super(
          DashboardState(
            selectedIndex: 0,
            currentCarouselIndex: 0,
            currentBestDealIndex: 0,
            selectedProductIndex: 0,
            bottomNavItems: [
              BottomNavWidgetModel(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  icon: GlobalSvgLoader(
                    imagePath: KAssetName.icHomeUnselectedsvg.imagePath,
                  ),
                  activeIcon: GlobalSvgLoader(
                    imagePath: KAssetName.icHomeSelectedsvg.imagePath,
                  ),
                  label: "Home",
                ),
                child: const HomeScreen(),
              ),
              BottomNavWidgetModel(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  icon: GlobalSvgLoader(
                    imagePath: KAssetName.icCategoryUnselectedsvg.imagePath,
                  ),
                  activeIcon: GlobalSvgLoader(
                    imagePath: KAssetName.icCategorySelectedsvg.imagePath,
                  ),
                  label: "Category",
                ),
                child: const CategoryScreen(
                  fromPush: false,
                ),
              ),
              BottomNavWidgetModel(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  icon: Consumer(
                    builder: (_, ref, __) {
                      final state = ref.watch(cartController);
                      return state.cartProducts.isNotEmpty
                          ? Stack(
                              children: [
                                const SizedBox(height: 24, width: 40),
                                Positioned(
                                  left: 5,
                                  child: GlobalSvgLoader(
                                    imagePath: KAssetName
                                        .icCartUnselectedsvg.imagePath,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        color: KColor.primary.color,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: GlobalText(
                                        str: '${state.cartProducts.length}',
                                        color: KColor.white.color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                        height: 0.10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : GlobalSvgLoader(
                              imagePath:
                                  KAssetName.icCartUnselectedsvg.imagePath,
                              height: 24.h,
                              width: 24.h,
                            );
                    },
                  ),
                  activeIcon: GlobalSvgLoader(
                    imagePath: KAssetName.icCartSelectedsvg.imagePath,
                    height: 24.h,
                    width: 24.h,
                  ),
                  label: "Cart",
                ),
                child: const CartScreen(),
              ),
              BottomNavWidgetModel(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  icon: GlobalSvgLoader(
                    imagePath: KAssetName.icAccountUnselectedsvg.imagePath,
                  ),
                  activeIcon: GlobalSvgLoader(
                    imagePath: KAssetName.icAccountSelectedsvg.imagePath,
                  ),
                  label: "Account",
                ),
                child: const AccountScreen(),
              ),
            ],
          ),
        );

  onOptionChange(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  setCarouselIndex(int index) {
    state = state.copyWith(currentCarouselIndex: index);
  }

  setBestDealIndex(int index) {
    state = state.copyWith(currentBestDealIndex: index);
  }

  setProductIndex(int index) {
    state = state.copyWith(selectedProductIndex: index);
  }
}
