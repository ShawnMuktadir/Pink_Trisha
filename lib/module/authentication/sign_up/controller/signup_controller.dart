import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/controller/signup_state.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/model/auth_model.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/model/signup_response.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';
import '../../../../utils/navigation.dart';
import '../../../../utils/view_util.dart';

final signUpController =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        (ref) => SignUpController());

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController()
      : super(SignUpState(
          firstNameCon: TextEditingController(),
          emailCon: TextEditingController(),
          phoneCon: TextEditingController(),
          passwordCon: TextEditingController(),
          isButtonEnabled: false,
          isSignupLoading: false,
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
    state.passwordCon.addListener(() {
      checkButtonStatus();
    });
  }
  bool isSelect = false;

  final formKey = GlobalKey<FormState>();

  checkButtonStatus() {
    final String firstName = state.firstNameCon.text.trim();
    final String email = state.emailCon.text.trim();
    final String phone = state.phoneCon.text.trim();
    final String password = state.passwordCon.text.trim();

    if (firstName.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        password.isNotEmpty) {
      state = state.copyWith(isButtonEnabled: true);
    } else {
      state = state.copyWith(isButtonEnabled: false);
    }
  }

  /// ==@ Function
  final ApiClient _apiClint = ApiClient();

  Future<void> reqSignUp(BuildContext context) async {
    try {
      state = state.copyWith(isSignupLoading: true);

      SignUpResponse? signUpResponse;
      if (formKey.currentState!.validate()) {
        signUpResponse = SignUpResponse(
          firstName: state.firstNameCon.text.trim(),
          lastName: ' ',
          email: state.emailCon.text.trim(),
          phoneNumber: state.phoneCon.text.trim(),
          password: state.passwordCon.text.trim(),
        );
        log('Pass: ${signUpResponse.toJson()}');
        if (isSelect == true) {
          await _apiClint.request(
              url: AppUrl.signUpUrl.url,
              method: MethodType.POST,
              data: signUpResponse!.toJson(),
              onSuccessFunction: (response) {
                log('Response${jsonEncode(response.data)}');

                if (response.data != null) {
                  'response is: ${jsonEncode(response.data)}'.log();
                  final AuthModel authModel = AuthModel.fromJson(response.data);
                  log('Response${authModel.statusCode}');

                  if (authModel.statusCode == 200) {
                    //  final cartCon = context.read(signInController.notifier);

                    Navigation.pop(context);
                    ViewUtil.SSLSnackbar("Account created Successfully!");

                    log("Success Message: ${authModel.message}");
                  } else if (authModel.statusCode == 401) {
                    log("Handle Error: ${authModel.message}");
                  } else {
                    // ==? Handle Error
                  }
                } else {
                  // Handle the case when the response data is null
                  log('Response data is null');
                }
              });
        } else {
          ViewUtil.SSLSnackbar("Please select terms policy & conditions");
        }
      }
    } catch (e) {
      // Handle exceptions
      log('Exception in reqSignIn: $e');
    }
    state = state.copyWith(isSignupLoading: false);
  }
}
