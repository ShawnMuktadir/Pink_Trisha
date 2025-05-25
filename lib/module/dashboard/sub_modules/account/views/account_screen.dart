import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this for Riverpod Consumer
import 'package:shimmer/shimmer.dart'; // Add this for shimmer effect

import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/components/account_login_dialogue.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_button_list.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_subtitle.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_title.dart';

import '../../../../../data_provider/storage_controller.dart';
import '../../../../../utils/shimmer_widget.dart';
import '../../../../dashboard/sub_modules/account/sub_modules/profile/controller/profile_state.dart';
import '../sub_modules/profile/controller/profile_controller.dart'; // import your provider

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = StorageController.isLoggedIn;

    // Show actual content once profile is loaded
    return GlobalBackground(
      child: isLoggedIn
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AccountTitle(),
                      VerticalSpace(),
                      AccountSubtitle(hasAddress: true),
                      AccountButtonList(),
                    ],
                  ),
                ),
              ),
            )
          : const AccountLoginDialogue(),
    );
  }
}

class ProfileView {}
