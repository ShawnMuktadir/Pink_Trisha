import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/update_profile_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/model/profile_model.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';
import '../../../../../../../constant/app_url.dart';
import '../../../../../../../constant/constant_key.dart';
import '../../../../../../../data_provider/api_client.dart';
import '../../../../../../../data_provider/pref_helper.dart';
import '../../../../../../../data_provider/storage_controller.dart';
import '../../../../../../../utils/app_routes.dart';
import '../../../../../../../utils/navigation.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../model/delete_profile_response.dart';
import '../model/update_profile_response.dart';

final updateProfileController = StateNotifierProvider.autoDispose<
    UpdateProfileController,
    UpdateProfileState>((ref) => UpdateProfileController());

class UpdateProfileController extends StateNotifier<UpdateProfileState> {
  UpdateProfileController()
      : super(UpdateProfileState(
          firstNameCon: TextEditingController(text: ''),
          lastNameCon: TextEditingController(text: ''),
          emailCon: TextEditingController(text: ' '),
          phoneCon: TextEditingController(text: ' '),
          isButtonEnabled: false,
          isUpdateBtnLoading: false,
          isDeleteBtnLoading: false,
        )) {
    state.firstNameCon.addListener(() {
      checkButtonStatus();
    });
    state.emailCon.addListener(() {
      checkButtonStatus();
    });
    state.phoneCon.addListener(() {
      checkButtonStatus();
    });
  }

  bool _isSynced = false;

  void syncWithProfile(ProfileData profile) {
    // Only update controllers if not synced yet or data changed
    if (!_isSynced ||
        state.firstNameCon.text != (profile.firstName ?? '') ||
        state.lastNameCon.text != (profile.lastName ?? '') ||
        state.phoneCon.text != (profile.phoneNumber ?? '') ||
        state.emailCon.text != (profile.email ?? '')) {
      state.firstNameCon.text = profile.firstName ?? '';
      state.lastNameCon.text = profile.lastName ?? '';
      state.phoneCon.text = profile.phoneNumber ?? '';
      state.emailCon.text = profile.email ?? '';
      _isSynced = true;
    }
  }

  // Make sure to reset _isSynced if needed on logout or similar
  void resetSync() {
    _isSynced = false;
  }

  checkButtonStatus() {
    final String firstNameCon = state.firstNameCon.text.trim();
    final String emailCon = state.emailCon.text.trim();
    final String phoneCon = state.phoneCon.text.trim();

    if (firstNameCon.isNotEmpty && emailCon.isNotEmpty && phoneCon.isNotEmpty) {
      state = state.copyWith(isButtonEnabled: true);
    } else {
      state = state.copyWith(isButtonEnabled: false);
    }
  }

  /// ==@ Function
  final ApiClient _apiClient = ApiClient();

  void setProfileData(ProfileData profileData) {
    state.firstNameCon.text = profileData.firstName ?? "";
    state.lastNameCon.text = profileData.lastName ?? "";
    state.emailCon.text = profileData.email ?? "";
    state.phoneCon.text = profileData.phoneNumber ?? "";
  }

  final formKey = GlobalKey<FormState>();

  Future<void> reqUpdateProfile(BuildContext context) async {
    state = state.copyWith(isUpdateBtnLoading: true);
    try {
      if (!formKey.currentState!.validate()) {
        state = state.copyWith(isUpdateBtnLoading: false);
        return;
      }

      UpdateProfileResponse updateProfileResponse = UpdateProfileResponse(
        firstName: state.firstNameCon.text.trim(),
        lastName: state.lastNameCon.text.trim(),
        phoneNumber: state.phoneCon.text.trim(),
      );

      final token = PrefHelper.getString(AppConstant.TOKEN.key);
      print('Update Profile Token get :- $token');
      print('Send data is: ${updateProfileResponse.toJson()}');

      await _apiClient.request(
        url: AppUrl.updateProfileUrl.url,
        method: MethodType.PUT,
        token: token,
        data: updateProfileResponse.toJson(),
        onSuccessFunction: (response) async {
          log('Response: ${jsonEncode(response.data)}');

          if (response.data != null) {
            'response is: ${jsonEncode(response.data)}'.log();
            final updatedProfile = ProfileModel.fromJson(response.data).data;

            final controller = context.read(profileController.notifier);

            // Directly update the controller's state with new data from update response
            controller.state =
                controller.state.copyWith(fetchProfile: updatedProfile);

            ViewUtil.SSLSnackbar("Profile Updated Successfully.");
          }
        },
      );
    } catch (e, s) {
      log("Log Error :-", error: e, stackTrace: s);
    }
    state = state.copyWith(isUpdateBtnLoading: false);
  }

  Future<void> deleteAccount(BuildContext context, int id, String email) async {
    state = state.copyWith(isDeleteBtnLoading: true);

    try {
      final token = PrefHelper.getString(AppConstant.TOKEN.key);

      final requestBody = DeleteProfileResponse(
        id: id,
        email: email,
        /*password: "",
        status: "DELETED",*/
      );

      await _apiClient.request(
        url: AppUrl.deleteAccountUrl.url,
        method: MethodType.POST,
        token: token,
        data: requestBody.toJson(),
        onSuccessFunction: (response) async {
          final result = DeleteProfileResponse.fromJson(
              response.data['data'] as Map<String, dynamic>);

          if (result.status == 'DELETED') {
            // Start blur
            showBlurOverlay(context);

            ViewUtil.SSLSnackbar("We're very sorry to see you go.");

            await Future.delayed(const Duration(seconds: 2));

            // Clear cart
            final cartCon = context.read(cartController.notifier);
            await cartCon.clearAllFromCart();

            // Remove blur screen
            Navigator.of(context, rootNavigator: true).pop();

            // Proceed to logout / navigate away
            _handleAccountDeletion(context);
          } else {
            ViewUtil.SSLSnackbar("Account deletion failed. Please try again.");
          }
        },
      );
    } catch (e, s) {
      log("Delete Account Error", error: e, stackTrace: s);
      ViewUtil.SSLSnackbar("Failed to delete account. Please try again.");
    }

    state = state.copyWith(isDeleteBtnLoading: false);
  }

  void _handleAccountDeletion(BuildContext context) async {
    await StorageController.setLoggedOut();
    Future(() =>
        Navigation.pushReplacement(context, appRoutes: AppRoutes.dashboard));
  }

  void showBlurOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  // Call this method from your UI after profile data is fetched
  void initializeControllers(ProfileData profile) {
    state.firstNameCon.text = profile.firstName ?? '';
    state.lastNameCon.text = profile.lastName ?? '';
    state.phoneCon.text = profile.phoneNumber ?? '';
    state.emailCon.text = profile.email ?? '';
  }
}
