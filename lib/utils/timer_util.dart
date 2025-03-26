import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';

class TimerUtil {
  static void splashNavigation(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigation.pushReplacement(context, appRoutes: AppRoutes.onboarding);
    });
  }
}
