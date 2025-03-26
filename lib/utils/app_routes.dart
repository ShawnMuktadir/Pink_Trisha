import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/module/authentication/forgot_password/views/forgot_password_screen.dart';
import 'package:pink_by_trisha_app/module/authentication/forgot_password/views/otp_screen.dart';
import 'package:pink_by_trisha_app/module/authentication/onboarding/views/onboarding_screen.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/sign_in_screen.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/views/sign_up_screen.dart';
import 'package:pink_by_trisha_app/module/authentication/splash/views/splash.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/add_address/create_address_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/address_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/address/model/all_address_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/f_a_q/f_a_q_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/help_and_support/help_and_support_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/my_order/my_order_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/order_details/order_details_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/model/profile_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/profile_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/terms_and_condition/terms_and_condition_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/update_address/update_address_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/wishlist/wish_list_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/category/category_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/model/screen_source_data.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product/product_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/home/sub_modules/product_details/product_details_screen.dart';
import 'package:pink_by_trisha_app/module/dashboard/views/dashboard_screen.dart';
import '../module/dashboard/sub_modules/account/sub_modules/privacy_and_policy/PrivacyPolicyScreen.dart';
import '../module/dashboard/sub_modules/account/sub_modules/return_and_policy/ReturnPolicyScreen.dart';
import '../module/dashboard/sub_modules/cart/sub_modules/shipping_address/shipping_address_screen.dart';
import '../module/dashboard/sub_modules/cart/sub_modules/add_payment_option/add_payment_option_screen.dart';
import '../module/dashboard/sub_modules/cart/sub_modules/order_confirm/order_confirm_screen.dart';
import '../module/dashboard/sub_modules/cart/sub_modules/order_summary/order_summary_screen.dart';
import '../module/dashboard/sub_modules/home/components/home_top_brands/components/top_brands_seeall.dart';

enum AppRoutes {
  splash,
  onboarding,
  signIn,
  signUp,
  forgotPassword,
  otp,
  dashboard,
  product,
  productDetails,
  categoriesSeeAll,
  topBrandsSeeAll,
  profile,
  address,
  myOrder,
  orderDetails,
  createAddress,
  wishlist,
  faq,
  termsAndCondition,
  privacyPolicy,
  returnPolicy,
  helpAndSupport,
  updateAddress,
  shippingAddress,
  addPaymentOption,
  orderSummery,
  orderConfirm
}

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.onboarding:
        return const OnBoardingScreen();
      case AppRoutes.signIn:
        return SignInScreen(
          hasBackButton: arguments as bool?,
        );
      case AppRoutes.signUp:
        return const SignUpScreen();
      case AppRoutes.dashboard:
        return const DashboardScreen();
      case AppRoutes.product:
        return ProductScreen(
          screenSourceData: arguments as ScreenSourceData,
        );
      case AppRoutes.productDetails:
        return ProductDetailsScreen(arguments as ProductDetailsScreenModel);
      case AppRoutes.profile:
        return ProfileScreen(profileData: arguments as ProfileData);
      case AppRoutes.categoriesSeeAll:
        return const CategoryScreen(
          fromPush: true,
        );
      case AppRoutes.address:
        return const AddressScreen();
      case AppRoutes.updateAddress:
        return UpdateAddressScreen(arguments as AllAddressData);
      case AppRoutes.myOrder:
        return const MyOrderScreen();
      case AppRoutes.orderDetails:
        return OrderDetailsScreen(
          orderId: arguments as String,
        );
      case AppRoutes.createAddress:
        return CreateAddressScreen(arguments as bool);
      case AppRoutes.wishlist:
        return const WishListScreen();
      case AppRoutes.faq:
        return const FAQScreen();
      case AppRoutes.termsAndCondition:
        return const TermsAndConditionScreen();
      case AppRoutes.privacyPolicy:
        return const PrivacyPolicyScreen();
      case AppRoutes.returnPolicy:
        return const ReturnPolicyScreen();
      case AppRoutes.helpAndSupport:
        return const HelpAndSupportScreen();
      case AppRoutes.shippingAddress:
        return const ShippingAddressScreen();
      case AppRoutes.addPaymentOption:
        return const AddPaymentOptionScreen();
      case AppRoutes.orderSummery:
        return const OrderSummeryScreen();
      case AppRoutes.orderConfirm:
        return OrderConfirmScreen(
          orderId: arguments as String,
        );
      case AppRoutes.topBrandsSeeAll:
        return const TopBrandsSeeAll();
      case AppRoutes.forgotPassword:
        return const ForgotPasswordScreen();
      case AppRoutes.otp:
        return const OtpScreen();
    }
  }
}
