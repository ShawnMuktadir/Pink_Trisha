import 'package:flutter/material.dart';

class UpdateProfileState {
  final TextEditingController firstNameCon;
  final TextEditingController lastNameCon;
  final TextEditingController emailCon;
  final TextEditingController phoneCon;
  final bool isButtonEnabled;
  final bool isUpdateBtnLoading;

  // Constructor
  UpdateProfileState(
      {required this.firstNameCon,
      required this.lastNameCon,
      required this.emailCon,
      required this.phoneCon,
      required this.isButtonEnabled,
      required this.isUpdateBtnLoading});

  // CopyWith method
  UpdateProfileState copyWith(
      {TextEditingController? firstNameCon,
      TextEditingController? lastNameCon,
      TextEditingController? emailCon,
      TextEditingController? phoneCon,
      bool? isButtonEnabled,
      bool? isUpdateBtnLoading}) {
    return UpdateProfileState(
        firstNameCon: firstNameCon ?? this.firstNameCon,
        lastNameCon: lastNameCon ?? this.lastNameCon,
        emailCon: emailCon ?? this.emailCon,
        phoneCon: phoneCon ?? this.phoneCon,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
        isUpdateBtnLoading: isUpdateBtnLoading ?? this.isUpdateBtnLoading);
  }
}
