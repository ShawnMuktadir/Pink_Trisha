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
  const ProfileScreen({super.key, required this.profileData});

  final ProfileData profileData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read(profileController.notifier);
    final updateController = context.read(updateProfileController.notifier);

    Future(() async {
      await controller.getProfile();

      // Now get the fresh profile data from profileController's state:
      final freshProfile = context.read(profileController).fetchProfile;

      // Update updateProfileController with fresh data
      updateController.setProfileData(freshProfile!);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isInitialized = false;
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(profileController);
      final updateState = ref.watch(updateProfileController);
      final updateController = ref.watch(updateProfileController.notifier);

      // Only initialize once
      if (!_isInitialized) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          updateController.initializeControllers(state.fetchProfile!);
          updateController.syncWithProfile(state.fetchProfile!);
        });
        _isInitialized = true;
      }

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
                            const AccountSubtitle(hasAddress: false),
                            if (widget.profileData.phoneNumber?.isNotEmpty ??
                                false)
                              PhoneNumber(),
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
                                    textInputType: TextInputType.name,
                                  ),
                                  const VerticalSpace(height: 12),
                                  GlobalPrimaryTextFormField(
                                    controller: updateState.lastNameCon,
                                    title: "Last Name",
                                    hint: "Enter Last Name",
                                    textInputType: TextInputType.name,
                                  ),
                                  const VerticalSpace(height: 12),
                                  GlobalPrimaryTextFormField(
                                    controller: updateState.phoneCon,
                                    title: phoneNo,
                                    hint: "12345678",
                                    textInputType: TextInputType.phone,
                                  ),
                                  const VerticalSpace(height: 12),
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
                            const VerticalSpace(height: 36),
                            GlobalButton(
                              isLoading: updateState.isUpdateBtnLoading,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              onPressed: () async {
                                await updateController
                                    .reqUpdateProfile(context);
                              },
                              buttonText: "Update Account",
                            ),
                            const VerticalSpace(height: 36),
                            GlobalButton(
                              isLoading: updateState.isDeleteBtnLoading,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              onPressed: () async {
                                showDeleteAccountDialog(context, ref);
                              },
                              buttonText: "Delete Account",
                            ),
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

  void showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                showAccountDeletionDialog(context, ref, widget.profileData);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void showAccountDeletionDialog(
      BuildContext context, WidgetRef ref, ProfileData data) {
    final emailController = TextEditingController(text: data.email);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Account Deletion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                readOnly: true,
                // You can set this to false if you want the user to type manually
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color(0xffF554B1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
          actions: [
            GlobalButton(
              onPressed: () {
                if (emailController.text.trim() == data.email) {
                  Navigator.of(dialogContext).pop();
                  ref
                      .read(updateProfileController.notifier)
                      .deleteAccount(context, data.id!, data.email!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email does not match')),
                  );
                }
              },
              buttonText: 'Confirm Delete',
            ),
          ],
        );
      },
    );
  }
}
