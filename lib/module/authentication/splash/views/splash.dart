import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_logo.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/constant_key.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkRememberMe(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GlobalImageLoader(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              imagePath: KAssetName.icSplashBackgroundpng.imagePath,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: GlobalPrimaryLogo(
                height: 81.h,
                width: 324.w,
                // height: 81.h,
                // width: 324.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkRememberMe(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool(AppConstant.REMEMBER_ME.key) ?? false;

    Future.delayed(const Duration(seconds: 2), () {
      if (rememberMe) {
        // Navigate to dashboard if remember-me is true
        Navigation.pushReplacement(context, appRoutes: AppRoutes.dashboard);
      } else {
        // Navigate to sign-in screen if remember-me is false
        Navigation.pushReplacement(context, appRoutes: AppRoutes.onboarding);
      }
    });
  }
}
