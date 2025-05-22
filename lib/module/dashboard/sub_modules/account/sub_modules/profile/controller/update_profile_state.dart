import 'package:flutter/material.dart';

class UpdateProfileState {
  final TextEditingController firstNameCon;
  final TextEditingController lastNameCon;
  final TextEditingController emailCon;
  final TextEditingController phoneCon;
  final bool isButtonEnabled;
  final bool isUpdateBtnLoading;
  final bool isDeleteBtnLoading;

  // Constructor
  UpdateProfileState(
      {required this.firstNameCon,
      required this.lastNameCon,
      required this.emailCon,
      required this.phoneCon,
      required this.isButtonEnabled,
      required this.isUpdateBtnLoading,
      required this.isDeleteBtnLoading});

  // CopyWith method
  UpdateProfileState copyWith(
      {TextEditingController? firstNameCon,
      TextEditingController? lastNameCon,
      TextEditingController? emailCon,
      TextEditingController? phoneCon,
      bool? isButtonEnabled,
      bool? isUpdateBtnLoading,
      bool? isDeleteBtnLoading}) {
    return UpdateProfileState(
      firstNameCon: firstNameCon ?? this.firstNameCon,
      lastNameCon: lastNameCon ?? this.lastNameCon,
      emailCon: emailCon ?? this.emailCon,
      phoneCon: phoneCon ?? this.phoneCon,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isUpdateBtnLoading: isUpdateBtnLoading ?? this.isUpdateBtnLoading,
      isDeleteBtnLoading: isDeleteBtnLoading ?? this.isDeleteBtnLoading,
    );
  }
}
