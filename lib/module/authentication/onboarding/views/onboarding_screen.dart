import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_logo.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    ViewUtil.setStatusbarColor(color: KColor.white.color);

    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.05, -1.00),
            end: const Alignment(-0.05, 1),
            //  colors: [Colors.white, Color(0xFFFDB6DF)],
            colors: [KColor.white.color, KColor.background5.color],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 24, top: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalSvgLoader(
                        width: 24,
                        height: 24,
                        imagePath: KAssetName.icArrowBacksvg.imagePath),
                    InkWell(
                      // onTap: () => Navigation.pushReplacement(context,
                      //     appRoutes: AppRoutes.signIn),
                      onTap: () => Navigation.pushReplacement(context,
                          appRoutes: AppRoutes.dashboard),
                      child: GlobalText(
                        str: "Next",
                        fontWeight: FontWeight.w600,
                        color: KColor.primary.color,
                        fontSize: 16,
                        height: 0.09,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: GlobalSvgLoader(
                          imagePath: KAssetName.icWelcomeLogosvg.imagePath,
                          height: 240.h,
                        ),
                      ),
                      VerticalSpace(
                        height: 40.h,
                      ),
                      GlobalText(
                        str: "Welcome to",
                        color: KColor.deep2.color,
                        fontSize: 24.h,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GlobalPrimaryLogo(
                          height: 35.h,
                          width: 110.w,
                        ),
                      ),
                      GlobalText(
                        str:
                            'Search your necessary product & enjoy shopping with us',
                        color: KColor.deepGrey.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        height: 0.09,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
