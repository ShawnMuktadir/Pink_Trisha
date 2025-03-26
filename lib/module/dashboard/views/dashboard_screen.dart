import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/controller/dashboard_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/controller/all_address/all_address_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/controller/wish_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/cart/controller/cart_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/components/home_categories/controller/category_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/controller/home_controller.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final homeCon = context.read(homeController.notifier);
    final cateCon = context.read(categoryController.notifier);
    Future(() {
      homeCon.getHomeResponse(categoryId: null, skip: 0, take: 10);
      homeCon.getHomeCountryResponse();
      cateCon.getCategory();
    });
    final cartCon = context.read(cartController.notifier);
    Future(() {
      cartCon.getCartProducts();
    });

    if (StorageController.isLoggedIn) {
      final wishCon = context.read(wishController.notifier);
      final addressCon = context.read(allAddressController.notifier);
      final profileCon = context.read(profileController.notifier);
      Future(() async {
        addressCon.getAllAddress();
        wishCon.getWishList();
        profileCon.getProfile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(dashboardController);
        final controller = ref.read(dashboardController.notifier);
        return WillPopScope(
          onWillPop: () async {
            if (state.selectedIndex == 0) {
              return true;
            }
            controller.onOptionChange(0);
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: KColor.white.color,
            body: Center(
              child: state.bottomNavItems.elementAt(state.selectedIndex).child,
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state.selectedIndex,
                type: BottomNavigationBarType.fixed,
                fixedColor: KColor.primary.color,
                selectedLabelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                onTap: controller.onOptionChange,
                items: state.bottomNavItems
                    .map((e) => e.bottomNavigationBarItem)
                    .toList()),
          ),
        );
      },
    );
  }
}
