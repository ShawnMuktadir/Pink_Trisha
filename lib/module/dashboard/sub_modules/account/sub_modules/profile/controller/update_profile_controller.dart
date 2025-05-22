import 'dart:convert';
import 'dart:developer';
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
      UpdateProfileResponse? updateProfileResponse;
      updateProfileResponse = UpdateProfileResponse(
        firstName: state.firstNameCon.text.trim(),
        lastName: state.lastNameCon.text.trim(),
        phoneNumber: state.phoneCon.text.trim(),
      );
      final token = PrefHelper.getString(AppConstant.TOKEN.key);
      // log('Error Token: $token');

      // final String? retrievedToken = await PrefHelper.getString(AppConstant.TOKEN.toString());
      print('Update Profile Token get :- $token');

      print('Send data is: ${updateProfileResponse.toJson()}');
      await _apiClient.request(
          url: AppUrl.updateProfileUrl.url,
          method: MethodType.PUT,
          token: PrefHelper.getString(AppConstant.TOKEN.key),
          data: updateProfileResponse.toJson(),
          onSuccessFunction: (response) {
            log('Response: ${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final controller = context.read(profileController.notifier);
              Future(() async {
                await controller.getProfile();
              });
              ViewUtil.SSLSnackbar("Profile Updated Successfully.");
            }
          });
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
        password: "",
        status: "DELETED",
      );

      await _apiClient.request(
        url: AppUrl.deleteAccountUrl.url,
        method: MethodType.POST,
        token: token,
        data: requestBody.toJson(),
        onSuccessFunction: (response) async {
          final result = DeleteProfileResponse.fromJson(response.data['data'] as Map<String, dynamic>);

          if (result.status == 'DELETED') {
            ViewUtil.SSLSnackbar("We're very sorry to see you go.");
            await Future.delayed(const Duration(seconds: 2));
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
}
