import 'package:flutter/cupertino.dart';

@immutable
class SignUpState {
  final TextEditingController firstNameCon;
  final TextEditingController emailCon;
  final TextEditingController phoneCon;
  final TextEditingController passwordCon;
  final bool isButtonEnabled;
  final bool isSignupLoading;

  const SignUpState({
    required this.firstNameCon,
    required this.emailCon,
    required this.phoneCon,
    required this.passwordCon,
    required this.isButtonEnabled,
    required this.isSignupLoading,
  });

  SignUpState copyWith({
    bool? isButtonEnabled,
    bool? isSignupLoading,
  }) =>
      SignUpState(
          firstNameCon: firstNameCon,
          emailCon: emailCon,
          phoneCon: phoneCon,
          passwordCon: passwordCon,
          isSignupLoading: isSignupLoading ?? this.isSignupLoading,
          isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled);
}
