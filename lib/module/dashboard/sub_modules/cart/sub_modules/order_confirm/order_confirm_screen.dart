import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';

import '../../../../../../global/widget/global_button.dart';
import '../../../../../../global/widget/global_image_loader.dart';
import '../../../../../../global/widget/global_text.dart';
import '../../../../../../utils/navigation.dart';
import '../../../../../../utils/styles/k_assets.dart';
import '../../../../../../utils/styles/k_colors.dart';
import 'components/track_order_button.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlobalImageLoader(
                      imagePath: KAssetName.icConfirmOrder.imagePath,
                      height: 99,
                      width: 83,
                    ),
                    VerticalSpace(
                      height: 10.h,
                    ),
                    GlobalText(
                      str: "Thank You",
                      color: KColor.deep2.color,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 0.04,
                    ),
                    VerticalSpace(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 313,
                      child: GlobalText(
                        str: "Your order is confirm",
                        color: KColor.deep3.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 0.07,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 36,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigation.pushReplacement(context,
                                appRoutes: AppRoutes.orderDetails,
                                arguments: orderId);
                          },
                          child: const TrackOrderButton()),
                      VerticalSpace(
                        height: 16.h,
                      ),
                      GlobalButton(
                        // btnHeight: 44,
                        onPressed: () {
                          Navigation.pop(context);
                        },
                        buttonText: "Continue Shopping",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
