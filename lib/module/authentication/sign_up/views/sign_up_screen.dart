import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/controller/signin_controller.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/buttons.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/text_widgets.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_up/controller/signup_controller.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signUpController.notifier);
    final signInCon = ref.read(signInController.notifier);
    final signInState = ref.watch(signInController);
    final state = ref.watch(signUpController);
    return SafeArea(
      child: Scaffold(
          backgroundColor: KColor.background.color,
          body: GlobalTopLoader(
            isLoading: signInState.isGoogleBtnLoading,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, right: 25, left: 25, bottom: 0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
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
                            const BigTitle(signUp),
                            const VerticalSpace(),
                            AuthTextFormField(
                                controller: state.firstNameCon,
                                title: name,
                                hint: nameHint,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'name should not be empty';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.name),
                            const VerticalSpace(),
                            AuthTextFormField(
                                controller: state.emailCon,
                                title: email,
                                hint: emailHint,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    print('Email is empty');
                                    return 'Email should not be empty';
                                  }
                                  // Check if email contains '@' or '.com'
                                  else if (!val.contains('@') ||
                                      !val.contains('.com')) {
                                    print('Invalid email format');
                                    return 'Invalid email format';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.emailAddress),
                            const VerticalSpace(),
                            AuthTextFormField(
                                controller: state.phoneCon,
                                title: phoneNo,
                                hint: phoneNoHint,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Phone No should not be empty';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.phone),
                            const VerticalSpace(),
                            AuthTextFormField(
                                controller: state.passwordCon,
                                title: password,
                                hint: passwordHint,
                                isPasswordField: true,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Password should not be empty';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.visiblePassword),
                            const VerticalSpace(),
                            const SignUpTermsAndPrivacyButton(),
                            const VerticalSpace(height: 22),
                            GlobalButton(
                                isLoading: state.isSignupLoading,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                onPressed: () async {
                                  await controller.reqSignUp(context);
                                },
                                buttonText: signUp),
                            const VerticalSpace(),
                            const LineText(or),
                            const VerticalSpace(),
                            GestureDetector(
                              onTap: () {
                                signInCon.reqSignInWithGoogle();
                              },
                              child: BorderedWhiteButton(
                                title: google,
                                svgPath: KAssetName.icGooglesvg.imagePath,
                              ),
                            ),
                            const VerticalSpace(),
                            InkWell(
                              onTap: () => Navigation.pop(context),
                              child: const Align(
                                alignment: Alignment.center,
                                child: CoupleTextButton(
                                    firstText: "Already have account? ",
                                    secondText: "Login"),
                              ),
                            ),
                            const VerticalSpace(
                              height: 30,
                            ),
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
          )),
    );
  }
}
