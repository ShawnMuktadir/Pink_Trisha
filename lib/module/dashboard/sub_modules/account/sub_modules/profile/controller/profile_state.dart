import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../model/profile_model.dart';

@immutable
class ProfileState {
  final ProfileData? fetchProfile;
  final bool isLoading;
  final bool isPictureUploading;
  final String uploadingImageLink;
  final bool isLoggedIn;

  const ProfileState({
    required this.fetchProfile,
    required this.uploadingImageLink,
    required this.isLoading,
    required this.isPictureUploading,
    required this.isLoggedIn,
  });

  ProfileState copyWith({
    ProfileData? fetchProfile,
    bool? isLoggedIn,
    bool? isLoading,
    bool? isPictureUploading,
    String? uploadingImageLink,
  }) {
    return ProfileState(
      fetchProfile: fetchProfile ?? this.fetchProfile,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      isPictureUploading: isPictureUploading ?? this.isPictureUploading,
      uploadingImageLink: uploadingImageLink ?? this.uploadingImageLink,
    );
  }
}
