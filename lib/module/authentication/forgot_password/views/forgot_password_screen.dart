import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/controller/signin_controller.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/text_widgets.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signInController.notifier);
    final state = ref.watch(signInController);
    ViewUtil.setStatusbarColor();

    return Scaffold(
        backgroundColor: KColor.background.color,
        body: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: GlobalBackButton(
                  title: "Forgot Password",
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, right: 25, left: 25, bottom: 0),
                    child: Form(
                      key: controller.forgotPasswordFormKey,
                      child: Column(
                        children: [
                          const VerticalSpace(
                            height: 30,
                          ),
                          GlobalContainer(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const BigTitle(
                                  "Enter Your Email",
                                  fontSize: 20,
                                ),
                                const VerticalSpace(),
                                AuthTextFormField(
                                    controller: state.forgotPasswordEmailCon,
                                    title: "Email address",
                                    hint: emailHint,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        print('Email is empty');
                                        return 'Email should not be empty';
                                      }
                                      // Check if email contains '@' or '.com'
                                      else if (!val.contains('@')
                                          //||!val.contains('.com')
                                          ) {
                                        print('Invalid email format');
                                        return 'Invalid email format';
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.emailAddress),
                                const VerticalSpace(),
                                GlobalButton(
                                    isLoading: state.isForgotPasswordLoading,
                                    onPressed: () async {
                                      await controller
                                          .reqForgotPassword(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    buttonText: "Submit"),
                              ],
                            ),
                          ),
                          const VerticalSpace(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
