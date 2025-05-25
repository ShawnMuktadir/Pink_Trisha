import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_state.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/model/profile_model.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';
import '../../../../../../../constant/constant_key.dart';
import '../../../../../../../data_provider/pref_helper.dart';

final profileController =
    StateNotifierProvider<ProfileController, ProfileState>(
        (ref) => ProfileController()); // Change: will now auto-load profile

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController()
      : super(ProfileState(
          fetchProfile: ProfileData(),
          isLoading: true,
          isLoggedIn: false,
          isPictureUploading: false,
          uploadingImageLink: '',
        )) {
    getProfile(); // Automatically fetch profile on provider creation
  }

  final ApiClient _apiClient = ApiClient();

  Future<void> getProfile({bool isLoading = true}) async {
    if (state.fetchProfile?.firstName?.isNotEmpty == true && !isLoading) {
      return; // Skip reloading if already fetched (optional caching)
    }

    state = state.copyWith(isLoading: isLoading, uploadingImageLink: "");

    final String? retrievedToken =
        await PrefHelper.getString(AppConstant.TOKEN.key);
    final email = PrefHelper.getString(AppConstant.EMAIL.key);
    final url = AppUrl.profileUrl.url.replaceFirst('{email}', email);

    await _apiClient
        .request(
            url: url,
            method: MethodType.GET,
            token: retrievedToken,
            onSuccessFunction: (response) {
              final ProfileModel profileModel =
                  ProfileModel.fromJson(response.data);
              state = state.copyWith(fetchProfile: profileModel.data);
            })
        .catchError((e) {
      "error $e".log();
    });

    state = state.copyWith(isLoading: false);
  }

  Future<void> openGallery(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        state = state.copyWith(uploadingImageLink: pickedFile.path);
        updateProfilePicture([File(pickedFile.path)]);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> updateProfilePicture(List<File>? files) async {
    state = state.copyWith(isPictureUploading: true);

    final token = PrefHelper.getString(AppConstant.TOKEN.key);
    final userId = PrefHelper.getString(AppConstant.USER_ID.key);
    final url = AppUrl.updateProfilePicture.url;

    await _apiClient
        .requestFormData(
            files: files,
            url: url,
            fileKeyName: "imageUrl",
            method: MethodType.PUT,
            token: token,
            params: {},
            onSuccessFunction: (response) async {
              ViewUtil.SSLSnackbar("Profile picture uploaded successfully.");
              await getProfile(isLoading: false); // Refresh after upload
            })
        .catchError((e) {
      ViewUtil.SSLSnackbar("Profile picture upload failed!");
      "error $e".log();
    });

    state = state.copyWith(isPictureUploading: false);
  }
}
