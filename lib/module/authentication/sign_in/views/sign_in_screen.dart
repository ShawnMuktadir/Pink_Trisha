import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_back_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_button.dart';
import 'package:pink_by_trisha_app/global/widget/global_container.dart';
import 'package:pink_by_trisha_app/global/widget/global_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_space.dart';
import 'package:pink_by_trisha_app/global/widget/global_text.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/controller/signin_controller.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/buttons.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/text_widgets.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({this.hasBackButton = false, Key? key}) : super(key: key);
  final bool? hasBackButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signInController.notifier);
    final state = ref.watch(signInController);
    ViewUtil.setStatusbarColor();

    return WillPopScope(
      onWillPop: () async {
        if (hasBackButton == null || !hasBackButton!) {
          Navigation.pushReplacement(context, appRoutes: AppRoutes.dashboard);
          return false;
        }
        return true;
      },
      child: Scaffold(
          backgroundColor: KColor.background.color,
          body: SafeArea(
            child: GlobalTopLoader(
              isLoading: state.isGoogleBtnLoading,
              child: Column(
                children: [
                  hasBackButton != null && hasBackButton!
                      ? const Align(
                          alignment: Alignment.centerLeft,
                          child: GlobalBackButton(
                            title: "Login",
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => Navigation.pushReplacement(context,
                                appRoutes: AppRoutes.dashboard),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 10),
                              child: GlobalText(
                                str: "Skip",
                                fontWeight: FontWeight.w600,
                                color: KColor.primary.color,
                                fontSize: 16,
                                height: 0.09,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, right: 25, left: 25, bottom: 0),
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
                                    const BigTitle(login),
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
                                          else if (!val.contains('@')
                                              //||!val.contains('.com')
                                              ) {
                                            print('Invalid email format');
                                            return 'Invalid email format';
                                          }
                                          return null;
                                        },
                                        textInputType:
                                            TextInputType.emailAddress),
                                    const VerticalSpace(),
                                    // const AuthTextFormField(
                                    //     title: phoneNo,
                                    //     hint: phoneNoHint,
                                    //     textInputType: TextInputType.phone),
                                    // const VerticalSpace(),
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
                                        textInputType:
                                            TextInputType.visiblePassword),
                                    const VerticalSpace(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const CheckIcon(),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            GlobalText(
                                              str: "Remember me",
                                              color: KColor.deep3.color,
                                              height: 0.10,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () => Navigation.push(context,
                                              appRoutes:
                                                  AppRoutes.forgotPassword),
                                          child: GlobalText(
                                            str: "Forgot password?",
                                            color: KColor.primary.color,
                                            fontSize: 14,
                                            height: 0.10,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const VerticalSpace(height: 20),
                                    GlobalButton(
                                        isLoading: state.isLoginLoading,
                                        onPressed: () {
                                          controller.reqSignIn(context);
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        buttonText: signIn),
                                    const VerticalSpace(),
                                    const LineText(or),
                                    const VerticalSpace(),
                                    GestureDetector(
                                      onTap: () {
                                        controller.reqSignInWithGoogle();
                                      },
                                      child: BorderedWhiteButton(
                                        title: google,
                                        svgPath:
                                            KAssetName.icGooglesvg.imagePath,
                                      ),
                                    ),
                                    const VerticalSpace(),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     controller.reqSignInWithFB();
                                    //   },
                                    //   child: BorderedWhiteButton(
                                    //     title: facebook,
                                    //     svgPath:
                                    //         KAssetName.icFacebooksvg.imagePath,
                                    //   ),
                                    // ),
                                    // const VerticalSpace(),
                                    InkWell(
                                      onTap: () => Navigation.push(context,
                                          appRoutes: AppRoutes.signUp),
                                      // ignore: prefer_const_constructors
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: const CoupleTextButton(
                                            firstText:
                                                "Still without account? ",
                                            secondText: "Create One"),
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
