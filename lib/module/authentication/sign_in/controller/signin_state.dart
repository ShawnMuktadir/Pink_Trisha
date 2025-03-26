import 'package:flutter/cupertino.dart';

@immutable
class SignInState {
  final TextEditingController emailCon;
  final TextEditingController forgotPasswordEmailCon;
  final TextEditingController otpEmailCon;
  final TextEditingController otpCon;
  final TextEditingController passwordCon;
  final bool isButtonEnabled;
  final bool isGoogleBtnLoading;
  final bool isLoginLoading;
  final bool isForgotPasswordLoading;
  final bool isOtpLoading;

  const SignInState(
      {required this.emailCon,
      required this.passwordCon,
      required this.forgotPasswordEmailCon,
      required this.otpEmailCon,
      required this.otpCon,
      required this.isButtonEnabled,
      required this.isGoogleBtnLoading,
      required this.isForgotPasswordLoading,
      required this.isOtpLoading,
      required this.isLoginLoading});

  SignInState copyWith(
          {bool? isButtonEnabled,
          bool? isLoginLoading,
          bool? isForgotPasswordLoading,
          bool? isOtpLoading,
          bool? isGoogleBtnLoading}) =>
      SignInState(
          emailCon: emailCon,
          passwordCon: passwordCon,
          forgotPasswordEmailCon: forgotPasswordEmailCon,
          otpEmailCon: otpEmailCon,
          otpCon: otpCon,
          isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
          isGoogleBtnLoading: isGoogleBtnLoading ?? this.isGoogleBtnLoading,
          isForgotPasswordLoading:
              isForgotPasswordLoading ?? this.isForgotPasswordLoading,
          isOtpLoading: isOtpLoading ?? this.isOtpLoading,
          isLoginLoading: isLoginLoading ?? this.isLoginLoading);
}
