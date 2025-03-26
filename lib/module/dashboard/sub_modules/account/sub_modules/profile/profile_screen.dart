import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_primary_textformfield.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/components/phone_number.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/components/profile_avatar.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/components/profile_edit_title.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/model/profile_model.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_subtitle.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'controller/update_profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.profileData}) : super(key: key);
  final ProfileData profileData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final controller = context.read(profileController.notifier);
    final updateController = context.read(updateProfileController.notifier);
    Future(() async {
      await controller.getProfile();
      updateController.setProfileData(widget.profileData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(profileController);
      final updateState = ref.watch(updateProfileController);
      final updateController = ref.watch(updateProfileController.notifier);
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: context.width,
            constraints: BoxConstraints(
              minHeight: context.height,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  KColor.homeGradientStart.color,
                  KColor.homeGradientEnd.color,
                ],
              ),
            ),
            child: GlobalTopLoader(
              isLoading: state.isPictureUploading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GlobalBackButton(title: "My Profile"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AccountSubtitle(
                              hasAddress: false,
                            ),
                            const PhoneNumber(),
                            const ProfileEditTitle(),
                            const ProfileAvatar(),
                            Form(
                              key: updateController.formKey,
                              child: Column(
                                children: [
                                  GlobalPrimaryTextFormField(
                                      controller: updateState.firstNameCon,
                                      title: "First Name",
                                      hint: "Enter First Name",
                                      textInputType: TextInputType.name),
                                  const VerticalSpace(
                                    height: 12,
                                  ),
                                  GlobalPrimaryTextFormField(
                                      controller: updateState.lastNameCon,
                                      title: "Last Name",
                                      hint: "Enter Last Name",
                                      textInputType: TextInputType.name),
                                  const VerticalSpace(
                                    height: 12,
                                  ),
                                  GlobalPrimaryTextFormField(
                                    controller: updateState.phoneCon,
                                    title: phoneNo,
                                    hint: "12345678",
                                    textInputType: TextInputType.phone,
                                  ),
                                  const VerticalSpace(
                                    height: 12,
                                  ),
                                  GlobalPrimaryTextFormField(
                                    controller: updateState.emailCon,
                                    title: email,
                                    hint: "Enter Email",
                                    enabled: false,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                ],
                              ),
                            ),
                            const VerticalSpace(
                              height: 36,
                            ),
                            GlobalButton(
                                isLoading: updateState.isUpdateBtnLoading,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                onPressed: () async {
                                  await updateController
                                      .reqUpdateProfile(context);
                                },
                                buttonText: "Update Account")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
