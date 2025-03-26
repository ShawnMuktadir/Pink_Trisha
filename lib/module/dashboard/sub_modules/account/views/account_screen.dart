import 'package:flutter/material.dart';
import 'package:pink_by_trisha_app/global/widget/global_background.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/components/account_login_dialogue.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_button_list.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_subtitle.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_title.dart';

import '../../../../../data_provider/storage_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalBackground(
        child: StorageController.isLoggedIn
            ? const SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountTitle(),
                        VerticalSpace(),
                        AccountSubtitle(
                          hasAddress: true,
                        ),
                        AccountButtonList()
                      ],
                    ),
                  ),
                ),
              )
            : const AccountLoginDialogue());
  }
}
